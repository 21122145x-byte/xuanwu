# 午盘发布硬闸阻断 - indices / sectors cleaned 缺失

**日期：** 2026-04-15  
**时间：** 12:16（Asia/Singapore）  
**触发：** cron 富贵-每日财经-午盘-出图写稿  
**Gate run_id：** midday_gate_20260415_121624  

## 事件摘要

午盘发布 gate 执行时发现缺少 2 个关键 cleaned 输入文件，导致 `overall_status=blocked_missing_inputs`，publish 未被允许。

## 直接原因（Immediate Cause）

当天午盘数据处理流程中，indices 和 sectors 两个数据源完成了抓取，但未完成清洗（cleaned）输出。

## 已确认存在的 cleaned 文件

| 数据源 | 文件 | 状态 |
|--------|------|------|
| breadth | breadth_20260415_midday_cleaned.json | ✅ 存在 |
| fund_flow | fund_flow_20260415_midday_cleaned.json | ✅ 存在 |
| zt_pool | zt_pool_20260415_midday_cleaned.json | ✅ 存在 |
| indices | indices_20260415_midday_cleaned.json | ❌ 缺失 |
| sectors | sectors_20260415_midday_cleaned.json | ❌ 缺失 |

## 根因（Root Cause）

待进一步排查。可能的路径：
1. 早盘或午盘抓取 cron 未触发 indices / sectors 抓取脚本
2. 抓取成功但清洗脚本（clean）未对 indices / sectors 执行
3. 清洗执行但输出路径不符合预期（文件名/目录偏差）

## 影响

- 午盘正式稿（longform）未生成
- 午盘长图（visuals）未生成
- 当日富贵财经午盘内容缺口

## 建议修复动作

1. 检查 today 抓取 cron 是否覆盖 indices / sectors 两个数据源
2. 确认清洗脚本对 indices / sectors 的处理路径
3. 考虑在 gate 运行前增加对 indices / sectors cleaned 文件存在性的预检

## 关联

- Gate summary: `projects/fugui-finance/output/runs/midday_gate_20260415_121624.json`
- Memory: `memory/2026-04-15.md`

