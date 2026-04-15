# skill 候选拆解卡 · stage-gate-helper v0.1

- 日期：2026-04-15
- 起草：粉雪
- 执行人：粉雪
- 状态：drafting
- 性质：skill 候选拆解卡
- 用途：将“阶段门机制 / 阶段门模板”拆成一个可评估、可试做、可纠偏的 skill 候选，先判断是否值得正式 skill 化，以及应 skill 化到哪一层。
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-机制与skill映射表_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-13-单一入口式multi-agent协作框架-主文_v0.1.md`
- 同位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-现役能力清单_v0.2.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-全局机制与skill化判断表_v0.1.md`
- 下位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-stage-gate-helper_试跑记录_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-stage-gate-helper_输入输出样例集_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-stage-gate-helper_技能说明草案_v0.1.md`
  - 待补：stage-gate-helper 技能说明草案
  - 待补：stage-gate-helper 输入输出样例集
  - 待补：stage-gate-helper 试跑记录
- 所属任务：
  - 轻量治理线：机制 → skill 候选第三张拆解卡

---

## 一、为什么第三张选它

`stage-gate-helper` 适合作为第三张 skill 候选，因为它承接的是轻治理主线里已经相对稳定的一层：

1. **触发条件清楚**
   - 当前任务进入阶段边界
   - 需要判断能否进入送审 / 放行 / 回转 / 阻塞
   - 需要把阶段状态收成统一结构

2. **输入输出相对稳定**
   - 输入：当前阶段目标、当前产物状态、已知问题、下一步候选动作
   - 输出：阶段门结构草稿 / 状态块 / 缺项提示

3. **收益明显**
   - 能减少阶段边界模糊
   - 能降低“已经做完但没有正式状态”的悬空
   - 能让 sent-to-audit / accepted / revision-needed / blocked 更稳定落地

4. **边界虽比前两张更复杂，但仍可控**
   - 它适合辅助收结构
   - 不适合自动替代审计位 / 主入口位做最终裁决

所以它属于：
> **可以 skill 化，但必须明确是“阶段门辅助器”，不是“阶段放行器”**

---

## 二、对应的上位机制

这个 skill 候选主要承接两层：

### 1. 阶段推进机制
来源：
- 单一入口式 multi-agent 协作框架主文（单元 4）

当前稳定口径：
- 阶段必须可见
- 阶段结果应有归位
- 审后回转必须能继续接链
- 不允许阶段悬空、假推进、做完无状态

### 2. 阶段门模板
来源：
- `2026-04-13-阶段门模板_v0.1.md`

当前稳定口径：
- 至少要有一套可复用的阶段门结构
- 至少能容纳：
  - `review-ready`
  - `sent-to-audit`
  - `accepted`
  - `revision-needed`
  - `blocked`

---

## 三、这个 skill 到底做什么

### 建议 skill 名称
- `stage-gate-helper`

### skill 的最小职责
只做下面三件事：

1. **检查**
   - 当前阶段门信息是否缺项
   - 当前状态是否未显式写出
   - 是否缺已知问题 / 下一步 / 归位判断

2. **补全**
   - 基于当前上下文生成阶段门草稿
   - 将状态、产物、已知问题、下一步整理成统一结构

3. **规范化**
   - 将散乱的阶段状态信息整理成标准阶段门块

### 明确不做的事
这个 skill 不应：
- 自动决定某阶段是否 accepted
- 自动决定 revision-needed 是否成立
- 自动决定 blocked 是否成立
- 替代审计位做放行判断
- 替代主入口位决定是否继续推进下一阶段

一句话：
> 它是阶段门结构辅助器，不是阶段裁决器。

---

## 四、建议的输入 / 输出

### 输入（最小版）
至少支持：
1. 当前阶段说明文本
2. 当前产物摘要 + 当前状态候选
3. 审计意见 / 回写结论草稿
4. 已有但散乱的阶段门信息块

### 输出（最小版）
建议支持：
1. 缺项检查结果
2. 标准阶段门草稿
3. 整理后的统一阶段状态块

---

## 五、为什么适合做成 skill

因为它是典型的：
- 高频重复动作
- 状态字段相对稳定
- 结构比正文简单
- 结果容易人工复核
- 对协作流转影响极大

如果没有这种辅助器，最容易出现：
- 阶段其实已做完，但没有正式状态
- 阶段已经送审，但外显结构很乱
- revision-needed / blocked 被口头提到，却没进入统一状态结构

---

## 六、为什么不能全自动做阶段裁决

即使这个 skill 值得做，也必须明确：

### 不能自动做的判断
- 当前阶段是否真的达到 accepted
- 某个问题是否足够严重到 blocked
- 是否应 revision-needed 而不是 accepted
- 当前结果是否足以进入下一阶段
- 当前 Known Issues 是否只是轻微问题还是结构性问题

所以：
- **结构完整** ≠ **阶段放行成立**
- **状态块写出来** ≠ **状态判断正确**

它最合理的定位是：
> **阶段门收口器 / 结构辅助器**
而不是：
> **自动阶段裁决器**

---

## 七、建议的 skill 形态

### 形态 A：轻 skill
SKILL.md 里只写：
- 何时触发
- 阶段门必备字段
- 不同状态下最少要写什么

### 形态 B：skill + 状态样例参考
额外配：
- `references/examples.md`
  - 放 accepted / revision-needed / blocked / sent-to-audit 的样例

### 当前建议
优先做：
- **轻 skill + 状态样例参考**

不建议一开始就做复杂的自动状态判定器。

---

## 八、建议的触发语境

适合触发：
- “帮我把这轮阶段状态整理成阶段门”
- “检查这个阶段门还缺什么”
- “把这段审计结论整理成标准阶段状态块”
- “当前应该如何写 sent-to-audit / revision-needed / blocked 结构”

不适合触发：
- 用户真正要的是最终放行裁决
- 当前阶段信息仍严重不足
- 当前只是轻量闲聊，不存在阶段边界

---

## 九、当前建议的最小试跑方式

### 试跑样本建议
选 3 类样本：
1. 送审前阶段门
2. 审后 accepted / revision-needed 回写
3. 被判断为 blocked 的阶段收口块

### 试跑要看什么
- 能否稳定识别缺项
- 补出的阶段门是否贴当前阶段语义
- 会不会越权把状态写死
- 会不会把弱问题误写成 blocked
- 会不会忽略 Known Issues 与下一步

### 最小通过标准
- 至少 3 个样本不出现明显越权裁决
- 至少 2 个样本输出明显优于临场手工收状态
- 不出现“把状态写错导致链路误导”的重大问题

---

## 十、当前判断：是否进入正式 skill 候选池

### 当前判断
- **应进入正式 skill 候选池**

### 理由
- 机制已相对稳定
- 技能化收益大
- 但裁量边界明显高于 handoff-checker / doc-mount-checker
- 因此适合做辅助 skill，不适合做自动裁决器

### 当前状态建议
- `candidate-active`

---

## 十一、一句话收口

> `stage-gate-helper` 适合做成一类“阶段门结构辅助 skill”：它可以检查、补全、规范阶段状态块，但不能自动替代主入口位和审计位做放行、回转或阻塞裁决。

---

## 十二、5 字段 handoff
- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-skill候选拆解卡_stage-gate-helper_v0.1.md`
- **What**
  - 为 `stage-gate-helper` 写第三张 skill 候选拆解卡，明确其承接机制、职责边界、输入输出、风险边界与最小试跑方式。
- **How to verify**
  - 检查文档是否已说明：承接哪条机制、做什么、不做什么、为什么适合 skill 化、为什么不能自动裁决、建议的最小试跑方式。
- **Known Issues**
  - 当前仍是候选拆解卡，尚未真正写成正式 SKILL.md 文件。
- **Next Steps**
  - 继续下拆：写 `stage-gate-helper` 的技能说明草案、样例集与试跑记录骨架。
