[HANDOFF]
📍 Where: /Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-07-Anna-安全扫描审计报告与修复优先级建议_OpenClaw-v2026.4.5配置变更_v1.md
🎯 What: 基于 `openclaw status`、`openclaw update status`、`openclaw security audit --deep` 与 `openclaw.json` 配置扫描结果，形成 Anna 的正式安全扫描审计报告与修复优先级建议，明确新版本配置合法性变化带来的主要风险面、当前高危组合、以及修复优先顺序。
🔍 How to verify: 检查文档是否明确包含：1）当前版本与更新状态；2）新配置字段变化已生效的事实；3）安全审计中的关键 critical / warn；4）当前最危险的配置组合；5）修复优先级建议。
⚠️ Known Issues: 本文档是只读扫描后的审计结论与修复建议，不等于已执行配置整改；任何状态变更动作（收紧 groupPolicy、调整 exec、安全策略、禁用 memos）仍需在后续执行窗口中审慎实施。
➡️ Next Steps: 优先收紧开放群策略与 exec/full 暴露，再推进去 memos 化；如需实施，后续应再出一份“最小配置修复清单”或执行卡，分步落地并保留回滚点。

# Anna 安全扫描审计报告与修复优先级建议｜OpenClaw v2026.4.5 配置变更 v1

- 日期：2026-04-07
- 审计人：Anna
- 扫描方式：只读检查
- 依据：
  - `openclaw status`
  - `openclaw update status`
  - `openclaw security audit --deep`
  - `~/.openclaw/openclaw.json`

---

## 一、审计结论

### 总判断
**高风险，需尽快收口。**

当前最准确的判断不是：
> **配置字段改了，但只是语法更新。**

而是：
> **配置语法层已跟上 `2026.4.5` 的新口径，但安全暴露面明显扩大。**

一句话：

> **现在的主要问题不是“字段不合法”，而是“合法配置在当前组合下过于开放”。**

---

## 二、当前已确认事实

### 1. 当前版本状态
只读结果显示：
- `openclaw update status` → `pnpm · up to date · npm latest 2026.4.5`

说明当前运行环境已经对齐到 `2026.4.5` 这条版本线。

### 2. 新配置字段变化已真实生效
在当前 `openclaw.json` 中，已看到：
- 旧的 channel 级 `allow: true` 口径已切到 `enabled: true`
- 大量 `groupPolicy` 已从旧的 `allowlist` 语义转为当前实际使用的 `open`

这说明：
> **当前配置已经进入新版本语义，而不是旧版字段残留为主。**

### 3. 安全审计结果已达高风险级别
`openclaw security audit --deep` 返回：
- **18 critical**
- **5 warn**
- **1 info**

这不是“轻提醒”，而是明确的高风险暴露面。

---

## 三、当前最危险的组合

## 1. `groupPolicy = "open"` 广泛存在
当前开放组策略已出现在：
- Discord 全局与多个 account
- Feishu 全局与多个 account

这意味着：
> **群侧触发面已明显打开。**

---

## 2. `exec.security = full` 仍在可触达链上
审计明确点到：
- `anna: security=full, host=gateway`

这意味着：
> **高权限执行能力仍然暴露在当前运行链上。**

---

## 3. `sandbox = off` 与 runtime / fs 工具暴露叠加
审计结果显示多个 agent 仍为：
- `sandbox=off`
- runtime tools 可用
- filesystem tools 可用
- `workspaceOnly=false`

这意味着：
> **当前不是单点开放，而是“开放群策略 + 高权限工具 + 无沙箱”的组合风险。**

---

## 4. memos 插件仍在默认 memory slot 上，且代码安全扫描继续给出红旗
当前配置仍有：
- `plugins.slots.memory = memos-local-openclaw-plugin`
- `memos-local-openclaw-plugin` 仍在 allow / enabled 状态

同时安全扫描明确命中其危险模式：
- shell command execution
- env harvesting + network send

这进一步支持：
> **memos 不应继续留在默认记忆基础设施位置。**

---

## 四、关键审计项（按风险归纳）

### A. 开放群策略风险
关键项包括：
- `security.exposure.open_channels_with_exec`
- `security.exposure.open_groups_with_elevated`
- `security.exposure.open_groups_with_runtime_or_fs`
- 多条 Discord / Feishu warning

### B. 高权限执行风险
关键项包括：
- `tools.exec.security_full_configured`
- `anna: security=full, host=gateway`

### C. 插件与技能代码安全风险
关键项包括：
- `plugins.code_safety` → `memos-local-openclaw-plugin`
- `skills.code_safety` → `openclaw-github-assistant`

### D. 平台安全基线缺口
关键项包括：
- `gateway.auth_no_rate_limit`
- `security.trust_model.multi_user_heuristic`
- `plugins.tools_reachable_permissive_policy`

---

## 五、修复优先级建议

## P0｜立即收口
### 1. 收紧开放群策略
优先级最高。

目标：
- 将 Discord / Feishu 中当前 `groupPolicy = "open"` 的暴露面收回
- 默认不让开放群直接触达高权限 agent 能力

这是当前最危险的入口层问题。

### 2. 隔离 `exec/full` 暴露
重点对象：
- `anna` 的 `exec.security=full`

当前至少应避免它继续处于“开放群可触达”的组合中。

---

## P1｜尽快处理
### 3. 推进去 memos 化
这条已在前面启动，应继续推进：
- 解除 `plugins.slots.memory = memos-local-openclaw-plugin`
- 不再让 memos 承担默认 memory slot
- 用本地替代层接管记忆承载

### 4. 收紧 runtime / fs 暴露面
目标：
- 评估 agents.defaults 与各 agent 的 runtime / fs 暴露是否需要收回
- 尤其是 `workspaceOnly=false` 与 `sandbox=off` 的组合

---

## P2｜后续治理项
### 5. 补网关 auth rate limit
当前审计明确提示：
- `gateway.bind` 非 loopback
- 但 `gateway.auth.rateLimit` 未配置

这属于安全基线缺口，应补上。

### 6. 复核技能与插件代码安全
至少应继续审：
- `memos-local-openclaw-plugin`
- `openclaw-github-assistant`

判断是否保留、迁移、隔离或移除。

---

## 六、当前不建议做的事

当前不建议：
- 直接大改全部配置结构
- 在没有执行卡的情况下同时改 groupPolicy / exec / sandbox / plugin / channel 全套
- 把这次扫描直接当作“已经完成修复”的依据

原因：
> **当前需要的是有顺序的收口，而不是一次性大震荡。**

---

## 七、当前最准确的总收口

> **OpenClaw `2026.4.5` 当前在语法层已跟上新配置口径，但安全层暴露面显著扩大；最危险的不是单个字段，而是 `groupPolicy: "open"`、`exec/security=full`、`sandbox=off` 与 runtime/fs 工具暴露的组合。当前应优先收紧开放群策略与高权限执行暴露，并继续推进去 memos 化。**

---

## 八、一句话收口

> **这轮安全扫描结论不是“配置写错了”，而是“配置虽然合法，但当前组合过于开放”；修复优先级应先收紧开放群策略与 exec/full 暴露，再推进去 memos 化和后续安全基线补齐。**