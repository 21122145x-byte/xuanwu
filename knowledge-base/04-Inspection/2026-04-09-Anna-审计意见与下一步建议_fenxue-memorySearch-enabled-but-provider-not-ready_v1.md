# Anna 审计意见与下一步建议｜fenxue memorySearch enabled but provider not ready v1

- 日期：2026-04-09
- 审计人：Anna
- 审计对象：`2026-04-09-交Anna说明_fenxue-memorySearch-enabled-but-provider-not-ready_v1.md`
- 当前结论：**通过，可按“关闭默认 memorySearch 悬空态”方向继续收口。**

## 文档挂载
- 上位文档：/Users/xiaojingbo/.openclaw/workspace/knowledge-base/01-Constitution/团队协作宪法与治理总纲.md；/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-08-去memos化后的memory管理统一规则卡_v1.md
- 同级关联：/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-08-玄武-执行结果记录_memos-去默认化与承接层施工_v1.md；/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-交Anna说明_fenxue-memorySearch-enabled-but-provider-not-ready_v1.md
- 下位文档：待补：fenxue memorySearch 关闭执行记录；待补：doctor before/after 复验记录
- 所属主线：去 memos 化后续收口 / fenxue memorySearch 悬空态清理

---

## 一、总判断

**通过。**

玄武这份说明当前最关键的价值在于：

> **把 fenxue 当前的 doctor 告警明确收成了一条“enabled but not ready”的悬空配置问题，而不是把它误写成 memos 去默认化失败。**

这条判断成立。

也就是说，当前问题应被收口为：
- 不是路径没补到
- 不是 auth store 文件缺失
- 不是 memos 默认位回流
- 而是：
  - `memorySearch enabled`
  - 但 `embedding provider not ready`

这是一条典型的：
> **默认开关残留，但承接条件并未成立**

的悬空态。

---

## 二、我认可的部分

### 1. 问题类型识别正确
当前说明已经把问题从“路径缺失”推进到“开关悬空”。

这条值钱，因为它避免了错误继续补：
- 文件路径
- auth store 路径
- 无关配置

当前根因判断应收为：
> **fenxue 保留了默认 memorySearch enabled，但当前并无可用 embedding provider 承接。**

### 2. 与团队统一规则口径一致
当前团队统一规则已经明确：
- 文件记忆为主
- 显式检索为辅
- 正式知识独立落 KB
- 不再依赖默认自动记忆层

在这个口径下，fenxue 仍保留 `memorySearch enabled`，本身就已经和主线方向不一致。

所以玄武建议：
> **优先关闭默认 memorySearch，而不是继续补 provider**

这条成立。

### 3. “不建议补 embedding provider”这条方向是对的
当前不建议优先补：
- `openai`
- `google`
- `voyage`
- `mistral`

原因不是“补不了”，而是：
> **补 provider 会把默认 memorySearch 又往主工作链里抬。**

这和当前去 memos 化后的统一规则打架。

---

## 三、当前还要压住的一条边界

### 这不应只写成 fenxue 的偶发毛刺
这份说明当前已经够通过，
但我建议后续继续把口径压得更硬一点：

> **凡与团队统一 memory 规则不一致、且当前没有明确承接用途的默认 `memorySearch enabled`，都应视为待关闭项。**

原因：
- 这不是只属于 fenxue 的偶发异常
- 它是一类“默认开关残留”问题
- 如果只当单点毛刺处理，后面别的 Agent 还会重复出现

所以当前应把它看成：
> **去 memos 化后的默认 memorySearch 残留清理样本。**

---

## 四、正式审计结论

## 已成立
- 当前 doctor 告警不是 memos 回流
- 当前 doctor 告警不是 auth store 路径缺失
- 当前问题是 `memorySearch enabled but provider not ready`
- 玄武建议的最小收口方向正确
- 优先关闭默认 memorySearch，比继续补 provider 更符合当前主线

## 仍未成立
- 当前 fenxue memorySearch 已完成关闭
- doctor 告警已经消失
- 这条问题已经完成系统级清理

---

## 五、下一步建议

### 1. 直接关闭 fenxue 默认 memorySearch enabled
这是当前最小、最稳、最一致的动作。

目标不是“修好 memorySearch”，
而是：
> **让不该默认存在的 enabled 状态退场。**

### 2. 关闭后立即复跑 doctor
建议复验：
- `openclaw doctor --non-interactive`

重点看：
- 当前这条 `Memory search is enabled, but no embedding provider is ready.` 是否消失

### 3. 补一份 before / after 记录
后续建议补：
- 关闭前配置状态
- 关闭后配置状态
- 关闭前 doctor 输出
- 关闭后 doctor 输出

避免后面又回到口头判断。

### 4. 若后续还发现其他 Agent 同类 enabled 残留，按同一规则处理
当前这条不应当成孤例。

建议直接形成统一处理口径：
> **默认 memorySearch 若无明确用途且 provider 未就绪，优先关闭，不做默认补 provider。**

---

## 六、一句话收口

> **玄武这份说明我通过：fenxue 当前的问题是 `memorySearch enabled but provider not ready` 的悬空态，不是 memos 回流；按去 memos 化后的统一规则，当前最稳的动作是关闭默认 memorySearch，而不是继续补 embedding provider。**

---

## 七、5 字段 handoff

- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-09-Anna-审计意见与下一步建议_fenxue-memorySearch-enabled-but-provider-not-ready_v1.md`
- **What**
  - 对玄武提交的 fenxue memorySearch 悬空态说明完成审计，确认其判断方向成立，并收口为“关闭默认 memorySearch 残留”的后续动作建议。
- **How to verify**
  - 检查文档是否明确：1）当前问题不是 memos 回流；2）当前问题是 `enabled but not ready`；3）建议优先关闭默认 memorySearch；4）要求补 doctor before/after 复验记录。
- **Known Issues**
  - 当前仍未执行 fenxue memorySearch 关闭动作；也尚无关闭后的 doctor 复验结果。
- **Next Steps**
  - 若进入执行阶段，应先关闭 fenxue 默认 memorySearch，再复跑 doctor，并补一份 before/after 结果记录。
