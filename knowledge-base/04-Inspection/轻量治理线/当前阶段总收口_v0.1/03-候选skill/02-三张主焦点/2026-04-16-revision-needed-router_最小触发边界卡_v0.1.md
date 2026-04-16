# revision-needed-router 最小触发边界卡 v0.1

- 日期：2026-04-16
- 起草：粉雪
- 状态：drafting
- 性质：最小触发边界卡
- 用途：为 `revision-needed-router` 提供试跑前的最小触发边界，减少把 blocked / 重编排 / 普通 repair 建议误吞成 revision-needed 回转的问题。
- 版本目录：轻量治理线 / 当前阶段总收口_v0.1
- 所属层级：候选 skill / 三张主焦点
- 当前阶段：真实样例试跑前收口 / accepted-for-pretrial
- 上位文档：
  - `../01-总览与编排/2026-04-16-三张候选skill试跑前分阶段推进编排表_v0.1.md`
- 同位文档：
  - `2026-04-15-skill候选拆解卡_revision-needed-router_v0.1.md`
  - `2026-04-15-revision-needed-router_技能说明草案_v0.1.md`
  - `2026-04-15-revision-needed-router_输入输出样例集_v0.1.md`

---

## 一、必命中
出现以下条件时，`revision-needed-router` 才值得进入：
- 审计 / 评审已经明确给出 `revision-needed` 或等价的“需要回转补口”结论
- 当前缺口对象可被指出，不是纯模糊不满意
- 当前任务仍可沿原链路继续，不需要直接停损或重开大编排
- 需要把“回哪层、补什么、谁接链、下一步怎么继续”整理成结构动作

## 二、不命中
出现以下任一情况时，不应命中：
- 审计结论尚未形成，只是有人口头说“再改改”
- 问题本质上是信息不足，尚不能判断该回哪层
- 当前更像 accepted 后的小修饰 / 普通 repair，而不是正式 revision-needed 回转
- 当前缺口已升级为关键前提缺失，局部修补无意义

## 三、易混淆但应分流
### 1. 表面像 revision-needed，实则更像 blocked
- 关键前提缺失
- 依赖对象不存在或已失真
- 即使回一层也无法补齐
- **应分流**：不要交给 `revision-needed-router` 硬给小修路线

### 2. 表面像 revision-needed，实则更像重编排
- 当前问题不只是补口，而是目标、阶段、主产物或协作结构本身错位
- **应分流**：回主入口位做重编排，不把结构错位压成回一层修字段

### 3. 表面像 revision-needed，实则只是普通 repair 建议
- 只是措辞、字段、局部文案微调
- 没有形成正式 revision-needed 回转口
- **应分流**：直接局部修补，不必强行走回转路由

## 四、一句话收口
> `revision-needed-router` 只处理“revision-needed 已成立，且需要把回转路径收成结构动作”的场景；未成立、已 blocked、或本质需重编排的，不应硬塞进来。
