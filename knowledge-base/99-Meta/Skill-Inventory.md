# OpenClaw Skill 清单

*最后更新: 2026-03-11*

---

## 📁 系统 Skills (16个)

位置: `~/.openclaw/skills/`

### 平台接入
| Skill | 描述 | 状态 |
|-------|------|------|
| **agent-reach** | 平台接入工具 (Twitter/X, Reddit, YouTube, GitHub, 小红书, 抖音等) | ✅ |
| **feishu** | 飞书集成 (文档、云盘、Wiki、多维表格) | ✅ |
| **qqbot** | QQ 机器人 | ⚠️ |

### 内容创作
| Skill | 描述 | 状态 |
|-------|------|------|
| **jimeng-image-generation** | 即梦 AI 图片生成 | ✅ |
| **elevenlabs** | TTS 语音合成 | ✅ |
| **faster-whisper** | 本地语音识别转文字 | ✅ |
| **feishu-voice-transcription** | 飞书语音消息自动转录 | ✅ |
| **toonflow** | 动画/漫画生成 | ✅ |
| **pixel-office** | 像素办公室看板 | ✅ |

### 数据处理
| Skill | 描述 | 状态 |
|-------|------|------|
| **csv-analyzer** | CSV/Excel 数据分析 | ✅ |
| **search** | 综合搜索工具包 | ✅ |
| **apple-music** | Apple Music 控制 | ✅ |
| **clickup** | ClickUp 项目管理 | ✅ |

### 编程与工具
| Skill | 描述 | 状态 |
|-------|------|------|
| **minimax-coding** | MiniMax 编程助手 | ✅ |
| **news-lite** | 新闻推送 (Hacker News) | ✅ |
| **official__openclaw-cn-toolkit** | OpenClaw-cn 社区工具包 | ✅ |

---

## 📁 工作区 Skills (14个)

位置: `~/.openclaw/workspace-fugui/.agents/skills/`

### 🏗️ 核心系统 (今日新建)

| Skill | 版本 | 描述 | 功能 |
|-------|------|------|------|
| **skill-vetter** | 1.0.0 | Skill 安全审计 | 检查安全漏洞、结构合规性 |
| **memory-architect** | 1.0.0 | 记忆架构师 | 5层记忆系统 (Flush/Sync/Compound) |
| **memory-guardian** | 1.0.0 | 记忆守护者 | 记忆文件维护、健康检查 |
| **daily-digest** | 1.0.0 | 日报系统 | 晨间/晚间日报自动生成 |
| **knowledge-bridge** | 1.0.0 | 知识库桥接 | OpenClaw ↔ Obsidian/Notion 同步 |
| **knowledge-base-optimizer** | 1.0.0 | 知识库优化 | 数据质量、检索优化、RAG |
| **self-evolver** | 1.0.0 | 自我进化 | 失败分析、自动优化、策略进化 |
| **openclaw-organizer** | 1.0.0 | 目录整理 | .openclaw 目录结构维护 |
| **search-router** | 1.0.0 | 搜索路由 | 智能选择最佳搜索方案 |

### 🎭 内容创作

| Skill | 描述 | 功能 |
|-------|------|------|
| **characteristic-voice** | 特色语音 | 情感化、人格化语音合成 |
| **chat-with-anyone** | 与任何人聊天 | 模拟特定人物对话风格 |
| **daily-news-caster** | 每日新闻播报 | 新闻→播客脚本→语音 |
| **video-translation** | 视频翻译配音 | 视频翻译+TTS配音 |

### 🛠️ 开发工具

| Skill | 描述 | 功能 |
|-------|------|------|
| **template-skill** | Skill 模板 | 创建新 Skill 的模板 |

---

## 📊 Skill 统计

| 类别 | 数量 | 占比 |
|------|------|------|
| 系统 Skills | 16 | 53% |
| 工作区 Skills | 14 | 47% |
| **总计** | **30** | 100% |

### 按功能分类

| 功能类别 | Skills | 数量 |
|----------|--------|------|
| **系统核心** | skill-vetter, memory-architect, memory-guardian, self-evolver | 4 |
| **知识管理** | knowledge-bridge, knowledge-base-optimizer, search, search-router | 4 |
| **日报/推送** | daily-digest, daily-news-caster, news-lite | 3 |
| **内容创作** | characteristic-voice, chat-with-anyone, video-translation, jimeng, elevenlabs | 5 |
| **平台接入** | agent-reach, feishu, qqbot | 3 |
| **数据处理** | csv-analyzer, faster-whisper | 2 |
| **开发工具** | template-skill, openclaw-organizer | 2 |
| **其他** | apple-music, clickup, pixel-office, toonflow, minimax-coding, official-toolkit | 7 |

---

## 🎯 今日新建 Skills (9个)

1. ✅ **skill-vetter** - Skill 安全审计
2. ✅ **memory-architect** - 5层记忆架构
3. ✅ **memory-guardian** - 记忆维护
4. ✅ **daily-digest** - 日报系统
5. ✅ **knowledge-bridge** - 知识库同步
6. ✅ **knowledge-base-optimizer** - 知识库优化
7. ✅ **self-evolver** - 自我进化
8. ✅ **openclaw-organizer** - 目录整理
9. ✅ **search-router** - 搜索路由

---

## 🚀 核心能力矩阵

```
┌─────────────────────────────────────────────────────────┐
│                    核心能力架构                          │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  🧠 记忆层                    📚 知识层                  │
│  ├── memory-architect         ├── knowledge-bridge       │
│  ├── memory-guardian          ├── knowledge-base-optimizer│
│  └── daily-digest             └── search-router          │
│                                                          │
│  🔍 检索层                    🛡️ 安全层                  │
│  ├── search                   ├── skill-vetter           │
│  ├── search-router            └── (安全审计)             │
│  └── kb-retrieval                                        │
│                                                          │
│  🔄 进化层                    🛠️ 工具层                  │
│  ├── self-evolver             ├── openclaw-organizer     │
│  └── (自动优化)               └── template-skill         │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

---

## 📋 使用建议

### 日常使用
- **记忆管理** → memory-architect / memory-guardian
- **知识查询** → knowledge-bridge + search-router
- **日报生成** → daily-digest
- **安全审计** → skill-vetter

### 开发新 Skill
- **模板** → template-skill
- **审计** → skill-vetter
- **整理** → openclaw-organizer

### 内容创作
- **语音** → characteristic-voice / elevenlabs
- **搜索** → search-router (粉雪) / search
- **视频** → video-translation

---

*本清单自动维护，更新时请同步修改*
