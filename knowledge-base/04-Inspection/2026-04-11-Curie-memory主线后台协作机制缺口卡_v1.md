# Curie memory 主线后台协作机制缺口卡 v1

- 日期：2026-04-11
- 主责：粉雪
- 性质：缺口卡 / 最小修复建议
- 适用范围：Curie / Anna / 粉雪 / 涉及后台多 Agent 协作的 memory 主线任务

## 文档挂载
- 上位文档：/Users/xiaojingbo/.openclaw/workspace/knowledge-base/01-Constitution/团队协作宪法与治理总纲.md；/Users/xiaojingbo/.openclaw/workspace/knowledge-base/01-Constitution/跨Agent协作流转执行卡.md
- 同级关联：/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-08-去memos化后的memory管理统一规则卡_v1.md
- 下位文档：/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-11-Curie-memory主线后台协作优化协议_v1.md
- 所属主线：Curie memory 主线后台协作 / 多 Agent 后台执行防卡断

---

## 一、问题概述

在 Curie 承担 memory 主线方案撰写的后台协作中，现有机制并非“完全卡死”，而是出现了：

- 写稿 subagent 已完成，但结果没有稳定进入下一环
- 主 Agent 已收口到 review-ready，但外部体感像“停住了”
- heartbeat 能证明链路还活着，但不能保证产物继续流转
- 前台 Discord 新消息会干扰后台 announce / 收口链

因此当前问题的本质不是“没人做事”，而是：

> **后台多 Agent 机制能产生产物，但不能稳定完成跨环交接与对外回传。**

---

## 二、已确认情况

### 1. 写稿 worker 并未真实卡住
- 写稿 subagent 已完成主文与 supporting cards
- 状态已进入 `done`
- 说明“50 分钟前不动”不等于它仍在执行，有可能是早已完成但无人继续接手

### 2. Curie 主 Agent 并未真实卡死
- Curie 主会话已推进到 `review-ready` 收口位
- 已有 heartbeat / package / next-step 判断
- 说明主 Agent 也不是完全失活，而是停在内部收口节点

### 3. 真实断点出现在“下一环流转”
当前最真实的缺口不是写稿，而是：
- worker → Curie 主 Agent
- Curie 主 Agent → Anna 审计
- 内部完成态 → Discord / 外部可见回传

---

## 三、当前机制的 4 个核心缺口

### 缺口 1：交接机制不够硬
worker 完成后，缺少强制性的：
- 状态落盘
- 下一责任位声明
- 下一动作声明

导致“做完”与“被下一环接住”之间存在空档。

### 缺口 2：heartbeat 只能保活，不能保闭环
heartbeat 现在能发现：
- subagent 还活着
- package 已到 review-ready

但做不到：
- review-ready 超时未送审的强制告警
- Anna 审计迟迟未承接的升级
- 链路停在节点上无人接力时的自动推动

### 缺口 3：后台执行与前台消息未彻底解耦
当前在同一 Discord 会话面中：
- 后台任务推进
- 前台询问确认
- announce / 回传

会互相抢控制权。结果是：
- webUI 中动作已经发生
- Discord 前台仍在追问或停留旧状态
- 用户一回复，又触发新回合，打断原有回传链

### 缺口 4：subagent 工具边界与流程设计不匹配
现有某些 subagent 无法稳定完成：
- 向下一会话发送结果
- 发起下一环审计
- 执行跨 session handoff

也就是说，当前机制设计要求 subagent 承担“下一环流转”，但运行时工具权限并没有完整支持。

---

## 四、当前判断

### 已确认情况
- 写稿 subagent 产物是能做出来的
- Curie 主 Agent 具备收口能力
- heartbeat 能证明链路未死

### 当前判断
> **当前后台协作机制的主缺陷不是执行能力不足，而是“阶段门不清、交接不硬、回传易被前台扰动”。**

### 待验证点
- Anna 审计链是否也存在同类“已完成但未稳定回传”的问题
- 若将交接动作改为独立状态流转，是否能显著降低“看起来停住”的概率

---

## 五、最小修复建议

### 修复 1：给每个后台节点加“阶段门”
每一环必须显式写出：
- `status`
- `owner`
- `next_owner`
- `next_action`
- `updated_at`

### 修复 2：heartbeat 从“保活”升级为“保流转”
除存活检查外，新增停滞规则：
- `review-ready > 20m` 未送审 → 提醒 Curie
- `sent-to-anna > 30m` 无承接 → 提醒 Anna / 粉雪
- `announced-pending > 15m` 未外放 → 标记回传异常

### 修复 3：前台确认与后台执行拆轨
原则：
- 后台任务一旦启动，默认以后台状态流转为准
- 前台提问只能在“待人工确认”节点发起
- 若后台已推进到更后阶段，前台旧问题不应反向打断主链

### 修复 4：把“送 Anna 审计”从 worker 职责剥离
worker 只负责：
- 写稿
- 修订
- 结果打包

Curie 主 Agent 才负责：
- 验收
- 送审
- 对外回传判断

这样可以避免让工具受限的 worker 承担超出权限的流转动作。

---

## 六、一句话收口

> **当前 Curie memory 主线后台协作的核心缺口，不是“没人做”，而是“做完后没有被稳定接住并继续流转”；修复重点应从保活转向保交接、保阶段门、保回传解耦。**

---

## 七、5 字段 handoff

- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-11-Curie-memory主线后台协作机制缺口卡_v1.md`
- **What**
  - 识别 Curie memory 主线后台协作的真实缺口，明确不是执行卡死，而是交接、阶段门、回传解耦不足。
- **How to verify**
  - 检查文档是否明确区分“worker 已完成”“主 Agent 已收口”“下一环未稳定流转”，并提出最小修复动作。
- **Known Issues**
  - 当前仍未实装修复；此卡只完成诊断与最小动作建议。
- **Next Steps**
  - 以本卡为输入，落一版《Curie memory 主线后台协作优化协议 v1》，把阶段门、owner、heartbeat 升级动作制度化。
