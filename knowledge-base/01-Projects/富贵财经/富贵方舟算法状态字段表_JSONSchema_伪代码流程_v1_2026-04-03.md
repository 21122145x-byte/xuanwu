# 富贵方舟算法状态字段表 / JSON Schema / 第一阶段伪代码流程 v1

- 日期：2026-04-03
- 项目：富贵财经 / 富贵方舟
- 基于：`富贵方舟算法定义文档_v2_2026-04-03.md`
- 目的：
  1. 把 v2 可执行规格继续压成可落代码的结构件
  2. 提供状态字段表
  3. 提供 JSON Schema 雏形
  4. 提供第一阶段伪代码流程

---

## 一、状态字段表（State Fields Table）

富贵方舟的最小状态单位是“标的记录”。

每条标的记录建议固定包含以下字段：

| 字段名 | 类型 | 必填 | 含义 | 示例 |
|--------|------|------|------|------|
| ticker | string | 是 | 标的代码 | `002353` |
| name | string | 是 | 标的名称 | `杰瑞股份` |
| source_reason | string | 是 | 入池原因摘要 | `主力净流入+油服主线` |
| route_type | string | 是 | 航线类型 | `main_route` / `side_route` / `avoid_route` |
| position_type | string | 是 | 位置类型 | `board` / `watch` / `avoid` |
| status | string | 是 | 当前状态 | `new` / `keep` / `upgrade` / `downgrade` / `remove` |
| score | integer | 是 | 综合评分 | `8` |
| confidence | string | 是 | 置信度 | `low` / `mid` / `high` |
| track_days | integer | 是 | 已跟踪天数 | `2` |
| entry_date | string | 是 | 首次入池日期 | `2026-04-02` |
| last_review_date | string | 是 | 最近复核日期 | `2026-04-03` |
| validation_state | string | 是 | 验证状态 | `pending` / `validated` / `falsified` |
| exit_reason | string/null | 否 | 移出原因 | `承接消失` |
| structure_score | integer | 是 | 结构强度分 | `3` |
| capital_score | integer | 是 | 资金承接分 | `2` |
| recognition_score | integer | 是 | 辨识度分 | `2` |
| continuity_score | integer | 是 | 持续性分 | `1` |
| risk_discount | integer | 是 | 风险折扣 | `0` / `-1` / `-2` |
| notes | string/null | 否 | 备注 | `待确认是否扩散` |

---

## 二、状态池文件建议结构

建议每日状态池文件采用：

```json
{
  "date": "2026-04-03",
  "market_regime": "defensive",
  "headline_judgement": "全天风险偏好继续收缩",
  "items": []
}
```

说明：
- `date`：当日日期
- `market_regime`：市场阶段标签，例如 `defensive` / `balanced` / `offensive`
- `headline_judgement`：当天总航线判断
- `items`：标的状态列表

---

## 三、JSON Schema（第一阶段雏形）

### 1. 单标的状态记录 Schema

```json
{
  "type": "object",
  "required": [
    "ticker",
    "name",
    "source_reason",
    "route_type",
    "position_type",
    "status",
    "score",
    "confidence",
    "track_days",
    "entry_date",
    "last_review_date",
    "validation_state",
    "structure_score",
    "capital_score",
    "recognition_score",
    "continuity_score",
    "risk_discount"
  ],
  "properties": {
    "ticker": { "type": "string" },
    "name": { "type": "string" },
    "source_reason": { "type": "string" },
    "route_type": {
      "type": "string",
      "enum": ["main_route", "side_route", "avoid_route"]
    },
    "position_type": {
      "type": "string",
      "enum": ["board", "watch", "avoid"]
    },
    "status": {
      "type": "string",
      "enum": ["new", "keep", "upgrade", "downgrade", "remove"]
    },
    "score": { "type": "integer" },
    "confidence": {
      "type": "string",
      "enum": ["low", "mid", "high"]
    },
    "track_days": { "type": "integer", "minimum": 0 },
    "entry_date": { "type": "string" },
    "last_review_date": { "type": "string" },
    "validation_state": {
      "type": "string",
      "enum": ["pending", "validated", "falsified"]
    },
    "exit_reason": { "type": ["string", "null"] },
    "structure_score": { "type": "integer" },
    "capital_score": { "type": "integer" },
    "recognition_score": { "type": "integer" },
    "continuity_score": { "type": "integer" },
    "risk_discount": { "type": "integer" },
    "notes": { "type": ["string", "null"] }
  }
}
```

### 2. 每日状态池 Schema

```json
{
  "type": "object",
  "required": ["date", "market_regime", "headline_judgement", "items"],
  "properties": {
    "date": { "type": "string" },
    "market_regime": { "type": "string" },
    "headline_judgement": { "type": "string" },
    "items": {
      "type": "array",
      "items": { "$ref": "#/definitions/ark_item" }
    }
  },
  "definitions": {
    "ark_item": {}
  }
}
```

> 注：真正实现时，应把 `ark_item` 的完整 schema 替换到 `definitions` 中。

---

## 四、第一阶段伪代码流程（Pseudo Code）

下面是富贵方舟第一阶段的推荐伪代码顺序。

### 1. 日更主流程

```python
def run_fugui_ark(today_inputs, yesterday_state):
    # 1. 读取昨日状态池
    prev_items = load_previous_items(yesterday_state)

    # 2. 对昨日池做验证 / 证伪
    reviewed_items = review_previous_items(prev_items, today_inputs)

    # 3. 更新旧池状态（继续 / 升级 / 降级 / 移出）
    updated_prev_items = update_previous_status(reviewed_items)

    # 4. 生成今日候选池
    candidate_pool = build_candidate_pool(today_inputs)

    # 5. 对今日候选池打分与分层
    scored_candidates = score_candidates(candidate_pool, today_inputs)
    layered_candidates = classify_candidates(scored_candidates)

    # 6. 将今日新增并入状态池
    merged_items = merge_state_pool(updated_prev_items, layered_candidates)

    # 7. 输出今日方舟结果
    ark_output = build_daily_ark_output(merged_items, today_inputs)

    # 8. 写入今日状态记录与验证摘要
    save_state_pool(merged_items, today_inputs)
    save_validation_summary(updated_prev_items, today_inputs)
    save_daily_output(ark_output)

    return ark_output
```

---

### 2. 候选池生成伪代码

```python
def build_candidate_pool(today_inputs):
    raw_candidates = []

    raw_candidates.extend(today_inputs['limit_up_samples'])
    raw_candidates.extend(today_inputs['main_inflow_samples'])
    raw_candidates.extend(today_inputs['main_route_representatives'])
    raw_candidates.extend(today_inputs['defensive_fillers'])

    deduped = deduplicate_by_ticker(raw_candidates)
    compressed = compress_same_sector_samples(deduped, max_per_sector=3)
    return compressed[:12]
```

---

### 3. 打分伪代码

```python
def score_candidate(item, today_inputs):
    structure_score = calc_structure_score(item, today_inputs)
    capital_score = calc_capital_score(item, today_inputs)
    recognition_score = calc_recognition_score(item, today_inputs)
    continuity_score = calc_continuity_score(item, today_inputs)
    risk_discount = calc_risk_discount(item, today_inputs)

    total = (
        structure_score
        + capital_score
        + recognition_score
        + continuity_score
        + risk_discount
    )

    return {
        **item,
        'structure_score': structure_score,
        'capital_score': capital_score,
        'recognition_score': recognition_score,
        'continuity_score': continuity_score,
        'risk_discount': risk_discount,
        'score': total,
    }
```

---

### 4. 分层伪代码

```python
def classify_candidates(scored_candidates):
    for item in scored_candidates:
        if item['score'] >= 7:
            item['position_type'] = 'board'
            item['route_type'] = 'main_route'
        elif item['score'] >= 4:
            item['position_type'] = 'watch'
            item['route_type'] = 'side_route'
        else:
            item['position_type'] = 'avoid'
            item['route_type'] = 'avoid_route'
    return scored_candidates
```

---

### 5. 验证 / 证伪伪代码

```python
def review_previous_items(prev_items, today_inputs):
    reviewed = []
    for item in prev_items:
        if still_supported(item, today_inputs):
            item['validation_state'] = 'validated'
        elif clearly_broken(item, today_inputs):
            item['validation_state'] = 'falsified'
            item['exit_reason'] = '原判断被证伪'
        else:
            item['validation_state'] = 'pending'
        reviewed.append(item)
    return reviewed
```

---

## 五、建议文件落点（可直接给实现层）

后续真正代码化时，建议最少形成 4 类文件：

1. **状态池文件**
   - `output/ark/state/YYYY-MM-DD.json`

2. **验证日志文件**
   - `output/ark/validation/YYYY-MM-DD.json`

3. **每日算法输出文件**
   - `output/ark/daily/YYYY-MM-DD.json`

4. **正文调用片段文件（可选）**
   - `output/ark/render/YYYY-MM-DD.md`

---

## 六、当前一句话结论

> 富贵方舟现在已经不只停留在算法定义文档 v2，而是进一步被拆成了可接实现层的三件套：状态字段表、JSON Schema 雏形、第一阶段伪代码流程；后续如果开始写代码，已经可以直接按这份规格往下落第一版状态系统。
