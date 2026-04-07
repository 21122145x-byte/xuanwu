# 玄武｜P1 delivery / channel target 异常诊断 v1

- 日期：2026-04-07
- 归属：玄武
- 类型：P1 异常诊断
- 范围：cron P1 问题簇（Unknown Channel / delivery target）

---

## 1. 对象

### P1 job 1
- `fenxue-cron-400-monitor`
- id: `95cc0291-7c72-4dc3-b0ec-eabada081434`

### P1 job 2
- `oa-collect`
- id: `17181a1b-d760-4d62-be62-e9bbd89c1a1b`

### 共用 delivery 配置
- `deliveryMode = announce`
- `deliveryChannel = discord`
- `deliveryTo = user:1481717539007496358`

---

## 2. 当前样本

### 2.1 cron job 侧
两条 job 当前都表现为：
- `lastError = Error: Unknown Channel`
- `lastDeliveryStatus = unknown`

### 2.2 手动 message send 对照样本
使用同一个目标：
- `channel = discord`
- `target = user:1481717539007496358`

手动发送结果：
- **发送成功**
- 已成功拿到 messageId

---

## 3. 当前最小判断

### 已排除
1. 不是 Discord 总体发不出去；
2. 不是 `user:1481717539007496358` 这个 target 天然无效。

### 当前更像
> **问题收窄到了 cron job 的 `announce` / delivery 执行链本身。**

也就是：
- 同一个 Discord user target，手动 `message send` 成功；
- 但 cron job 里的 `delivery.mode=announce` 仍报 `Unknown Channel`。

### 当前优先怀疑
1. cron announce 链对 `user:` 目标的解析口径异常；
2. cron delivery 执行环境与手动 `message send` 的目标解析口径不一致；
3. 两条 job 共用同一 delivery target，所以一起中招。

---

## 4. 下一步验证

### A/B 验证原则
- 不改任务内容
- 只改 delivery 口径
- 先拿一条 P1 job 做最小验证

### 当前计划
对 `fenxue-cron-400-monitor` 做 delivery A/B：
- A：保留 `to = user:1481717539007496358`
- B：改为 `channel = last` 或改用不同 target 口径

---

## 5. 一句话收口

> **P1 当前已经从“目标是不是错了”推进到“cron announce / delivery 链自身有问题”：同一个 Discord user 目标手动发送能成功，但 cron job 仍统一报 `Unknown Channel`。**
