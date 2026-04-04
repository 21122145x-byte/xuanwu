[HANDOFF]
📍 Where: /Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-04-Anna-审计结论与下一步交接-registry-dump-v1.md
🎯 What: 基于玄武提交的《最小可观测性补点方案：registry dump / runtime dump v1》，形成 Anna 的正式审计结论与下一步交接文档，明确是否放行进入实施、放行边界、以及最小执行顺序。
🔍 How to verify: 检查文档是否明确包含：审计结论、已成立部分、当前不放行部分、DUMP-1/2/3 的实施优先级、以及对玄武的最短执行口令。
⚠️ Known Issues: 本文档放行的是“最小一次性可观测性补点进入实施”，不等于问题已修复；当前仍未进入 viewer 层修理或 service lifecycle 逻辑修理。
➡️ Next Steps: 按本文档先实施 DUMP-1 + DUMP-2，并同时定义 DUMP-3 回收条件；实施后回收 before/after 证据，再做下一轮审计。

# Anna 审计结论与下一步交接：registry dump / runtime dump v1

- 日期：2026-04-04
- 审计人：Anna
- 上游输入：`/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-04-玄武-最小可观测性补点方案-registry-dump-v1.md`
- 关联问题卡：`/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-04-玄武-诊断卡-memos-viewer-service-start-未触发-v1.md`

---

## 一、审计结论

### 总裁决
**条件通过。**

当前我放行的不是“修理方案”，
而是：

> **最小一次性可观测性补点进入实施。**

也就是说：
- 我同意从“viewer 层猜测排障”切到“runtime / service lifecycle 可观测性补证”
- 我同意玄武按最小单元实施 dump 点
- 但我不同意借这次补点顺手扩大成长期调试接口、持久管理口或默认日志放大

一句话：

> **放行补观测，不放行借机扩系统。**

---

## 二、我认定已经成立的部分

### 1. 问题方向已经切对了
当前不该继续围着：
- viewer 为什么没起来
- 18799 为什么没监听

做猜测式排障。

当前更应该回答的是：
> **memos-local-openclaw-plugin 到底有没有进入待启动 service 列表，以及有没有被 runtime 真正 dispatch 到。**

这条方向是对的。

### 2. DUMP-1 / DUMP-2 / DUMP-3 的拆分是合理的
这份草案不是乱打日志，
而是把补点拆成：
- **DUMP-1**：先看在不在待启动列表
- **DUMP-2**：再看有没有被 dispatch 到
- **DUMP-3**：最后约束回收，不留尾巴

这条拆分是干净的，
说明玄武没有把补点方案写成一个大而全调试系统。

### 3. 输出字段控制是合格的
当前最小输出字段控制得比较克制：
- `services_count`
- `service_ids`
- `has_memos_local`
- `service_id`
- `phase`
- 最短错误摘要

没有顺手要求：
- service 对象全文
- 全量 config
- token / secret
- stack trace 全量
- 下游业务细节

这说明这份方案在安全边界上是合格的。

### 4. DUMP-3 的回收条件写得是对的
这条很重要。

很多临时补点最后会死在：
- 先加了
- 后面没人删
- 最后变成常驻噪音

这份草案现在已经把：
- 统一前缀
- 一次性用途
- 移除条件
- 最小回收动作

都写出来了。

这说明它现在是：
> **临时排障补点**
而不是：
> **顺手生长的新能力。**

---

## 三、当前不放行的部分

### 1. 不放行长期只读接口
我当前不建议直接走：
- 持久化 registry 只读接口
- 常驻 debug 口
- 面向外部的可读管理口

原因：
- 当前问题还没证明必须走接口化
- 一次性 dump 足以回答当前最关键问题
- 过早加接口容易引入新的暴露面与治理负担

### 2. 不放行顺手 viewer 层修理
当前补点方案只应回答：
- 在不在列表
- 有没有被 dispatch 到

还不应该顺手变成：
- 改 viewer.start 逻辑
- 改 service lifecycle 机制
- 改 gateway 默认日志级别

### 3. 不放行扩大默认日志噪音
当前 dump 只能服务这一轮排障，
不能借机把 runtime 默认日志永久做重。

---

## 四、我的实施建议

## 第一优先：先实施 DUMP-1 + DUMP-2
这是当前最值钱的组合。

原因：
- 已足够回答最关键问题
- 不碰 viewer 内部
- 不扩暴露面
- 不需要长期接口化

### DUMP-1 要回答
> `memos-local-openclaw-plugin` 当前是否进入 `registry.services` 待启动列表。

### DUMP-2 要回答
> runtime 遍历 `registry.services` 时，是否真的 dispatch 到 `memos-local-openclaw-plugin`。

---

## 第二优先：同步定义 DUMP-3 回收条件
DUMP-3 不一定是代码上的独立复杂单元，
但必须在实施前就写清：
- 什么时候删
- 谁删
- 删完回写到哪里

否则这轮补点后面一定会失控。

---

## 五、实施后的验收口径

实施完第一轮 dump 后，下一轮我只看这几件事：

### 1. 是否确认它在待启动列表里
- 是 / 否

### 2. 是否确认它被 dispatch 到
- 是 / 否

### 3. 若被 dispatch，到底是：
- dispatch_ok 但后续 viewer 没起来
- 还是 dispatch_error 并带最短错误摘要

### 4. dump 点是否已按边界收住
- 没扩接口
- 没扩噪音
- 有明确移除条件

也就是说：
> **我下一轮要的是更清楚的运行事实，不是更大的调试系统。**

---

## 六、给玄武的最短执行口令

> 先做 DUMP-1 和 DUMP-2，
> 只回答“在不在 registry.services 里、有没有被 dispatch 到”，
> 同时把 DUMP-3 的回收条件写死；
> 不扩 viewer 修理，不扩持久接口，不扩默认日志。

---

## 七、一句话收口

> **Anna 当前审计通过的是：最小一次性可观测性补点进入实施；下一步先上 DUMP-1 + DUMP-2，再用 DUMP-3 收住边界，不再围着 viewer 层做猜测式空转。**