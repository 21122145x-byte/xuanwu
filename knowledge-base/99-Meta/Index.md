# Knowledge Base Index

## 目录结构

```
knowledge-base/
├── 00-Inbox/           # 收件箱（待整理）
├── 01-Projects/        # 项目知识
│   ├── Active/         # 进行中项目
│   └── Archive/        # 已归档项目
├── 02-Areas/           # 领域知识
│   ├── Technology/     # 技术领域
│   ├── Business/       # 业务领域
│   └── Process/        # 流程规范
├── 03-Resources/       # 参考资料
│   ├── Articles/       # 文章收藏
│   ├── Books/          # 读书笔记
│   └── Tools/          # 工具资源
├── 04-Archive/         # 归档内容
├── 30-evergreen/       # 永久笔记
│   └── 一个想法一个文件
└── 99-Meta/            # 元数据
    └── Templates/      # 笔记模板
```

## 快速导航

### 活跃项目
- [[01-Projects/Active/OpenClaw-System]]
- [[01-Projects/Active/Daily-2026-03-11]]

### 常用领域
- [[02-Areas/Technology/Agent-Architecture]]
- [[02-Areas/Process/Workflow]]

### 永久笔记
- [[30-evergreen/README]]

### 最近更新
- [[03-Resources/Articles/KB-Comparison-Analysis]]

## 标签系统

### 项目标签
- #project-active
- #project-archive

### 优先级标签
- #priority-high
- #priority-medium
- #priority-low

### 状态标签
- #status-active
- #status-archived
- #status-draft
- #status-evergreen

## 使用规范

1. **新笔记**：先放入 00-Inbox，整理后归类
2. **命名**：使用英文，空格用连字符替代
3. **元数据**：使用模板，填写完整信息
4. **链接**：使用双括号 `[[文件名]]` 建立关联
5. **定期整理**：每周 review Inbox 和 Archive

## 检索技巧

- 按目录：使用路径前缀 `01-Projects/Active/`
- 按标签：使用标签搜索 `#priority-high`
- 按日期：使用日期范围 `2026-03-01..2026-03-11`
- 按内容：使用关键词搜索

## AI 规则

- **.openclaw/CLAUDE.md** - AI 助手行为规则
- **.openclaw/rules/** - 详细规则定义
- **.openclaw/skills/** - 技能定义

---

*最后更新: 2026-03-11*
