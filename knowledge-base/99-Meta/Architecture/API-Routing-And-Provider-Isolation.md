# API 路由与 Provider 隔离规范

**更新时间**: 2026-03-18
**起草人**: Anna
**背景**: 基于 2026-03-18 的大模型 404/400 连环宕机事故复盘（“粉雪断线事件”）。

## 核心原则 (Core Principle)

**禁止前台交互模型与后台结构化任务共用同一套存有歧义的 Provider 网关。**
**必须实施“分而治之 (Provider Isolation)”的配置隔离策略。**

## 问题溯源 (The Problem)
在 OpenClaw 系统中，不同的任务层级对 API 适配器 (Adapter) 和参数有着截然不同的预期：
- **前台聊天 (Agent 交互)**: 侧重于灵活、流式输出、厂商原生兼容性（如 `anthropic-messages`）。
- **后台任务 (MemOS Summarizer/Filter)**: 强依赖绝对的 `openai-responses` 协议，且由于任务的严谨性，后台代码会**硬性注入 `temperature=0`**。

当这两者混用同一个大网关（如单一的 `minimax-cn`）时：
1. **参数冲突**: 某些官方 API（如 Kimi、MiniMax 的旧端点）拒收绝对的 `temperature=0`，直接拦截报错 (`400 Invalid Temperature`)。
2. **路由拼接冲突**: `openai-responses` 会自动在 BaseURL 后强行拼接 `/chat/completions` 或 `/v1/chat/completions`，而 `anthropic-messages` 会拼接 `/messages`。共用 BaseURL 会导致拼接出 `v1/v1/` 或 `anthropic/chat/completions` 的畸形地址，触发 `404 Nginx Error`，导致整个运行时崩溃。

## 标准解决方案：双轨制隔离 (Dual-Track Isolation)

在 `openclaw.json` 中，针对同一家厂商（如 MiniMax），必须在 `models.providers` 下拆分为两个独立的节点：

### 1. 前台通道 (Frontend / Chat)
- **命名规范**: `{vendor}-frontend` (例: `minimax-frontend` 或保留原名 `minimax-cn`)
- **协议要求**: 使用厂商最原生、最适应流式的协议（如 `anthropic-messages`）。
- **BaseURL**: 指向原生协议对应的标准路由（如 `https://api.minimaxi.com/anthropic`）。
- **用途**: 仅在 `agents.list` 的 `model` 字段中绑定给负责发声和生成的 Agent（如粉雪、旺财）。

### 2. 后台通道 (Backend / System)
- **命名规范**: `{vendor}-backend` (例: `minimax-backend`)
- **协议要求**: **必须且只能**使用标准的 `openai-responses` 协议。
- **BaseURL**: 必须指向最纯净、且**允许 `temperature=0` 通行**的 OpenAI 兼容大平层地址（如 `https://api.minimax.chat/v1`）。
- **用途**: 仅在 `agents.defaults.model.primary` 中全局绑定，专供 MemOS 记忆提炼、过滤去重等后台静默任务使用。

## 审计红线
Anna 在进行系统体检时，一旦发现 `agents.defaults.model.primary` 使用的 Provider 包含了 `anthropic` 或非标 API 配置，将强制阻断并要求执行“双轨制隔离”。