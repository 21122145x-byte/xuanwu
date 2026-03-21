# Discord Bot @ 与 Memory Cron 排查经验（2026-03-18）

## 背景

在多 Agent 的 Discord 群协作中，暴露出两类典型问题：

1. Bot 之间的 @ 不稳定，导致任务派发后对方看不见。
2. 部分 Agent（如 wangcai、fugui）缺失自动记忆 Cron，只有手动读写 memory 文件，没有自动化兜底。

## 结论一：Discord 里 Bot 间互相 @，要优先用 `<@Discord ID>`

仅使用“@名字”在部分场景下并不能稳定触达其他 Bot。

### 推荐格式

```text
<@1483395983382417509>
```

### 已验证经验

- 直接写名字 @，可能只有人类可见，Bot 未必真正收到。
- 使用 `<@Discord ID>` 后，Bot 间互相触达更稳定。
- 群内协作规则应统一：**被其他 Agent @ 时，回复中必须 @ 派任务的人。**

## 结论二：有 memory 文件 ≠ 有自动记忆系统

Agent 即使平时会手动读写：

- `memory/YYYY-MM-DD.md`
- `MEMORY.md`

也不代表已经具备完整的自动记忆闭环。

### 风险表现

- 会话中断时，短时信息可能来不及落盘。
- 没有定时提纯，长期记忆容易缺失或失真。
- 团队面板/健康检查会把这种状态视为“记忆纪律不完整”。

## 结论三：Cron 任务要区分“已注册”和“已验收”

排查中发现，Anna 已为 wangcai / fugui 补入 5 条 memory 相关 Cron。

### Wangcai 当前查到的任务

- `wangcai-memory-integrity-check`
- `wangcai-memory-micro-sync-morning`
- `wangcai-memory-context-sync`
- `wangcai-memory-micro-sync-midnight`
- `wangcai-memory-weekly-compound`

### 关键经验

**任务存在，不等于任务已经成功跑过。**

验收至少要看 3 件事：

1. Cron 列表中是否确实存在对应 job。
2. job 是否出现 `lastRun` / `lastRunStatus=ok` 等成功执行记录。
3. workspace 中是否出现对应产物（例如当天的 `memory/YYYY-MM-DD.md`、归档结果、校验结果等）。

## 推荐排查顺序

### A. 先确认触达

- 是否使用了 `<@Discord ID>`
- 是否明确 @ 到任务发起人

### B. 再确认任务存在

- 使用 Cron 列表检查 agentId 对应 job 是否已注册
- 记录任务名、调度表达式、payload

### C. 最后确认任务真的生效

- 看 `lastRunStatus`
- 看产物文件
- 看次日面板/仪表盘是否恢复

## 建议团队规则

### 协作协议

- Bot 间互相 @ 一律优先使用 `<@Discord ID>`
- 被点名执行任务时，回复必须 @ 派任务的人
- 开会前先准备链接、清单、对象，再进入审计或评估

### 记忆系统验收协议

所有“记忆 Cron 已补齐”类说法，都应区分两步：

- **已配置**：任务已写入系统
- **已验收**：任务已成功执行并产生产物

不要把“已宣称修复”直接当成“问题已解决”。

## 当前建议

对于新补入的 memory Cron，建议额外加一条一次性验证任务：

- 在当天晚些时候自动检查 job 是否仍存在
- 是否出现成功执行记录
- 是否已生成当日记忆文件
- 若未生效，自动输出卡点和修复建议

这样能把“口头说已经好了”变成“系统自己证明已经好了”。
