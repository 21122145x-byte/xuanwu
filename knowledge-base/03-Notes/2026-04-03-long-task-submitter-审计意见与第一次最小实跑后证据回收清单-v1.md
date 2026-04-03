[HANDOFF]
📍 Where: /Users/xiaojingbo/.openclaw/workspace/knowledge-base/03-Notes/2026-04-03-long-task-submitter-审计意见与第一次最小实跑后证据回收清单-v1.md
🎯 What: 基于 Curie 当前三审材料的实体核验结果，形成一份合并文档：前半部分为 Anna 的最新审计意见稿，后半部分为《第一次最小实跑后的证据回收清单》。
🔍 How to verify: 检查文档是否明确包含：当前三审放行口径、已通过 / 未通过边界，以及第一次最小实跑结束后必须回收的最小证据清单。
⚠️ Known Issues: 本文档不等于 long-task-submitter 已真实闭环通过；当前口径仅为“允许执行第一次最小实跑验证，不通过上线”。
➡️ Next Steps: 执行方按当前材料完成第一次最小实跑后，严格按本文档回收证据，再提交 Anna 做下一轮执行性审计。

# long-task-submitter 审计意见与第一次最小实跑后证据回收清单 v1

- 日期：2026-04-03
- 审计人：Anna
- 对象：Curie 当前推进到三审阶段的 `long-task-submitter`

参考材料：
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/2026-04-03-long-task-submitter-提交Anna三审说明-v1.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/2026-04-03-long-task-submitter-最小实跑验证方案-v1.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/task-queue/task-20260403-001.json`
- `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/templates/operator-runbook.example.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/2026-04-03-long-task-submitter-执行方操作卡-v1.md`
- `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/03-Notes/2026-04-03-long-task-submitter-审计意见与最小落地清单-v2.md`

---

# 第一部分：审计意见稿

## 一、当前审计结论

### 裁决
**允许执行第一次最小实跑验证，不通过上线。**

这意味着：
- 当前材料已经足以支撑执行方去做第一次最小实跑
- 但仍不足以宣称：
  - 真实闭环已经跑通
  - 稳定性已经验证
  - 可以直接上线

---

## 二、当前已通过的部分

### 1. 三审入口通过
`提交Anna三审说明-v1.md` 已把本轮提交目的、相对二审新增内容、建议重点审的问题与材料总路径压实。

### 2. 最小实跑验证方案通过
`最小实跑验证方案-v1.md` 已明确：
- 本轮只验证什么
- 不验证什么
- 验证步骤
- 通过标准
- 失败判定

### 3. 第一次 task 样例通过
`task-20260403-001.json` 已具备：
- 明确的最小验证任务描述
- 完整状态字段
- 初始 `pending` 状态
- `cronJobId` 等关键字段

### 4. operator runbook 通过
`operator-runbook.example.md` 已明确：
- 输入材料
- 执行步骤
- pass condition
- 证据保留要求

### 5. 执行方操作卡通过
`执行方操作卡-v1.md` 已明确：
- 执行方需用材料
- 执行顺序
- 通过标准
- 收口边界

---

## 三、当前仍未通过的部分

### 1. 未证明真实闭环已跑通
当前还没有证据证明：
- worker 真写回 `pending -> running -> done`
- cron 真读到 terminal state
- cron 真执行 cleanup

### 2. 未证明通知链边界已真实验证
当前仍未见：
- `notified=true` 与通知成功之间的真实验证证据

### 3. 未证明 retry / escalation / cleanup 已真实跑过
当前只是：
- 规则成立
- 样例成立
- 操作卡成立

还不是：
- 执行结果成立

---

## 四、风险判断

如果现在把当前状态误说成“已真实闭环通过”，风险会是：
- 把执行前准备误判成执行结果
- 把一次样例准备误判成稳定性证明
- 把 bridge / example 文档误判成真实系统运行证据

所以当前口径必须锁死为：

> **允许执行第一次最小实跑验证，但不升级为真实闭环通过。**

---

## 五、一句话裁决

> **Curie 当前三审材料，我给通过；现在可以正式进入第一次最小实跑验证，但仍然不通过上线。**

---

# 第二部分：《第一次最小实跑后的证据回收清单》

## 六、目标

本清单只服务于一件事：

> **让执行方在第一次最小实跑后，回收足够证据，供下一轮审计判断“真实最小闭环是否已跑通”。**

如果没有证据回收，
那这轮实跑就仍然只是“口头完成”。

---

## 七、必须回收的最小证据

## 1. 初始 task JSON
### 必须提供
- 执行前的 task JSON 内容或文件快照

### 目的
用于证明：
- task 真实存在
- 初始状态真实为 `pending`
- 本轮不是事后补写结果

### 通过标准
能明确看到：
- `status = pending`
- `notified = false`
- `attempt / maxAttempts`
- `cronJobId`

---

## 2. worker 写回后的 task JSON
### 必须提供
- worker 至少写过一次 `running`
- worker 最终写过一次 terminal state

### 目的
用于证明：
- worker 不是只被描述，而是真的写回了状态
- `pending -> running -> terminal` 至少发生过一次

### 通过标准
能明确看到：
- `status = running` 的中间证据
- `status = done`（或明确失败态）的终态证据
- `updatedAt` 被更新
- `assignedAgent` 被写入
- 成功时有 `result`，失败时有 `failureType / failureReason`

---

## 3. cron judgment / action log
### 必须提供
- cron 运行后的判断结果
- 至少一条 action log 或等价证据

### 目的
用于证明：
- cron 真的读取了 task state
- cron 不是纸面 handler，而是至少做过一次真实判断

### 通过标准
能明确看到：
- cron 读到了什么状态
- cron 做了什么动作
- 为什么判定 terminal / cleanup

---

## 4. terminal cleanup 结果
### 必须提供
- terminal 后 cron 应移除的证据
- 或明确说明 cleanup 已执行的结果记录

### 目的
用于证明：
- 闭环不是只停在 terminal state
- terminal 后 cron 没有继续残留

### 通过标准
能明确回答：
- terminal 后 cron 是否还活着
- 如果已移除，移除证据是什么

---

## 5. `notified` 字段边界证据
### 必须提供
- 本轮如果触发了通知，提供通知成功与 `notified=true` 的对应证据
- 如果本轮没有触发通知，也要明确写“本轮未验证通知链”

### 目的
用于防止：
- 把 `notified=true` 写成假成功
- 把未验证的链路说成已验证

### 通过标准
要么：
- 通知成功证据与 `notified=true` 一致

要么：
- 明确标注“本轮通知链未验证，不据此放行该项”

---

## 八、建议附带回收的补充证据

虽然不是硬性必需，但建议一并回收：
- worker 实际收到的 brief 文本
- cron 实际收到的 handler brief 文本
- 关键时间点（创建 / running / done / cleanup）
- 执行中出现的异常或人工干预说明

这些材料有助于 Anna 判断：
- 这次是真跑通了
- 还是只是靠临时手工补桥完成的

---

## 九、执行方回传格式

第一次最小实跑后，建议执行方至少按以下 5 字段回传：

### Where
- task JSON 路径
- 相关日志 / 结果路径

### What
- 本轮实跑做了什么
- 当前跑到哪一步

### How to verify
- 哪些证据可核
- 各证据对应证明什么

### Known Issues
- 本轮仍未覆盖的链路
- 是否有人工补桥
- 是否仍有未验证项

### Next Steps
- 是否建议进入下一轮验证
- 还是应先返工

---

## 十、一句话收口

> **第一次最小实跑后，最重要的不是“说跑了”，而是把 task 初态、worker 写回、cron judgment、terminal cleanup 四类最小证据收回来；没有这些证据，就不能把本轮升级为真实闭环通过。**