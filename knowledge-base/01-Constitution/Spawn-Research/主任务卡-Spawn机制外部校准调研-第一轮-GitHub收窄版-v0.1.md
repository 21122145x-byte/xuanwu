# 主任务卡：Spawn 机制外部校准调研（第一轮 / GitHub 收窄版）v0.1

## 任务信息
- Task ID: T-20260328-SPAWN-CALIBRATION-01
- Issued By: 旺财
- Primary Owner: 旺财
- Task Rating: P3
- Execution Mode: Mixed（A/B 异源执行 + 主 Agent 收束）

---

## 任务目标
在不使用默认 `web_search`、不使用 `minimax web search mcp` 的前提下，先收窄到 GitHub 公开信息域，完成 Spawn 机制第一轮外部校准调研。

本轮目标不是定稿最终制度，
而是先回答：
1. 我们当前机制骨架，哪些部分被外部实践支持？
2. 哪些部分会被外部实践挑战？
3. 哪些收益点与坑点，已经能初步从外部样本中看到？

---

## 本轮边界（In Scope）
1. 只看 GitHub 公开信息
2. 只围绕 Spawn 机制骨架相关问题展开
3. 只做第一轮外部校准，不做终稿结论
4. A/B 两线都必须按各自子任务边界收紧执行

---

## 本轮明确不做（Out of Scope）
1. 不做全网搜索
2. 不用默认 `web_search`
3. 不用 `minimax web search mcp`
4. 不做 Moltbook / X 第一轮外部采样
5. 不直接产出最终制度定稿

---

## 执行拆分

### A 线（异源）
- 执行单元：`kimi-coding-plan`
- 主题：成立性验证 + 结构参照

### B 线（异源）
- 执行单元：`minimax-m2.7`
- 主题：收益点验证 + 坑点验证
- 限制：不承担强搜索依赖任务

### 主 Agent
- 负责两线结果整合
- 负责对照 `spawn-mechanism-overview-fragment-v0.1`
- 负责输出“支持点 / 挑战点 / 修正建议”

---

## 输入材料
1. `spawn-mechanism-overview-fragment-v0.1.md`
2. `spawn-mechanism-external-calibration-research-outline.md`
3. A/B 两线预检结论
4. 当前工具约束：只用 `gh` 查 GitHub

---

## 输出要求
最终输出必须包含：
1. 本轮外部校准的结论摘要
2. A 线结果摘要
3. B 线结果摘要
4. 外部支持点
5. 外部挑战点
6. 对当前骨架的修正建议
7. 未决问题

---

## 验收标准
1. A/B 两线都基于 GitHub 公开信息，而不是内部材料冒充外部校准
2. 不越过边界调用禁用工具
3. 最终输出能直接帮助我们判断骨架该保留什么、修正什么
4. 不把第一轮外部样本写成最终定论

---

## Completion Signal
`Task Complete: Yes / No`
