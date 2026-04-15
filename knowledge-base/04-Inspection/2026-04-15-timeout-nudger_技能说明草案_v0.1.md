# timeout-nudger 技能说明草案 v0.1

- 日期：2026-04-15
- 起草：粉雪
- 状态：drafting
- 性质：skill 说明草案
- 用途：为 `timeout-nudger` 提供第一版技能说明，明确触发条件、输入输出、边界、最小工作流与禁止事项。
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-skill候选拆解卡_timeout-nudger_v0.1.md`
- 下位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-timeout-nudger_输入输出样例集_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-timeout-nudger_试跑记录_v0.1.md`

---

## 1. 建议 skill 名称
- `timeout-nudger`

## 2. 建议 description（触发描述草案）
Comprehensive timeout nudger for Discord semi-automatic workflows and checkpoint-based task flows. Use when a task needs to: (1) check whether a checkpoint has timed out, (2) generate a standard nudge/reminder message for the responsible role, (3) normalize scattered coordination reminders into a formal timeout action, or (4) help the coordinator expose stalled states without replacing human judgment about escalation or resolution.

## 3. 触发条件
当出现以下任一情况时应触发：
- 用户或协调位要求检查当前任务是否超时
- 当前任务处于带检查点的状态
- 到检查点仍无正式结论或正式阻塞说明
- 当前协调位需要整理一条标准催办消息

## 4. 不触发条件
以下情况不应触发或不应单独依赖该 skill：
- 当前还没到检查点
- 当前责任位刚刚给出正式回执
- 当前任务需要的是最终裁决而非催办
- 当前只是在做轻量提醒，不进入正式催办动作

## 5. 输入
最小支持以下输入：
1. 当前任务状态
2. 检查点时间 / 超时阈值
3. 当前责任位
4. 当前任务卡摘要

## 6. 输出
最小输出应限于以下三类：
1. 超时检查结果
2. 标准催办消息草稿
3. 催办动作记录建议

## 7. 建议输出结构（示意）
```md
- 当前状态：
- 检查点：
- 当前责任位：
- 是否已超时：
- 建议催办动作：
```

## 8. 最小工作流
1. 识别当前是否属于带检查点的状态
2. 检查是否已到超时点
3. 若超时，指出缺失结论或缺失阻塞说明
4. 输出催办消息草稿
5. 保留边界，不把催办写成裁决
6. 输出统一催办动作块

## 9. 禁止事项
- 不得自动判定 accepted / blocked
- 不得替责任位补正式结论
- 不得把催办写成任务失败结论
- 不得在未到检查点时强行催办
- 不得替协调位决定是否升级责任链

## 10. 当前边界
这个 skill 的定位是：
- 超时检查器
- 催办消息辅助器
- 催办动作格式规范器

它不是：
- 状态裁决器
- 升级裁判
- 自动闭环器

## 11. 一句话收口
> `timeout-nudger` 只负责把超时检查和催办动作收清、补齐、整理出来，不负责替代人做最终状态裁决与升级判断。
