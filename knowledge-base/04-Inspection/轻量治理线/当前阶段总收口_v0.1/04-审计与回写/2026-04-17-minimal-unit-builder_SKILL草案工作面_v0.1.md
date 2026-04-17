# minimal-unit-builder｜SKILL 草案工作面 v0.1

- 日期：2026-04-17
- 起草：Anna
- 状态：drafting
- 性质：正式 `SKILL.md` 草案工作面
- 用途：将 `minimal-unit-builder` 从候选治理件推进到正式 `SKILL.md` 草案阶段，先固定骨架、触发条件、职责边界与最小输出口径。
- 版本目录：轻量治理线 / 当前阶段总收口_v0.1
- 所属层级：审计与回写
- 当前阶段：路径 2 / 正式 SKILL.md 草案阶段
- 承接口径：分层推进 / 直接进入

---

## 一、当前草案结论

> `minimal-unit-builder` 可直接进入正式 `SKILL.md` 草案编写。

当前不再停留在“是否够格写 skill”，
而进入：
- 正式 skill 名称
- 触发描述
- 职责边界
- 最小输入输出
- 风险红线

---

## 二、建议 skill 名称
- `minimal-unit-builder`

## 三、建议 description 草案
Use when a task is too thick to dispatch directly and needs to be compressed into the smallest executable unit without losing the real goal. Good for detecting fake splitting, fake prompt shrinking, and “looks smaller but still not executable” situations. Not for main-artifact judgment, audit-return routing, or registry/entry-state decisions.

---

## 四、草案骨架

### 1. 它做什么
只做三件事：
1. 判断当前问题是否过厚，尚未达到可执行最小对象
2. 把厚问题压成最小可执行对象 / 最小判断对象 / 最小拍板对象
3. 拒绝假缩小：只换标题、只切段、只换措辞但仍不可执行

### 2. 它不做什么
- 不负责判断谁是主产物
- 不负责判断 `revision-needed` 该回哪层
- 不负责替主 Agent 重编整条主线
- 不把“任务拆细”伪装成“问题已解决”

### 3. 何时触发
- 当前任务目标清楚，但粒度过厚
- 当前卡点不是“不知道做什么”，而是“不知道怎样切成可执行最小对象”
- 当前存在“形式上分段，但执行上仍过厚”的风险

### 4. 不应触发
- 主产物判断问题
- 审后回转路径问题
- 注册层 / 默认读取顺序 / 状态判断问题
- 最小执行对象其实已经明确，只是材料很多

### 5. 最小输入
- 当前厚问题摘要
- 当前目标
- 当前卡点
- 现有材料 / 产物位置

### 6. 最小输出
- 应压成的最小对象类型
- 该对象为何足够小且仍可执行
- 明确排除的“假缩小”说明

---

## 五、正式写作时必须保留的硬边界

1. **最小对象必须可执行、可验证、可回收**
2. **不能把最终目标改写成最小动作**
3. **不能只通过标题变短来制造“已压小”幻觉**
4. **不能吸收主产物判断、回转路由、注册层入口判断**

---

## 六、当前风险点

### 已知风险
- 样本量仍不足
- 尚未覆盖更多不同形态的厚问题

### 非当前主风险
- 本体定义模糊
- 邻近边界失控

也就是说，当前主要风险是：
> **样本覆盖不够，不是定义发虚。**

---

## 七、当前是否可进入草案审查
> **可进入。**

理由：
- 边界已足够清楚
- 风险集中在样本扩展，而不是职责发散

---

## 八、下一步
1. 按本骨架正式落 `SKILL.md` 草案正文
2. 若需要，可补 1 份 references：假缩小典型样例
3. 草案完成后进入草案审查
