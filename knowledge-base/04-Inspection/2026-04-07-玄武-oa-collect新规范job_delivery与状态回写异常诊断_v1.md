# 玄武｜oa-collect 新规范 job｜delivery 与状态回写异常诊断 v1

- 日期：2026-04-07
- 归属：玄武
- 类型：异常诊断
- 对象：`oa-collect` 新规范 cron job
- Job ID：`17181a1b-d760-4d62-be62-e9bbd89c1a1b`
- 当前版本：`OpenClaw v2026.4.5`

---

## 1. 现象

在清理旧 `oa-collect` 无 id 脏记录、恢复 `cron list` 的 `padEnd` 问题后，重新创建的新规范 job 仍未形成正常闭环。

当前样本表现为：
- `openclaw cron run 17181a1b-d760-4d62-be62-e9bbd89c1a1b` 返回：
  - `ok: true`
  - `enqueued: true`
- 已补齐 `payload.workingDir`
- OA 本体脚本手动执行可跑通
- 但 job 最终状态为：
  - `lastRunStatus = error`
  - `lastStatus = error`
  - `lastDeliveryStatus = unknown`
  - `lastError = null`
  - `consecutiveErrors = 1`

---

## 2. 已排除的方向

### 2.1 OA 本体执行失败
已排除。

手动执行：
- 目录：`/Users/xiaojingbo/.openclaw/workspace-anna/projects/oa-project`
- 命令：`./oa collect`
- 结果：`ok: true`

### 2.2 `workingDir` 缺失是唯一原因
已排除。

最初新规范 job 确实缺 `workingDir`，但补齐后，job 仍未恢复正常闭环。

### 2.3 旧 `Unknown Channel` 在新 job 上原样复现
未成立。

当前新规范 job 没有再直接打出：
- `Unknown Channel`

因此不能把当前异常直接写回老错误。

---

## 3. 当前最像的故障层

当前更像卡在：
> **delivery / 状态回写 / 最终收口链**

原因：
- job 能入队
- OA 本体能跑
- delivery 配置表面完整：
  - `mode: announce`
  - `channel: discord`
  - `to: user:1481717539007496358`
- 但结果没有形成正常 delivered / failed 的明确闭环
- `lastError = null`，说明不是明确业务执行错误

这组组合更接近：
> **执行面通过，但回写面/投递面没有完成完整状态落盘。**

---

## 4. 当前判断

### 已成立
1. 新规范 `oa-collect` 已摆脱旧无 id 脏记录问题；
2. OA 本体执行链可用；
3. `workingDir` 已补齐；
4. 当前问题更偏 delivery / 状态回写链，而不是脚本执行链。

### 未成立
1. 不能写“oa-collect 已恢复正常闭环”；
2. 不能写“delivery 已正常”；
3. 不能写“当前仍是 Unknown Channel 同一错误”。

---

## 5. 风险

- 这条 job 当前虽然不再破坏 `cron list`，但仍不能稳定完成闭环；
- 若后续继续依赖它做生产级 OA 采集与通知，结果可信度不足；
- 若不继续拆 delivery / 状态回写层，后续可能把“执行成功但投递未知”误判为任务失败或成功。

---

## 6. 最小修复路径

### 下一步建议
1. 直接抓这条 job 对应的运行明细 / delivery 事件；
2. 校验 announce 到 Discord user 的收口链是否在当前版本口径下仍有异常；
3. 必要时把 `oa-collect` 改成：
   - 执行面先落盘
   - delivery 面单独验证
4. 在未验证闭环前，不把它恢复为可信生产链。

---

## 7. 一句话收口

> **新规范 `oa-collect` 当前已经不是“脏记录 + Unknown Channel”的老问题，而是一个新的、更窄的异常：任务能入队、OA 本体能跑、workingDir 已补齐，但最终收口停在 `lastDeliveryStatus=unknown / lastError=null`，因此应单列为 delivery / 状态回写链异常继续诊断。**
