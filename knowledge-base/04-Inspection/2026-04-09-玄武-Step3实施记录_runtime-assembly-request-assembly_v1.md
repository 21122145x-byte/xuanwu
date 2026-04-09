# 玄武 Step 3 实施记录｜runtime assembly request assembly v1

- 日期：2026-04-09
- 执行对象：玄武
- 性质：实施记录 / 入口判断 / 后续持续更新宿主
- 所属主线：Runtime Pipeline / runtime assembly 第一轮
- 对应阶段：Step 3 `request-assembly`
- 当前状态：第一刀已实施，并通过最小复验
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/shaun-wiki/91-Curie-Knowledge-Base/Runtime-Pipeline/01-Notes/2026-04-09-runtime-assembly-第一轮施工说明交接文档_v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/Runtime-Pipeline/01-Notes/2026-04-09-runtime-assembly-Step3-行动卡_v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-玄武-Step2实施记录_runtime-assembly-context-assembly_v1.md`

---

## 一、当前阶段说明
这份文档当前仍承担 Step 3 的实施记录宿主角色，
但已从“纯入口判断”推进到：
> **入口判断已落 + request-assembly 最小宿主已实施 + 最小复验已完成。**

当前本文既记录：
- request params 的主输入源汇流带
- 主消费点与最小挂点判断
- 最小新增文件应落哪

也开始记录：
- 实际新增文件
- 最小 export / schema
- focused test
- 全量类型检查

---

## 二、Step 3 当前目标
根据 Curie 交接文档与行动卡，Step 3 当前目标不是 provider-specific request body 全重写，
而是先收回 request shaping 输入面解释权。

### 本步完成后应能回答
1. 当前 request params 从哪些输入面汇入
2. 哪些属于 dynamic input
3. 哪些参数已经足够形成稳定 request shaping 层

### 当前边界
- 不顺手改 provider-specific 完整 request body
- 不顺手进入 tool execution lifecycle
- 不顺手把 Step 3 做成 Step 4 runtime-assembly

---

## 三、当前主输入源判断
### 1. prompt / system prompt 输入面
当前最像的输入源包括：
- `src/agents/system-prompt.ts`
- `src/agents/system-prompt-params.ts`
- `resolveProviderSystemPromptContribution(...)`
- `buildEmbeddedSystemPrompt(...)`
- `buildSystemPromptParams(...)`

### 2. model / reasoning / runtime flags 输入面
当前最像的输入源包括：
- `params.model`
- `thinkLevel`
- `reasoningLevel`
- `streamParams`
- `toolResultFormat`
- `clientTools`
- `supportsModelTools(...)`
- `normalizeProviderToolSchemas(...)`
- `toClientToolDefinitions(...)`
- `resolveToolCallArgumentsEncoding(...)`

### 3. 当前判断
这些输入面说明：
> **Step 3 的 source layer，不是单一文件，而是 prompt params + model/runtime flags + tool/request compat 邻接输入面的汇流。**

---

## 四、当前主消费点判断
### 判定
当前更像 Step 3 主消费点的宿主仍然是：
- `src/agents/pi-embedded-runner/run/attempt.ts`

### 理由
因为真正把这些输入汇成一次 embedded run request shaping 邻接带的，
不是单独的 system-prompt 文件，也不是单独的 provider compat 文件，
而是 `run/attempt.ts` 中围绕以下内容形成的 request 邻接区：
- system prompt 已成形
- tool definitions / tool compat 已成形
- model / reasoning / stream / tool flags 已拿到
- 但尚未正式掉入 provider-specific 深层请求体与执行期

一句话：
> **Step 3 的 source 面是分散的，但当前更像主消费点的仍是 `run/attempt.ts`。**

---

## 五、当前最稳的最小新增落点
### 建议新增
- `src/runtime/request-assembly.ts`

### 当前职责
由 `request-assembly.ts` 去做：
- 汇总 prompt 输入面
- 汇总 model / reasoning / runtime flags
- 输出最小 `RequestParamsOutput`
- 标记 `dynamicInputs`

### 当前不建议
- 直接在 provider runtime / compat 细部堆 request assembly
- 直接把 Step 3 做成完整 request body 生成器
- 直接把 Step 3 与 Step 4 runtime-assembly 混在一起

---

## 六、当前最稳的最小挂点判断
### 当前判断
Step 3 的最小挂点，不应落在：
- 纯 prompt build 之前（太早，只拿到 prompt source）
- provider-specific request body 之后（太晚，已进入深层执行体）

而应落在：
> **`run/attempt.ts` 中，system prompt / tool definitions / model/runtime flags 已成形，但尚未掉入更深 provider request body 的 request preflight band。**

这比 Step 2 的 pre-session assembly band 更靠后一点，
但仍然没进入 execution 主链深处。

---

## 七、当前不建议误选的点
### 1. `system-prompt.ts` / `system-prompt-params.ts`
**原因：**
- 它们是 prompt source，不是 request params 总消费宿主

### 2. provider compat / schema 细部文件
例如：
- `provider-model-compat.ts`
- `pi-tool-definition-adapter.ts`

**原因：**
- 这些更像 request body 细部兼容逻辑
- 太容易把 Step 3 做成 provider-specific patch

### 3. `createAgentSession(...)` 之后的执行期
**原因：**
- 过晚
- 已脱离 request assembly 解释层

---

## 八、当前最小结论
截至当前，玄武对 Step 3 的最稳判断是：

> **Step 3 request assembly 的主输入源是 prompt params + model/runtime flags + tool/request compat 邻接输入面的汇流；当前更像主消费点的宿主仍是 `src/agents/pi-embedded-runner/run/attempt.ts`；最小新增落点应为 `src/runtime/request-assembly.ts`，并在 request preflight band 接入。**

---

## 九、当前已实施的第一刀（新增）
### 1. 已新增最小宿主
已在源码仓新增：
- `src/runtime/request-assembly.ts`
- `src/runtime/request-assembly.test.ts`

### 2. 当前第一刀做了什么
当前最小宿主已完成：
- 定义 `RequestAssemblyInput`
- 定义 `RequestParamsOutput`
- 定义 `DynamicInputMarker`
- 提供 `buildRequestParams(...)`

### 3. 当前先收的三类输入面
#### prompt
- `systemPrompt`
- `providerContribution`
- `extraSystemPrompt`

#### model / runtime flags
- `provider`
- `model`
- `thinkLevel`
- `reasoningLevel`
- `verboseLevel`
- `streamParams`

#### tools / request compat 邻接面
- `toolResultFormat`
- `effectiveToolCount`
- `clientToolsCount`
- `supportsModelTools`
- `toolCallArgumentsEncoding`

### 4. 当前可标出的 dynamic inputs
- `provider-contribution`
- `extra-system-prompt`
- `thinking`
- `reasoning`
- `stream-params`
- `tool-result-format`
- `client-tools`
- `tool-visibility`

### 5. 当前复验结果
已完成：
- 新增测试：`src/runtime/request-assembly.test.ts`
- 全量类型检查：`tsc -p tsconfig.json --noEmit`

复验口径：
- 新增测试退出码：`0`
- 全量类型检查退出码：`0`

当前可以成立为：
> **Step 3 第一刀最小宿主已落地，并通过 focused test 与全量类型检查。**

### 6. 当前新增接线（补记）
已在：
- `src/agents/pi-embedded-runner/run/attempt.ts`
- `src/agents/pi-embedded-runner/run/types.ts`
- `src/runtime/request-assembly.ts`

完成 Step 3 的下一小步：
- 在 `run/attempt.ts` 的 request preflight band 构出 `requestParams`
- 将其带入 `EmbeddedRunAttemptResult`
- 暂不扩到 run meta / prompt report

当前 requestParams 汇流内容仍保持三类输入面：
- prompt
- model / runtime flags
- tools / request compat 邻接面

### 7. 类型口径收口（补记）
本轮在接线时出现过一个真实卡点：
- `run/attempt.ts` 当前拿到的 `providerContribution` 是 `ProviderSystemPromptContribution | undefined`
- 但 `request-assembly.ts` 里 `RequestAssemblyInput.prompt.providerContribution` 一开始只写成了 `string | undefined`

最终收口路径不是在 `attempt.ts` 里把它硬压成 string，
而是：
- 放宽 `request-assembly.ts` 输入类型
- 让解释层宿主接收 `ProviderSystemPromptContribution | string | undefined`
- 在 `request-assembly.ts` 内部做最小归一化

当前口径：
> **这次收口点发生在解释层输入合同，而不是挂点判断本身；修法也守住了 Step 3 的边界。**

### 8. 当前更新后的状态
因此当前 Step 3 应写成：
> **入口判断已成立；最小宿主已落地；request preflight band 已完成第一刀接线；focused test 与全量 tsc 已通过；但更深的主链消费闭环仍未开始。**

### 9. 当前 runtime meta / prompt 邻接解释（新增）
在 request preflight band 第一刀接线成立之后，本轮继续补了 Step 3 的最小邻接解释：

#### 已在：
- `src/agents/pi-embedded-runner/run/helpers.ts`
- `src/agents/pi-embedded-runner/run.ts`
- `src/agents/system-prompt-report.ts`
- `src/agents/pi-embedded-runner/run/attempt.ts`
- `src/agents/pi-embedded-runner/types.ts`
- `src/config/sessions/types.ts`

#### 当前新增内容
- 新增 `buildRequestParamsAgentMeta(...)`
  - 统一收口 run meta 侧的 request params 摘要逻辑
- `run.ts` 成功路径会并入 `agentMeta.requestParams` 最小摘要
- `systemPromptReport` 新增 `requestParams` 摘要位
- `attempt.ts` 已将 `requestParams` 带入 `buildSystemPromptReport(...)`

#### 当前摘要字段
- `dynamicInputCount`
- `dynamicInputs`
- `hasProviderContribution`
- `hasExtraSystemPrompt`
- `effectiveToolCount`

#### 当前验证结果
- focused tests：`EXIT 0`
- 全量类型检查：`EXIT 0`

#### 当前边界
- 仍未进入 Step 4 runtime-assembly
- 仍未做更大范围 request consumption loop 验证
- 当前只是在 Step 3 内把 request params 的最小 runtime meta / prompt report 邻接解释补齐

当前可以成立为：
> **Step 3 已从“最小挂点接线”推进到“runtime meta + prompt 邻接解释”，且 focused tests 与 tsc 已通过。**

## 十、当前还没做什么
- 尚未把 Step 3 接入 `run/attempt.ts`
- 尚未形成 Step 3 的主链邻接解释
- 尚未输出 Step 3 的 before / after 主链验证结果
- 尚未进入 Step 3 的后续更细 request params 消费闭环

所以当前文档应写成：
> **Step 3 入口判断已成立；第一刀最小宿主已实施并通过最小复验；其最小挂点已接入 `run/attempt.ts` 的 request preflight band，且类型口径已按解释层宿主收口；后续更深主链接线仍未开始。**

---

## 十、后续更新规则
若继续推进 Step 3，后续在本文继续补：
1. 实际改动文件
2. 最小 export / schema
3. focused tests / tsc
4. 主链邻接解释
5. 已知问题与偏差说明

---

## 十一、5 字段 handoff
- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-玄武-Step3实施记录_runtime-assembly-request-assembly_v1.md`
- **What**
  - 作为 Step 3 request assembly 的实施记录宿主，当前先记录入口判断：主输入源、主消费点、最小新增落点与最小挂点判断。
- **How to verify**
  - 检查文档是否明确：Step 3 为什么不是只看 prompt system，也不是直接落到 provider compat 细部；为什么当前主消费点仍判在 `run/attempt.ts`；为什么建议新增 `src/runtime/request-assembly.ts`。
- **Known Issues**
  - 当前仅完成入口判断，尚未开始 Step 3 代码实施。
- **Next Steps**
  - 在守住边界的前提下，若继续推进 Step 3，则应在已形成的 runtime meta / prompt 邻接解释基础上，继续判断是否需要补更明确的主链消费闭环验证，或停止在此并准备进入 Step 4。
