# revision-needed-router｜最后放行判断卡 v0.1

- 日期：2026-04-17
- 起草：粉雪
- 状态：drafting
- 性质：最后放行判断卡 / 路径 2 执行件
- 用途：在《轻量治理线》路径 2 已推进到第三张主焦点后，对 `revision-needed-router` 做最后放行判断，确认它是否进入 `ready-for-final-gate`，还是仍需 `revision-needed`。
- 版本目录：轻量治理线 / 当前阶段总收口_v0.1
- 所属层级：审计与回写
- 当前阶段：路径 2 / revision-needed-router 最后放行判断
- 主任务位：粉雪

---

## 一、当前判断对象

- 候选 skill：`revision-needed-router`
- 当前阶段结论（既有）：`accepted-for-pretrial`
- 当前轮目标：判断它是否进入：
  - `ready-for-final-gate`
  - 或 `revision-needed`

---

## 二、当前已知前提

### 已成立
1. 四件套已齐：
   - 候选拆解卡
   - 技能说明草案
   - 输入输出样例集
   - 试跑记录
2. 已补最小触发边界卡
3. 已有阶段审计记录
4. 已被收口摘要列为：`accepted-for-pretrial`
5. 路径 2 当前前两张已推进到：
   - `minimal-unit-builder` → `ready-for-final-gate`
   - `main-artifact-judge-helper` → `ready-for-final-gate`

### 仍需保留的边界
1. 尚未进入真实样例试跑
2. “revision-needed 回转卡”本体并未正式独立成件
3. “accepted 后进入下一阶段动作格式”与“更通用轮转规则”当前仍只是候选推进联动，不等于本体已成立

---

## 三、本轮判断标准

### 若要进入 `ready-for-final-gate`，至少需满足
1. **触发边界清楚**
   - 不是看到任何 `revision-needed` 字样就机械回退
   - 而是能识别：哪些情形才真的进入审后回转路由问题

2. **回转层级清楚**
   - 能判断应回到哪一层：
     - 当前执行层
     - 上一阶段结果层
     - 主入口层
     - 审计前收口层
   - 不乱跳层，不一律退回最上层

3. **accepted 后续动作不混读**
   - 不把“accepted”与“直接关闭”混作一件事
   - 能看清 accepted 后到底是：继续推进、转归位、转下一阶段，还是先回主入口

4. **不串线到注册层 / 主产物判断 / 最小单元问题**
   - 不把入口判断、主产物判断、最小单元拆分硬吸进来

### 若上述任一项仍明显不足，则给：
- `revision-needed`

---

## 四、当前初步判断

`revision-needed-router` 的难点，不在于“有没有回转”这个概念，
而在于：
- 回哪一层
- accepted 后怎么继续
- 什么属于真正的审后回转，什么只是普通继续修改

也就是说，它真正难的是：
> **层级与状态一起判断。**

---

## 五、当前仍需重点核的地方

### 1. 会不会一看到 `revision-needed` 就机械回上层
如果是，那它还不够。

### 2. accepted 后动作是否仍模糊
如果 accepted 出来后，仍不能明确：
- 继续哪段
- 回哪层
- 谁接链
那它还不够稳。

### 3. 会不会吸走注册层入口判断
如果问题本质只是：
- 当前该先看哪层
- 当前默认入口是谁

那不应误送进 `revision-needed-router`。

---

## 六、当前核查结论（粉雪判断）

当前看，`revision-needed-router` 在三项上：

### 1. 触发边界
- **基本成立**
- 当前最小触发边界卡已经把“不是所有 revision-needed 都等于同一路由问题”压出来了

### 2. 回转层级
- **基本成立，但比前两张更依赖真实样例验证**
- 当前文档链已能说明“不能机械一律回上层”
- 但它真正的稳度仍更依赖实际命中样本

### 3. accepted 后续动作
- **部分成立**
- 当前已开始补 accepted 后动作格式问题
- 但这一层仍更像候选推进联动，尚未完全独立沉淀成件

---

## 七、当前正式结论建议

基于本轮最后放行判断，粉雪当前建议：
> **`revision-needed-router` 可进入 `ready-for-final-gate`，但它是三张中“最终门前风险提醒”需要写得最重的一张。**

原因：
- 当前最小触发边界已经补出
- 回转层级判断已不是空口径
- accepted 后续动作虽然还没完全独立成件，但当前已足以支撑进入最终门前判断

同时必须保留提醒：
> 三张里最需要在真实样例试跑中继续重点观察的，就是 `revision-needed-router`。 

---

## 八、下一步动作

### 若本张被接受进入 `ready-for-final-gate`
则路径 2 的三张主焦点将形成：
- `minimal-unit-builder` → `ready-for-final-gate`
- `main-artifact-judge-helper` → `ready-for-final-gate`
- `revision-needed-router` → `ready-for-final-gate`

届时将进入新的拍板点：
> **是否接受“路径 2 的三张主焦点已全部进入最终门前状态”，并决定是否组织下一阶段最终门判断 / 真实样例试跑前总放行。**

---

## 九、关联入口
- [[2026-04-17-候选skill放行判断卡_v0.1.md|候选 skill 放行判断卡]]
- [[../03-候选skill/02-三张主焦点/2026-04-15-skill候选拆解卡_revision-needed-router_v0.1.md|revision-needed-router 候选拆解卡]]
- [[../03-候选skill/02-三张主焦点/2026-04-16-revision-needed-router_最小触发边界卡_v0.1.md|revision-needed-router 最小触发边界卡]]
- [[../03-候选skill/02-三张主焦点/2026-04-16-revision-needed-router_阶段审计记录_试跑前收口_v0.1.md|revision-needed-router 阶段审计记录]]

---

## 十、5 字段 handoff
- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/轻量治理线/当前阶段总收口_v0.1/04-审计与回写/2026-04-17-revision-needed-router_最后放行判断卡_v0.1.md`
- **What**
  - 对 `revision-needed-router` 发起最后放行判断，并给出当前正式结论建议。
- **How to verify**
  - 检查本文是否已覆盖：当前对象、已知前提、判断标准、风险点、当前核查结论、正式结论建议与下一步动作。
- **Known Issues**
  - 三张中它最依赖真实样例继续验证，尤其是 accepted 后动作与回转层级的真实命中样本。
- **Next Steps**
  - 若当前建议被接受，则进入“路径 2 三张全部 ready-for-final-gate 后的总拍板点”。 
