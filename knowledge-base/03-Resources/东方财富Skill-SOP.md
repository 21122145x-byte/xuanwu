# 东方财富 Skill 使用 SOP

## 1. Skill 清单

| Skill | 用途 | 命令模板 |
|-------|------|----------|
| `mx_search` | 搜索财经新闻/资讯 | `~/.openclaw/skills/mx_search/mx_search "关键词"` |
| `mx_data` | 查询个股数据 | `~/.openclaw/skills/mx_data/mx_data 股票代码` |
| `mx_select_stock` | 条件选股 | `~/.openclaw/skills/mx_select_stock/mx_select_stock "条件"` |
| `mx_selfselect` | 自选股管理 | `~/.openclaw/skills/mx_selfselect/mx_selfselect list` |
| `mx_stock_simulator` | 模拟交易 | ⚠️ 占位实现，暂不可用 |

## 2. 常用示例

```bash
# 搜索新闻
~/.openclaw/skills/mx_search/mx_search "上证指数"

# 查询个股
~/.openclaw/skills/mx_data/mx_data 000001

# 选股
~/.openclaw/skills/mx_select_stock/mx_select_stock "涨停股票"
~/.openclaw/skills/mx_select_stock/mx_select_stock "主力资金净流入超1亿"

# 自选股
~/.openclaw/skills/mx_selfselect/mx_selfselect list
```

## 3. 关键原则

- **使用完整路径**：`~/.openclaw/skills/Skill名/Skill名`
- **不配置 PATH**：避免复杂度，直接调用
- **先验证再使用**：不确定时先用 `000001` 测试

## 4. 问题复盘（2026-03-20）

### 错误路径
1. 试图用短命令 `mx_data` → 未找到
2. 尝试配置 PATH → `source ~/.zshrc` 后仍无效
3. 想创建 wrapper 脚本 → 过度复杂化

### 根本原因
- Skill 文件在子文件夹中（`mx_data/mx_data`），不在 PATH 根目录
- 把简单问题复杂化，忽略了最直接的使用方式

### 正确做法
直接使用完整路径调用，不折腾 PATH 配置。

---
*创建时间：2026-03-20*
