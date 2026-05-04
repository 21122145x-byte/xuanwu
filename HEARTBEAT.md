# OpenClaw Workspace 夜间静默整理任务

目标：在夜间静默时段，使用本机 Ollama 小模型对 `/Users/xiaojingbo/.openclaw/workspace/` 做低风险整理与提炼，优先产出摘要、索引、归类建议，不做大规模自动搬移。

原则：
- 只在工作区内操作
- 默认先读、汇总、写摘要，再考虑小范围结构化整理
- 避免触碰 `.git/`、`.obsidian/`、大型第三方 `tools/` 代码树本体
- 优先处理 markdown / note / wiki / governance 文档
- 若无明确把握，不做 destructive 操作

今晚优先检查：
1. `shaun-wiki/`
   - 提炼主题簇、入口页、重复页、候选正式页
   - 产出一份新的夜间整理摘要
2. `knowledge-base/`
   - 提炼项目区、治理区、检查区的高频主题
   - 标记可能的重复说明文档与可归档对象
3. `main/` 与 `codex/` 下的 memory/dreaming
   - 只做目录级摘要，不深度改写原始记忆
4. `skills/`
   - 盘点有哪些本地 skill / 治理文档
5. 根目录
   - 识别噪音、运行态文件、长期保留文件

输出偏好：
- 优先写入新的 markdown 摘要文件
- 记录“可整理建议”与“暂不动原因”
- 如果要落地结构调整，先形成小批次计划
