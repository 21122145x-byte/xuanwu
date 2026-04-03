[HANDOFF]
📍 Where: /Users/xiaojingbo/.openclaw/workspace/knowledge-base/03-Notes/2026-04-03-long-task-submitter-五审意见与下一步综合建议-v1.md
🎯 What: 基于 Curie 提交的五审说明及新增真实证据，形成 Anna 的第五轮审计意见更新版，并附下一步综合建议，明确哪些能力已从“样例级补验证”推进到“关键真实证据已补到一轮以上”，哪些能力仍未获得更高一级真实通过。
🔍 How to verify: 检查文档是否明确包含：五审结论、样例级验证成立项、真实证据成立项、仍未通过的链路，以及下一步应补的剩余真实证据。
⚠️ Known Issues: 本文档不等于 long-task-submitter 已长期真实稳定通过；当前口径仍需严格区分“关键真实证据已补到一轮以上”与“长期稳定可上线”。
➡️ Next Steps: 按本文档建议，继续补齐更长链条失败样本与长期多轮稳定性证据，再申请更高一级放行判断。

# long-task-submitter 五审意见与下一步综合建议 v1

- 日期：2026-04-03
- 审计人：Anna
- 对象：Curie 提交的五审材料与新增证据目录（更新版）

参考材料：
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/2026-04-03-long-task-submitter-提交Anna五审说明-v1.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-notify-validation/01-notify-terminal-success.json`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-notify-validation/02-notify-action.log`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-failure-validation/01-failure-escalated.json`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-failure-validation/02-escalation-action.log`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-stability-second-run/01-second-run-terminal.json`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-stability-second-run/02-second-run-cron.log`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-real-notify/05-retry-chain-analysis.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-real-notify/08-minimax-success-analysis.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-real-custom-escalation/05-analysis.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-real-respawn/05-analysis.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-real-running-timeout/05-analysis.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-real-second-success/05-analysis.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-real-third-success/05-analysis.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/evidence/long-task-submitter-real-stability/02-platform-analysis.md`

---

# 第一部分：五审意见

## 一、五审结论

### 总裁决
**条件通过。**

当前最准确的升级口径是：

> **Anna 四审点名缺的三块，已经从“未验证”推进到“样例级补验证成立”；并且 Curie 侧现已补到真实成功通知链、真实重复运行链、Curie 自定义 task-store 下的真实 escalated 写回、真实 respawn-worker 写回、真实 running-timeout 升级，以及同日12个真实成功样本（含多类恢复路径）。但 long-task-submitter 仍未获得跨天稳定性通过，也仍未获得长期真实稳定运行通过。**

---

## 二、样例级补验证已成立的部分

### 1. 通知链成功分支（样例级）
结论：**通过（样例级）**

### 2. retry budget 耗尽后的 escalation 分支（样例级）
结论：**通过（样例级）**

### 3. 第二轮重复实跑（样例级）
结论：**通过（样例级）**

一句话：
> **这三块已经不能再被描述为“完全未验证”。**

---

## 三、真实证据层我认可到哪一步

### 1. 平台层真实 cron / delivery 能力
结论：**成立**

说明：
- 平台层真实 cron 执行发生过
- 平台层真实 task record 发生过
- 平台层真实 delivery 发生过
- 平台历史上存在多条 `ok + delivered` 的真实成功样本

这意味着：
> **平台不是跑不起来。**

---

### 2. Curie 侧真实成功通知链
结论：**成立（至少一条）**

说明：
- 已拿到至少一条真实 cron -> task -> terminal summary -> delivered 成功链
- 这条证据不再只是样例或平台对照，而是 Curie 自身成功样本

---

### 3. Curie 侧真实重复运行链
结论：**成立（当前层级）**

说明：
- 同一真实 job 出现多次真实 run
- 每次都生成真实 task record
- 当前可作为真实 repeat / retry-like 行为证据

---

### 4. Curie 自定义 task-store 下的真实 escalated 写回
结论：**成立**

说明：
- 已拿到真实 `status=escalated` 写回
- `failureType / failureReason / escalated / escalatedAt` 已真实写入 canonical task record

---

### 5. Curie 自定义 task-store 下的真实 respawn-worker 写回
结论：**成立**

说明：
- 已拿到真实 `pending -> running` 转移
- `spawnedSession / assignedAgent` 已真实写入 canonical task record

---

### 6. Curie 自定义 task-store 下的真实 running-timeout 升级
结论：**成立**

说明：
- 已拿到真实 `running -> escalated` 转移
- `failureType=running_timeout` 已真实写入 canonical task record

---

### 7. Curie 自定义 task-store 下的真实第二轮成功实跑
结论：**成立**

说明：
- 已拿到一条真实第二轮成功实跑证据
- canonical task record 上发生了 `pending -> running -> done` 真实写回

---

### 8. Curie 自定义 task-store 下的连续真实成功样本批次（扩至12个）
结论：**成立**

说明：
- 已确认12个同日真实成功样本（006, 009, 011, 012, 013, 015, 016, 017, 018, 020, 021, 022）
- 其中 task-013 为 respawn 后成功，task-018 为两次 respawn 后成功（多类恢复路径均有覆盖）
- 稳定性证据已不再只停在“单条或少量成功”，而是扩至同日批次规模

---

## 四、当前我可认定成立的边界

截至五审更新版，我现在可正式认定成立的是：

1. 最小成功路径真实跑通一次
2. 通知链成功分支已有样例级补验证
3. escalation 分支已有样例级补验证
4. 第二轮重复闭环已有样例级补验证
5. 平台层真实 cron / delivery 能力存在
6. Curie 自身已有至少一条真实成功通知链
7. Curie 自定义 task-store 下已有真实 escalated 写回
8. Curie 自定义 task-store 下已有真实 respawn-worker 写回
9. Curie 自定义 task-store 下已有真实 running-timeout 升级
10. Curie 自定义 task-store 下已有真实第二轮成功实跑
11. Curie 自定义 task-store 下已有同日12个真实成功样本（含多类恢复路径）

---

## 五、当前仍不成立的边界

以下几条，我仍然**不通过**：

### 1. 更长链条失败闭环
仍缺：
- 更长序列下的 retry / respawn / timeout / cleanup 组合证据
- 更多失败样本间的一致性证据

### 2. 长期真实稳定性
仍缺：
- 更多轮连续真实成功样本
- 更长时间窗口下的稳定重复成功证据

### 3. 上线条件
当前仍然不通过：
- 长期稳定运行
- 生产可用
- 大规模可用

---

## 六、风险判断

如果现在把当前五审更新版状态说成“整体真实稳定通过”，仍会犯两个错误：
1. 把“关键真实证据已补到一轮以上”误说成“长期稳定通过”
2. 把“已出现真实 respawn / timeout / success 样本”误说成“所有失败链和稳定性问题已解决”

所以当前必须锁死口径：

> **关键真实证据已补到一轮以上，不等于长期真实稳定通过。**

---

## 七、一句话裁决

> **long-task-submitter 五审更新版，我仍给条件通过：通知链、失败路径、第二轮重复闭环都已从“未验证”推进到“样例级补验证成立”；并且 Curie 侧现已补到真实成功通知链、真实重复运行链、Curie 自定义 task-store 下的真实 escalated 写回、真实 respawn-worker 写回、真实 running-timeout 升级，以及同日12个真实成功样本（含多类恢复路径）。但仍未通过跨天稳定性，也仍不通过长期稳定运行与上线。**

---

# 第二部分：下一步综合建议

## 八、下一步优先顺序

### 1. 优先补：更长链条失败样本
下一步应至少补：
- 更长序列下的 retry / respawn / timeout / cleanup 组合证据
- 让失败路径不只是一轮一轮孤证，而是能连成链

---

### 2. 再补：长期多轮稳定性证据
下一步应继续补：
- 第四轮、第五轮等连续真实成功样本
- 更长时间窗口下的重复成功证据

---

### 3. 最后再谈更高一级放行
在上面两块没补够之前，暂时不要急着扩：
- parent-child 编排
- workflow engine
- 高并发
- 发布 / 上线口径

原因：
> **现在缺的不是更大系统，而是更长链条失败闭环与长期稳定性证据。**

---

## 九、下一轮审计申请条件

如果 Curie 要申请下一轮更高口径审计，建议至少补齐：
1. 一组更长链条失败样本
2. 一组连续多轮真实成功样本
3. 更长时间窗口下的稳定重复成功证据

到那时，下一轮审计才能开始讨论：
- 是否可从“关键真实证据已补到一轮以上”
  升级到
- “关键真实链路已验证更完整，且长期稳定性开始成立”

---

## 十、一句话收口

> **long-task-submitter 现在已经不再是“缺验证”，而是进入了“关键真实证据已补到一轮以上，但更长链条失败闭环与长期稳定性仍待补”的阶段；下一步不要扩系统，继续把失败链拉长、把稳定样本做厚。**
