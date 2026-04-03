[HANDOFF]
📍 Where: /Users/xiaojingbo/.openclaw/workspace/knowledge-base/03-Notes/2026-04-03-long-task-submitter-四审意见与下一步综合建议-v1.md
🎯 What: 基于 Curie 提交的第一次最小实跑证据回收包，形成 Anna 的第四轮审计意见，并附下一步综合建议，明确当前可认定成立的能力边界与后续验证顺序。
🔍 How to verify: 检查文档是否明确包含：四审结论、证据链判断、当前已通过 / 未通过边界、以及下一步应优先验证的链路。
⚠️ Known Issues: 本文档不等于 long-task-submitter 已稳定上线；当前口径仅升级到“真实最小闭环至少跑通一次”，仍不通过稳定运行与上线。
➡️ Next Steps: 按本文档建议，优先进入通知链验证，再进入失败路径（retry / escalation）验证，完成后再申请下一轮审计。

# long-task-submitter 四审意见与下一步综合建议 v1

- 日期：2026-04-03
- 审计人：Anna
- 对象：Curie 提交的第一次最小实跑证据回收包

参考材料：
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/2026-04-03-long-task-submitter-第一次最小实跑证据回收与提交Anna四审说明-v1.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-first-run/01-task-initial.json`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-first-run/02-task-running.json`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-first-run/03-task-terminal.json`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-first-run/04-cron-judgment.log`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-first-run/05-cleanup-result.md`

---

# 第一部分：四审意见

## 一、四审结论

### 总裁决
**条件通过。**

当前口径正式升级为：

> **真实最小闭环至少已跑通一次，但仍不通过稳定运行，不通过上线。**

这意味着：
- long-task-submitter 已不再只是“允许做第一次最小实跑”
- 而是已经通过证据证明：
  - task store 最小承载真实发生过
  - worker 最小状态写回真实发生过
  - cron terminal judgment / cleanup 分支真实发生过

但同时仍不能宣称：
- 通知链已通过
- retry / escalation 已通过
- 稳定性已通过
- 可以上线

---

## 二、证据链判断

## 1. 初始 task JSON 证据
### 结论：通过
证据：`01-task-initial.json`

已证明：
- task 真实存在
- 初始状态为 `pending`
- `notified=false`
- `cronJobId` 已填写

这说明：
> 不是事后补写终态，而是存在一个真实的初始任务状态。

---

## 2. worker 中间写回证据
### 结论：通过
证据：`02-task-running.json`

已证明：
- `status` 已从 `pending` 进入 `running`
- `spawnedSession` 已写入
- `assignedAgent` 已写入
- `updatedAt` / `lastHeartbeatAt` 已更新

这说明：
> worker 不是纸面 contract，而是至少发生过一次真实中态写回。

---

## 3. worker 终态写回证据
### 结论：通过
证据：`03-task-terminal.json`

已证明：
- `status = done`
- `result` 已写入
- `updatedAt` 再次推进
- `cronAttempts` 已发生变化

这说明：
> worker 已完成从 `running -> done` 的真实终态写回。

---

## 4. cron judgment / action log 证据
### 结论：通过
证据：`04-cron-judgment.log`

已证明：
- cron 真实读取了 task 文件
- cron 真实读到了 `status = done`
- cron 真实进入了 terminal judgment
- cron 真实给出了 cleanup action

尤其关键的是，日志里已经明确写出：
- `Decision: terminal state detected`
- `Action: cleanup required`
- `Action: remove cron ...`

这说明：
> cron bridge 已不再只是说明文，而是至少被执行过一次终态判断链。

---

## 5. cleanup 结果证据
### 结论：通过（按当前验证边界）
证据：`05-cleanup-result.md`

已证明：
- cleanup judgment 已被显式记录
- 本轮明确验证的是 terminal cleanup judgment
- 本轮明确未把通知链冒充成已验证

### 边界说明
这份证据更准确地证明的是：
> **cleanup judgment 成立并被记录。**

它还不足以单独证明：
> 系统级 cron 真删除动作已在真实调度层完成并被外部再次核实。

但结合 `04-cron-judgment.log`，本轮四审仍可认定：
- terminal cleanup 分支至少已跑通一次

---

## 三、当前已可认定成立的能力

本轮四审后，可认定以下能力已成立：

### 1. task store 最小状态承载成立
至少一次真实任务状态流转已留痕。

### 2. worker 最小写回链成立
至少一次真实 `pending -> running -> done` 已发生。

### 3. cron terminal judgment 成立
至少一次真实 terminal state judgment 已发生。

### 4. terminal cleanup 分支至少跑通一次
至少在最小成功路径上，cleanup judgment 已被执行并留痕。

一句话：

> **long-task-submitter 的真实最小闭环，至少已跑通一次。**

---

## 四、当前仍未成立的能力

以下能力本轮仍不成立：

### 1. 通知链未验证
本轮日志已明确：
- `notify skipped for this minimal validation run`

所以：
- `notified=true` 边界未通过真实验证
- 不能宣称通知链成立

### 2. retry / escalation 未验证
本轮只跑了成功路径：
- `pending -> running -> done -> cleanup`

没有跑：
- retry path
- escalation path
- blocked / logic failure 等失败态

### 3. 稳定性未验证
一次实跑通过，不能推出：
- 多次可重复通过
- 长期稳定
- 生产可用

### 4. 上线条件未满足
当前仍不能宣称：
- 稳定运行
- 可上线
- 可大规模使用

---

## 五、风险判断

如果现在把当前状态误说成“已可上线”，会出现：
- 把一次最小成功路径当成稳定性证明
- 把 cleanup judgment 当成完整调度链验证
- 把未验证的通知链、失败链误记为已成立

所以当前必须严守边界：

> **通过的是“真实最小闭环至少跑通一次”，不是“系统已稳定可运行”。**

---

## 六、一句话裁决

> **Curie 本轮提交的第一次最小实跑证据包，我给通过；当前可以认定 long-task-submitter 的真实最小闭环至少已跑通一次，但仍然不通过稳定运行，也不通过上线。**

---

# 第二部分：下一步综合建议

## 七、下一步优先顺序

现在不要回头再补骨架文档，
也不要急着扩 parent-child / workflow engine。

下一步建议顺序固定为：

### 1. 先验证通知链
原因：
- `notified` 字段边界现在仍未闭合
- 这是当前最直接的下一块短板

至少要验证：
- 通知成功后才写 `notified=true`
- 通知失败时不会假写成功

---

### 2. 再验证失败路径
优先跑：
- retry path
- escalation path

至少要证明：
- pending 超预算时如何升级
- running 超等待预算时如何升级
- cron 在失败链上的 cleanup 是否成立

---

### 3. 再做第二轮重复实跑
目的不是扩复杂度，
而是验证：
- 这条最小闭环不是只能偶然跑通一次
- 至少能重复通过

---

## 八、暂时不要扩的方向

在通知链和失败路径没补之前，暂时不要扩：
- DAG / workflow engine
- parent-child 多层编排
- 复杂 duplicate strategy
- 高并发
- 生产级稳定性叙述

原因很简单：

> **现在该补的是验证层，不是架构层。**

---

## 九、下一轮审计申请条件

如果 Curie 要申请下一轮审计，建议至少补齐：
- 一次通知链验证证据包
- 一次失败路径（retry 或 escalation）验证证据包
- 证据仍按：前态 / 中态 / 终态 / judgment / cleanup / 边界说明 收回

届时下一轮审计才有资格判断：
- 是否可从“真实最小闭环至少跑通一次”
  升级到
- “真实关键链路已验证更完整”

---

## 十、一句话收口

> **现在不是继续扩系统，而是顺着验证顺序往前走：先补通知链，再补失败路径，再谈是否进入更高一级的可运行性判断。**