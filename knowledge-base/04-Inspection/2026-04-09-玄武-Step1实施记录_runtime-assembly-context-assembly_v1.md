# 玄武 Step 1 实施记录｜runtime assembly context assembly v1

- 日期：2026-04-09
- 执行对象：玄武
- 性质：实施记录 / 阶段收口
- 所属主线：Runtime Pipeline / runtime assembly 第一轮
- 对应阶段：Step 1 `context-assembly`
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/shaun-wiki/91-Curie-Knowledge-Base/Runtime-Pipeline/01-Notes/2026-04-09-runtime-assembly-第一轮施工说明交接文档_v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/Runtime-Pipeline/01-Notes/2026-04-09-runtime-assembly-第一轮主接入点判定卡_v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-玄武实施入口判断_runtime-assembly-第一轮_v1.md`

---

## 一、这一步做了什么
本轮未进入 Step 2 / Step 3，也未扩写 system prompt/report 体系；只完成 Step 1 的最小落地：

### 1. 在 reply/runtime ingress 侧新增最小 context assembly
已在源码仓：
- `/Users/xiaojingbo/.openclaw/workspace-system-guardian/tmp/openclaw-src`

完成最小汇总：
- `src/auto-reply/reply/agent-runner-utils.ts`
  - 新增 `RuntimeContextAssembly`
  - 新增 `buildContextAssembly(...)`

当前汇总内容仅包含：
- inbound.raw
- inbound.finalized
- command
- outboundSession

### 2. 挂入 `RunEmbeddedPiAgentParams`
已在：
- `src/agents/pi-embedded-runner/run/params.ts`

新增：
- `contextAssembly?: RuntimeContextAssembly`

说明：
- 当前采用“参数快照挂载”
- 不把整块 context assembly 直接绑进 `systemPromptReport`
- 不把这一步伪装成完整 runtime report 改造

### 3. 让 `runEmbeddedPiAgent` 真正读取 context assembly
已在：
- `src/agents/pi-embedded-runner/run.ts`
- `src/agents/pi-embedded-runner/run/helpers.ts`
- `src/agents/pi-embedded-runner/types.ts`

当前读取方式为：
- 读取 `params.contextAssembly`
- 先经 `buildContextAssemblyAgentMeta(...)` 生成最小 summary
- 再并入 `agentMeta.contextAssembly`

当前 summary 字段仅包含：
- `present`
- `chatType`
- `commandAuthorized`
- `hasOutboundSession`
- `commandSurface`
- `commandChannel`

在此基础上，Step 1 后续又继续补齐了两处前段解释位：
- 在 `contextAssembly.inbound` 中新增
  - `effectiveAgentBody`
  - `agentBodySource`
- 在 `contextAssembly` 中新增
  - `sender` 统一解释块（`senderId / senderName / senderUsername / senderE164 / senderIsOwner / commandSenderId`）

本轮中间曾出现一次口径修正：
- Curie 审阅指出：错误路径已消费 `contextAssembly`，但成功路径 `agentMeta.contextAssembly` 摘要接入尚未闭合
- 玄武随后按“只补一刀”的要求，在成功路径 `agentMeta` 构造处补入：
  - `buildContextAssemblyAgentMeta({ contextAssembly: params.contextAssembly })`

因此当前 Step 1 的真实口径已从：
> “上游参数里有 contextAssembly”
推进到：
> “embedded run 主链的错误路径与成功路径都已可读取并暴露 contextAssembly 的最小摘要；同时前段已显式补出 effective body 与 sender 的统一解释位。”

---

## 二、这一步没做什么
为守住第一轮边界，本轮明确没有做：

### 1. 没推进 Step 2 capability surface
- 未新增 `capability-surface.ts`
- 未开始 capability provider 汇总

### 2. 没推进 Step 3 request assembly
- 未开始 request shaping 收口
- 未开始 model / reasoning / budget 输入归并

### 3. 没把 context assembly 扩成报告层重构
- 未把整块 `contextAssembly` 落入 `systemPromptReport`
- 当前仅在 `agentMeta` 中暴露最小 summary，不等于 report/schema 主线改造
- 未把 report schema 改造成 runtime assembly 观测结构
- 未顺手扩写 broader observability / governance 面

### 4. 没碰禁并项
- 未碰 tool invocation pipeline
- 未碰 runtime objects
- 未碰 stuck / rebuild / watchdog 主流程
- 未碰 compaction / memory / recall 体系重构

---

## 三、校验结果
### 1. 单测
已新增并通过：
- `src/auto-reply/reply/agent-runner-utils.context-assembly.test.ts`

校验点覆盖：
- context assembly 可组装
- finalized inbound 可用
- command context 可用
- outbound session context 可用

### 2. 类型检查
已完成全量：
- `tsc -p tsconfig.json --noEmit`

过程中出现过两类非结构性阻塞，但均已压住：
1. 初次全量 tsc 因 Node 堆内存不够中断
   - 通过提高 `NODE_OPTIONS=--max-old-space-size=12288` 继续
2. 因 `buildEmbeddedRunBaseParams` 新增 `sessionCtx` 必填，造成旧测试调用面签名回归
   - 已收口为 `sessionCtx?` 可选
   - 且仅在存在 `sessionCtx` 时注入 `contextAssembly`

### 3. 针对 Curie 审阅缺口的补刀复验
Curie 在《Step 1 审阅验证与补充实施合并件 v1》中指出：
- Step 1 一度停在“成功路径闭合前一格”
- 具体缺口为：成功路径 `agentMeta.contextAssembly` 摘要接入未闭合

玄武后续已按要求补刀，并复验：
- 成功路径 `agentMeta` 已显式并入 `contextAssembly` 最小摘要
- 错误路径仍保持原有 `contextAssembly` 消费
- 未新增 broader report schema 改造
- 未引入 Step 2 / Step 3 内容

当前口径：
> **Step 1 已完成最小 context assembly、参数挂载、summary helper、错误路径消费、成功路径闭合、effective body 显式解释位、sender 统一解释位，并通过最小单测与全量类型检查。**

---

## 四、源码仓当前提交状态
源码仓：
- `/Users/xiaojingbo/.openclaw/workspace-system-guardian/tmp/openclaw-src`

当前已形成的本地提交：
1. `686944fc0b`
   - `feat(runtime): add step1 context assembly snapshot`
2. `d59976c680`
   - `fix(runtime): make context assembly injection optional`
3. `0dc3c7e7af`
   - `feat(runtime): surface context assembly in embedded run meta`

说明：
- 第二个提交用于收口 `sessionCtx` 签名回归问题
- 第三个提交用于让 `runEmbeddedPiAgent` 在主链上真正读取并暴露 `contextAssembly` 最小摘要
- 后续 B/C 两处补刀（`effectiveAgentBody/agentBodySource` 与 `sender` 统一解释位）当前已完成代码层落地，并待本轮收口提交

---

## 五、玄武当前判断
当前 Step 1 可以成立，但它的成立口径仍应严格写成：

> **已完成 context assembly 的最小结构落地、参数挂载、summary helper、主链读取、错误路径消费、成功路径闭合、effective body 显式解释位、sender 统一解释位与最小校验；当前仍不是完整 runtime assembly 成立，而是第一轮 Step 1 已正式收成“前段 context assembly 已进入 embedded run 主链并具备最小可解释摘要”的状态。**

也就是说：
- 这不是“runtime assembly 全做完了”
- 也不是“只是写了个类型壳子”
- 而是：
  - Step 1 已从概念结构进入真实执行链，并完成成功/错误路径闭合与三问中的前段解释补齐
  - 但后续仍需继续推进 Step 2 / Step 3 / Step 4

---

## 六、5 字段 handoff
- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-玄武-Step1实施记录_runtime-assembly-context-assembly_v1.md`
- **What**
  - 记录 runtime assembly 第一轮 Step 1 的最小实施结果：context assembly 已落在 ingress 侧、挂入 RunEmbeddedPiAgentParams，并被 embedded run 主链读取为极简 summary。
- **How to verify**
  - 检查源码仓是否包含 `RuntimeContextAssembly`、`buildContextAssembly(...)`、`RunEmbeddedPiAgentParams.contextAssembly`、`agentMeta.contextAssembly` 最小 summary；检查新增单测是否通过，类型检查是否通过。
- **Known Issues**
  - 当前尚未进入 Step 2 capability surface；也未将 context assembly 扩成 report/schema 主线资产。
- **Next Steps**
  - 在守住边界的前提下，继续推进 runtime assembly 第一轮后续步骤；Step 1 当前已完成最小前段闭合，下一步更自然的是进入 Step 2 capability surface 的最小入口判断与落点。
