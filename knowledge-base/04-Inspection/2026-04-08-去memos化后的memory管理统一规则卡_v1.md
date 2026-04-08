# 去 memos 化后的 memory 管理统一规则卡 v1

- 日期：2026-04-08
- 主责：Anna
- 性质：团队统一规则卡
- 适用范围：Anna / Curie / 富贵 / 玄武 / 旺财 / 粉雪 / main 及后续新增 Agent

## 文档挂载
- 上位文档：/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-08-移除memos与记忆技能本地化迁移方案-v2.md；/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-08-去memos化-切换窗口执行卡-v2.md
- 同级关联：/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-08-去memos化方案与实际改动清单_交接文档-v1.md；/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-08-Anna-孤儿文档问题收口与挂载规则_v1.md
- 下位文档：待补：各 Agent memory 使用检查表；待补：before/after 验收记录模板；待补：团队 memory 巡检清单
- 所属主线：MemOS 去默认化 / 团队 memory 管理统一口径

---

## 一、当前统一判断

MemOS 已从默认运行链退场后，团队 memory 管理必须统一改口为：

> **文件记忆为主，显式检索为辅，正式知识独立落 KB。**

也就是说，后续不再允许把 memory 管理建立在：
- 默认 auto-recall
- 默认 prependContext 注入
- 插件隐式返注上下文
- “系统自己会记住” 这种模糊预期

上。

---

## 二、团队统一总原则

### 原则 1：记忆改为显式管理
后续所有 Agent 的 memory，都按：
- 显式读
- 显式写
- 显式检索
- 显式归档

不再按：
- 隐式注入
- 背景 recall
- 默认返注

### 原则 2：三层分开，不混写
每个 Agent 后续统一分三层：

#### A. 长期记忆层
- 文件：`workspace-xxx/MEMORY.md`
- 用途：长期有效的规则、偏好、职责边界、长期红线

#### B. 当日推进层
- 文件：`workspace-xxx/memory/YYYY-MM-DD.md`
- 用途：当天推进、承诺、阻塞、临时决策、未闭环事项

#### C. 正式知识层
- 文件：`workspace-xxx/knowledge_base/` 或团队 `workspace/knowledge-base/`
- 用途：审计、RCA、执行卡、SOP、规则、项目主文、交接文档

### 原则 3：正式知识不写进 memory
以下内容不得只停留在 `MEMORY.md` 或 daily memory：
- 审计意见
- RCA
- 执行卡
- 正式规则
- SOP
- 项目主文
- 跨 Agent 交接文档

这些必须进入正式 KB。

### 原则 4：需要回忆时，优先显式检索
统一顺序：
1. 读启动文件
2. 查正式 KB
3. 再按需手动检索 memory 工具

而不是一上来依赖系统默认注入。

---

## 三、每个 Agent 的标准 memory 结构

每个 Agent 后续至少应具备：

### 1. 长期记忆文件
- `MEMORY.md`

### 2. daily memory 目录
- `memory/YYYY-MM-DD.md`

### 3. 正式知识目录
- `knowledge_base/`

如果当前缺失 daily memory 目录，应补建；
如果当前把正式知识散落在聊天或临时文件中，应逐步回挂到 KB。

---

## 四、每个 Agent 的默认工作流

### 启动时
默认读取：
1. `SOUL.md`
2. `USER.md`
3. `MEMORY.md`
4. 今天 / 昨天的 `memory/YYYY-MM-DD.md`

### 工作中
- 临时推进、阻塞、承诺 → 写入 daily memory
- 正式结论、规则、交接 → 落入 knowledge_base

### 需要回查时
按顺序：
1. 先读 KB
2. 再手动用 memory 工具检索
3. 不依赖默认 recall 注入

### 收尾时
当天至少补一轮 daily memory：
- 今天做了什么
- 还有什么没闭环
- 明天接什么
- 哪些结论值得上提为长期记忆或正式知识

---

## 五、团队级与个人级的分工边界

### 团队 KB：`workspace/knowledge-base/`
负责：
- 团队共享规则
- 团队协同接口
- 跨 Agent 主线文档
- 团队级审计意见
- 公共 SOP / 规则 / 主线入口

### 个人 KB：`workspace-xxx/knowledge_base/`
负责：
- 各 Agent 自己的项目主文
- 个人方法沉淀
- 个人研究结论
- 个人长期维护知识资产

### 统一原则
> **团队 KB 写共享接口与公共规则；个人 KB 写个人主任务与个人正式知识。**

不得反过来混用。

---

## 六、各角色的最低动作要求

### 每个 Agent 每天至少做 4 件事
1. 启动时读长期记忆 + 当日记忆
2. 工作中把推进与阻塞写进 daily memory
3. 把正式结论落入 KB
4. 收尾时补一轮 daily memory

### 额外上提规则
当某条结论满足以下任一条件时，应从 daily memory 上提：
- 长期有效
- 反复复用
- 属于红线 / 规则 / SOP
- 会影响后续多次判断

上提位置：
- `MEMORY.md`
或
- `knowledge_base/` 正式文档

---

## 七、后续允许使用的 memory / 检索方式

### 允许
- `MEMORY.md`
- `memory/YYYY-MM-DD.md`
- `knowledge_base/`
- 显式 memory 工具（如 `memory_search` / `memory_get` / `memory_timeline`）
- 显式共享（如正式交接、公共 memory 写入）

### 不允许作为默认机制
- auto-recall
- 默认 prependContext
- 插件式隐式背景返注
- “先不写，反正系统会记住”

---

## 八、当前禁止事项

### 禁止 1：把正式结论只留在聊天里
这是 memory 污染和知识丢失的根源之一。

### 禁止 2：把 daily memory 当正式主文用
daily memory 只承接推进，不承接正式主结论。

### 禁止 3：把 KB 写成聊天流水账
KB 是正式知识层，不是闲聊备忘录。

### 禁止 4：因为检索麻烦就恢复默认自动注入
这会直接把去 memos 化边界打穿。

### 禁止 5：把“保留研究材料”误写成“恢复默认运行位”
任何历史 memory 组件若保留，只能是研究/对照/改造材料。

---

## 九、团队巡检重点

后续检查每个 Agent 的 memory 管理是否合格，主要看这 6 条：
1. 是否有 `MEMORY.md`
2. 是否有 daily memory 目录与当日记录
3. 是否把正式结论落进 KB
4. 是否仍在依赖隐式 recall
5. 是否存在“聊天里有结论、KB 没落文”的断层
6. 是否把团队 KB 与个人 KB 混用

---

## 十、一句话收口

> **去 memos 化后的统一口径是：长期规则写 `MEMORY.md`，当天推进写 `memory/YYYY-MM-DD.md`，正式结论写 `knowledge_base/`，需要回忆时手动检索；团队不再依赖任何默认自动注入记忆层。**

---

## 十一、5 字段 handoff

- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-08-去memos化后的memory管理统一规则卡_v1.md`
- **What**
  - 为团队落一版 MemOS 退场后的统一 memory 管理规则，明确长期记忆、当日推进、正式知识三层分工，以及团队 KB / 个人 KB 的边界。
- **How to verify**
  - 检查文档是否明确：1）三层 memory 结构；2）默认工作流；3）团队 KB 与个人 KB 分工；4）禁止事项与巡检重点。
- **Known Issues**
  - 当前这是统一规则卡，还未逐个 Agent 检查是否完全达标；部分 Agent 可能仍缺 daily memory 目录或正式回挂动作。
- **Next Steps**
  - 基于本卡继续补：各 Agent memory 使用检查表、团队 memory 巡检清单、切换后 before/after 验收记录模板。
