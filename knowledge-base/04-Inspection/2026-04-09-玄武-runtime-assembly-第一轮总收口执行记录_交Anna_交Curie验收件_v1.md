# 玄武 runtime assembly 第一轮总收口执行记录｜交 Anna / 交 Curie 验收件 v1

- 日期：2026-04-09
- 执行对象：玄武
- 性质：第一轮总收口执行记录 / 交 Anna / 交 Curie 验收件
- 所属主线：Runtime Pipeline / runtime assembly 第一轮
- 范围：Step 1 ~ Step 4
- 当前状态：第一轮最小闭环已成立，进入验收口径

---

## 一、总结论

> **runtime assembly 第一轮当前可以成立为：最小闭环已完成。**
>
> 已成立的不是“完整 runtime governance / observability 闭环”，
> 而是：
> - Step 1 已完成 `contextAssembly` 最小接线与可见化
> - Step 2 已完成 `capabilitySurface` 最小接线与消费闭环
> - Step 3 已完成 `requestParams` 最小接线与消费闭环
> - Step 4 已完成 `runtimeAssembly` 最小宿主、outer-run aggregation band 接线，以及最终成功返回块 `meta` 收口
>
> 当前更准确的验收口径应写成：
> **runtime assembly 第一轮已经完成“前三步解释层结果块 + run 级元数据”的最小汇总闭环。**

---

## 二、本轮完成范围

### Step 1：context assembly
已形成：
- `RuntimeContextAssembly`
- `buildContextAssembly(...)`
- 成功路径 `agentMeta.contextAssembly`
- `effectiveAgentBody` / `agentBodySource`
- `sender` 统一解释块
- 最小单测 / 类型检查 / 文档回写 / 本地提交

当前成立为：
> **Step 1 已把 context 侧最小解释层结果块长出来，并挂到最小可消费位置。**

### Step 2：capability surface
已形成：
- `src/runtime/capability-surface.ts`
- pre-session assembly band 接线
- runtime meta / prompt 邻接解释
- `CapabilitySurfaceItem` 精度补强
- `availabilityOverrides`
- `modelVisibleOverrides`
- 文档 / 代码双收口

当前成立为：
> **Step 2 已把 capability 侧最小解释层结果块长出来，并完成第一轮消费闭环。**

### Step 3：request assembly
已形成：
- `src/runtime/request-assembly.ts`
- attempt band 接线
- run / prompt meta 邻接可见化
- request 参数解释层最小消费闭环
- focused test / tsc / 文档 / 提交

当前成立为：
> **Step 3 已把 request 侧最小解释层结果块长出来，并完成第一轮消费闭环。**

### Step 4：runtime assembly
已形成：
- `src/runtime/runtime-assembly.ts`
- `RuntimeAssemblyInput`
- `RuntimeAssemblyOutput`
- `CacheBoundaryInfo`
- `buildRuntimeAssembly(...)`
- `run.ts` outer-run aggregation band 第一刀接线
- `EmbeddedPiRunMeta.runtimeAssembly?`
- 最终成功返回块 `meta.runtimeAssembly` 收口
- focused test / `tsc -p tsconfig.json --noEmit` 通过

当前成立为：
> **Step 4 已把前三步结果块与 run 元数据收成最小 runtime assembly，并真正带入最终成功返回块 `meta`。**

---

## 三、当前正式成立的口径

### 可以正式写成
> **runtime assembly 第一轮已完成最小闭环。**

它包括：
- 最小 source 解释层结果块已具备：
  - `contextAssembly`
  - `capabilitySurface`
  - `requestParams`
- 汇总层最小宿主已具备：
  - `runtimeAssembly`
- run 侧最小消费闭环已具备：
  - `agentMeta` 摘要可见化
  - `systemPromptReport` 邻接解释
  - 最终成功返回块 `meta.runtimeAssembly`

### 不能写成
> **runtime assembly 已完成完整 runtime governance / observability 闭环。**

### 也不能写成
> **timeout / incomplete / 各旁支错误返回块均已完成对齐。**

当前这两条都超前。

---

## 四、证据链

### 代码证据
- Step 1：`src/agents/pi-embedded-runner/run.ts` / Step 1 相关 context assembly 接线
- Step 2：`src/runtime/capability-surface.ts` + `run/attempt.ts` 邻接接线
- Step 3：`src/runtime/request-assembly.ts` + attempt / run / prompt meta 接线
- Step 4：
  - `src/runtime/runtime-assembly.ts`
  - `src/runtime/runtime-assembly.test.ts`
  - `src/agents/pi-embedded-runner/types.ts`
  - `src/agents/pi-embedded-runner/run.ts`

### 结果证据
- `runtime-assembly.test.ts` 通过
- `tsc -p tsconfig.json --noEmit` 通过
- `runtimeAssembly` 已真正进入最终成功返回块 `meta`
- Curie 点名的“最后一格缺口”已闭合

### 文档证据
- `2026-04-09-玄武-Step1实施记录_runtime-assembly-context-assembly_v1.md`
- `2026-04-09-玄武-Step2实施记录_runtime-assembly-context-assembly_v1.md`
- `2026-04-09-玄武-Step3实施记录_runtime-assembly-request-assembly_v1.md`
- `2026-04-09-玄武-Step4实施记录_runtime-assembly_v1.md`
- 当前本文档：第一轮总收口执行记录 / 验收件

---

## 五、当前仍保留的边界

### 已明确不顺手扩
- 不把 Step 4 扩成完整 runtime governance 中心
- 不顺手补全所有 timeout / incomplete / error 旁支返回块
- 不回头返工 Step 1~3 主链方向
- 不把 cache boundary 一次做厚

### 当前仍待后续判断
- 是否需要更强的 before / after 主链消费闭环验证
- 是否需要将 `runtimeAssembly` 继续扩到 timeout / incomplete 等旁支返回块
- 是否需要再补更明确的 runtime meta / prompt 邻接解释

---

## 六、对 Anna 的验收口径

建议 Anna 当前按以下口径验收：

> **本轮可验收的是“第一轮最小闭环成立”，不是“完整系统治理闭环成立”。**

### Anna 应重点核
1. 当前结论是否与源码一致
2. 文档是否已清干净旧状态残留
3. 是否存在把“最小闭环”写成“完整闭环”的超前表述
4. 当前边界是否守住：没有顺手扩成大而散的 runtime 改造

---

## 七、对 Curie 的验收口径

建议 Curie 当前按以下口径验收：

> **第一轮施工目标已达：前三步解释层结果块已成，Step 4 汇总面已成立，并进入 run 最终成功返回块 `meta`。**

### Curie 应重点核
1. Step 4 当前是否仍严格遵守“汇总面，不是新 source”
2. `runtimeAssembly` 是否已真正进入最终成功返回块 `meta`
3. 当前是否只补了真实缺口，而没有返工主链方向
4. 下一轮若继续推进，是否应另立行动卡，而不是在本轮口径里超前扩写

---

## 八、当前已知问题

- 当前代码缺口已基本收住
- 当前剩余风险不在“代码没接上”，而在：
  - 文档是否持续保持与实现一致
  - 下一轮若继续推进，是否会不守边界而扩写过度

因此当前已知问题应写成：
> **本轮主要缺口已闭合；后续风险主要转入“口径治理”和“下一轮边界治理”。**

---

## 九、最小修复路径 / 下一步建议

### 若本轮到此收口
建议正式写成：
> **runtime assembly 第一轮已完成最小闭环，可进入 Anna / Curie 验收。**

### 若要继续第二轮
建议新开独立行动卡，只讨论以下其一：
1. runtime assembly 更强消费闭环验证
2. timeout / incomplete 旁支返回块对齐
3. runtime meta / prompt 邻接解释补强

不建议把这些后续项混回本轮“已完成”口径。

---

## 十、5 字段 handoff
- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-玄武-runtime-assembly-第一轮总收口执行记录_交Anna_交Curie验收件_v1.md`
- **What**
  - 汇总 Step 1~4 当前实施结果，收成 runtime assembly 第一轮总收口执行记录，并给 Anna / Curie 提供统一验收口径。
- **How to verify**
  - 对照 Step1~4 实施记录、Step 4 审阅合并件与对应源码，确认当前是否成立为“第一轮最小闭环已完成”，且没有把最小闭环超写成完整闭环。
- **Known Issues**
  - 当前剩余风险主要在文档口径持续一致性，以及下一轮是否守住扩写边界；不再是本轮代码未接上的问题。
- **Next Steps**
  - 交 Anna / Curie 验收；若继续第二轮，另立行动卡，不混写进本轮完成口径。
