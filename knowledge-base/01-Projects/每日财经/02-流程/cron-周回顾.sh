#!/bin/bash
# 每周回顾 - 周六生成
# 触发时间：周六 10:00
# 任务：汇总本周（周一至周五）A股市场表现
# 版本：v2.0 - 基于新大纲优化

set -e

echo "=== 每周回顾 ==="
echo "时间: $(date '+%Y-%m-%d %H:%M')"

# Skill 绝对路径
MX_SEARCH="/Users/xiaojingbo/.openclaw/skills/mx_search/mx_search"
MX_DATA="/Users/xiaojingbo/.openclaw/skills/mx_data/mx_data"
MX_SELECT="/Users/xiaojingbo/.openclaw/skills/mx_select_stock/mx_select_stock"

DATE=$(date '+%Y-%m-%d')
OUTPUT_DIR="/Users/xiaojingbo/.openclaw/workspace-fugui/knowledge-base/01-Projects/每日财经/03-样例"

echo "[1/6] 采集本周大盘数据..."
$MX_DATA "上证指数本周涨跌幅" > "$OUTPUT_DIR/.tmp_大盘_$DATE.json" 2>&1
$MX_DATA "深成指本周涨跌幅" >> "$OUTPUT_DIR/.tmp_大盘_$DATE.json" 2>&1
$MX_DATA "创业板指本周涨跌幅" >> "$OUTPUT_DIR/.tmp_大盘_$DATE.json" 2>&1
$MX_DATA "沪深两市本周成交额" >> "$OUTPUT_DIR/.tmp_大盘_$DATE.json" 2>&1

echo "[2/6] 采集本周涨幅排名..."
$MX_SELECT "本周涨幅排名前10" > "$OUTPUT_DIR/.tmp_涨幅_$DATE.json" 2>&1

echo "[3/6] 采集本周跌幅排名..."
$MX_SELECT "本周跌幅排名前10" > "$OUTPUT_DIR/.tmp_跌幅_$DATE.json" 2>&1

echo "[4/6] 采集主力资金流向..."
$MX_SELECT "本周主力资金净流入最多的股票" 1 10 > "$OUTPUT_DIR/.tmp_资金_$DATE.json" 2>&1

echo "[5/6] 采集周五龙虎榜..."
FRIDAY=$(date -v-1d '+%m月%d日')
$MX_SEARCH "${FRIDAY}龙虎榜" > "$OUTPUT_DIR/.tmp_龙虎榜_$DATE.json" 2>&1

echo "[6/6] 采集本周重要新闻..."
$MX_SEARCH "本周A股重要政策事件" > "$OUTPUT_DIR/.tmp_新闻_$DATE.json" 2>&1

echo "数据采集完成！"

# 生成周回顾报告框架
cat > "$OUTPUT_DIR/周回顾_$DATE.md" << EOF
# 《每周回顾》初稿 | $(date -v-5d '+%Y年%m月%d日') - $(date -v-1d '+%Y年%m月%d日')

> 数据来源：东方财富妙想 Skill | 采集时间：$DATE
> 状态：初稿待核验

---

## 一、本周大盘表现

### 三大指数周涨跌幅

| 指数 | 本周涨跌幅 | 市场特征 |
|------|-----------|----------|
| 上证指数 | 待提取 | 待分析 |
| 深成指 | 待提取 | 待分析 |
| 创业板指 | 待提取 | 待分析 |

**成交额**：待提取（目标：10万亿级别）

**一句话总结**：待富贵分析补充

---

## 二、本周热点板块

### 最热门板块 TOP3

| 排名 | 板块方向 | 代表股 | 周涨幅 | 驱动逻辑 |
|------|----------|--------|--------|----------|
| 1 | 待分析 | 待提取 | 待提取 | 待补充 |
| 2 | 待分析 | 待提取 | 待提取 | 待补充 |
| 3 | 待分析 | 待提取 | 待提取 | 待补充 |

### 资金流入方向（主力净流入）
数据已采集，详见：.tmp_资金_$DATE.json

---

## 三、本周重要事件

| 日期 | 事件 | 影响力 | 关联板块 |
|------|------|--------|----------|
| 待补充 | 待提取 | 待评估 | 待分析 |

数据已采集，详见：.tmp_新闻_$DATE.json

---

## 四、个股表现（人物故事）

### 本周黑马 TOP3

| 排名 | 个股 | 周涨幅 | 故事简述 |
|------|------|--------|----------|
| 1 | 待提取 | 待提取 | 待富贵补充 |
| 2 | 待提取 | 待提取 | 待富贵补充 |
| 3 | 待提取 | 待提取 | 待富贵补充 |

数据已采集，详见：.tmp_涨幅_$DATE.json

### 本周最失望个股 TOP3

| 排名 | 个股 | 周跌幅 | 掉队原因 |
|------|------|--------|----------|
| 1 | 待提取 | 待提取 | 待富贵补充 |
| 2 | 待提取 | 待提取 | 待富贵补充 |
| 3 | 待提取 | 待提取 | 待富贵补充 |

数据已采集，详见：.tmp_跌幅_$DATE.json

### 龙虎榜亮点
数据已采集，详见：.tmp_龙虎榜_$DATE.json

---

## 五、市场情绪总结

### 情绪温度计

| 日期 | 情绪指数 | 特征描述 |
|------|----------|----------|
| 周一 | 待评估 | 待补充 |
| 周二 | 待评估 | 待补充 |
| 周三 | 待评估 | 待补充 |
| 周四 | 待评估 | 待补充 |
| 周五 | 待评估 | 待补充 |

**趋势**：待判断（升温/降温/震荡）

### 整体判断
- **本周情绪关键词**：待富贵提炼
- **一句话总结**：待富贵补充

### 关键观察点
1. 待补充
2. 待补充
3. 待补充

---

## 六、下期《下周展望》关注点

1. 待富贵补充
2. 待富贵补充
3. 待富贵补充

---

## 附录：数据获取记录

| 数据项 | Skill | 状态 |
|--------|-------|------|
| 三大指数周涨跌幅 | mx_data | ✅ 已采集 |
| 本周成交额 | mx_data | ✅ 已采集 |
| 涨幅排名 | mx_select_stock | ✅ 已采集 |
| 跌幅排名 | mx_select_stock | ✅ 已采集 |
| 主力资金流向 | mx_select_stock | ✅ 已采集 |
| 龙虎榜数据 | mx_search | ✅ 已采集 |
| 本周重要新闻 | mx_search | ✅ 已采集 |

---

**初稿完成时间**：$DATE
**下一步**：富贵分析补充 → Anna核验 → 旺财优化 → Shaun发布

---

## Handoff

**Where**：$OUTPUT_DIR/周回顾_$DATE.md
**What**：《每周回顾》初稿框架，数据已采集
**How to verify**：
1. 核验指数涨跌幅数据准确性
2. 核验个股排名数据完整性
3. 检查是否有占位符未替换
**Known Issues**：
- 需富贵补充分析内容
- 需核验新闻事件影响力评级
**Next Steps**：
1. 富贵读取数据文件，补充分析
2. Anna核验客观数值
3. 旺财文本优化
EOF

# 清理临时文件标记（保留json供分析）
echo "周回顾已生成：$OUTPUT_DIR/周回顾_$DATE.md"
echo "$(date '+%Y-%m-%d %H:%M') 周回顾数据已采集" >> "$OUTPUT_DIR/../02-流程/cron_trigger.log"

# 可选：删除临时json文件（如需保留供分析，注释掉下面一行）
# rm -f "$OUTPUT_DIR/.tmp_"*"_$DATE.json"

echo "=== 完成 ==="
echo "文件：$OUTPUT_DIR/周回顾_$DATE.md"
echo "临时数据：$OUTPUT_DIR/.tmp_*_$DATE.json"
