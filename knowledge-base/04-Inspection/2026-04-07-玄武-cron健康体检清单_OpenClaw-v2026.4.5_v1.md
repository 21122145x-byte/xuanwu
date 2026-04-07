# 玄武｜cron 健康体检清单｜OpenClaw v2026.4.5 v1

- 日期：2026-04-07
- 归属：玄武
- 类型：cron 健康体检清单
- 版本口径：当前运行版本 `2026.4.5`
- 数据来源：`~/.openclaw/cron/jobs.json` + `openclaw cron list --json` + `openclaw cron status --json`

---

## 1. 总体状态

### 结构层
- cron 总数：`51`
- scheduler：`enabled = true`
- storePath：`/Users/xiaojingbo/.openclaw/cron/jobs.json`
- 缺 `id` 脏记录：`0`
- 核心字段缺失：`0`
- 重复 name：`0`

### 运行层状态分布
- `ok`：`27`
- `error`：`9`
- `none`：`9`

### 当前判断
> **cron 存储层当前已恢复健康，主要问题已从“底层脏记录”转为“运行态 error job 分簇待清”。**

---

## 2. error job 根因分组

## P1｜Unknown Channel / delivery target
### 风险判断
这是当前优先级最高的一组，因为它们不是脚本本体异常，而是**delivery / channel 路由**问题，直接影响任务闭环与通知可靠性。

### 清单
1. `fenxue-cron-400-monitor`
- id: `95cc0291-7c72-4dc3-b0ec-eabada081434`
- agent: `system-guardian`
- consecutiveErrors: `5`
- lastDeliveryStatus: `unknown`
- lastError: `Error: Unknown Channel`

2. `oa-collect`
- id: `17181a1b-d760-4d62-be62-e9bbd89c1a1b`
- agent: `anna`
- consecutiveErrors: `2`
- lastDeliveryStatus: `unknown`
- lastError: `Error: Unknown Channel`

### 当前判断
> **这两条都属于 delivery / channel target 问题簇，应优先单独拆投递链。**

---

## P2｜400 / request parameter or routing
### 风险判断
这组属于**请求参数 / 路由口径错误**，会持续导致 job 失败，但破坏面略低于 Unknown Channel。

### 清单
1. `fenxue-daily-status-report`
- id: `aa72f075-2b4b-480e-b417-6d62cf79b206`
- agent: `fenxue`
- consecutiveErrors: `1`
- lastDeliveryStatus: `unknown`
- lastError: `AxiosError: Request failed with status code 400`

2. `fenxue-weekly-inspection`
- id: `7817dc04-52b9-42fd-81c4-f323fe67a90e`
- agent: `fenxue`
- consecutiveErrors: `2`
- lastDeliveryStatus: `unknown`
- lastError: `AxiosError: Request failed with status code 400`

### 当前判断
> **这两条应按 400 参数 / 路由链单列复核，不与 Unknown Channel 混案。**

---

## P2｜delivery 配置缺 channel
### 风险判断
这组本质上也是 delivery 配置问题，但比 Unknown Channel 更具体：**多通道环境下未显式指定 channel**。

### 清单
1. `fenxue-minimax-tts-audit-test-0430`
- id: `2f174ce6-5a04-4347-bd25-63734663c108`
- agent: `fenxue`
- consecutiveErrors: `1`
- lastDeliveryStatus: `unknown`
- lastError: `Channel is required when multiple channels are configured: discord, feishu ...`

### 当前判断
> **这条已基本指向配置缺项，不需要大范围猜测。**

---

## P3｜Timeout / run exceeded window
### 风险判断
这组更偏执行窗口与 timeout 配置，不是 delivery 主链故障，优先级可后置。

### 清单
1. `fenxue-memory-integrity-check`
- id: `1d03ae25-d09d-4a77-bb54-a27fbdfdb6f5`
- consecutiveErrors: `2`
- lastDeliveryStatus: `not-delivered`
- lastError: `Request timed out before a response was generated...`

2. `fenxue-daily-token-stats`
- id: `261c663f-20b9-4b17-b7dd-3307c2d52c7c`
- consecutiveErrors: `1`
- lastDeliveryStatus: `delivered`
- lastError: `Request timed out before a response was generated...`

3. `fenxue-weekly-compound`
- id: `34b65da5-520a-4f11-b524-3a5856e9b938`
- consecutiveErrors: `1`
- lastDeliveryStatus: `delivered`
- lastError: `Request timed out before a response was generated...`

### 当前判断
> **这三条是执行时间窗口问题，应归到 timeout 治理，不要混入 delivery 根因。**

---

## P3｜Rate limit / upstream throttling
### 风险判断
这组属于上游限流，当前不应误判为本机结构问题。

### 清单
1. `富贵-每日23点向粉雪汇报主任务状态`
- id: `fugui-daily-status-report-to-fenxue`
- agent: `fugui`
- consecutiveErrors: `2`
- lastDeliveryStatus: `delivered`
- lastError: `⚠️ API rate limit reached. Please try again later.`

### 当前判断
> **这是上游限流，不是存储损坏，不是 delivery target 缺失。**

---

## 3. 当前最小治理建议

### 优先序
1. **P1**：Unknown Channel / delivery target
2. **P2**：400 参数 / 路由 + delivery 缺 channel
3. **P3**：timeout + rate limit

### 最小动作
1. 先清 P1：
- `fenxue-cron-400-monitor`
- `oa-collect`

2. 再清 P2：
- `fenxue-daily-status-report`
- `fenxue-weekly-inspection`
- `fenxue-minimax-tts-audit-test-0430`

3. 最后再看 P3：
- timeout 窗口是否需要调优
- 限流任务是否需要错峰/退避

---

## 4. 一句话收口

> **这轮 cron 健康体检已经可以正式收口：存储层已恢复健康，当前 9 条 error job 主要集中在 delivery / channel 路由、400 参数、timeout 与 rate limit 四类运行问题；治理顺序应先打 P1 的 delivery target，再打 P2 的参数与配置缺项，最后处理 P3 的超时和限流。**
