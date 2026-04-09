# 午盘发布硬闸阻断报告

**日期:** 2026-04-09  
**时间:** 12:16  
**Gate ID:** midday_gate_20260409_121620  
**状态:** blocked_missing_inputs  

## 阻断原因

午盘发布硬闸（midday_publish_gate.py）执行时发现缺少两个关键 cleaned 输入文件：

| 文件 | 状态 |
|------|------|
| sectors_20260409_midday_cleaned.json | ❌ 不存在 |
| fund_flow_20260409_midday_cleaned.json | ❌ 不存在 |

## 已就绪输入

| 文件 | 状态 | 备注 |
|------|------|------|
| breadth_20260409_midday_cleaned.json | ✅ | turnover_basis 已写入"新浪轻量 breadth"口径 |
| indices_20260409_midday_cleaned.json | ✅ | 3只指数 |
| zt_pool_20260409_midday_cleaned.json | ✅ | 20只涨停股 |

## 影响

- writer 未执行（被 input check 阻断）
- audit 未执行
- render 未执行
- **正式午盘稿/正式长图未输出**

## 根因（初步）

sectors 和 fund_flow 的 midday 抓取任务今日（2026-04-09）未成功生成 cleaned 文件。可能原因：

1. 抓取任务未在 12:00-12:15 时段触发
2. 抓取任务执行了但中途失败
3. 抓取任务完成但 cleaned 步骤未运行
4. 文件存在但命名/路径与 gate 期望不一致

## 待验证事项

- [ ] 确认 sectors 抓取 cron 今日是否执行
- [ ] 确认 fund_flow 抓取 cron 今日是否执行
- [ ] 检查 sectors raw → cleaned 链路是否有报错
- [ ] 检查 fund_flow raw → cleaned 链路是否有报错
- [ ] 如抓取任务未触发，需排查 cron 配置

## 复盘建议

gate 脚本在 input check 阶段即阻断，无法区分"文件完全不存在"和"文件存在但路径不对"两种情况。建议在 gate 报告里增加 raw 文件检查，区分阻断原因。

