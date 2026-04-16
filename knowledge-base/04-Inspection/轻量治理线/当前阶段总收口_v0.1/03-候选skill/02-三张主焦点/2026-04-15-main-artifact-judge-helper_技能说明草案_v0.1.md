# main-artifact-judge-helper 技能说明草案 v0.1

- 日期：2026-04-15
- 起草：粉雪
- 状态：drafting
- 性质：skill 说明草案
- 用途：为 `main-artifact-judge-helper` 提供第一版技能说明，明确触发条件、输入输出、边界、最小工作流与禁止事项。
- 版本目录：轻量治理线 / 当前阶段总收口_v0.1
- 所属层级：候选 skill / 三张主焦点
- 当前阶段：真实样例试跑前收口 / accepted-for-pretrial
- 上位文档：
  - `2026-04-15-skill候选拆解卡_main-artifact-judge-helper_v0.1.md`
- 下位文档：
  - `2026-04-15-main-artifact-judge-helper_输入输出样例集_v0.1.md`
  - `2026-04-15-main-artifact-judge-helper_试跑记录_v0.1.md`

---

## 1. 建议 skill 名称
- `main-artifact-judge-helper`

## 2. 建议 description（触发描述草案）
Comprehensive main-artifact judge helper for phase outputs, artifact prioritization, and placement guidance. Use when a task needs to: (1) check whether the current phase has a clearly identified main artifact, (2) distinguish likely main artifacts from attachments or explanation pieces, (3) detect attachment takeover risk, or (4) normalize scattered artifact judgments into a structured main-artifact block without replacing human judgment.

## 3. 触发条件
当出现以下任一情况时应触发：
- 用户要求判断当前主产物更像哪个
- 用户要求检查当前是否有配件反客为主风险
- 当前阶段同时出现多个产物候选
- 当前结果需要决定默认归位点

## 4. 不触发条件
以下情况不应触发或不应单独依赖该 skill：
- 当前阶段目标还没锁定
- 当前对象列表本身不清
- 当前需要的是最终内容裁决而非辅助判断
- 当前任务只是单一产物，没有主配区分问题

## 5. 输入
最小支持以下输入：
1. 当前阶段目标
2. 当前产物列表
3. 每个产物的作用说明
4. 当前已知归位位置 / 用途

## 6. 输出
最小输出应限于以下三类：
1. 主产物判断缺项检查结果
2. 主产物 / 配件 / 说明件初步区分草稿
3. 归位建议与预警提示

## 7. 建议输出结构（示意）
```md
- 当前阶段目标：
- 主产物候选：
- 配件 / 说明件：
- 当前风险：
- 默认归位建议：
```

## 8. 最小工作流
1. 识别当前阶段是否存在多产物候选
2. 检查主产物判断是否缺项
3. 区分主产物候选 / 配件 / 说明件
4. 输出归位建议与风险提示
5. 若信息不足，保留不确定性，不伪造已锁定结论
6. 输出统一结构版本

## 9. 禁止事项
- 不得自动锁定最终主产物
- 不得自动删除配件
- 不得把说明件一律视为配件
- 不得替代主入口位做最终归位裁决
- 不得在信息不足时伪造“已锁定主产物”

## 10. 当前边界
这个 skill 的定位是：
- 主产物判断辅助器
- 配件反客为主预警器
- 归位建议整理器

它不是：
- 主产物裁判
- 内容放行器
- 资产上提裁决器

## 11. 一句话收口
> `main-artifact-judge-helper` 只负责把主产物判断、配件风险与归位建议收清、补齐、整理出来，不负责替代人做最终主产物裁决。
