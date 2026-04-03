[HANDOFF]
📍 Where: /Users/xiaojingbo/.openclaw/workspace/knowledge-base/03-Notes/2026-04-03-long-task-submitter-审计意见与下一阶段最小落地清单-v1.md
🎯 What: 基于 Curie 对 long-task-submitter 的吸收复盘文与实际 skill 本体，形成一份合并文档：前半部分是 Anna 的审计意见稿，后半部分是《long-task-submitter 下一阶段最小落地清单》。
🔍 How to verify: 检查文档是否明确包含：当前可放行部分、当前不放行部分、核心断点、以及下一阶段只需补齐的最小 3 块落地项。
⚠️ Known Issues: 本文档不等于 long-task-submitter 已可上线；当前判断仍是“通过骨架，不通过上线”。
➡️ Next Steps: 将本文档交 Curie / 相关实现方，按最小落地清单补 task store、worker 模板、cron 决策桥，补完后再进入下一轮执行性审计。

# long-task-submitter 审计意见与下一阶段最小落地清单 v1

- 日期：2026-04-03
- 审计人：Anna
- 对象：Curie 当前吸收与重构后的 `long-task-submitter`
- 参考材料：
  - `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/2026-04-03-long-task-submitter-skill-吸收与演进复盘-v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/SKILL.md`
  - `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/task-state-schema.md`
  - `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/submission-pattern.md`
  - `/Users/xiaojingbo/.openclaw/workspace-curie/skills/long-task-submitter/references/task-unitization.md`

---

# 第一部分：审计意见稿

## 一、审计结论

### 结论
**通过骨架，不通过上线。**

也就是说：
- Curie 这轮工作已经把 long-task-submitter 从“外部机制稿”推进成了“我们自己的正式 skill 骨架”
- 但当前仍不能放行成：
  - 已可稳定上线的长任务提交器
  - 已完成真实执行闭环的系统

---

## 二、已成立的部分

### 1. skill 化收口成立
当前不是把外部稿照搬进来，
而是已经形成：
- 独立 skill 目录
- 独立 `SKILL.md`
- 分层 references
- 主文压瘦、细节下沉的结构

这一步是成立的。

### 2. v2 升级是实质升级，不是换词
当前 skill 主文已明确写入：
> 提交最小可执行任务单元

并且 `task-unitization.md` 已把这条原则解释清楚。

这意味着它已经从：
- “怎么提交长任务”
升级到：
- “怎么先压单元，再提交长任务”

这一步是这轮最有价值的升级。

### 3. 状态机骨架清楚
当前 `task-state-schema.md` 已至少压清三层：
- task record
- worker
- cron

并明确：
- worker 负责执行与写结果
- cron 负责 retry / escalation / terminal cleanup

这条主骨架成立。

### 4. references 分层正确
当前 skill 结构已经具备：
- 主文可读
- reference 可下沉
- 后续可以继续长

这比把所有机制一次塞进主文要稳得多。

### 5. v3 方向预留方式正确
Curie 把 v3 方向压进了 reference 和本地说明卡，
而不是直接塞爆主文。

这说明这轮判断是克制的，没有提前把 skill 膨胀成 workflow engine 设计书。

---

## 三、当前仍未成立的部分

### 1. task store 还没真落地
当前有 schema，
但还没有：
- 真实存储位置约定
- 读写约定
- 生命周期约定

所以 task state 现在还是“定义存在”，不是“系统已接通”。

### 2. worker 还是 contract，不是模板
现在已经明确 worker 应该：
- 置 running
- 写 assignedAgent
- 写 heartbeat
- 写 result / failure

但还没有一个：
- 可复用 worker brief
- 可直接提交的 worker template
- 能稳定套用的执行模板

所以 worker 还停在契约层。

### 3. cron decision bridge 还没变成执行桥
当前已经写了 cron 的 decision model，
但还没有一个真正的桥把这件事落下来：
- cron 如何读取 task
- 如何判断 wait / retry / escalate / cleanup
- 如何真正执行 terminal cleanup

这一块不补，skill 仍然只是机制骨架。

---

## 四、根因判断

当前 long-task-submitter 的问题，不是方向错，
也不是 skill 写得虚。

真正的问题是：

> **它已经完成了“机制型 skill”这一步，但还没完成“执行型 skill”这一步。**

也就是：
- 状态机已经被说明
- 但状态机还没有被接成真实执行闭环

---

## 五、风险

如果现在把它放行为“可稳定上线”，会出现：
- task state 有定义但没有真实单一状态源
- worker 行为因人而异
- cron 逻辑停留在纸面，无法保证终态清理
- 系统表面像能跑，实际上核心桥接还没补上

最终风险是：
> **看起来像系统，实际还只是一个结构漂亮的机制骨架。**

---

## 六、裁决

### 可放行部分
- 吸收动作：通过
- skill 化收口：通过
- v2 升级：通过
- references 分层：通过
- v3 方向预留：通过

### 不放行部分
- 不放行为“已可稳定执行的长任务提交器”
- 不放行为“已完成闭环实现”
- 不允许在当前阶段对外宣称已可上线稳定使用

### 一句话裁决
> **Curie 已把它推进成正式 skill 骨架，这一步通过；但仍应坚持“通过骨架，不通过上线”。**

---

# 第二部分：《long-task-submitter 下一阶段最小落地清单》

## 七、目标

下一阶段不要继续扩概念，
只补最少、最硬、最能让它真正开始跑起来的 3 块。

目标只有一个：

> **让 long-task-submitter 从“机制型 skill”进入“最小可执行闭环”。**

---

## 八、最小落地清单

## 1. task store 落点
### 必补内容
明确：
- task JSON 写在哪里
- 谁读
- 谁写
- 何时创建
- 何时更新
- 何时删除 / 归档

### 最小要求
至少补清：
- 统一目录
- 文件命名规则
- 单一状态源原则
- terminal 状态后的归档 / 清理规则

### 本项通过标准
回答清楚：
> 每一个 task record 的真实落点在哪，以及系统里谁对它负责读写。

---

## 2. worker 模板
### 必补内容
把当前 worker contract 变成：
- 一份可直接复用的 worker brief
- 一份清楚的输入 / 输出模板
- 一套最小成功 / 失败写回规则

### 最小要求
至少补清：
- worker 启动后第一步写什么
- 成功时怎么写回
- 失败时怎么写回
- heartbeat 何时更新
- worker 明确不能做什么（例如不能自己定义 escalation policy）

### 本项通过标准
回答清楚：
> 如果今天要实际提交一个最小长任务，是否已经有一个可直接套用的 worker 模板。

---

## 3. cron 决策桥
### 必补内容
把当前 cron decision model 变成一份真实桥接模板：
- cron 读 task
- 判断状态
- 决定 wait / retry / escalate / notify / cleanup
- terminal 立即删 cron

### 最小要求
至少补清：
- cron 每次 tick 读什么
- 按什么分支判断
- 在什么条件下重试 worker
- 在什么条件下升级
- 在什么条件下通知
- 在什么条件下删 cron

### 本项通过标准
回答清楚：
> cron 现在不只是“应该怎么做”，而是已经有一份可执行桥接模板可照着跑。

---

## 九、本轮不要扩的东西

下一阶段明确不要扩：
- 不做 workflow engine
- 不做 DAG 调度器
- 不做复杂并发编排
- 不做多父多子任务树
- 不做过早量化的性能优化
- 不做过早 duplicate strategy 大设计

原因很简单：

> **现在缺的不是更大的脑图，而是三块最小执行桥。**

---

## 十、建议实施顺序

建议顺序固定为：
1. task store 落点
2. worker 模板
3. cron 决策桥

原因：
- 没有 task store，后两者都悬空
- 没有 worker 模板，cron 也无从重试
- 没有 cron 决策桥，就没有终态闭环

---

## 十一、下一轮审计放行条件

下一轮若要申请从“骨架通过”升级到“可执行通过”，至少满足：
- task store 已有真实落点
- worker 模板已可直接复用
- cron 决策桥已形成可执行模板
- 能举出一个最小样例证明这三者能串起来

否则仍不放行为“稳定可运行”。

---

## 十二、一句话收口

> **long-task-submitter 下一阶段不要继续长概念，只补三件实东西：task store 落点、worker 模板、cron 决策桥。补完这三块，它才有资格从正式骨架进入最小可执行闭环。**