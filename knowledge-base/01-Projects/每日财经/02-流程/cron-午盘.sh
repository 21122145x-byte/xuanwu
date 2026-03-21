#!/bin/bash
# 每日财经 - 午间快讯 Cron 任务
# 触发时间：12:05（上午收盘后，预留数据稳定时间）
# 任务：采集上午数据，生成午间快讯初稿
# 版本：v2.0 - 添加周末判断、修正查询词

set -e

# 周末判断（周六=6，周日=0）
WEEKDAY=$(date '+%w')
if [ "$WEEKDAY" -eq 0 ] || [ "$WEEKDAY" -eq 6 ]; then
    echo "=== 每日财经 - 午间快讯 ==="
    echo "时间: $(date '+%Y-%m-%d %H:%M')"
    echo "状态: ❌ 跳过 - 今日周末，A股休市"
    echo "任务: 周六运行《每周回顾》，周日运行《每周展望》"
    exit 0
fi

echo "=== 每日财经 - 午间快讯 ==="
echo "时间: $(date '+%Y-%m-%d %H:%M')"

# Skill 绝对路径
MX_SEARCH="/Users/xiaojingbo/.openclaw/skills/mx_search/mx_search"
MX_DATA="/Users/xiaojingbo/.openclaw/skills/mx_data/mx_data"
MX_SELECT="/Users/xiaojingbo/.openclaw/skills/mx_select_stock/mx_select_stock"

DATE=$(date '+%Y-%m-%d')
OUTPUT_DIR="/Users/xiaojingbo/.openclaw/workspace-fugui/knowledge-base/01-Projects/每日财经/03-样例"

echo "[1/5] 采集大盘数据..."
$MX_DATA "上证指数涨跌幅" > "$OUTPUT_DIR/.tmp_午盘_大盘_$DATE.json" 2>&1
$MX_DATA "深成指涨跌幅" >> "$OUTPUT_DIR/.tmp_午盘_大盘_$DATE.json" 2>&1
$MX_DATA "创业板指涨跌幅" >> "$OUTPUT_DIR/.tmp_午盘_大盘_$DATE.json" 2>&1
$MX_DATA "沪深两市上午成交额" >> "$OUTPUT_DIR/.tmp_午盘_大盘_$DATE.json" 2>&1

echo "[2/5] 采集涨幅异常个股（涨停统计）..."
$MX_SELECT "今日涨幅大于10%的股票" > "$OUTPUT_DIR/.tmp_午盘_涨停_$DATE.json" 2>&1

echo "[3/5] 采集板块数据..."
$MX_SELECT "今日涨幅最大的板块" 1 5 > "$OUTPUT_DIR/.tmp_午盘_板块_$DATE.json" 2>&1
$MX_SELECT "今日跌幅最大的板块" 1 5 >> "$OUTPUT_DIR/.tmp_午盘_板块_$DATE.json" 2>&1

echo "[4/5] 采集主力资金..."
$MX_SELECT "今日主力资金净流入最多的股票" 1 5 > "$OUTPUT_DIR/.tmp_午盘_资金_$DATE.json" 2>&1

echo "[5/5] 采集上午新闻..."
$MX_SEARCH "今日上午A股重要新闻" > "$OUTPUT_DIR/.tmp_午盘_新闻_$DATE.json" 2>&1

echo "数据采集完成！"

# 生成午间快讯初稿
cat > "$OUTPUT_DIR/每日财经_午间_$DATE.md" << EOF
# 《每日财经》午间快讯 | $DATE

> 数据来源：东方财富妙想 Skill | 采集时间：$(date '+%H:%M')
> 状态：初稿待核验

---

## 上午大盘表现

| 指数 | 涨跌幅 | 状态 |
|------|--------|------|
| 上证指数 | 待提取 | 待分析 |
| 深成指 | 待提取 | 待分析 |
| 创业板指 | 待提取 | 待分析 |

**上午成交额**：待提取

---

## 上午异动板块

### 涨幅前5
数据已采集，详见：.tmp_午盘_板块_$DATE.json

### 跌幅前5
数据已采集，详见：.tmp_午盘_板块_$DATE.json

---

## 上午涨幅异常个股

数据已采集，详见：.tmp_午盘_涨停_$DATE.json

---

## 主力资金动向

数据已采集，详见：.tmp_午盘_资金_$DATE.json

---

## 上午重要新闻

数据已采集，详见：.tmp_午盘_新闻_$DATE.json

---

## 下午关注点

待富贵补充

---

**初稿完成时间**：$(date '+%H:%M')
**下一步**：富贵补充分析 → Anna核验 → 旺财优化 → Shaun发布

---

## Handoff

**Where**：$OUTPUT_DIR/每日财经_午间_$DATE.md
**What**：《每日财经》午间快讯初稿，数据已采集
**How to verify**：
1. 核验指数涨跌幅数据准确性
2. 核验板块数据完整性
**Known Issues**：
- 需富贵补充下午关注点
**Next Steps**：
1. 富贵读取数据文件，补充分析
2. Anna核验客观数值
3. 旺财文本优化
EOF

echo "午间快讯初稿已生成：$OUTPUT_DIR/每日财经_午间_$DATE.md"
echo "$(date '+%Y-%m-%d %H:%M') 午间快讯数据已采集" >> "$OUTPUT_DIR/../02-流程/cron_trigger.log"

echo "=== 完成 ==="
