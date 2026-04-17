# main-artifact-judge-helper｜SKILL 草案工作面 v0.1

- 日期：2026-04-17
- 起草：Anna
- 状态：drafting
- 性质：正式 `SKILL.md` 草案工作面
- 用途：将 `main-artifact-judge-helper` 推进到正式 `SKILL.md` 草案阶段，但先把“辅助判断、不替最终裁决”的强边界写死，再扩主体。
- 版本目录：轻量治理线 / 当前阶段总收口_v0.1
- 所属层级：审计与回写
- 当前阶段：路径 2 / 正式 SKILL.md 草案阶段
- 承接口径：分层推进 / 带强边界进入

---

## 一、当前草案结论

> `main-artifact-judge-helper` 可进入正式 `SKILL.md` 草案编写，
> 但必须先写死强边界，再扩主体描述。

---

## 二、建议 skill 名称
- `main-artifact-judge-helper`

## 三、建议 description 草案
Use when the real question is which output is the current stage’s main artifact versus supporting artifacts such as bridge docs, entry cards, explanation docs, or path cards. Helps clarify the judgment surface and likely result center, but does not replace the lead agent’s final decision on overall project placement or final acceptance.

---

## 四、先写死的边界（必须原样保留到正式草案）

### 1. 它是辅助判断 skill，不是最终裁决器
- 可以帮助识别“当前阶段主产物判断面”
- 不能代替主 Agent 做最终项目归位裁决

### 2. 它负责压清判断面，不负责接管整条结果链
- 负责回答：当前阶段更应把谁视为结果中心
- 不负责替主 Agent 完成最终交付结构编排

### 3. 高复杂场景允许“不写死”
遇到复杂交付场景时，应允许输出：
- 当前判断
- 依据
- 待验证点
- 不强行给死结论

### 4. 不能把“最显眼 / 最完整 / 最方便接链”误当主产物
这是本 skill 的核心反误判红线。

---

## 五、草案骨架

### 1. 它做什么
1. 判断当前阶段哪个对象更接近主产物 / 结果中心
2. 区分主产物与：
   - 配件
   - 桥接件
   - 解释件
   - 入口卡
   - 路径卡
   - 收口件
3. 输出判断依据与归位理由

### 2. 它不做什么
- 不做最终项目归位裁决
- 不替主 Agent 决定最终交付结构
- 不吸收最小单元拆分问题
- 不吸收 `revision-needed` 回转问题

### 3. 何时触发
- 当前问题是“谁才是本阶段主产物”
- 多个对象都在承担主线功能，容易反客为主
- 当前需要明确结果中心而非继续依赖最显眼对象

### 4. 最小输入
- 当前阶段对象列表
- 各对象当前承担的功能
- 当前阶段目标 / 判断面
- 已知争议点

### 5. 最小输出
- 当前更可能的主产物
- 为什么是它
- 为什么其他对象不是
- 哪些点仍待人工确认

---

## 六、当前风险点

### 主风险
- 离结果中心最近
- 高复杂交付场景里最容易再次暴露误判

### 当前收口
所以正式草案必须天然支持：
> **在不确定时输出“当前判断 + 待验证点”，而不是硬判。**

---

## 七、当前是否可进入草案审查
> **可进入，但必须先过风险审查。**

理由：
- 现在能写
- 但写法是否足够克制、是否保持辅助判断定位，需要额外审

---

## 八、下一步
1. 先按本工作面写正式 `SKILL.md` 草案
2. 草案里优先落实“辅助判断 / 非最终裁决”红线
3. 草案完成后进入风险审查，再决定是否扩 examples / references
