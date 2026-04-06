[HANDOFF]
📍 Where: /Users/xiaojingbo/.openclaw/workspace/knowledge-base/01-Constitution/workspace根目录清理规则_v1_2026-04-06.md
🎯 What: 将团队各 agent workspace 根目录应保持轻量、清晰、可维护的要求，压成一张正式规则卡，明确哪些文件可留在根目录、哪些应移走、哪些目录属于正式承载层，以及后续周期性清理的执行口径。
🔍 How to verify: 检查文档是否明确包含：1）workspace 根目录允许保留项；2）禁止长期堆放项；3）推荐迁移去向；4）清理优先级；5）与知识库、项目目录、临时区的边界关系。
⚠️ Known Issues: 当前为 v1 规则卡，尚未等同于各 workspace 已完成清理迁移；不同 agent 的历史残留与项目结构差异仍需后续逐个收口。
➡️ Next Steps: 以本规则卡为依据，后续逐步清理各 agent workspace 根目录，将非必要文件迁离根目录，并把该规则纳入 wiki-maintenance / periodic-maintenance profile 的结构治理前提。

# workspace 根目录清理规则 v1

- 日期：2026-04-06
- 状态：v1 / 规则卡
- 适用范围：团队全体 Agent workspace
- 上位关系：挂载于《团队协作宪法与治理总纲 v1》的知识治理条目之下

---

## 一、规则目标

workspace 根目录不是杂物堆放层，而是：
- 运行入口层
- 结构识别层
- 周期维护的第一观察面

因此默认要求：

> **workspace 根目录只保留必要文件与必要一级目录；非必要文件、散文件、历史残留、临时产物不得长期停留在根目录。**

---

## 二、根目录允许保留的内容

## 1. 必要规则文件
允许保留：
- `AGENTS.md`
- `SOUL.md`
- `USER.md`
- `TOOLS.md`
- `MEMORY.md`
- `HEARTBEAT.md`
- `BOOTSTRAP.md`
- `IDENTITY.md`
- 其他被运行时明确依赖的根级规则文件

## 2. 必要系统目录
允许保留：
- `memory/`
- `skills/`
- `knowledge_base/`（agent 本地正式知识库根）
- 运行所必需的少量标准目录

## 3. 已明确承担一级结构角色的目录
只有在职责明确时才允许根级保留，例如：
- `projects/`
- `outputs/`
- `deliverables/`
- `workspace/`
- `config/`

前提是：
- 这些目录有稳定角色
- 不与知识库根混淆
- 不沦为临时堆放层

---

## 三、默认不应长期停留在根目录的内容

以下内容默认不应长期停留在 workspace 根目录：
- 零散 `.md` 文件
- 临时实验文件
- 单次产物
- 待整理资料
- 误放的报告文件
- 误放的项目过程文件
- 重复副本
- 系统残留（如 `.DS_Store`）
- 无明确归属的中间文件

一句话：

> **根目录不做“以后再整理”的缓冲区。**

---

## 四、推荐迁移去向

## 1. 可复用知识
迁入：
- `knowledge_base/`

## 2. 正式项目产物
迁入：
- `projects/` 或明确项目目录
- `deliverables/` 或明确交付目录

## 3. 临时文件 / 中间产物
迁入：
- `tmp/`
- `outputs/`
- 或其他已定义临时承载目录

## 4. 报告类文档
迁入：
- `knowledge_base/` 对应报告层
- 或明确的 `reports/` / `50-REPORTS/`

## 5. 模板类文档
迁入：
- `templates/`
- `knowledge_base/02-Templates/`
- 或明确模板层

---

## 五、清理优先级

### P1：高优先清理
- 根目录散落的无归属 `.md`
- 系统残留文件
- 已明确应进入知识库但仍停在根目录的文件
- 已明确应进入项目目录但仍停在根目录的文件

### P2：中优先清理
- 临时实验文件
- 重复副本
- 历史遗留但已无一级结构意义的目录

### P3：低优先清理
- 已有明确角色、但命名略粗糙的目录
- 需要与 agent 自身工作流一起调整的目录

---

## 六、执行口径

后续默认采用以下规则：
1. workspace 根目录只保留必要文件与必要一级目录
2. 根目录出现散文件时，优先判断其正式归属，不允许长期挂在根目录
3. 可复用知识优先回沉 `knowledge_base/`
4. 正式项目文件进入项目目录
5. 临时文件进入临时承载目录
6. 根目录清理优先在 observe / suggest 下确认，再进入 maintain
7. 若 owner 已授权常规自治维护，则知识库内移动与根目录清理可纳入 routine maintenance，但删除动作仍不默认放开

---

## 七、与团队知识治理的关系

此规则与《团队知识库根命名与项目边界统一建议卡》共同构成团队知识治理的结构前提：
- 一个解决“知识库根叫什么、项目文件放哪里”
- 一个解决“workspace 根目录该不该堆东西”

若这两条不先立住，则后续：
- wiki-maintenance
- periodic-maintenance profile
- heartbeat
- weekly maintenance report

都容易建立在噪音结构之上。

---

## 八、一句话收口

> workspace 根目录应保持轻量、清晰、可识别；除必要文件与必要一级目录外，其余内容都应迁离根目录，不得把根目录当作长期杂物层。
