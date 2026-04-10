# Curie memory 主线后台协作优化协议 v1

- 日期：2026-04-11
- 主责：粉雪
- 性质：优化协议 / 后台协作执行协议
- 适用范围：Curie / Anna / 粉雪 / 涉及后台撰写—验收—审计链的多 Agent 任务

## 文档挂载
- 上位文档：/Users/xiaojingbo/.openclaw/workspace/knowledge-base/01-Constitution/团队协作宪法与治理总纲.md；/Users/xiaojingbo/.openclaw/workspace/knowledge-base/01-Constitution/跨Agent协作流转执行卡.md
- 同级关联：/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-11-Curie-memory主线后台协作机制缺口卡_v1.md
- 下位文档：待补：后台协作状态模板；待补：Curie memory 主线状态看板模板；待补：Anna 审计承接模板
- 所属主线：Curie memory 主线后台协作 / 多 Agent 协作优化

---

## 一、协议目标

本协议的目标是解决以下问题：
- 产物已完成但没有稳定进入下一环
- heartbeat 只能保活，不能保闭环
- 前台 Discord 消息干扰后台协作收口
- worker 与主 Agent 职责边界不清

本协议的原则是：

> **后台任务必须有阶段门、责任位、下一动作与停滞升级规则；任何一环完成，不以“有人记得接”为前提，而以“状态已显式流转”为前提。**

---

## 二、角色边界

### 1. Worker（写稿 / 修订 subagent）
负责：
- 产出主文 / 修订稿 / supporting cards
- 写明当前结果包内容
- 写明自身完成状态

不负责：
- 直接送 Anna 审计
- 对外 announce
- 处理前台确认消息

### 2. Curie 主 Agent
负责：
- 验收 worker 产物
- 做 accept / revise 判断
- 决定是否送 Anna 审计
- 维护后台主线状态
- 决定是否对外回传

### 3. Anna
负责：
- 审计与放行判断
- 打回 / 修改意见
- 审计结论归档

### 4. Heartbeat 子链
负责：
- 盯阶段门停滞
- 发现“已完成未流转”“已送审未承接”“待回传未外放”
- 只提醒、记录、升级，不替代主链执行业务判断

---

## 三、标准阶段门

每个后台任务必须显式处于以下状态之一：

- `drafting`
- `revision-needed`
- `review-ready`
- `sent-to-anna`
- `anna-reviewing`
- `accepted`
- `returned`
- `announced`
- `closed`

禁止使用“差不多好了”“基本完成”这类无状态表达替代阶段门。

---

## 四、每次状态更新的强制字段

每次状态流转至少记录：

- `status`
- `owner`
- `next_owner`
- `next_action`
- `updated_at`
- `artifact_where`
- `known_issues`

推荐格式：

```md
status: review-ready
owner: curie
next_owner: anna
next_action: audit
updated_at: 2026-04-11 01:30 Asia/Shanghai
artifact_where: /path/to/doc
known_issues: section 3 still needs Anna audit on scope boundary
```

---

## 五、标准流转

### 流转 1：Worker 完成
当 worker 完成主文时，必须：
1. 产出主文与 supporting cards
2. 显式写 `status=review-ready`
3. 指定 `next_owner=curie`
4. 停止继续外放，不自己直接送 Anna

### 流转 2：Curie 验收
Curie 主 Agent 收到 `review-ready` 后，只允许做两种正式动作：
- `accept` → 进入 `sent-to-anna`
- `revise` → 进入 `revision-needed`，并派回 worker

不得在 `review-ready` 状态上长期悬停不决。

### 流转 3：Anna 承接
当状态进入 `sent-to-anna` 后，Anna 必须尽快回：
- `anna-reviewing`
或
- `returned`

不得出现“收到但无状态变化”的隐式承接。

### 流转 4：对外回传
只有当状态达到：
- `accepted`
- 或明确需要人工知情的 `returned`

才进入 `announced`。

默认不允许 worker 自己 announce；由 Curie 主 Agent 或明确指定责任位统一回传。

---

## 六、Heartbeat 升级规则（优化版）

heartbeat 不再只问“活着没”，还要问“流转了没”。

### 规则 1：review-ready 停滞
- `review-ready > 20 分钟` 未变更 → 提醒 Curie

### 规则 2：sent-to-anna 停滞
- `sent-to-anna > 30 分钟` 未承接 → 提醒 Anna
- 若再 30 分钟无变化 → 升级粉雪

### 规则 3：accepted 后未 announce
- `accepted > 15 分钟` 未进入 `announced` → 标记为回传链异常

### 规则 4：returned 后未重分配
- `returned > 20 分钟` 未重新进入 `revision-needed` 或 `review-ready` → 提醒 Curie

---

## 七、前台消息与后台执行的解耦规则

### 原则
后台主链以状态流转为准，不以前台 Discord 对话节奏为准。

### 具体规则
1. 若后台已进入更后阶段，前台旧问题不得把主链拉回较早阶段
2. 前台确认只允许发生在显式的 `awaiting-human-confirmation` 节点
3. 若用户新消息到来，但后台状态已变更，以后台最新状态为准，不因旧问题再次启动重复动作
4. announce 失败或被打断，不等于主链未执行；必须查看当前阶段门判断真实进度

---

## 八、最小执行模板

```md
Task: Curie memory mainline draft
status: review-ready
owner: curie
next_owner: anna
next_action: audit
updated_at: 2026-04-11 01:30 Asia/Shanghai
artifact_where:
- /path/mainline-v0.2.md
- /path/supporting-card-1.md
known_issues:
- chapter 2 evidence density still pending audit
```

---

## 九、一句话收口

> **优化后的后台协作，不以“大家都还在线”为稳定标准，而以“每一环都有阶段门、责任位、下一动作，且停滞可升级”为稳定标准。**

---

## 十、5 字段 handoff

- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-11-Curie-memory主线后台协作优化协议_v1.md`
- **What**
  - 给 Curie memory 主线后台协作补一版可执行优化协议，明确角色边界、阶段门、流转规则与 heartbeat 升级动作。
- **How to verify**
  - 检查是否定义了 1）角色边界；2）标准阶段门；3）状态强制字段；4）标准流转；5）heartbeat 停滞升级规则；6）前后台解耦规则。
- **Known Issues**
  - 本协议尚未通过一次完整真实任务闭环验证；需要结合下一次 Curie 主线任务试跑。
- **Next Steps**
  - 基于本协议落状态模板与看板模板，并在下一轮 Curie memory 主线任务中试跑一次。
