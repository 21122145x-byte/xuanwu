# revision-needed-router 技能说明草案 v0.1

- 日期：2026-04-15
- 起草：粉雪
- 状态：drafting
- 性质：skill 说明草案
- 用途：为 `revision-needed-router` 提供第一版技能说明，明确触发条件、输入输出、边界、最小工作流与禁止事项。
- 版本目录：轻量治理线 / 当前阶段总收口_v0.1
- 所属层级：候选 skill / 三张主焦点
- 当前阶段：真实样例试跑前收口 / accepted-for-pretrial
- 上位文档：
  - `2026-04-15-skill候选拆解卡_revision-needed-router_v0.1.md`
- 下位文档：
  - `2026-04-15-revision-needed-router_输入输出样例集_v0.1.md`
  - `2026-04-15-revision-needed-router_试跑记录_v0.1.md`

---

## 1. 建议 skill 名称
- `revision-needed-router`

## 2. 建议 description（触发描述草案）
Comprehensive revision-needed router for audit-return flows, patch routing, and structured next-step recovery. Use when an audit result or review feedback needs to: (1) check whether a revision-needed route is complete, (2) suggest which layer to return to, (3) structure follow-up patch actions, or (4) normalize scattered revision-needed reasoning into a clear recovery block without replacing human judgment.

## 3. 触发条件
当出现以下任一情况时应触发：
- 用户要求判断 revision-needed 该回哪层
- 用户要求整理审后回转结构
- 当前已有审计意见，但缺明确回转路径
- 当前 revision-needed 消息散乱，需要整理成统一结构

## 4. 不触发条件
以下情况不应触发或不应单独依赖该 skill：
- 审计结论本身尚未形成
- 当前需要的是最终放行判断
- 当前问题明显更像 blocked / 重编排
- 当前缺口还不足以判断回转层级

## 5. 输入
最小支持以下输入：
1. 审计意见摘要
2. 当前阶段状态
3. 当前产物位置 / 回收位置
4. 已知缺口与待补内容

## 6. 输出
最小输出应限于以下三类：
1. revision-needed 缺项检查结果
2. 回转层级建议草稿
3. 补口对象与下一步动作草稿

## 7. 建议输出结构（示意）
```md
- 当前审计结论：revision-needed
- 当前主要缺口：
- 建议回转层级：
- 建议补口对象：
- 下一步：
```

## 8. 最小工作流
1. 识别当前是否属于 revision-needed 场景
2. 检查是否缺回转必要信息
3. 若缺项，先指出缺项
4. 输出回转层级建议与补口对象建议
5. 若边界不清，保留不确定性，不伪造已裁决结论
6. 输出统一回转结构版本

## 9. 禁止事项
- 不得自动判定 revision-needed 是否成立
- 不得自动写死回转层级
- 不得替代主入口位重编排后续阶段
- 不得把建议写成最终裁决
- 不得把应 blocked 的问题压成 revision-needed 小修补

## 10. 当前边界
这个 skill 的定位是：
- revision-needed 路由辅助器
- 回转结构整理器
- 补口对象提示器

它不是：
- 审计裁判
- 回转裁判
- 重编排器

## 11. 一句话收口
> `revision-needed-router` 只负责把 revision-needed 的回转结构、补口对象和下一步动作收清、补齐、整理出来，不负责替代人做最终回转裁决。
