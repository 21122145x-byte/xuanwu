# skill 候选拆解卡 · revision-needed-router v0.1

- 日期：2026-04-15
- 起草：粉雪
- 执行人：粉雪
- 状态：drafting
- 性质：skill 候选拆解卡
- 用途：将“审后回转机制 / revision-needed 回转规则”拆成一个可评估、可试做、可纠偏的 skill 候选，先判断是否值得正式 skill 化，以及应 skill 化到哪一层。
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-机制与skill映射表_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-13-单一入口式multi-agent协作框架-主文_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-14-单一入口式multi-agent协作框架_缺口表_v0.1.md`
- 同位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-现役能力清单_v0.2.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-全局机制与skill化判断表_v0.1.md`
- 下位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-revision-needed-router_试跑记录_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-revision-needed-router_输入输出样例集_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-revision-needed-router_技能说明草案_v0.1.md`
- 所属任务：
  - 轻量治理线：机制 → skill 候选第十张拆解卡

---

## 一、为什么现在补它

`revision-needed-router` 值得现在补，是因为“审后回转”已经通过最小验证成立，但当前仍缺一套更通用、可复用的回转路由层：

1. **触发条件清楚**
   - 审计结论为 `revision-needed`
   - 当前任务已明确需要补回某层，而不是直接 accepted / blocked
   - 主入口位需要决定：回哪层、补什么、谁接链、下一步怎么继续

2. **输入输出相对稳定**
   - 输入：审计意见、当前阶段状态、当前产物位置、已知缺口
   - 输出：回转层级建议、补口对象建议、回转后下一步结构草稿

3. **收益明显**
   - 能减少 `revision-needed` 后的原地打转
   - 能降低“知道要改，但不知道回哪层改”的停滞
   - 能帮助主入口位把审后回转收成结构动作，而不是口头模糊继续

4. **边界必须提前卡死**
   - 它适合辅助判断回转方向
   - 但不适合替代审计位定义 revision-needed 的成立
   - 更不适合替代主入口位做最终回转裁决

所以它属于：
> **适合做回转路由辅助 skill，但不能做自动回转裁判**

---

## 二、对应的上位机制

这个 skill 候选主要承接：

### 1. 审后回转机制
来源：
- 单一入口式 multi-agent 协作框架主文（单元 4）

当前稳定口径：
- 审计结论出来后，主入口位必须能继续接链
- `revision-needed` 不等于任务结束，而是正式回转口
- 回转后应明确：回哪层、补什么、谁来接、何时再进入阶段门

### 2. 当前缺口方向
当前已明确仍缺：
- revision-needed 回转卡
- 更通用轮转规则
- accepted 后进入下一阶段动作格式

所以这张 skill 候选，本质上是在把 revision-needed 这层从“知道要回”推进到“知道怎么回”。

---

## 三、这个 skill 到底做什么

### 建议 skill 名称
- `revision-needed-router`

### skill 的最小职责
只做下面三件事：

1. **检查**
   - 当前 `revision-needed` 是否已明确缺口对象
   - 当前是否已明确回转层级
   - 当前是否缺少回转后下一步动作

2. **补全**
   - 输出一版回转层级建议
   - 输出补口对象建议
   - 输出回转后下一步结构草稿

3. **规范化**
   - 将散乱的“要改什么 / 回哪层 / 怎么继续”整理成统一回转结构块

### 明确不做的事
这个 skill 不应：
- 自动决定 revision-needed 是否成立
- 自动决定最终该回哪层
- 自动替主入口位重编排完整后续阶段
- 自动替审计位定义通过标准
- 把“建议回哪层”误写成“已裁定必须回哪层”

一句话：
> 它是 revision-needed 回转辅助器，不是回转裁判。

---

## 四、建议的输入 / 输出

### 输入（最小版）
至少支持：
1. 审计意见摘要
2. 当前阶段状态
3. 当前产物位置 / 当前回收位置
4. 当前已知缺口与待补内容

### 输出（最小版）
建议支持：
1. revision-needed 缺项检查结果
2. 回转层级建议草稿
3. 补口对象与下一步动作草稿

---

## 五、为什么适合做成 skill

因为它是典型的：
- 高频但结构重复的判断辅助动作
- 错误模式稳定
- 一旦做不好就容易原地打转
- 输出结构可以被人工快速复核

如果没有它，最容易出现：
- 知道需要 revision-needed，但不知道回哪层
- 审计意见有了，但没有被收成结构动作
- 回转后下一步继续模糊，造成来回绕圈
- 本该回小层补口，却直接重开大题

---

## 六、为什么不能全自动做回转裁决

即使这个 skill 候选值得做，也必须明确：

### 不能自动做的判断
- 审计意见里真正优先级最高的缺口是什么
- 当前到底应回最小单元、阶段门、主文，还是注册层
- 当前 revision-needed 是否已经严重到应升级为 blocked
- 当前是否需要重编排，而不是简单回转

所以：
- **回转结构完整** ≠ **回转路径正确**
- **建议回某层** ≠ **已裁定必须回该层**

它最合理的定位是：
> **回转路由辅助器 / 补口对象整理器**
而不是：
> **自动回转裁判**

---

## 七、建议的 skill 形态

### 形态 A：轻 skill
SKILL.md 里只写：
- 何时触发
- revision-needed 至少要明确什么
- 常见回转层级判断口径

### 形态 B：skill + 回转样例参考
额外配：
- `references/examples.md`
  - 放回最小单元、回阶段门、回主文、回注册层的正反例

### 当前建议
优先做：
- **轻 skill + 回转样例参考**

---

## 八、建议的触发语境

适合触发：
- “这条 revision-needed 现在该回哪层”
- “帮我把审后回转整理成结构动作”
- “检查这轮 revision-needed 还缺什么判断”
- “把这条审计意见整理成回转路线”

不适合触发：
- 审计结论本身还没出来
- 当前真正需要的是最终放行裁决
- 当前缺口太大，本质上需要重编排而非单纯回转

---

## 九、当前建议的最小试跑方式

### 试跑样本建议
选 4 类样本：
1. 只需回最小单元补口的 revision-needed
2. 需要回阶段门补结构的 revision-needed
3. 需要回主文补骨架的 revision-needed
4. 表面像 revision-needed，实则更像 blocked / 重编排 的边缘样本

### 试跑要看什么
- 能否稳定识别回转缺项
- 回转层级建议是否贴当前缺口性质
- 会不会把复杂问题误压成小修小补
- 会不会把建议写成既定裁决

### 最小通过标准
- 至少 4 个样本无明显越权写死回转层级
- 至少 3 个样本输出明显优于手工临场回转判断
- 不出现“把应 blocked 的问题误导回 revision-needed 小修补”的重大问题

---

## 十、当前判断：是否进入正式 skill 候选池

### 当前判断
- **应进入正式 skill 候选池**

### 理由
- 机制已部分成立
- 缺口真实存在
- 回转结构很适合被辅助化
- 但裁量边界较高，必须维持辅助型定位

### 当前状态建议
- `candidate-active`

---

## 十一、一句话收口

> `revision-needed-router` 适合做成审后回转辅助 skill：它能帮助主入口位把 revision-needed 变成清楚的回转结构与下一步动作，但不能替代审计位和主入口位做最终回转裁决。

---

## 十二、5 字段 handoff
- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-skill候选拆解卡_revision-needed-router_v0.1.md`
- **What**
  - 为 `revision-needed-router` 写第十张 skill 候选拆解卡，明确其承接机制、职责边界、输入输出、风险边界与最小试跑方式。
- **How to verify**
  - 检查文档是否已说明：承接哪条机制、做什么、不做什么、为什么适合 skill 化、为什么不能自动做回转裁决、建议的最小试跑方式。
- **Known Issues**
  - 当前仍是候选拆解卡，尚未真正写成正式 SKILL.md 文件。
- **Next Steps**
  - 继续下拆：写 `revision-needed-router` 的技能说明草案、样例集与试跑记录骨架。
