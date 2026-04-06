# 玄武 → Anna 回传交接文档｜OpenClaw v2026.4.5 映射表补充 v1

- 日期：2026-04-06
- 回传方向：玄武 → Anna
- 类型：审计回传 / 映射表补充
- 状态：按 Anna 审计意见补件完成，提交复核

---

## Where

### 本轮新增补件
1. release 修复项 ↔ 本地现象映射表  
`/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-06-玄武-OpenClaw-v2026.4.5-release修复项↔本地现象映射表_v1.md`

2. issue 簇 ↔ 本地问题簇强弱分级表  
`/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-06-玄武-OpenClaw-v2026.4.5-issue簇↔本地问题簇强弱分级表_v1.md`

### 上游审计意见
3. Anna 审计意见文档  
`/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-06-Anna-审计意见与下一步建议交接文档_OpenClaw-v2026.4.5-版本风险扫描_v1.md`

### 原始背景输入
4. OpenClaw v2026.4.5 版本情报与首批 Bug 扫描  
`/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/03-Notes/2026-04-06-OpenClaw-v2026.4.5-版本情报与首批Bug扫描_v1.md`

---

## What

按 Anna 的审计意见，本轮玄武已补齐两张映射表，并刻意把边界压死：

### 1. 第一张：release 修复项 ↔ 本地现象映射表
这张表已把每条关键 release 修复项拆成：
- release 修复项
- 本地现象
- 当前对应证据
- 证据等级
- 当前判断
- 还缺什么

证据等级已写死为：
- `L0｜仅同域`
- `L1｜弱对应`
- `L2｜中对应`
- `L3｜强对应`

当前口径：
- **不给 L3**
- 只把若干条收为“高相关映射项”
- 不把它们写成“已完成本地定因”

本轮优先压出的 4 条高相关映射项：
1. `Live model switching` ↔ Curie 的 `/models` 切换历史 / 旧 session 失稳
2. `OpenAI / reply delivery / final_answer buffering` ↔ 本地“假在线 / 无收口 / 叫不应”
3. `Auto-reply lifecycle ownership` ↔ 新旧 session 差异 / 在线但真实执行状态分离
4. `Tool result truncation / retention fixes` ↔ `toolResult` 已回写但 assistant 不续跑

### 2. 第二张：issue 簇 ↔ 本地问题簇强弱分级表
这张表已把上游 issue 簇压成 4 档：
- `G0｜背景噪音`
- `G1｜弱相关参考`
- `G2｜高相关参考`
- `G3｜值得专项验证`

当前明确写死：
> `G3` = 值得专项验证，不等于已完成定因。

本轮最重要的分级结果：

#### G3｜值得专项验证
1. `active run / listener ownership / gateway crash`
   - 对应本地：
     - `XW-RUN-05`
     - `XW-CHAIN-01`
     - `XW-STAT-01`

2. `reply / delivery / context leak`
   - 对应本地：
     - `XW-RUN-04`
     - `XW-RUN-05`
     - `XW-STAT-01`

#### G2｜高相关背景输入
3. `gateway crash / startup / plugin reload`
4. `memory-core / dreaming`

#### G0｜当前不抢主线
5. `channel / media regressions`

---

## How to verify

请 Anna 复核时优先核以下 5 点：

### 1. 两张表是否都守住“背景输入，不作定因”的边界
重点核：
- 是否仍未把 release 修复项写成本地根因
- 是否仍未把 issue 簇写成已确认同根
- 是否仍未把任一映射等级写成放行依据

### 2. 第一张表的证据等级是否够克制
重点核：
- 当前不给 `L3` 是否合理
- `Live model switching / reply delivery / lifecycle ownership / tool result retention` 四条是否应继续保持在“高相关映射项”而非“已定因项”

### 3. 第二张表的强弱分级是否合理
重点核：
- `active run / listener ownership / gateway crash`
- `reply / delivery / context leak`

是否可接受作为：
- `G3｜值得专项验证`
而不是：
- 已完成本地定因

### 4. memory / channel 两条支线是否压住了边界
重点核：
- `memory-core / dreaming` 是否适合作为 G2 背景输入，而非直接并入 Curie 续跑主线
- `channel / media regressions` 是否适合作为 G0 背景噪音保留，而不抢当前主线资源

### 5. 是否足以进入下一轮专项验证设计
请 Anna 判断：
- 这两张表是否已经足够支撑下一轮验证计划 v2
- 还是还需要先补一轮更细的事件层证据表

---

## Known Issues

1. 两张表都仍是“映射层资产”，不是定因资产
- 它们可以提升审计精度
- 但不能替代本地 before/after

2. 当前最强也只是“G3｜值得专项验证”与“L2｜中对应”
- 还没有任何条目被写成“已完成本地同根确认”

3. Curie / 多模型续跑簇仍需靠本地样本继续压实
- 尤其要补：
  - active run 边界
  - delivery 层丢失/偏移
  - session ownership / rotation / compaction 邻接证据

4. 版本映射不能替代系统级拍板
- 任何默认模型路线、默认会话策略、channel 策略调整，仍需回 BOSS

---

## Next Steps

### 玄武建议的下一步
若 Anna 认可这两张表的边界与分级，可继续进入：

1. **专项验证计划 v2**
优先围绕两条 G3 主线展开：
- active run / listener ownership / gateway crash
- reply / delivery / context leak

2. **事件层证据补强**
重点补：
- 是未续跑，还是已续跑未投递
- 是否伴随 session rotation / ownership 变化
- 是否存在 active run 边界错位样本

3. **继续保持 memory / channel 的边界**
- memory-core / dreaming：作为治理背景输入继续盯
- channel / media regressions：保持监控，不抢主线

### 请求 Anna 本轮复核给出的判断
请 Anna 优先明确：
- 当前是否接受这两张映射表作为合格补件
- 是否同意据此进入 next-step 验证计划 v2
- 是否还需要补一层“事件级证据表”再进入下一轮验证

---

## 一句话收口

> 按 Anna 上轮审计要求，玄武已补齐 `release 修复项 ↔ 本地现象` 与 `issue 簇 ↔ 本地问题簇` 两张映射表；当前两张表都已守住“背景输入、不作定因、不作放行”的边界，现提交 Anna 复核，判断是否可据此进入下一轮更硬的专项验证设计。