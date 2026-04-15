# skill 候选拆解卡 · handoff-checker v0.1

- 日期：2026-04-15
- 起草：粉雪
- 执行人：粉雪
- 状态：drafting
- 性质：skill 候选拆解卡
- 用途：将“长文产物 5 字段 handoff 规则 / 跨 Agent 正式交接格式”拆成一个可评估、可试做、可纠偏的 skill 候选，先判断是否值得正式 skill 化，以及应 skill 化到哪一层。
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-机制与skill映射表_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/01-Constitution/团队协作宪法与治理总纲.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/01-Constitution/跨Agent协作流转执行卡.md`
- 同位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-现役能力清单_v0.2.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-全局机制与skill化判断表_v0.1.md`
- 下位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-handoff-checker_试跑记录_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-handoff-checker_输入输出样例集_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-handoff-checker_技能说明草案_v0.1.md`
  - 待补：handoff-checker 技能说明草案
  - 待补：handoff-checker 输入输出样例集
  - 待补：handoff-checker 试跑记录
- 所属任务：
  - 轻量治理线：机制 → skill 候选首轮拆解
- 责任人：
  - 主归属位：粉雪
  - 协助位：Curie
  - 审查位：Anna

---

## 一、为什么第一张先写它

`handoff-checker` 之所以适合作为第一张 skill 候选，是因为它满足几个条件：

1. **触发条件清楚**
   - 产物为长文 / 方案 / SOP / 报告 / 机制文档 / 正式交接内容
   - 需要补 5 字段 handoff
   - 或需要检查正式交接是否缺字段

2. **输入输出清楚**
   - 输入：当前文本 / 当前产物 / 当前交接消息
   - 输出：
     - 缺失字段提示
     - 补全建议
     - 标准 handoff 草稿

3. **风险相对可控**
   - 它做的是格式检查与结构补全
   - 不负责最终裁决
   - 不替代内容质量判断
   - 不替代审计位放行

4. **收益立刻可见**
   - 能减少“正文写完但没 handoff”
   - 能减少“正式交接缺字段”
   - 能让长文交付与跨 Agent 流转更加稳定

所以它非常适合作为：
> **第一批模板化 / 检查化 / 格式化 skill 候选**

---

## 二、对应的上位机制

这个 skill 候选主要承接两条已完整成立的机制：

### 1. 长文产物 5 字段 handoff 规则
来源：
- 团队协作宪法与治理总纲

当前稳定口径：
- 凡长文、方案、报告、SOP、机制文档等正式产物
- 默认必须附：
  - Where
  - What
  - How to verify
  - Known Issues
  - Next Steps

### 2. 跨 Agent 正式交接格式
来源：
- 跨Agent协作流转执行卡

当前稳定口径：
- 正式交接必须附 5 字段
- 并附文档链接 / 文件路径

---

## 三、这个 skill 到底做什么

### 建议 skill 名称
- `handoff-checker`

### skill 的最小职责
只做下面三件事：

1. **检查**
   - 当前文本是否已有完整 5 字段 handoff
   - 是否缺字段
   - 字段是否明显空泛

2. **补全**
   - 若缺字段，按当前文档内容生成 handoff 草稿

3. **规范化**
   - 若已有 handoff，但格式散乱，整理成统一结构

### 明确不做的事
这个 skill 不应：
- 替代正文写作
- 替代审计位判断内容是否 accepted
- 替代粉雪判断是否可以正式交接
- 自动伪造用户并未确认的结论
- 自动把“未知问题”写成“已解决”

一句话：
> 它是 handoff 结构检查器与补全器，不是内容裁判。

---

## 四、建议的输入 / 输出

### 输入（最小版）
至少支持这几类输入：

1. **完整文档文本**
   - 用于检查文末是否已有 5 字段

2. **摘要 + 文档路径**
   - 用于快速补 handoff 草稿

3. **正式交接消息草稿**
   - 用于检查是否缺字段、缺路径、缺下一步

### 输出（最小版）
建议支持三类输出：

#### 输出 A：检查结果
例如：
- 缺 `Known Issues`
- `How to verify` 过空
- 缺文档路径

#### 输出 B：补全草稿
自动给出：
- Where
- What
- How to verify
- Known Issues
- Next Steps

#### 输出 C：整理版
如果原文已有 5 字段但格式散乱：
- 输出统一版 handoff 块

---

## 五、为什么它适合做成 skill，而不是只留在文档里

因为它是典型的：
- 高频重复动作
- 输入输出相对稳定
- 出错时能明确指出缺什么
- 不需要高强度主权裁量

与其每次人工提醒：
- 记得补 handoff
- 记得加 Where
- 记得写 Known Issues

不如直接有一个稳定 skill 来做：
- 检查
- 补齐
- 规范化

这正符合 skill-creator 里说的：
> 适合 skill 化的，是那些触发明确、步骤稳定、输出可验证的结构性动作。

---

## 六、为什么它又不能“全自动放行”

即使这个 skill 很适合做，仍然有边界：

### 不能自动做的判断
- handoff 是否真的准确反映正文
- Known Issues 有没有刻意淡化
- Next Steps 是否越权
- What 是否过度夸大已完成范围

也就是说：
- **结构完整** ≠ **内容真实**
- **格式正确** ≠ **交接可放行**

所以这个 skill 最合理的定位是：
> **辅助检查 + 草稿生成**
而不是：
> **自动放行器**

---

## 七、建议的 skill 形态

按目前判断，这个候选更适合：

### 形态 A：轻 skill
SKILL.md 里只写：
- 何时触发
- 检查规则
- 输出格式

优点：
- 轻
- 快
- 易迭代

### 形态 B：skill + 样例参考
额外配：
- `references/examples.md`
  - 放 5-10 个 handoff 正反例

优点：
- 更容易稳定输出质量
- 更适合后续纠偏

### 当前建议
优先做：
- **轻 skill + 少量样例参考**

不建议一开始就做太重的脚本型 skill。
因为这里更像结构判断与文案整理，
不是确定性很强的纯脚本任务。

---

## 八、建议的触发语境

这个 skill 适合在以下场景触发：
- “帮我补 5 字段 handoff”
- “检查这份文档的 handoff 完不完整”
- “把这段交付说明整理成标准 handoff”
- “这份正式交接内容有没有缺项”
- “把这篇 SOP 的交接块补齐”

不适合在以下场景触发：
- 用户只是要正文写作，不是要交接块
- 当前内容仍极不完整，连正文主体都还没形成
- 需要审计位判断是否 accepted，而不是只补 handoff

---

## 九、当前建议的最小试跑方式

不要一上来就把它装成正式 skill 大范围用。
先做最小试跑：

### 试跑样本建议
选 3 类样本：
1. 长文（如机制文档）
2. 正式交接消息
3. 已有 handoff 但格式松散的旧文档

### 试跑要看什么
- 能否稳定识别缺字段
- 补出来的 handoff 是否贴正文
- 会不会空话化
- 会不会越权补写结论
- 会不会把未知写成已知

### 最小通过标准
- 至少 3 个样本不出现明显越权误写
- 补写质量明显优于纯临场手写
- 不新增明显误导字段

---

## 十、当前判断：是否进入正式 skill 候选池

### 当前判断
- **应进入正式 skill 候选池**

### 理由
- 机制已稳定
- skill 化边界清楚
- 输入输出稳定
- 风险可控
- 收益立刻可见

### 当前状态建议
- `candidate-active`

说明：
- 已值得继续往下写 skill 草案
- 但还没到“直接上线默认使用”的程度
- 仍需先走：草案 → 样例 → 试跑 → 纠偏

---

## 十一、一句话收口

> `handoff-checker` 是当前最适合先起的第一张 skill 候选：它承接的是已稳定成立的 handoff 机制，边界清楚、风险低、收益直接，适合先做成“结构检查 + 草稿补全 + 格式规范化”的辅助型 skill，而不应做成自动放行器。

---

## 十二、5 字段 handoff
- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-skill候选拆解卡_handoff-checker_v0.1.md`
- **What**
  - 为 `handoff-checker` 写第一张 skill 候选拆解卡，明确其承接机制、职责边界、输入输出、风险边界与最小试跑方式。
- **How to verify**
  - 检查文档是否已说明：承接哪条机制、做什么、不做什么、为什么适合 skill 化、为什么不能自动放行、建议的最小试跑方式。
- **Known Issues**
  - 当前已补出技能说明草案、样例集与试跑记录骨架，但尚未真正写成正式 SKILL.md 文件。
- **Next Steps**
  - 继续下拆：若试跑通过，再写正式 `SKILL.md` 与候选 skill 目录结构。
