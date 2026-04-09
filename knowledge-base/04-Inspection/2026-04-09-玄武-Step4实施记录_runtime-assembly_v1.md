# 玄武 Step 4 实施记录｜runtime assembly v1

- 日期：2026-04-09
- 执行对象：玄武
- 性质：实施记录 / 入口判断 / 后续持续更新宿主
- 所属主线：Runtime Pipeline / runtime assembly 第一轮
- 对应阶段：Step 4 `runtime-assembly`
- 当前状态：第一刀已实施，并通过最小复验
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/shaun-wiki/91-Curie-Knowledge-Base/Runtime-Pipeline/01-Notes/2026-04-09-runtime-assembly-第一轮施工说明交接文档_v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/Runtime-Pipeline/01-Notes/2026-04-09-runtime-assembly-Step4-行动卡_v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-玄武-Step1实施记录_runtime-assembly-context-assembly_v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-玄武-Step2实施记录_runtime-assembly-context-assembly_v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-玄武-Step3实施记录_runtime-assembly-request-assembly_v1.md`

---

## 一、当前阶段说明
这份文档当前仍承担 Step 4 的实施记录宿主角色，
但已从“纯入口判断”推进到：
> **入口判断已落 + runtime-assembly 最小宿主已实施 + 最小复验已完成。**

当前本文既记录：
- runtime assembly 的主输入 / 主消费点 / 最小挂点判断
- 最小新增文件应落哪

也开始记录：
- 实际新增文件
- 最小 export / schema
- focused test
- 全量类型检查

---

## 二、Step 4 当前目标
根据 Curie 交接文档与行动卡，Step 4 不是去重做 Step 1/2/3，
也不是直接掉进执行期，而是要：
> **把 context / capability / request 三块第一次聚合成一个可解释的 runtime assembly。**

### 本步完成后应能回答
1. 哪一个统一入口负责这轮 runtime assembly
2. context / capability / request 是否已第一次在系统内被统一收口
3. stable / dynamic / cache-breaking 是否至少首次成字段

### 当前边界
- 不顺手重写 prompt system
- 不顺手进入 tool execution lifecycle
- 不顺手改成完整 runtime governance / observability 框架

---

## 三、当前主输入判断
### Step 1 输入块
- `contextAssembly`
- 当前已在 `EmbeddedPiAgentMeta` 中有最小摘要

### Step 2 输入块
- `capabilitySurface`
- 当前已在 `EmbeddedRunAttemptResult`、`agentMeta`、`systemPromptReport` 中有最小摘要链

### Step 3 输入块
- `requestParams`
- 当前已在 `EmbeddedRunAttemptResult`、`agentMeta`、`systemPromptReport` 中有最小摘要链

### 其他运行时聚合邻接输入
- `systemPromptReport`
- `agentMeta`
- `promptCache` / `promptCache.observation`
- `stopReason`
- `usage` / `lastCallUsage`

### 当前判断
Step 4 的 source layer 不是新的独立来源，
而是：
> **前 3 步已经长出的解释层结果块 + run 侧现有聚合元数据。**

---

## 四、当前主消费点判断
### 判定
当前更像 Step 4 主消费点的宿主是：
- `src/agents/pi-embedded-runner/run.ts`

### 理由
因为 `run.ts` 当前已经负责：
- 调度 attempt 结果
- 聚合 `agentMeta`
- 挂 `systemPromptReport`
- 产出 `EmbeddedPiRunResult.meta`
- 承接 stopReason / usage / error / payloads 等 run 级信息

也就是说：
> **Step 4 要找的不是“前段预装配带”，而是“外层最终统一收口带”。**

这条带当前更像落在 `run.ts`，而不是继续停在 `run/attempt.ts`。

---

## 五、当前最稳的最小新增落点
### 建议新增
- `src/runtime/runtime-assembly.ts`

### 当前职责
由 `runtime-assembly.ts` 去做：
- 接收 context / capability / request 的解释层结果
- 接收 run 侧必要元数据
- 输出最小 `RuntimeAssemblyOutput`
- 输出最小 `CacheBoundaryInfo`

### 当前不建议
- 直接在 `run.ts` 里内联堆 runtime assembly 结构
- 直接把 Step 4 写成完整 execution/runtime governance 中心
- 直接把 cache boundary 扩成完整缓存策略系统

---

## 六、当前最稳的最小挂点判断
### 当前判断
Step 4 的最小挂点，不应落在：
- `run/attempt.ts` 内部（太早，仍是 Step 1/2/3 的局部消费带）
- `createAgentSession(...)` 之后的执行期细部（太深）

而应落在：
> **`run.ts` 中，attempt result 已返回、`agentMeta/systemPromptReport` 已可读，但最终 `EmbeddedPiRunResult.meta` 仍未完全收口的 outer-run aggregation band。**

一句话：
> **Step 4 的最小挂点应在 outer-run aggregation band，而不是 pre-session / request preflight band。**

---

## 七、当前不建议误选的点
### 1. `run/attempt.ts`
**原因：**
- 它是 Step 1/2/3 的主消费带
- 太早，不适合做最终统一收口

### 2. `system-prompt-report.ts`
**原因：**
- 它是 prompt 邻接解释宿主
- 不是 runtime assembly 总收口宿主

### 3. `types.ts` / `run/types.ts`
**原因：**
- 它们是类型定义位
- 不是第一刀的逻辑宿主

---

## 八、当前最小结论
截至当前，玄武对 Step 4 的最稳判断是：

> **Step 4 runtime assembly 的主输入，不是新的独立 source，而是 Step 1/2/3 已形成的解释层结果块与 run 侧元数据；当前更像主消费点的宿主应判为 `src/agents/pi-embedded-runner/run.ts`；最小新增落点应为 `src/runtime/runtime-assembly.ts`，并在 outer-run aggregation band 接入。**

---

## 九、当前已实施的第一刀（新增）
### 1. 已新增最小宿主
已在源码仓新增：
- `src/runtime/runtime-assembly.ts`
- `src/runtime/runtime-assembly.test.ts`

### 2. 当前第一刀做了什么
当前最小宿主已完成：
- 定义 `RuntimeAssemblyInput`
- 定义 `RuntimeAssemblyOutput`
- 定义 `CacheBoundaryInfo`
- 提供 `buildRuntimeAssembly(...)`

### 3. 当前先收的汇总面
- `contextAssembly`
- `capabilitySurface`
- `requestParams`
- `systemPromptReport`
- `agentMeta`
- `promptCache`
- `usage`
- `stopReason`
- `error`

### 4. 当前先导出的 cache boundary
- `stablePrefixInputs`
- `dynamicDeltaInputs`
- `cacheBreakers`

### 5. 当前复验结果
已完成：
- 新增测试：`src/runtime/runtime-assembly.test.ts`
- 全量类型检查：`tsc -p tsconfig.json --noEmit`

复验口径：
- 新增测试退出码：`0`
- 全量类型检查退出码：`0`

当前可以成立为：
> **Step 4 第一刀最小宿主已落地，并通过 focused test 与全量类型检查。**

### 6. 当前新增接线（补记）
已在：
- `src/agents/pi-embedded-runner/run.ts`
- `src/agents/pi-embedded-runner/types.ts`
- `src/runtime/runtime-assembly.ts`

完成 Step 4 的下一小步：
- 在 `run.ts` 成功路径的 outer-run aggregation band 组出 `runtimeAssembly`
- 将其带入最终 `meta` 返回
- 暂不扩到更深错误路径 / execution 主链

当前 runtimeAssembly 汇总内容仍保持：
- contextAssembly
- capabilitySurface
- requestParams
- systemPromptReport
- agentMeta
- promptCache
- usage
- stopReason
- error

### 7. 类型口径收口（补记）
本轮在 Step 4 接线时出现过两个局部卡点：
1. 更早返回分支里残留了 `runtimeAssembly` 引用，导致“先用后定义”
2. 成功路径里使用了不正确的 `stopReason` 局部名

最终已收口为：
- 摘掉更早分支里的残留 `runtimeAssembly` 引用
- 在成功路径使用当前段可用的 stop reason 来源

当前口径：
> **这次卡点发生在 outer-run aggregation band 的局部接线，而不是 Step 4 挂点判断本身；当前类型口径已收住。**

### 8. 当前更新后的状态
因此当前 Step 4 应写成：
> **入口判断已成立；最小宿主已落地；outer-run aggregation band 已完成第一刀接线；focused test 与全量 tsc 已通过；但更深的 runtime assembly 消费闭环仍未开始。**

### 9. 最终成功返回块 meta 收口（新增）
在 Curie 审阅指出“`runtimeAssembly` 已在成功路径被组出，但尚未真正挂入最终 `EmbeddedPiRunResult.meta`”之后，本轮已补最后一格：

#### 已在：
- `src/agents/pi-embedded-runner/run.ts`

#### 当前新增内容
- 在最终成功返回块的 `meta` 中，显式并入 `runtimeAssembly`
- 这意味着 `runtimeAssembly` 当前不再只是 outer-run aggregation band 里的中间组装物，而是已经进入最终成功返回结果

#### 当前复验结果
- `src/runtime/runtime-assembly.test.ts`：`EXIT 0`
- `tsc -p tsconfig.json --noEmit`：`EXIT 0`

#### 当前口径
> **Step 4 此前最后一条缺口已闭合：`runtimeAssembly` 已真正进入最终成功返回块的 `meta`。**

## 十、当前还没做什么
- 尚未补更强的 runtime assembly 消费闭环验证
- 尚未输出更完整的 Step 4 before / after 主链验证结果
- 是否继续向更深消费闭环推进，尚待按 Curie / Anna / BOSS 的口径再判断

所以当前文档应写成：
> **Step 4 第一刀已完成最小闭环：最小宿主已落地，outer-run aggregation band 已接线，`runtimeAssembly` 已进入最终成功返回块 `meta`，focused test 与全量 tsc 已通过；后续是否继续扩到更深消费闭环，另行判断。**

---

## 十一、后续更新规则
若继续推进 Step 4，后续在本文继续补：
1. 实际改动文件
2. 最小 export / schema
3. focused tests / tsc
4. outer-run aggregation 邻接解释
5. 已知问题与偏差说明

---

## 十二、5 字段 handoff
- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-玄武-Step4实施记录_runtime-assembly_v1.md`
- **What**
  - 记录 Step 4 runtime assembly 从入口判断推进到最小闭环成立：最小宿主、outer-run aggregation band 接线、最终成功返回块 `meta.runtimeAssembly` 收口，以及对应 focused test / tsc 结果。
- **How to verify**
  - 检查文档是否明确：1）Step 4 不是新 source，而是前三步结果块 + run 元数据的汇总面；2）`runtimeAssembly` 已真正进入最终成功返回块 `meta`；3）focused test 与全量 tsc 已通过；4）剩余问题仅是是否继续扩到更深消费闭环。
- **Known Issues**
  - 当前代码缺口已收住；剩余问题不在于“是否已开始实施”，而在于是否还需要继续补更强的 runtime assembly 消费闭环验证。
- **Next Steps**
  - 在守住边界的前提下，若继续推进 Step 4，则应在当前已完成最小宿主、outer-run aggregation band 接线与最终 meta 收口的基础上，判断是否还需要补更明确的 runtime assembly 消费闭环验证，或停止在此并完成第一轮总收口。
