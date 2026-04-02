[HANDOFF]
📍 Where: /Users/xiaojingbo/.openclaw/workspace/knowledge-base/03-Notes/2026-04-02-玄武-MemOS-Topic-Judge-最小Patch执行前准备卡-v1.md
🎯 What: 将 Curie 的《MemOS Topic Judge 轻量化重构方案与最小 Patch 设计稿 v1》压成玄武可直接执行的实施前准备卡，收口实现边界、风险口径、日志要求与验收动作。
🔍 How to verify: 检查文档是否包含：实施目标、阻塞项裁决、明确改动文件、函数级任务单、日志字段、验收口径、回退点、Known Issues、Next Steps。
⚠️ Known Issues: 本文档是执行前准备卡，不等于代码已改完；Curie 原方案文档仍是上游设计依据；最终放行仍需实施后复验。
➡️ Next Steps: 玄武按本文档完成最小 patch、记录观测结果并回传；Anna 基于回传结果做放行 / 返工裁决。

# 玄武｜MemOS Topic Judge 最小 Patch 执行前准备卡 v1

- 日期：2026-04-02
- 角色：执行前准备卡
- 执行人：玄武
- 审计口径：Anna
- 上游设计稿：`/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/2026-04-02-MemOS-Topic-Judge-轻量化重构方案与最小Patch设计稿-v1.md`

---

## 0. 一句话目标

不是继续给 Topic Judge 加 timeout，
而是把它从“吃拼接聊天上下文的易漂移慢链路”，压回“吃结构化短上下文的稳定二分类 worker”。

---

## 1. 当前已确认事实

### 现象
- Topic Judge 在长 context 下明显变慢。
- 长 context 下会出现非 `NEW / SAME` 输出。
- 历史已有真实报错：
  - `judgeNewTopic failed (openai_compatible/qwen2.5:7b), no more fallbacks: TimeoutError: The operation was aborted due to timeout`

### 代码落点
当前真实链路：
- `src/ingest/task-processor.ts`
  - `processChunksIncrementally(...)`
  - `buildContextSummary(currentTaskChunks)`
  - `summarizer.judgeNewTopic(context, newMsg)`
- `src/ingest/providers/openai.ts`
  - `judgeNewTopicOpenAI(...)`
- `src/ingest/providers/index.ts`
  - `Summarizer.judgeNewTopic(...)`
  - provider dispatch

### 当前实现断点
1. `buildContextSummary()` 仍是拼接式 conversational text。
2. `user` 默认可吃到 `500 chars`，`assistant` 默认可吃到 `200 chars`。
3. provider 层目前用 `answer.startsWith("NEW")` 判断结果。
4. 非法自然语言输出没有被显式收口成可观测信号。

---

## 2. 本轮允许做什么 / 不允许做什么

## 允许做
1. 为 Topic Judge 新增专用 context builder。
2. 缩短 `newMsg` 输入长度。
3. 增加 topic-judge 输出标准化。
4. 增加 topic-judge 调用观测日志。
5. 在不改 schema 的前提下完成最小止血 patch。

## 不允许做
1. 不改数据库 schema。
2. 不引入 rolling synopsis 字段。
3. 不顺手重构整个 summarizer 链路。
4. 不靠继续增大 timeout 充当主修复手段。
5. 不引入多次自动重试。
6. 不把非法输出静默吞成“看起来没事”。

---

## 3. 三个阻塞项裁决（执行前必须按此口径）

### 阻塞项 1：返回值边界统一
**裁决：**
- provider 层负责拿到 `raw_output`
- 标准化函数负责产出：`"NEW" | "SAME" | null`
- `Summarizer.judgeNewTopic(...)` 对外仍收口为：`boolean | null`

**原因：**
- 不能把当前布尔返回链路打散。
- 也不能让各 provider 各自偷偷定义“非法输出”。

---

### 阻塞项 2：非法输出统一按 `null` 处理
**裁决：**
- 首版禁止“非法输出默认 SAME”。
- 首版统一：非法输出 => `null`
- 上层沿用现有保守逻辑：`null` 时继续并入当前 task，不直接切新 task。

**原因：**
- 默认 SAME 会吞掉异常，观测面变差。
- `null` 既不炸链路，也保留失守证据。

---

### 阻塞项 3：日志字段固定，不再停留在建议层
**裁决：**
每次 Topic Judge 调用后，至少记录以下字段：
- `context_length`
- `new_msg_length`
- `existing_user_turns`
- `used_chunks_count`
- `used_user_chunks_count`
- `used_assistant_chunks_count`
- `elapsed_ms`
- `raw_output`
- `normalized_output`
- `invalid_output`

**原因：**
没有这组字段，就无法做 patch 前后对照，也无法确认是“真稳定”还是“静默吞错”。

---

## 4. 明确改动文件

### 必改文件
1. `~/.openclaw/extensions/memos-local-openclaw-plugin/src/ingest/task-processor.ts`
2. `~/.openclaw/extensions/memos-local-openclaw-plugin/src/ingest/providers/openai.ts`
3. `~/.openclaw/extensions/memos-local-openclaw-plugin/src/ingest/providers/index.ts`

### 非必改但可检查
- 其他 provider 文件（若 Topic Judge 也走同类实现，可同步补齐标准化口径；若本轮只修 openai_compatible 路径，需在回传里明确边界）

---

## 5. 函数级任务单

## A. `task-processor.ts`

### 任务 A1：保留旧 `buildContextSummary()`，新增 `buildTopicJudgeContext()`
要求：
- 不删除旧函数。
- 只让 Topic Judge 切换到新函数。
- 新函数产出结构化上下文卡，而非 `[User] / [Assistant]` 大段拼接。

建议结构：
- `TASK ORIGINAL TOPIC`
- `CURRENT WORKING TOPIC`
- `RECENT USER INTENT`
- `RECENT UNRESOLVED ISSUE`

### 任务 A2：新增 `pickChunkSnippet(...)`
要求：
- 统一 `summary` 优先、原文截断兜底的逻辑。
- `user` 和 `assistant` 长度限制分开控制。
- 长度值提成常量，避免魔法数字散落。

### 任务 A3：切换 `processChunksIncrementally(...)` 的 topic-judge 输入
旧：
```ts
const context = this.buildContextSummary(currentTaskChunks);
const newMsg = userChunk.content.slice(0, 500);
```

新目标：
```ts
const context = this.buildTopicJudgeContext(currentTaskChunks);
const newMsg = userChunk.content.slice(0, TOPIC_JUDGE_NEW_MSG_MAX_LEN);
```

执行口径：
- 首版 `TOPIC_JUDGE_NEW_MSG_MAX_LEN` 可先取 `300`
- 但必须提成常量，禁止硬编码散落

### 任务 A4：补 topic-judge 调用日志
要求：
- 在 `judge` 调用前后记录长度、耗时、结果
- 日志内容足以支撑 patch 前后对照

---

## B. `openai.ts`

### 任务 B1：新增 `normalizeTopicJudgeOutput(raw)`
要求：
- 输入：原始模型输出字符串
- 输出：`"NEW" | "SAME" | null`
- 只接受严格口径，不接受 `startsWith("NEW")` 这种模糊命中

建议接受逻辑：
- `trim()`
- 必要时做大小写归一
- 仅在归一结果严格等于 `NEW` / `SAME` 时通过
- 其余一律 `null`

### 任务 B2：停止使用 `answer.startsWith("NEW")`
旧风险：
- `NEW: because...` 被误判 NEW
- `好的，我们继续...` 被隐式落成 SAME
- 非法输出无显式暴露

新口径：
- provider 层拿到 `raw`
- 标准化后返回结构化结果或 `null`
- 不强抛异常炸掉整条链路

### 任务 B3：返回值与日志信息可供上层消费
要求：
- 至少保证上层能拿到：`raw_output`、`normalized_output`
- 如果现有函数签名不适合，允许新增内部 helper，但不要做大重构

---

## C. `providers/index.ts`

### 任务 C1：`Summarizer.judgeNewTopic(...)` 对外保持 `boolean | null`
要求：
- 不改调用方主签名
- `NEW` => `true`
- `SAME` => `false`
- 非法输出 => `null`

### 任务 C2：fallback 行为不变，但要能记录模型失守
要求：
- timeout / provider error 仍按现有 fallback 链跑
- 非法输出不伪装成正常 SAME
- 回传时要能区分：
  - timeout / request error
  - invalid output
  - normal SAME / NEW

---

## 6. 建议参数口径（首版）

### context 预算
- 软上限：`600~900 chars`
- 硬上限：`1200 chars`

### snippet 建议
- Original Topic：每条 `120~160 chars`
- Current Working Topic：每条 `100~140 chars`
- Recent User Intent：每条 `100~140 chars`
- Recent Unresolved Issue：每条 `120~160 chars`

### new message
- 首版：`300 chars`
- 要求：提常量，可后调

---

## 7. 最小验收标准

本轮不接受“感觉快了一点”这种结论。
至少给出下面四项中的可验证结果：

### 1）延迟
- patch 前后 Topic Judge：
  - P50
  - P95

### 2）非法输出率
- 输出非 `NEW/SAME` 的比例是否下降

### 3）错切率
- patch 后是否出现明显更多误切 task

### 4）主观稳定性
- timeout 是否减少
- 输出漂移是否减少
- 长 context 下是否更稳

---

## 8. 回退点

如果 patch 后出现以下任一情况，先回退再复盘：
1. 错切率明显上升
2. 大量正常 follow-up 被切成 NEW
3. provider 返回结构变化导致 topic judge 普遍 `null`
4. patch 导致别的 summarizer 路径连带失稳

建议回退方式：
- 保留旧 `buildContextSummary()` 路径
- 新函数 / 新标准化尽量以最小侵入方式接入，便于单点回撤

---

## 9. 玄武回传要求

玄武实施完成后，回传必须包含：

### Where
- 实际改动文件路径
- 如有 commit / patch 文件，也附路径

### What
- 实际完成了哪些最小 patch
- 哪些本轮没做，为什么没做

### How to verify
- 用什么方式测了
- 观测了哪些日志 / 指标
- patch 前后差异是什么

### Known Issues
- 仍未解决的问题
- 仍保留的风险边界

### Next Steps
- 建议继续观测、补强，还是可以先放行

---

## 10. Known Issues

1. 本轮仍依赖 `chunk.summary` 质量。
2. 第一版未引入 rolling synopsis。
3. 若其他 provider 也承接 Topic Judge，但本轮只修 openai_compatible 路径，则仍存在口径不一致风险。
4. 目前上游设计稿实际位于 Curie 工作区，不是共享知识库正式路径；后续若要沉淀正式规则，需迁移归档。

---

## 11. Next Steps

1. 玄武按本卡实施最小 patch。
2. 实施后输出 5 字段回传，不要只回“已改”。
3. Anna 按回传证据做放行 / 返工裁决。
4. 若 patch 有效，再考虑第二阶段观测版与第三阶段增强版。

---

## 12. 给玄武的最短执行口令

> 只改 Topic Judge，不顺手大修；
> 只做结构化短 context、严格输出校验、观测日志；
> 非法输出统一回 `null`，不要静默吞成 SAME；
> 改完带证据回传。