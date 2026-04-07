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

## 4. A/B 验证结果

### 验证原则
- 不改任务内容
- 只改 delivery 口径
- 先拿 `fenxue-cron-400-monitor` 做最小验证

### A/B 第一针
#### 改动
- 保留 `to = user:1481717539007496358`
- 将 `channel` 从 `discord` 改为 `last`

#### 结果
- `lastRunStatus = error`
- `lastStatus = error`
- `lastDeliveryStatus = unknown`
- `lastError = Error: Unknown Channel`

#### 判断
> **改成 `channel=last` 后，错误没有变化。**

这说明：
- 不是单纯 `channel=discord` 写法有问题；
- 不是只要换成 `last` 就能恢复。

---

### A/B 第二针
#### 改动
- 将 target 从 `user:1481717539007496358` 改为当前 DM channel：
  - `channel:1489158314012180582`
- `channel` 改回 `discord`

#### 结果
- `lastRunStatus = error`
- `lastStatus = error`
- `lastDeliveryStatus = unknown`
- `lastError = ""`（空）

#### 判断
> **改成当前 DM `channel:` 目标后，`Unknown Channel` 消失了，但 job 仍未正常闭环。**

这说明：
- `user:` 目标口径确实存在问题；
- 即使换成有效 `channel:` 目标，cron announce / delivery 链仍有更深层异常。

---

## 5. 正式结论

### 已成立
1. 同一个 Discord 目标，手动 `message send` 成功；
2. `user:...` 目标用于 cron announce 时会触发 `Unknown Channel`；
3. 改成当前 DM `channel:` 目标后，`Unknown Channel` 消失；
4. 但 cron announce / delivery 链仍未正常闭环，表现为：
   - `lastRunStatus = error`
   - `lastDeliveryStatus = unknown`
   - `lastError` 为空

### 当前最稳收口
> **先修 target 口径，再继续查 announce / delivery 状态回写链。**

### 新增代码级判断｜Discord provider 返回值未进入 `deliveryResults`
当前代码链已经可对应为：
- cron direct delivery 会调用 `deliverOutboundPayloads(...)`
- `deliverOutboundPayloads(...)` 的返回数组会直接决定：
  - `deliveryResults.length > 0` 是否成立
  - `delivered` 是否能被置成 `true`
- Discord 发送最终通过 runtime 包装层：
  - `discordMessagingActionRuntime.sendMessageDiscord(...)`

当前 P1 样本已经排除：
- target 仍不合法
- payload 不可投递

因此当前最稳代码级判断是：
> **Discord provider 的发送结果没有成功进入 `deliverOutboundPayloads(...)` 的返回数组，于是 `deliveryResults.length` 没起来，后续 `delivered` 也起不来。**

再往前一层可进一步写成：
> **当前更像不是 provider 完全没返回，而是 provider 返回值结构没有被 `deliverOutboundPayloads(...)` 识别成可累计结果。**

### 新增代码级判断｜无 result 分支
在 `server-Cv5hzFG4.js` 中，`deliverOutboundPayloads(...)` 存在一个关键尾部分支：

- 若 `deliverViaDirect(...)` **没有返回值**
- 或 `finalizeTextDelivery(...)` **没有返回值**

函数会直接返回：

```js
{
  delivered,
  deliveryAttempted,
  summary,
  outputText,
  synthesizedText,
  deliveryPayloads
}
```

也就是：
> **执行层尝试过 delivery，但没有产出明确 `result`。**

这与当前 P1 现象是对得上的：
- `lastRunStatus = error`
- `lastDeliveryStatus = unknown`
- `lastError = ""`

因此当前可以再往前压一层：
> **P1 不只是 target 口径问题；在 target 改正后，cron announce / delivery 执行链仍可能走到“无 result 分支”，导致归档层只能把 `lastDeliveryStatus` 落成 `unknown`。**

---

### 新增代码级判断｜疑似落到 `sendTextChunks(...)` 兜底路径
在 `deliver-DqZbx7oj.js` 中，direct delivery 的累计分支顺序是：

1. `handler.sendPayload(...)` → `results.push(delivery)`
2. `handler.sendFormattedText(...)` → `results.push(...array)`
3. `sendTextChunks(...)` 兜底

其中只有前两条会明确把 provider 结果累计进 `results`。
而 `sendTextChunks(...)` 路径当前可见行为是：
> **负责发送，但没有看到对应的 `results.push(...)`。**

因此当前新增判断是：
> **这条 Discord cron announce 很可能没有走到 `sendPayload / sendFormattedText`，而是掉到了 `sendTextChunks(...)` 兜底分支；这会自然解释为什么发送可能发生了，但 `deliveryResults.length` 仍然起不来。**

## 6. 一句话收口

> **P1 当前已经被拆成四层：第一层是 `user:` target 口径不成立；第二层是改成有效 `channel:` 目标后 `Unknown Channel` 消失；第三层是 cron announce / delivery 仍可能走到“无 result 分支”；第四层是这条路径很可能进一步落到了 `sendTextChunks(...)` 兜底分支，因此状态回写停在 `unknown`。**
