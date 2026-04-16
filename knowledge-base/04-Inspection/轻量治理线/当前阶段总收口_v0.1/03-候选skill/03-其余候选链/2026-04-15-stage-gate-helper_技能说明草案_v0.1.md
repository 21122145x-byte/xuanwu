# stage-gate-helper 技能说明草案 v0.1

- 日期：2026-04-15
- 起草：粉雪
- 状态：drafting
- 性质：skill 说明草案
- 用途：为 `stage-gate-helper` 提供第一版技能说明，明确触发条件、输入输出、边界、最小工作流与禁止事项。
- 版本目录：轻量治理线 / 当前阶段总收口_v0.1
- 所属层级：候选 skill / 其余候选链
- 当前阶段：候选链已形成 / 当前优先级后置
- 上位文档：
  - `2026-04-15-skill候选拆解卡_stage-gate-helper_v0.1.md`
- 下位文档：
  - `2026-04-15-stage-gate-helper_输入输出样例集_v0.1.md`
  - `2026-04-15-stage-gate-helper_试跑记录_v0.1.md`

---

## 1. 建议 skill 名称
- `stage-gate-helper`

## 2. 建议 description（触发描述草案）
Comprehensive stage-gate helper for multi-stage tasks, audit boundaries, and structured phase transitions. Use when a task needs to: (1) check whether a phase/status block is complete, (2) fill missing fields for review-ready / sent-to-audit / accepted / revision-needed / blocked, (3) normalize scattered phase state text into a standard stage-gate structure, or (4) prepare a structured phase handoff without replacing human judgment.

## 3. 触发条件
当出现以下任一情况时应触发：
- 用户要求“补阶段门 / 阶段状态块”
- 用户要求“检查这段阶段状态是否完整”
- 当前任务已进入送审 / 回转 / blocked / accepted 边界
- 当前已有状态信息，但结构散乱、缺下一步或缺 Known Issues

## 4. 不触发条件
以下情况不应触发或不应单独依赖该 skill：
- 当前还没有真正形成阶段边界
- 用户需要的是最终放行裁决，而不是结构整理
- 当前阶段信息严重不足，补结构只会制造假确定性
- 当前只是轻量闲聊或即时问答

## 5. 输入
最小支持以下输入：
1. 当前阶段说明文本
2. 当前产物摘要 + 当前状态候选
3. 审计意见草稿
4. 已有但散乱的阶段状态块

## 6. 输出
最小输出应限于以下三类：
1. 缺项检查结果
2. 标准阶段门草稿
3. 整理后的统一阶段状态块

## 7. 建议输出结构（示意）
```md
- 当前状态：
- 当前产物：
- 已知问题：
- 是否送审 / 是否回转：
- 下一步：
```

## 8. 最小工作流
1. 识别当前是否已进入阶段边界
2. 检查是否已有显式状态块
3. 若缺项，先指出缺项
4. 基于当前上下文补阶段门草稿
5. 若状态判断仍不确定，保留不确定性，不伪造 accepted / blocked
6. 输出统一结构版本

## 9. 禁止事项
- 不得自动把阶段写成 accepted
- 不得自动把问题升级成 blocked
- 不得在缺证据时把 revision-needed 写死
- 不得替代审计位与主入口位做最终裁决
- 不得为了结构完整而制造虚假确定性

## 10. 当前边界
这个 skill 的定位是：
- 阶段门检查器
- 状态块补全器
- 阶段状态格式规范器

它不是：
- 放行器
- 阻塞裁判
- 回转裁决器

## 11. 一句话收口
> `stage-gate-helper` 只负责把阶段门结构收清、补齐、整理，不负责替代人去做最终阶段裁决。
