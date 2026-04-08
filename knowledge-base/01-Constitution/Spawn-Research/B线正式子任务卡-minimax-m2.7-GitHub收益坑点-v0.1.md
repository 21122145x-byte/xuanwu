# B 线正式子任务卡：minimax-m2.7 / GitHub 收益点与坑点调研 v0.1

## 基本信息
- Subtask ID: ST-20260328-B-GITHUB-RISK
- Parent Task ID: T-20260328-SPAWN-CALIBRATION-01
- Issued By: 旺财
- Assigned To: `minimax-m2.7`
- Execution Mode: 异源正式子任务
- Card Version: 标准版

---

## 任务目标
基于 GitHub 公开可见信息，对 Spawn 机制做第一轮“收益点验证 + 坑点验证”调研。

---

## In Scope
1. 观察公开项目里，这类机制最常被认为带来的收益
2. 观察常见失败模式、过重模式、误判模式
3. 提取与我们当前骨架最相关的收益/风险信号
4. 输出“哪些收益点更像成立、哪些坑点必须警惕”

---

## Out of Scope
1. 不做全网搜索
2. 不用默认 `web_search`
3. 不使用未证实可用的 minimax web search
4. 不扩展到 GitHub 之外的外部源
5. 不直接下最终制度结论

---

## 工具限制
- 只允许：`gh`
- 不允许：`web_search`
- 不允许：`minimax web search mcp`

---

## 输入材料
1. `spawn-mechanism-overview-fragment-v0.1.md`
2. `spawn-mechanism-external-calibration-research-outline.md`
3. 主任务卡：`主任务卡-Spawn机制外部校准调研-第一轮-GitHub收窄版-v0.1.md`

---

## 输出要求
必须包含：
1. 外部收益点摘要
2. 外部坑点摘要
3. 哪些收益点与我们的内部判断一致
4. 哪些坑点对我们当前机制最危险
5. 风险 / 缺口

Output Format：Markdown

---

## 验收标准
1. 必须基于 GitHub 公开信息
2. 必须围绕收益点/坑点，不退回内部材料整理
3. 不得假装搜索链已打通
4. 必须明确哪些是外部支持、哪些只是外部风险信号

---

## 回传格式
1. 结果摘要
2. 收益点 / 坑点正文
3. 风险 / 缺口
4. Completion Signal: `Subtask Complete: Yes / No`
