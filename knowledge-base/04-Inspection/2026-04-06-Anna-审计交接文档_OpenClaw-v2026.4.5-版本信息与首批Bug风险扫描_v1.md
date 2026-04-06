# Anna 审计交接文档：OpenClaw v2026.4.5 新版本信息与首批 Bug 风险扫描 v1

- 日期：2026-04-06
- 提交方向：供 Anna 审计
- 提交人：玄武
- 类型：版本审计交接 / 风险收口 / 下一步建议
- 状态：提交审计，不主张直接放行系统级判断

---

## Where

### 核心文档
1. 版本情报与首批 Bug 扫描主文  
`/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/03-Notes/2026-04-06-OpenClaw-v2026.4.5-版本情报与首批Bug扫描_v1.md`

### 上游来源
2. Release 页面  
`https://github.com/openclaw/openclaw/releases/tag/v2026.4.5`

3. 目标仓库  
`openclaw/openclaw`

### 关联治理背景（供 Anna 参考，不并案）
4. Curie 单样本诊断卡  
`/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/03-Notes/2026-04-06-Curie主会话LLM续跑超时诊断卡-v1.md`

5. 多模型续跑超时簇总卡  
`/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/03-Notes/2026-04-06-多模型续跑超时簇诊断卡-v1.md`

---

## What

本次交给 Anna 审计的，不是“玄武已判断 2026.4.5 有问题”，而是以下三层材料：

### 1. `v2026.4.5` 的版本结构已单独整理
已提取并单独整理：
- release tag：`v2026.4.5`
- 发布时间：`2026-04-06T03:04:54Z`
- release commit：`3e72c0352dde84a0bcb3aabafa99c2d4b12d1c46`
- breaking changes
- 主要新增能力
- 与运行时治理相关的关键修复域

其中与系统治理最相关的 release 域，已单独压出：
- live model switching
- reply delivery / final_answer buffering
- auto-reply lifecycle ownership
- prompt caching / tool results
- cron / heartbeat 调度稳定性

### 2. 发布当天首批 bug 已做按簇收口
不是散抄 issue，而是按治理相关性收成问题簇：

#### A. active run / listener ownership / gateway crash
重点 issue：
- `#61931`
- `#61917`
- `#61912`
- `#61947`

#### B. reply / delivery / context leak
重点 issue：
- `#61908`
- `#61913`
- `#61944`
- `#61916`

#### C. gateway crash / startup / plugin reload
重点 issue：
- `#61922`
- `#61938`
- `#61920`
- `#61883`
- `#61733`

#### D. memory-core / dreaming
重点 issue：
- `#61951`
- `#61946`
- `#61919`
- `#61848`

#### E. channel / media regressions
重点 issue：
- `#61906`
- `#61923`
- `#61726`
- `#61862`
- `#61861`
- `#61880`

### 3. 当前判断已刻意守边界
当前可以成立的判断是：
- `v2026.4.5` 不是小修补，而是一次功能扩张明显、影响面较广的版本
- 发布当天仓库已出现多簇新 bug / regression
- 其中部分 issue 与我们正在治理的运行时问题域高度同域

但当前**不能直接成立**的判断是：
- 不能直接把本地 Curie / 续跑问题归因为 `v2026.4.5`
- 不能把 release note 里的修复项写成“本地已自然解决”
- 不能把 issue 同域性直接写成“已确认同根”

---

## How to verify

请 Anna 审计时优先核以下 5 点：

### 1. 版本信息是否已独立成文、可审可复核
核对主文是否已包含：
- 版本 tag
- 发布时间
- release commit
- breaking / changes / fixes 的压缩结构

### 2. issue 收口方式是否正确
核对是否做到：
- 不是平铺 issue 列表
- 而是按治理问题簇分组
- 每组能看出与系统稳定性/状态可信度的关系

### 3. 边界是否守住
请重点核：
- 是否把“同域”误写成“同根”
- 是否把“发布当天有 regression”误写成“本地问题已被确认来自该版本”
- 是否把“release 修过某类问题”误写成“本地现象已自动解决”

### 4. 与当前治理主线的关联口径是否稳
请核是否仅写成：
- 与 Curie / reply delivery / live switch / cron / heartbeat 等问题域高度相关
而没有越界写成：
- 已并案
- 已定因
- 已可据此放行系统级变更

### 5. 下一步建议是否仍停留在审计安全边界内
请核当前建议是否仍是：
- 可以作为版本风险参考输入治理判断
- 但不应直接据此拍板默认模型路线、默认会话策略、channel 策略调整

---

## Known Issues

1. 当前是“版本情报 + 首批 issue 风险扫描”，不是完整回归测试
- 只能说明上游当天暴露了哪些问题簇
- 不能替代本地 before/after 验证

2. issue 与本地现象的关系仍主要是“同域”
- 当前最多能说：问题域高度相关
- 不能说：已经证实是同一个根因

3. 本文档不应被误用为升级放行依据
- 它适合作为 Anna 的审计参考输入
- 不适合作为直接推动默认行为变更的依据

4. 当前工作区不是 git 仓库
- 本次文档已落盘
- 但无法在该目录下做 git commit 留痕

---

## Next Steps

### 建议 Anna 本轮优先给出的审计判断
1. 是否接受当前版本风险文档的边界口径：
   - 版本问题簇已收口
   - 与本地治理主线高相关
   - 但未定因、未并案、未放行

2. 是否同意将这份文档作为：
   - 后续审计运行时问题时的背景参照
   - 而不是直接升级为结论性诊断

3. 是否需要进一步要求玄武补做一轮：
   - release note 修复项 ↔ 本地现象 的逐条映射审计
   - issue 簇 ↔ 本地问题簇 的证据强弱分级表

### 玄武建议的下一步
1. 若 Anna 同意，可继续补一页：
   - `v2026.4.5 release 修复项` 与 `当前本地问题簇` 的逐条对照表
2. 对 active run / reply delivery / gateway crash / memory-core 四簇优先持续盯样
3. 在本地问题未做 before/after 验证前，不把上游 release / issue 直接转写为本地修复结论

---

## 一句话收口

> 本文档提交 Anna 审计的核心，不是证明 `v2026.4.5` 已导致本地问题，而是提交一份已收紧边界的版本风险扫描：上游新版本当天已出现多簇高相关 bug / regression，足以作为本地治理判断的背景输入，但不足以直接替代本地定因与放行。