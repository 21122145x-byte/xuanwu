# default-start-checker 试跑记录 v0.1

- 日期：2026-04-15
- 起草：粉雪
- 状态：drafting
- 性质：试跑记录骨架
- 用途：记录 `default-start-checker` 在真实样本上的最小试跑结果，避免候选 skill 未经闭环就进入默认使用。
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-skill候选拆解卡_default-start-checker_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-default-start-checker_技能说明草案_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-default-start-checker_输入输出样例集_v0.1.md`

---

## 1. 试跑目标
验证三件事：
1. 能否稳定识别默认起手缺项
2. 读取顺序建议是否贴任务态
3. 是否会在信息不足时制造假清晰

## 2. 推荐样本类型
- 项目态续接任务
- 审后回转任务
- 新任务起手判断
- 复盘 / 审计类任务

## 3. 记录模板
### 样本编号
- 文件 / 消息：
- 输入类型：
- 是否识别缺项：
- 输出是否贴任务态：
- 是否有假清晰判断：
- 是否建议放入现役 skill 候选池：
- 备注：

## 4. 最小通过标准
- 至少 4 个样本无明显误导性起手建议
- 至少 3 个样本输出明显优于手工临场判断
- 不出现“引导跳过注册层 / 项目总表”的重大问题

## 5. 当前状态
- 尚未记录真实试跑样本

## 一句话收口
> 候选 skill 可以先存在，但进入默认使用前，必须至少有一轮最小试跑记录。
