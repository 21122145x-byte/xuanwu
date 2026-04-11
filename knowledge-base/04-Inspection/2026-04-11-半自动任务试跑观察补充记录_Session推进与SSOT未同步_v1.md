# 半自动任务试跑观察补充记录｜Session 推进与 SSOT 未同步 v1

- 日期：2026-04-11
- 记录人：粉雪
- 记录性质：试跑观察补充记录 / SSOT 分叉现象记录
- 对应协议：`/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-11-半自动任务执行协议_v1.md`
- 对应修订方向：`/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-11-半自动任务执行协议_v1.1_修订清单.md`
- 对应试跑任务：Curie memory mainline semi-auto pilot

## 文档挂载
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-11-半自动任务执行协议_v1.md`
- 同级关联：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-11-半自动任务试跑观察记录_Curie-memory-mainline_v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-11-半自动任务执行协议_v1.1_修订清单.md`
- 外部状态来源：
  - `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/00-Inbox/2026-04-11-memory-mainline-package-pending-anna/2026-04-11-memory-semi-auto-pilot-status-card_v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/00-Inbox/2026-04-11-memory-mainline-package-pending-anna/2026-04-11-memory-semi-auto-pilot-board_v1.md`
- 会话观察来源：
  - `agent:curie:main`
  - `agent:anna:main`

---

## 一、观察目标

记录本轮试跑中出现的新现象：

> **会话层已经出现新的推进口径，但状态卡 / 看板（SSOT 候选）仍停留在旧状态。**

本记录用于确认：
- 当前问题不再只是“有没有动作”
- 而是“动作发生后，唯一状态源是否同步更新”

---

## 二、已确认情况

### 1. Curie / Anna 会话层已有新推进
本轮会话观察中，Curie 主会话口径已明确变为：

- **第一段关键链路已验证通过**
- **现在进入审计结果回传验证段**
- 后续只盯：
  - `accepted`
  - `returned`
  - `audit-blocked`
  - 正式文档 + `session_send` 双轨回传

这说明：
> 会话层面并非停在最初的 `review-ready` 理解上，而是已经进入下一观察段。

### 2. 状态卡 / 看板仍停在旧状态
截至本次观察，状态卡与看板仍显示：
- `status: review-ready`
- `owner: curie`
- `next_owner: anna`
- `next_action: audit`
- `updated_at: 2026-04-11 01:50 Asia/Shanghai`

未见同步更新到新的观察口径。

---

## 三、当前现象的本质

### 当前不是哪种情况
- 不是后台完全没跑
- 不是会话完全无新动作
- 不是单纯显示延迟

### 当前是哪种情况
> **会话层真实推进已经发生，但状态卡 / 看板没有同步跟进。**

也就是说：
- 聊天 / 会话正在向前跑
- SSOT 候选载体仍停在上一状态门

---

## 四、制度判断

这次现象直接证明：

> **当前协议 v1 中“状态记录唯一真实来源”还没有被真正制度化执行。**

因为一旦 SSOT 规则足够硬，就不应出现：
- 会话推进一版
- 状态卡停留一版

当前已经出现的不是“谁忘了更新一下”，而是：
- **会话流转与状态流转开始分叉**

这正是 v1.1 修订清单里“SSOT 缺失”问题的现实证据。

---

## 五、当前风险

### 风险 1：复盘口径失真
后续回看时，可能会得到两个不同结论：
- 看会话：链路已进入下一段
- 看状态卡：链路仍停在 `review-ready`

### 风险 2：heartbeat / 看板误判
若后续依赖状态卡判断，可能误以为：
- 主链未推进

但实际上：
- 会话层已经推进

### 风险 3：制度链路与体验链路重新分离
如果继续放任：
- 聊天里理解的是一套
- 状态记录里写的是另一套

那么协议就会重新退化成：
> “看起来有制度，实际上还是靠聊天体感推进。”

---

## 六、当前判断

### 已确认情况
- Curie / Anna 会话层已有新推进口径
- 状态卡 / 看板仍未同步更新

### 当前判断
> **本轮试跑已经进入第二类真实机制问题：不是没有推进，而是推进发生后，SSOT 没有同步。**

### 待验证点
- Curie 后续是否会补写状态卡 / 看板
- 她们是否会把“进入审计结果回传验证段”显式落为新的状态门或观察字段
- v1.1 中 SSOT 规则补齐后，能否消除这种分叉

---

## 七、建议动作

### 动作 1
将本现象作为 v1.1 修订的直接证据，优先补：
- 状态卡 = SSOT
- 会话 / 审计模板 / 看板 = 派生件

### 动作 2
后续要求：
- 一旦会话层出现新推进判断
- 必须同步更新状态卡 / 看板
- 否则不算完成合法流转

### 动作 3
若本轮试跑继续推进，下一次观察应优先核对：
- 新状态是否先写入状态卡
- 再看会话层是否与之对齐

---

## 八、一句话收口

> **这轮试跑已暴露出第二类真实机制问题：后台会话层已经推进到下一观察段，但状态卡 / 看板仍停留在旧状态，说明 SSOT 尚未真正制度化落地。**

---

## 九、5 字段 handoff

- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-11-半自动任务试跑观察补充记录_Session推进与SSOT未同步_v1.md`
- **What**
  - 将“会话层已推进、但状态卡 / 看板未同步”的现象压成正式观察补充记录，作为 v1.1 修订 SSOT 规则的直接证据。
- **How to verify**
  - 检查文档是否同时写出：1）Curie 会话已进入新的观察口径；2）状态卡 / 看板仍停在 `review-ready`；3）由此得出 SSOT 分叉判断。
- **Known Issues**
  - 当前还未确认 Curie 是否稍后会补写状态卡；本记录基于当前观察截面。
- **Next Steps**
  - 继续观察后续状态卡是否补写；并将本现象纳入 `半自动任务执行协议_v1.1` 的 SSOT 修订中。
