# stage-gate-helper 试跑记录 v0.1

- 日期：2026-04-15
- 起草：粉雪
- 状态：drafting
- 性质：试跑记录骨架
- 用途：记录 `stage-gate-helper` 在真实样本上的最小试跑结果，避免候选 skill 未经闭环就进入默认使用。
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-skill候选拆解卡_stage-gate-helper_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-stage-gate-helper_技能说明草案_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-stage-gate-helper_输入输出样例集_v0.1.md`

---

## 1. 试跑目标
验证三件事：
1. 能否稳定识别阶段门缺项
2. 补出的状态块是否贴当前阶段语义
3. 是否会越权把状态写死

## 2. 推荐样本类型
- 送审前阶段门
- 审后 revision-needed / accepted 回写
- blocked 阶段收口

## 3. 记录模板
### 样本编号
- 文件 / 消息：
- 输入类型：
- 是否识别缺项：
- 输出是否贴阶段语义：
- 是否有越权裁决：
- 是否建议放入现役 skill 候选池：
- 备注：

## 4. 最小通过标准
- 至少 3 个样本无明显越权裁决
- 至少 2 个样本输出明显优于手工临场收状态
- 不出现“把状态写错导致主链误导”的重大问题

## 5. 当前状态
- 尚未记录真实试跑样本

## 一句话收口
> 候选 skill 可以先存在，但进入默认使用前，必须至少有一轮最小试跑记录。
