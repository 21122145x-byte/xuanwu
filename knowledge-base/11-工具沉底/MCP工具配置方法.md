# MCP 工具配置方法

> 更新时间：2026-03-25

---

## 背景

OpenClaw 通过 mcporter 管理 MCP（Model Context Protocol）工具服务器。配置方法记录于此。

---

## 查看当前 MCP 工具

```bash
mcporter list
```

输出示例：
```
mcporter 0.7.3 — Listing 3 server(s)
- xiaohongshu (offline)
- minimax (2 tools, 428ms) ✅ online
- exa (3 tools, 2.5s) ✅ online
```

---

## 添加新的 MCP 工具

### 1. 找到工具的添加命令

参考 `mcporter config add --help`，常用方式：

```bash
# HTTP MCP 服务器
mcporter config add <name> --url <https://host/mcp>

# STDIO MCP 服务器（常用）
mcporter config add <name> --command <binary> --arg <args> --env KEY=value
```

### 2. 添加 MiniMax MCP 示例

```bash
mcporter config add minimax \
  --command uvx \
  --arg minimax-coding-plan-mcp \
  --env MINIMAX_API_KEY="你的API_KEY" \
  --env MINIMAX_API_HOST="https://api.minimaxi.com" \
  --description "MiniMax coding plan MCP"
```

### 3. 验证工具是否可用

```bash
mcporter list
# 确认状态为 online
```

### 4. 查看工具列表和参数

```bash
mcporter list <name> --schema
```

---

## 调用 MCP 工具

```bash
mcporter call <server>.<tool> key=value
```

示例：
```bash
mcporter call minimax.web_search query="hello"
mcporter call exa.web_search_exa query="search term" numResults=5
mcporter call exa.crawling_exa urls=["https://example.com"]
```

---

## 常见问题

### 1. mcpServers 配置无效

OpenClaw 配置文件中 `mcpServers` key 不被识别（`Unrecognized key: "mcpServers"`）。正确做法是通过 mcporter 管理。

### 2. STDIO 工具需要环境变量

通过 `--env KEY=value` 传递，mcporter 会自动注入。

### 3. API Key 配置位置

当前 mcporter 配置在：
```
~/.openclaw/workspace-fenxue/config/mcporter.json
```

---

## 当前可用 MCP 工具（2026-03-25）

| 工具 | 状态 | 工具数 | 工具 |
|------|------|--------|------|
| exa | ✅ online | 3 | web_search_exa, crawling_exa, get_code_context_exa |
| minimax | ✅ online | 2 | web_search, understand_image |
| xiaohongshu | ❌ offline | - | - |

---

## 参考文档

- mcporter: http://mcporter.dev
- MiniMax Token Plan MCP: https://platform.minimaxi.com/docs/token-plan-mcp
