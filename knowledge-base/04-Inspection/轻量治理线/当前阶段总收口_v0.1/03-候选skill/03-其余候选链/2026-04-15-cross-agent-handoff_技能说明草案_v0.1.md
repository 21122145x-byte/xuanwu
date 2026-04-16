# cross-agent-handoff 技能说明草案 v0.1

- 日期：2026-04-15
- 起草：粉雪
- 状态：drafting
- 性质：skill 说明草案
- 用途：为 `cross-agent-handoff` 提供第一版技能说明，明确触发条件、输入输出、边界、最小工作流与禁止事项。
- 版本目录：轻量治理线 / 当前阶段总收口_v0.1
- 所属层级：候选 skill / 其余候选链
- 当前阶段：候选链已形成 / 当前优先级后置
- 上位文档：
  - `2026-04-15-skill候选拆解卡_cross-agent-handoff_v0.1.md`
- 下位文档：
  - `2026-04-15-cross-agent-handoff_输入输出样例集_v0.1.md`
  - `2026-04-15-cross-agent-handoff_试跑记录_v0.1.md`

---

## 1. 建议 skill 名称
- `cross-agent-handoff`

## 2. 建议 description（触发描述草案）
Comprehensive cross-agent handoff formatter and checker for formal Discord coordination flows. Use when a message needs to: (1) become a formal cross-agent handoff, (2) validate whether a handoff/reply is structurally complete, (3) generate a standard 【收到】 / 【任务完成】 / 打回 / 重提 message, or (4) normalize scattered coordination text into the formal structure required by the protocol.

## 3. 触发条件
当出现以下任一情况时应触发：
- 用户要求整理正式交接消息
- 用户要求检查交接消息合格性
- 当前需要发【收到】回执
- 当前需要发【任务完成】回传
- 当前需要整理打回 / 重提消息

## 4. 不触发条件
以下情况不应触发或不应单独依赖该 skill：
- 当前尚未明确交接对象
- 当前只是讨论，不是正式交接
- 当前需要的是协调位做主权判断，而不是格式整理
- 当前没有文档路径 / 文件路径且也无补路径能力

## 5. 输入
最小支持以下输入：
1. 当前任务摘要 + 文档路径
2. 交接对象 Discord ID
3. 当前消息草稿
4. 当前交接类型

## 6. 输出
最小输出应限于以下三类：
1. 缺项检查结果
2. 正式交接 / 回执消息草稿
3. 整理后的统一消息块

## 7. 建议输出结构
正式交接默认至少包含：
- Where
- What
- How to verify
- Known Issues
- Next Steps
- 文档链接 / 文件路径
- 文末 `<@Discord数字ID>`

## 8. 最小工作流
1. 识别当前消息类型
2. 检查是否满足对应类型的最小字段要求
3. 若缺字段，先指出缺项
4. 基于上下文补正式消息草稿
5. 保留边界，不伪造“对方已承接 / 已完成”
6. 输出统一格式版本

## 9. 禁止事项
- 不得伪造 `<@Discord数字ID>`
- 不得把消息合格写成任务已被承接
- 不得替代人决定交给谁
- 不得伪造不存在的文档路径
- 不得把讨论消息硬整理成正式交接，除非用户明确要这么做

## 10. 当前边界
这个 skill 的定位是：
- 正式交接消息检查器
- 回执模板补全器
- 消息格式规范器

它不是：
- 调度裁判
- 承接确认器
- 阶段放行器

## 11. 一句话收口
> `cross-agent-handoff` 只负责把跨 Agent 正式交接消息收成合格结构，不负责替代人判断交接是否合理或是否被真正承接。
