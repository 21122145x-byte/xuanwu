# 富贵方舟 - 数据采集 SOP

## 一、采集工具

| 工具 | 路径 | 用途 |
|------|------|------|
| **mx_data** | `~/.openclaw/skills/mx_data/mx_data` | 指数/个股实时行情、基本面数据 |
| **mx_select_stock** | `~/.openclaw/skills/mx_select_stock/mx_select_stock` | 条件选股、涨停/跌停统计 |
| **mx_search** | `~/.openclaw/skills/mx_search/mx_search` | 新闻/公告/政策搜索 |

---

## 二、每日收盘数据采集流程

### 步骤1：大盘指数（必须）

```bash
# 上证指数
~/.openclaw/skills/mx_data/mx_data "上证指数"

# 深证成指
~/.openclaw/skills/mx_data/mx_data "深证成指"

# 创业板指
~/.openclaw/skills/mx_data/mx_data "创业板指"
```

**提取字段：**
- `f2`：最新价（收盘点位）
- `f3`：涨跌幅
- `f6`：成交额
- `f5`：成交量
- `f17`：开盘价
- `f15`：最高价
- `f16`：最低价

---

### 步骤2：涨跌家数（必须）

```bash
# 涨停股票
~/.openclaw/skills/mx_select_stock/mx_select_stock "今日涨停股票"

# 跌停股票
~/.openclaw/skills/mx_select_stock/mx_select_stock "今日跌停股票"
```

**提取字段：**
- `securityCount`：涨停/跌停家数
- 列表中的股票代码和名称

---

### 步骤3：个股数据（富贵方舟股票池）

```bash
# 股票池：600867 通化东宝、600166 福田汽车、601106 中国一重、000009 中国宝安

~/.openclaw/skills/mx_data/mx_data 600867
~/.openclaw/skills/mx_data/mx_data 600166
~/.openclaw/skills/mx_data/mx_data 601106
~/.openclaw/skills/mx_data/mx_data 000009
```

**提取字段：**
- 最新价、涨跌幅、成交额
- 公司基本信息（行业、主营业务）

---

### 步骤4：新闻/公告搜索（可选）

```bash
# 搜索股票相关新闻
~/.openclaw/skills/mx_search/mx_search "通化东宝 公告"
~/.openclaw/skills/mx_search/mx_search "福田汽车 新闻"
```

---

## 三、数据验证规则

| 检查项 | 标准 | 失败处理 |
|--------|------|----------|
| 数据时间戳 | 必须是当日 | 标注"数据时间异常" |
| 涨跌幅范围 | -20% ~ +20%（主板±10%，创业板±20%） | 人工复核 |
| 成交额 | > 0 | 重新查询 |
| 涨停家数 | 0 ~ 5000 | 人工复核 |

---

## 四、文件落盘规范

### 文件命名
```
富贵方舟_日报_YYYY-MM-DD.md
富贵方舟_个股分析_股票代码_YYYY-MM-DD.md
```

### 存储路径
```
knowledge-base/01-Projects/富贵方舟/
├── 03-日报/           # 每日收盘总结
├── 04-个股分析/       # 个股深度分析
└── 05-原始数据/       # 原始采集数据（JSON）
```

### 文件头模板
```markdown
---
date: YYYY-MM-DD
data_source: 东方财富Skill
collection_time: HH:MM:SS
verified: true/false
---

# 富贵方舟日报 | YYYY-MM-DD

## 大盘概况
| 指数 | 收盘 | 涨跌 | 成交额 |
|------|------|------|--------|

## 股票池表现
| 代码 | 名称 | 收盘 | 涨跌 | 与大盘对比 |
|------|------|------|------|------------|

## 异动提醒
- 

## 明日关注
- 
```

---

## 五、频率限制规避

| 限制类型 | 说明 | 规避方法 |
|----------|------|----------|
| 操作过于频繁 | 503错误 | 单次查询间隔 > 5秒 |
| 数据返回不完整 | JSON解析失败 | 重试3次，间隔10秒 |

---

## 六、交接标准 [HANDOFF]

```markdown
**[HANDOFF]**

| 字段 | 内容 |
|------|------|
| **📍 Where** | 文件绝对路径 |
| **🎯 What** | 已采集的数据摘要 |
| **🔍 How to verify** | 核验要点 |
| **⚠️ Known Issues** | 数据缺失/异常说明 |
| **➡️ Next Steps** | 下一步动作 |
```

---

## 七、今日测试记录

**日期：** 2026-03-23
**测试人：** 富贵
**结果：**
- ✅ mx_data 指数查询正常
- ✅ mx_select_stock 涨停查询正常（38只涨停）
- ✅ 数据时间戳准确（16:01收盘后）
- ⚠️ 个股查询有频率限制，需间隔调用

**采集数据样本：**
- 上证指数：3813.28 / -3.63% / 成交额1.086万亿
- 涨停家数：38只

---

*SOP版本：v1.0*
*创建时间：2026-03-23*
*适用项目：富贵方舟*
