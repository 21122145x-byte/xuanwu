# 升级后首轮复测清单｜Discord 离线 + 上下文异常专项版｜OpenClaw v2026.4.5 v1

- 日期：2026-04-07
- 归属：玄武
- 类型：升级后专项复测清单
- 适用对象：`2026.4.5` 受控升级后的首轮复测
- 目的：针对当前最相关的两类风险——**Discord 离线/假离线** 与 **上下文异常/污染/错位**——做最小但足够硬的复测收证。

---

## 0. 使用边界

### 这份清单负责什么
- 升级后第一轮快速复测
- 压清 Discord 在线状态与真实链路是否一致
- 压清 session / thread / reset / context 注入是否异常
- 为后续“升级有效 / 升级无效 / 部分收敛”提供证据

### 这份清单不负责什么
- 不直接输出“已彻底修复”
- 不替代完整 before / after 总结稿
- 不替代系统级最终放行结论

一句话：
> **这是一份升级后首轮复测清单，不是闭环结案单。**

---

## 1. 当前专项背景

本轮专项关注两类问题：

### A. Discord 离线 / 假离线 / ready 状态失真
对应上游 issue 重点样本：
- `#31260` — Discord bot shows as offline despite being functional
- `#58290` — Discord bot never reaches ready state — stuck at awaiting gateway readiness
- `#57925` — Discord extension silently skipped during gateway startup
- `#56086 / #57111 / #13688 / #51116` — stale socket / reconnect / resume / restart 问题簇

### B. 上下文异常 / 污染 / reset 不干净 / thread 错位
对应上游 issue 重点样本：
- `#41823` — Discord Thread Session Fork Causes Context Pollution
- `#44447` — Discord thread context re-injected every turn
- `#55474` — session.resetTriggers 命中但 sessionId 不旋转，context 持续累积
- `#52112` — Thread context lost on gateway restart
- `#60448 / #61908 / #58821 / #49080` — metadata leak / context leak / stale policy context

---

## 2. 首轮复测总目标

升级到 `2026.4.5` 后，首轮只回答四个核心问题：

1. **Discord 是否仍会出现“显示离线，但实际部分链路还能工作”或“看似在线但真实不可用”**
2. **旧主会话 / 新 session / thread session 的上下文边界是否更干净**
3. **reset / new session 后，sessionId 与上下文是否真的切换**
4. **是否仍出现 metadata leak / context reinject / stale context 累积**

---

## 3. 复测项 A｜Discord 离线 / 状态一致性

### A1. 在线状态 vs 实际可达性
#### 要测什么
- Discord 侧显示是否在线
- 实际能否收到消息
- 实际能否正常回复
- 状态面板与真实链路是否一致

#### 最小动作
1. 检查 gateway / node / channel 状态
2. 向目标 Discord 会话发一条最小 user 消息
3. 观察：
   - bot 是否显示在线
   - 消息是否入链
   - assistant 是否正常收口

#### 记录字段
- Discord 显示状态：
- gateway 状态：
- user 是否入链：
- assistant 是否收口：
- 是否存在“显示离线但实际可用”：
- 是否存在“显示在线但实际不收口”：

#### 判定重点
- 若**状态与真实链路一致** → 记为收敛
- 若**状态与真实链路继续分叉** → 记为未收敛，偏状态一致性问题

---

### A2. ready / reconnect / stale socket 复核
#### 要测什么
- 升级后是否仍卡在 ready 前
- reconnect 后是否出现长时间不可用
- stale socket 是否仍导致整链异常

#### 最小动作
1. 查看启动/运行日志中的 ready / reconnect / stale socket 信号
2. 若发生重连，复核消息链是否恢复
3. 核对是否出现静默跳过 Discord extension 的情况

#### 判定重点
- 是否还有 `awaiting gateway readiness` 卡死
- 是否还有 Discord extension 启动被静默跳过
- 是否还有重连后长时间不可达窗口

---

## 4. 复测项 B｜上下文异常 / session 边界

### B1. 旧主会话 vs 新 session
#### 要测什么
- 旧主会话是否仍明显劣于新 session
- 升级后这种差异是否收敛

#### 最小动作
1. 在旧主会话发最小 user-after 测试
2. 在新 session 发同规格测试
3. 对比：
   - user 入链
   - assistant 收口
   - timeout / error
   - reply 稳定性

#### 判定重点
- 若旧主会话明显恢复 → 记为主链收敛信号
- 若仍只有新 session 稳 → 记为旧主会话链未收敛

---

### B2. thread / fork 上下文污染
#### 要测什么
- thread session 是否仍出现上下文串扰
- fork 后是否把不该带的上下文带进来

#### 最小动作
1. 在 thread 中发起新问题
2. 检查是否混入父上下文或历史无关内容
3. 如可行，做一次 thread 内连续两轮对话，观察是否出现重复注入

#### 判定重点
- 是否出现 thread context pollution
- 是否出现每轮重复 reinject
- 是否出现 thread history 丢失或错位

---

### B3. reset / new session 是否真重置
#### 要测什么
- `!new` / reset 后 sessionId 是否真实旋转
- 旧上下文是否仍残留累积

#### 最小动作
1. 触发 reset / new session
2. 记录变更前后 sessionId
3. 发一条与旧上下文故意可区分的测试消息
4. 看是否仍带入旧上下文

#### 判定重点
- sessionId 是否变化
- 上下文是否干净切换
- 是否出现“reset 表面成功，但上下文继续累积”

---

### B4. metadata leak / stale context / context reinject
#### 要测什么
- 是否仍看到 metadata 混入上下文
- 是否仍出现旧策略残留
- 是否仍出现系统提示/内部块泄漏到用户面或 agent 上下文

#### 最小动作
1. 观察新一轮对话的上下文表现
2. 检查是否出现：
   - sender metadata 混入
   - 重复注入固定上下文
   - 旧策略残留
   - 用户可见泄漏

#### 判定重点
- 有无 metadata leak
- 有无 stale policy context
- 有无系统上下文泄漏到用户侧

---

## 5. 首轮记录格式（建议）

每个复测项至少记录：
- 测试时间
- 会话 key / sessionId
- 测试动作
- 实际现象
- 原始证据
- 当前判断
- 是否收敛

建议统一用三值：
- **收敛**
- **部分收敛**
- **未收敛**

---

## 6. 首轮结论口径

### 若结果较好
> 升级后首轮复测显示：Discord 状态一致性与上下文边界问题出现收敛迹象，但当前仍只可写“初步收敛”，不可直接写“彻底修复”。

### 若结果一般
> 升级后首轮复测显示：部分链路收敛，但 Discord 状态一致性或上下文边界仍有残余异常，当前只可写“部分收敛”。

### 若结果较差
> 升级后首轮复测显示：Discord 离线/假离线或上下文异常主问题仍未明显改善，当前不可写升级有效，需继续压事件级问题拆分。

---

## 7. 一句话收口

> **这轮专项复测的关键，不是证明 `2026.4.5` 一定修好了，而是先压清两件事：Discord 的“在线状态”有没有继续撒谎，session / thread / reset 的上下文边界有没有变干净。**
