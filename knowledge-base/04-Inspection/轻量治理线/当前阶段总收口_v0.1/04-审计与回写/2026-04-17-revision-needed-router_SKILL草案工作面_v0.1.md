# revision-needed-router｜SKILL 草案工作面 v0.1

- 日期：2026-04-17
- 起草：Anna
- 状态：drafting
- 性质：正式 `SKILL.md` 草案工作面
- 用途：将 `revision-needed-router` 推进到正式 `SKILL.md` 草案阶段，但必须先把“默认最近有效判断面、不默认上提、复杂分叉允许待人工确认”的复杂度边界写死。
- 版本目录：轻量治理线 / 当前阶段总收口_v0.1
- 所属层级：审计与回写
- 当前阶段：路径 2 / 正式 SKILL.md 草案阶段
- 承接口径：分层推进 / 带复杂度边界进入

---

## 一、当前草案结论

> `revision-needed-router` 可进入正式 `SKILL.md` 草案编写，
> 但必须带复杂度边界进入，不能写成自动上提或自动裁决器。

---

## 二、建议 skill 名称
- `revision-needed-router`

## 三、建议 description 草案
Use when an audit or review result is `revision-needed` and the real problem is where the work should return, what should be patched, which judgment surface should resume, and what the next action should be after acceptance. Defaults to routing back to the nearest valid judgment surface instead of escalating upward. For cross-layer or multi-branch rollback, it should surface the likely route, evidence, and human confirmation points rather than pretending certainty.

---

## 四、先写死的复杂度边界（必须原样保留到正式草案）

### 1. 默认回最近有效判断面，不默认上提
- `revision-needed` 不自动等于回更高层重开
- 优先回到产生该判断的最近有效判断面

### 2. 复杂分叉允许待人工确认
遇到：
- 跨层回退
- 多分叉并行回转
- 并发补件
时，应允许输出：
- 当前建议回转层
- 依据
- 待人工确认点

### 3. 不吸收其他判断层
它不负责：
- 注册层入口判断
- 主产物判断
- 整组阶段判断

### 4. 不把 accepted 后动作写成原地打转
accepted 后应接到下一有效动作，而不是继续停在原判断面。

---

## 五、草案骨架

### 1. 它做什么
1. 判断 `revision-needed` 应回哪层
2. 判断补件后应回哪个最近有效判断面
3. 判断 accepted 后下一动作应接到哪里
4. 把散乱回转逻辑收成统一结构块

### 2. 它不做什么
- 不自动裁决整条链重开
- 不替审计位判定 `revision-needed` 是否成立
- 不吞掉主产物判断或注册层判断
- 不把复杂回转场景伪装成简单回一层

### 3. 何时触发
- 已出现 `revision-needed`
- 当前真正问题是“回哪层 / 补什么 / 回审面在哪 / accepted 后怎么接”
- 当前回转逻辑散乱，需统一结构化

### 4. 最小输入
- 当前判断结论
- 当前补件项
- 当前判断面 / 阶段面
- 已知回转争议

### 5. 最小输出
- 建议回转层
- 最近有效判断面
- accepted 后下一动作
- 人工确认点（如有）

---

## 六、当前风险点

### 主风险
- 多分叉 / 跨层 / 并发回转样本仍不足

### 当前收口
所以正式草案必须支持：
> **复杂情况输出“建议 + 依据 + 待确认点”，而不是伪装成已裁定。**

---

## 七、当前是否可进入草案审查
> **可进入，但需先过复杂度风险审查。**

理由：
- 当前核心能力已被真实案例证明一次
- 但复杂度边界是正式 skill 最关键的保险丝

---

## 八、下一步
1. 先按本工作面写正式 `SKILL.md` 草案
2. 优先把复杂度边界写死
3. 草案完成后进入风险审查，再决定是否补多分叉 references
