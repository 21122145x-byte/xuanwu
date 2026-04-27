# 午盘发布硬闸阻断报告

**日期:** 2026-04-27  
**触发时间:** 12:26（cron 第二段任务）  
**Gate执行时间:** 12:27:06  
**Gate ID:** midday_gate_20260427_122706  
**状态:** `blocked_missing_inputs`  
**publish_allowed:** false（不允许输出正式稿/正式长图）

---

## 一、事件摘要

午盘发布硬闸（midday_publish_gate.py）在第二段任务触发时执行，发现午盘抓数链（第一段）未产生任何 cleaned 文件，导致全量 5 个 required inputs 缺失，gate 阻断 writer → audit → render 链路，正式午盘稿与正式长图均未输出。

---

## 二、硬闸执行结果

### Gate 原始输出

```json
{
  "run_id": "midday_gate_20260427_122706",
  "date": "2026-04-27",
  "stage": "midday_publish_gate",
  "started_at": "2026-04-27T12:27:06.740556",
  "writer": null,
  "audit": null,
  "render": null,
  "overall_status": "blocked_missing_inputs",
  "publish_allowed": false,
  "notes": "缺少 cleaned 输入：indices、sectors、zt_pool、fund_flow、breadth",
  "finished_at": "2026-04-27T12:27:06.740604"
}
```

### 缺失的 cleaned 输入（全量5个）

| 文件 | 期望路径 | 状态 |
|------|---------|------|
| indices | `temp/indices_20260427_midday_cleaned.json` | ❌ 不存在 |
| sectors | `temp/sectors_20260427_midday_cleaned.json` | ❌ 不存在 |
| zt_pool | `temp/zt_pool_20260427_midday_cleaned.json` | ❌ 不存在 |
| fund_flow | `temp/fund_flow_20260427_midday_cleaned.json` | ❌ 不存在 |
| breadth | `temp/breadth_20260427_midday_cleaned.json` | ❌ 不存在 |

### 本次硬闸检查项状态

| 检查项 | 状态 | 说明 |
|--------|------|------|
| breadth turnover_basis 口径 | N/A | breadth 文件不存在，未验证 |
| writer turnover_basis 输出 | N/A | writer 未执行 |
| render 成功 | N/A | render 未执行 |

---

## 三、证据链

### 1. temp 目录最新文件截止日

```
ls -laT temp/ | grep "2026-04"
→ 最后写入时间: 2026-04-24 12:05:01（breadth_20260424_midday_cleaned.json）
→ 2026-04-27 无任何写入
```

### 2. output/daily 目录报告文件截止日

```
report_20260424_midday.md（2026-04-24 12:16:07）
→ 2026-04-25、2026-04-26、2026-04-27 均无报告
```

### 3. output/runs 目录任务记录截止日

```
midday_gate_20260424 及相关 runs 均在 2026-04-24
→ 2026-04-27 无任何 run 记录（本次 gate 执行为首次）
```

### 4. cron sessions 检查

```
sessions_list(kind=cron)
→ count: 0
→ 午盘第一段抓数链 cron session 不存在
```

---

## 四、根因分析（RCA）

### 结论先行

> **午盘第一段抓数链（indices / breadth / sectors / fund_flow / zt_pool cron 任务）今日（2026-04-27）未执行或未成功完成，导致全量 cleaned 文件缺失。**

### 可能原因（待验证）

1. **cron 未触发（概率高）**
   - 午盘抓数 cron 今日（2026-04-27）未被调度执行
   - 原因待查：cron 表达式正常但调度器未触发 / cron 被 disabled / 调度器异常

2. **cron 触发了但全部失败（概率中）**
   - 5个抓数任务均被触发
   - 但全部在 raw→cleaned 阶段失败
   - 或全部在抓取阶段失败

3. **部分失败导致 cleaned 未生成（概率低）**
   - 部分任务成功但 cleaned 步骤未完成
   - 然而任何单一 cleaned 缺失都会阻断 gate

4. **文件存在但命名/路径不匹配（排除）**
   - gate 脚本路径逻辑明确：`temp/{type}_{date}_midday_cleaned.json`
   - 无自定义路径需求，排除路径不匹配

### 待验证事项

- [ ] 确认午盘抓数 cron 今日（2026-04-27）是否被调度触发
- [ ] 确认 cron 表达式的 nextRunAt / lastRunAt 状态
- [ ] 检查是否有 cron 被意外 disabled
- [ ] 检查 OpenClaw 调度器健康状态
- [ ] 如发现是周末（周六/日）导致，确认是否应有周末午盘流程

---

## 五、影响

| 影响项 | 状态 |
|--------|------|
| writer 执行 | ❌ 被阻断（无 cleaned 输入） |
| audit 执行 | ❌ 未执行 |
| render 执行 | ❌ 未执行 |
| 正式午盘稿 | ❌ 未输出 |
| 正式长图 | ❌ 未输出 |
| breadth turnover_basis | ⚠️ 未验证（文件缺失） |

---

## 六、复用文件参考（2026-04-24 最近一次正常产出）

breadth_20260424_midday_cleaned.json 口径参考：

```json
{
  "turnover_basis": "新浪轻量 breadth：涨跌幅榜样本 + 上证指数/深证成指成交额合计",
  "source": "sina-light"
}
```

→ breadth 的轻量稳定口径（新浪轻量 breadth）在 2026-04-24 已确认写入，但本次文件不存在，无法验证今日口径是否一致。

---

## 七、复盘建议

1. **建立午盘 cron 健康检查**
   - 每日午盘链执行后应写入 run log 或 session 记录
   - 第二段任务触发前应确认第一段已完成

2. **补充午盘补跑机制**
   - 参照 2026-04-21 的 RCA 规则：窗口后恢复 = 高风险操作
   - 建议增加 cron 状态监控告警

3. **确认 2026-04-25 ~ 2026-04-27 是否为交易日**
   - 如为节假日/周末，午盘链本不应执行（需确认是否有节假日跳过逻辑）

4. **考虑增加 temp 文件存在性的主动巡检**
   - 在 gate 执行前增加"数据就绪"预检查

---

## 八、一句话

> **午盘全量 cleaned 输入缺失，第一段抓数链今日未成功产出，正式稿/长图阻断。根因待 cron 健康状态验证。**

---

## 九、补充证据：Cron Session 状态（12:30 调取）

### 第一段 Cron（抓数）Session 存在性

| Cron 名称 | Session ID | updatedAt | 状态 |
|-----------|-----------|-----------|------|
| fugui-midday-fetch-indices-20260407 | a4d0da28-90e1-422b-929c-d82aee799915 | ~Apr 24 | 无今日 session |
| fugui-midday-fetch-breadth-20260407 | a6675faf-f292-49b6-8019-da29903820e | ~Apr 24 | 无今日 session |
| fugui-midday-fetch-sectors-20260407 | d6e853ee-4f84-4c17-862b-7378fddeae17 | ~Apr 24 | 无今日 session |
| fugui-midday-fetch-fundflow-20260407 | fdab378e-40ee-4e9a-8b53-5d485512fbb4 | ~Apr 24 | 无今日 session |
| fugui-midday-fetch-ztpool-20260407 | a7c79f05-358d-4e40-8b88-576769fcce9b | ~Apr 24 | 无今日 session |
| fugui-midday-fetch-summary-20260407 | 34250c7f-36d3-4217-b208-45e08f1cc27a | ~Apr 24 | 无今日 session |

### 第二段 Cron（出图写稿）Session 存在性

| Cron ID | 名称 | 今日 Session | 状态 |
|---------|------|-------------|------|
| eb59e129-079c-4552-9d4e-8eb5700c6c04 | 富贵-每日财经-午盘-出图写稿 | ✅ d0a83d4e（运行中） | 因无 cleaned 数据，gate 阻断 |

### 结论

> **第一段抓数 cron 今日（2026-04-27）没有任何 session 记录，说明 cron 未触发或未成功执行。**
> 
> **第二段 cron 触发了，但在 gate 阶段因无数据输入而被阻断。**

---

## 十、根因定性（正式）

### 根因

> **午盘第一段 cron（抓数链）在今日（2026-04-27）未触发执行，导致全量 cleaned 文件缺失。**

### 可能触发机制

1. cron 调度器当日未对第一段任务做 catch-up trigger（即使 cron 表达式正确）
2. 第一段 cron 的 enabled 状态在某个时间点被设为 false（未在本次调取中确认）
3. 调度器在交易日重新激活后，第一段 cron 未被包含在 catch-up 范围内

### 需立即确认事项

- [ ] 第一段 cron 的 enabled 状态（openclaw cron list 中的 status 列未显示 enabled 字段）
- [ ] 第一段 cron 的 lastRunAt 是否确实为 3d ago
- [ ] 是否需要手动触发第一段 cron 补跑
- [ ] 确认为何第二段 cron 触发了但第一段没有

