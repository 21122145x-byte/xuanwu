# RCA: 午盘 Publish Gate 质量问题

**日期**: 2026-04-13
**触发时间**: 12:16 第二段任务
**gate run_id**: midday_gate_20260413_121632
**overall_status**: pass（结构层面），但内容存在质量问题

---

## 发现的问题

### 1. turnover_basis 字段缺失

**现象**: writer 输出稿件 report_20260413_midday.md 中无 `turnover_basis` 字段

**影响**: 成交额口径未结构化输出，阅读者无法直接识别换手基准来源

**根本原因**: writer_skill.py 未将 turnover_basis 作为结构化字段显式写入稿件元数据，仅在正文用文字描述了口径

**建议修复**: writer_skill 中增加 turnover_basis 结构化输出字段，并在稿件 header 元数据区输出

---

### 2. breadth来源 元数据未填充

**现象**: 报告 header 写"breadth来源: 待补充"，但 breadth 口径已确认（新量轻量 breadth：涨跌幅榜样本 + 上证指数/深证成指成交额合计）

**影响**: 口径信息存在于 cleaned 文件，但未传递到最终稿元数据

**根本原因**: writer 读取 breadth_cleaned 时未将已确认的口径填充到报告元数据区

---

### 3. audit skill 未拦截以上两项

**现象**: audit_status=pass，但未发现 turnover_basis 缺失和 breadth来源 未填充

**根本原因**: audit 脚本的 check 维度不覆盖 breadth来源 元数据字段检查

**建议修复**: audit skill 增加 breadth来源 和 turnover_basis 的存在性 + 非空检查

---

## 上下文

- indices cleaned 文件在第一段未生成（12:16 补数后落盘）
- breadth 轻量口径已确认写入 breadth_20260413_midday_cleaned.json ✅
- writer ✅ / audit ✅ / render ✅ 均结构层面 pass
- 但内容质量存在上述三项缺口

---

## 后续行动

| 优先级 | 行动 | 负责 |
|--------|------|------|
| P1 | writer_skill 增加 turnover_basis 结构化字段输出 | 富贵 |
| P1 | writer 读取 breadth_cleaned 时填充 breadth来源 到稿件元数据 | 富贵 |
| P2 | audit skill 增加 breadth来源 和 turnover_basis 的存在性检查 | 待指派 |
