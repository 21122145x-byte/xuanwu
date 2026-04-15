# minimal-unit-builder 试跑记录 v0.1

- 日期：2026-04-15
- 起草：粉雪
- 状态：drafting
- 性质：试跑记录骨架
- 用途：记录 `minimal-unit-builder` 在真实样本上的最小试跑结果，避免候选 skill 未经闭环就进入默认使用。
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-skill候选拆解卡_minimal-unit-builder_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-minimal-unit-builder_技能说明草案_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-minimal-unit-builder_输入输出样例集_v0.1.md`

---

## 1. 试跑目标
验证三件事：
1. 能否稳定识别伪单元 / 过厚单元
2. 生成的单元是否可执行、可回收、可并入
3. 是否会把需要重编排的问题错误压成单元

## 2. 推荐样本类型
- 合格最小单元
- 伪单元
- 过厚单元
- 缺回收结构的派单

## 3. 记录模板
### 样本编号
- 文件 / 消息：
- 输入类型：
- 是否识别厚度问题：
- 输出是否可执行 / 可回收 / 可并入：
- 是否有误判为可直接派发：
- 是否建议放入现役 skill 候选池：
- 备注：

## 4. 最小通过标准
- 至少 4 个样本无明显误判为“可直接派发”
- 至少 3 个样本输出明显优于手工临场拆分
- 不出现“把厚问题伪装成最小单元”的重大问题

## 5. 当前状态
- 尚未记录真实试跑样本

## 一句话收口
> 候选 skill 可以先存在，但进入默认使用前，必须至少有一轮最小试跑记录。
