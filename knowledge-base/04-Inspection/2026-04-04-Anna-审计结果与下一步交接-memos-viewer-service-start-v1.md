[HANDOFF]
📍 Where: /Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-04-Anna-审计结果与下一步交接-memos-viewer-service-start-v1.md
🎯 What: 基于玄武提交的《memos viewer service start 未触发，导致 18799 UI 持续掉线》诊断卡，形成 Anna 的审计结果与下一步交接文档，明确当前可成立判断、边界、以及后续最小动作顺序。
🔍 How to verify: 检查文档是否明确包含：审计结论、已成立证据、未成立部分、风险、最小下一步、以及是否允许进入只读可观测性补点。
⚠️ Known Issues: 本文档不等于 memos UI 已修复；当前结论仍停留在“runtime/service lifecycle 可观测性缺口”层，不等于已定位到唯一代码根因。
➡️ Next Steps: 先按本交接文档补最小可观测性，再做二次验证，不再继续做 viewer 层猜测式排障。

# Anna 审计结果与下一步交接：memos viewer service start 未触发 v1

- 日期：2026-04-04
- 审计人：Anna
- 上游输入：`/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-04-玄武-诊断卡-memos-viewer-service-start-未触发-v1.md`

---

## 一、审计结论

### 总裁决
**条件通过。**

当前最准确的审计判断是：

> **memos UI 掉线问题，已经从“viewer 为什么没起来”的猜测层，压实到了“service lifecycle 是否被真实派发/进入缺少可观测性”的 runtime 治理问题。**

也就是说：
- 这次诊断卡不是空推理
- 证据链已经够支持“不要再在 viewer 层盲猜”
- 但当前仍未到“已找到唯一代码根因”
- 更未到“已修复”

---

## 二、我认定已经成立的部分

### 1. 18799 当前确实不监听
这不是感知问题，而是已被多轮复位验证确认。

### 2. memos-local 在 restart 后只到 `initialized`
当前证据支持：
- 能看到 `initialized`
- 看不到 `started`
- 看不到 `http://127.0.0.1:18799`

所以：
> **initialized ≠ service started**

这条边界现在已经必须写死。

### 3. viewer 原本由插件生命周期内嵌拉起
这一点也已经被压实：
- 不是独立 daemon
- 不是独立 LaunchAgent
- 不是外部单独托管 UI 服务

所以 viewer 掉线问题现在不能继续朝“独立服务退出”方向发散。

### 4. 当前没有证据显示 memos-local service start 被真实进入
这是这张卡最关键的判断。

因为现在已经补了最小观测点：
- `service start entered`
- `viewer.start begin`
- `viewer.start resolved`
- `viewer.start catch reached`

而真实 runtime 日志里这几项都是 **0 条**。

这说明：
> **当前最强判断不是 viewer 自己崩，而是 service start 在本次运行中根本没有被真实派发/进入，或至少没有任何证据证明它被进入了。**

### 5. 当前 live registry 在运行边界下不可直接读取
这点也成立：
- 没有 inspect/debug 口
- 没有 registry RPC
- 没有安全可行的 live registry 只读入口

所以目前最大的断点不是“没判断”，
而是：
> **缺一个最小只读可观测性入口。**

---

## 三、当前仍未成立的部分

### 1. 还不能说唯一根因已锁定
当前只能锁到：
- `registerService` 存在
- `startPluginServices` 存在
- 日志中却没有任何 service start 进入证据

但还不能直接说：
- 一定是 registry 未写入
- 一定是 runtime 遍历漏掉
- 一定是上游生命周期静默短路中的哪一行代码

### 2. 还不能说 memos-local 自身逻辑崩溃
因为：
- 没看到 `viewer.start begin`
- 也没看到 `viewer.start catch`

所以现在更像是：
- 还没走到 viewer.start 这一层
而不是：
- 走到了 viewer.start 但崩了

### 3. 还不能说问题已经修复
当前没有 before/after 修复对照，
也没有 `started + 18799 listening` 恢复样本。

---

## 四、风险判断

如果现在继续按旧方式排障，会有三个风险：
1. 继续把 `initialized` 误判成“服务已经正常起来”
2. 继续围着 viewer 层做猜测式排障，造成空转
3. 反复 restart，反而增加断链和噪音

所以这条线现在最需要避免的是：
> **猜 viewer，不查 lifecycle。**

---

## 五、我的审计裁决

### 可以放行的部分
- 放行“这是一个 runtime / plugin lifecycle / observability 问题”的判断
- 放行“先补最小可观测性，再继续判断修理路径”的顺序
- 放行玄武进入“起草最小只读调试口 / registry dump 点方案”

### 不放行的部分
- 不放行“已找到唯一根因”
- 不放行“viewer 层已经确认崩溃”
- 不放行“问题已修复”
- 不放行继续无目标重复 restart 作为主要排障手段

---

## 六、下一步动作顺序（最小版）

### 第一步：先补最小可观测性
优先级最高。

推荐两种最小方案，二选一：
1. **只读 registry 可观测点**
   - 仅本地可见
   - 只回答：`activeRegistry.services` 当前有哪些 service id
   - 是否包含 `memos-local-openclaw-plugin`
2. **一次性 runtime dump 日志点**
   - 不做持久接口
   - 只在 `startPluginServices` 调用前后打一轮最小 dump

如果只能选一个，
我更倾向先上：
> **一次性 dump 点**

因为更轻、更不容易引入额外暴露面。

---

### 第二步：补 service lifecycle 锚点
在 `startPluginServices` 调用前后只加最少日志：
- services 总数
- 正在 dispatch 的 service id
- dispatch 成功 / 异常

目标不是长期加重日志，
而是只回答：
> memos-local 到底有没有真的被遍历到。

---

### 第三步：再做二次验证
只有在补了最小可观测性之后，
才值得重新做：
- gateway restart
- 18799 监听检查
- `started` / `viewer.start` 锚点检查

否则还是空转。

---

## 七、交接给玄武的最短执行口令

> 不再猜 viewer 层；
> 先补最小可观测性；
> 先证明 memos-local service 有没有被 runtime 真的 dispatch 到；
> 再决定后续修理路径。 

---

## 八、一句话收口

> **Anna 当前审计通过的是“问题已经被压到 runtime/service lifecycle 可观测性缺口层”，不是“问题已经修好”；下一步应先补最小可观测性，再继续排障，不再围着 viewer 层做猜测式空转。**