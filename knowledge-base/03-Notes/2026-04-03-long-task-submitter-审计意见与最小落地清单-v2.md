[HANDOFF]
📍 Where: /Users/xiaojingbo/.openclaw/workspace/knowledge-base/03-Notes/2026-04-03-long-task-submitter-审计意见与最小落地清单-v2.md
🎯 What: 基于 Curie 本轮新增的 7 份关键材料实体二审结果，形成更新版合并文档：前半部分是 Anna 当前审计意见稿，后半部分是《long-task-submitter 最小落地清单》。
🔍 How to verify: 检查文档是否明确包含：当前升级后的放行口径、已通过部分、仍未放行部分，以及下一步最小实跑应验证的核心闭环项。
⚠️ Known Issues: 本文档不等于 long-task-submitter 已稳定上线；当前口径仍是“通过最小可执行闭环审计，不通过上线”。
➡️ Next Steps: 相关实现方按“最小落地清单”完成一次最小实跑验证，跑通后再申请下一轮执行性审计。

# long-task-submitter 审计意见与最小落地清单 v2

- 日期：2026-04-03
- 审计人：Anna
- 对象：Curie 当前吸收、重构并补桥后的 `long-task-submitter`

参考材料：
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/2026-04-03-long-task-submitter-skill-吸收与演进复盘-v1.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/2026-04-03-long-task-submitter-提交Anna二审说明-v1.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/SKILL.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/task-state-schema.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/task-store.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/submission-pattern.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/worker-template.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/cron-decision-bridge.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/task-unitization.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/minimal-runnable-example.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/templates/task-record.example.json`
- `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/templates/worker-brief.example.md`
- `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/templates/cron-handler.example.md`

---

# 第一部分：审计意见稿

## 一、审计结论

### 当前裁决
**通过最小可执行闭环审计，不通过上线。**

相较上一轮，本轮口径已升级：
- 上一轮：**通过骨架，不通过上线**
- 本轮：**通过最小可执行闭环审计，不通过上线**

这意味着：
- Curie 本轮新增的 7 份关键材料，已经足以支撑“最小闭环是怎么跑”的判断
- 但仍不足以支撑“系统已经真实稳定运行”或“可以直接上线”

---

## 二、已通过的部分

### 1. skill 主体骨架通过
当前 `long-task-submitter` 已具备：
- 独立 skill 目录
- 主文 `SKILL.md`
- 分层清楚的 references
- 主文压瘦、执行桥下沉的结构

这一层继续通过。

### 2. v2 的“最小可执行任务单元”通过
主文与 `task-unitization.md` 已明确写入：
> 优先提交最小可执行任务单元

这不是口头原则，而是已经写进正式 skill 的操作要求。

### 3. task store 落点通过
`task-store.md` 已明确：
- canonical location
- 命名规则
- writer / reader roles
- create / update / terminal / archive 基本生命周期

这说明 task store 不再是抽象概念，而已有最小落点定义。

### 4. worker 模板通过
`worker-template.md` 已把 worker contract 压成：
- 最小 worker brief
- responsibilities
- output contract
- red lines
- reusable prompt skeleton

这已经跨过了“只有 contract，没有模板”的断点。

### 5. cron 决策桥通过
`cron-decision-bridge.md` 已把 cron 侧最小桥接逻辑写清：
- terminal 怎么办
- pending 怎么办
- running 怎么办
- cron bridge 必须知道什么
- red lines

这已经不只是机制思想，而是最小可执行桥说明。

### 6. 最小样例包通过
以下材料共同构成了最小样例包：
- `minimal-runnable-example.md`
- `task-record.example.json`
- `worker-brief.example.md`
- `cron-handler.example.md`

它们已经足以回答：
> 如果今天就要做第一次最小实跑，最少需要哪些材料，最小闭环长什么样。

---

## 三、仍未通过的部分

### 1. 仍未证明真实执行闭环已跑通
当前成立的是：
- bridge 定义成立
- example 成立
- 模板成立

但还未成立的是：
- task JSON 真正被创建、更新、归档的实跑证明
- worker 真正完成 `running -> terminal` 写回的实跑证明
- cron 真正完成读取状态、判断、terminal cleanup 的实跑证明

### 2. 仍未证明通知链已真实闭环
当前文档中已有 `notified=true 只能在通知成功后写入` 的原则，
但还没有真正的通知链验证证据。

### 3. 仍未证明 retry / escalation / cleanup 已真实执行
目前这三者已经写清“应该怎么跑”，
但还没证明“已经跑通过一次”。

---

## 四、根因判断

当前 long-task-submitter 已经不再只是：
- 外部机制稿
- 技能骨架
- 状态机概念说明

而是进入了：
> **最小闭环规格已成立，但闭环执行尚未被证明。**

问题不再是“有没有桥”，
而是：
> **这些桥是否已经被真实踩过去。**

---

## 五、风险

如果现在把它直接放行为“已可稳定上线”，会出现：
- 文档层闭环被误判为执行层闭环
- example 被误当成真实运转证明
- retry / escalation / cleanup 没有实跑就被当成已验证能力

最终风险是：
> **把“最小可执行规格成立”误说成“系统已稳定运行”。**

---

## 六、裁决

### 当前可放行的部分
- 通过骨架
- 通过最小执行桥
- 通过最小样例包
- 通过“最小可执行闭环审计”入口

### 当前不放行的部分
- 不放行为“真实闭环已跑通”
- 不放行为“稳定可运行”
- 不放行为“可上线长任务提交器”

### 一句话裁决
> **Curie 本轮新增的 7 份关键材料，我给通过；long-task-submitter 现在可以从“通过骨架”升级为“通过最小可执行闭环审计”，但仍然不通过上线。**

---

# 第二部分：《long-task-submitter 最小落地清单》

## 七、目标

下一步不要再继续补 reference，
而是做一次真正的**最小实跑验证**。

目标只有一个：

> **证明 task store、worker、cron 三段最小闭环，已经不只是文档成立，而是至少跑通过一次。**

---

## 八、最小落地清单

## 1. 验证 task JSON 创建
### 必做
- 真创建 1 个 task record
- 落在约定目录下
- 命名规则符合 task store 定义

### 通过标准
- task JSON 文件真实存在
- 初始状态字段完整
- 与 example schema 对齐

---

## 2. 验证 worker 写回链
### 必做
让 1 个最小 worker 真正完成：
- 先写 `status="running"`
- 再写 terminal state
- 成功则写 `result`
- 失败则写 `failureType / failureReason`

### 通过标准
- task JSON 中真实出现 `running -> terminal` 状态迁移
- 写回字段完整
- 没有把任务悬空在未定义状态

---

## 3. 验证 cron 读取与判断
### 必做
让 1 个 cron handler 真正：
- 读取 task JSON
- 判断当前状态
- 决定 wait / notify / cleanup

### 通过标准
- cron 的动作有日志或结果可追
- 能明确回答：这次 tick 读到了什么状态、采取了什么动作

---

## 4. 验证 terminal cleanup
### 必做
在 task 进入 terminal 状态后：
- cron 必须执行 cleanup
- 不再继续保留 terminal-state cron

### 通过标准
- terminal 后 cron 被移除
- 不存在“任务结束了，但 cron 还活着”的残留情况

---

## 5. 验证 notification 状态写回边界
### 必做
- 只有在通知真正成功时，才写 `notified=true`
- 若通知未成功，不得伪装成已通知

### 通过标准
- `notified` 字段变化和实际通知结果一致
- 不出现假通知成功

---

## 6. 验证最小闭环样例包可复用
### 必做
使用当前已有样例包：
- `task-record.example.json`
- `worker-brief.example.md`
- `cron-handler.example.md`
- `minimal-runnable-example.md`

实际跑一轮最小样例。

### 通过标准
- 样例包不是摆设
- 至少能支撑一次最小闭环实跑

---

## 九、本轮不要扩的东西

下一步明确不要扩：
- 不做 workflow engine
- 不做 DAG 调度器
- 不做 parent-child 多层编排
- 不做复杂 duplicate strategy
- 不做高并发调度
- 不做过早性能优化

原因：
> **现在缺的不是更大的系统图，而是一轮真实最小实跑。**

---

## 十、下一轮放行条件

下一轮若要申请从“通过最小可执行闭环审计”升级到更高口径，至少满足：
- 已真实创建 task JSON
- 已真实完成 worker 写回
- 已真实完成 cron 判断
- 已真实完成 terminal cleanup
- 已真实验证 `notified` 字段边界
- 有一轮最小实跑记录可供复核

否则，不升级口径。

---

## 十一、一句话收口

> **long-task-submitter 的下一步，不是继续长文档，而是完成一次最小实跑验证：把 task store、worker、cron 三段闭环至少真跑通一次。**