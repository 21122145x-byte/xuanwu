# default-start-checker 技能说明草案 v0.1

- 日期：2026-04-15
- 起草：粉雪
- 状态：drafting
- 性质：skill 说明草案
- 用途：为 `default-start-checker` 提供第一版技能说明，明确触发条件、输入输出、边界、最小工作流与禁止事项。
- 版本目录：轻量治理线 / 当前阶段总收口_v0.1
- 所属层级：候选 skill / 其余候选链
- 当前阶段：候选链已形成 / 当前优先级后置
- 上位文档：
  - `2026-04-15-skill候选拆解卡_default-start-checker_v0.1.md`
- 下位文档：
  - `2026-04-15-default-start-checker_输入输出样例集_v0.1.md`
  - `2026-04-15-default-start-checker_试跑记录_v0.1.md`

---

## 1. 建议 skill 名称
- `default-start-checker`

## 2. 建议 description（触发描述草案）
Comprehensive default-start checker for project-state tasks, continuous tasks, and audit-return flows. Use when a task needs to: (1) verify whether the default start sequence is complete, (2) check whether registry/project table/phase context has been reviewed, (3) suggest the minimal read order before planning or production, or (4) normalize scattered start reasoning into a structured start-check block without replacing human planning judgment.

## 3. 触发条件
当出现以下任一情况时应触发：
- 用户要求“现在默认先看什么”
- 用户要求“检查这轮起手顺序有没有漏”
- 当前任务是项目态续接 / 连续推进 / 审后回转
- 当前起手判断散乱，需要整理成统一起手检查块

## 4. 不触发条件
以下情况不应触发或不应单独依赖该 skill：
- 当前目标还没对齐
- 当前需要的是完整编排方案，而不是起手检查
- 当前任务不是项目态 / 连续推进态
- 当前信息严重不足，补起手结论会制造假清晰

## 5. 输入
最小支持以下输入：
1. 当前任务摘要
2. 当前任务态（若已知）
3. 当前已知文档链
4. 起手判断草稿

## 6. 输出
最小输出应限于以下三类：
1. 起手缺项检查结果
2. 默认读取顺序建议
3. 起手检查块 / 起手结论块

## 7. 建议输出结构（示意）
```md
- 当前任务态：
- 当前是否已回注册层：
- 当前是否已回项目总表：
- 默认读取顺序：
- 当前默认下一动作：
```

## 8. 最小工作流
1. 识别当前是否属于项目态 / 连续推进态 / 审后回转
2. 检查是否已完成起手必要动作
3. 若缺项，先指出缺项
4. 输出默认读取顺序建议
5. 若信息不足，保留不确定性，不伪造已完成判断
6. 输出统一起手检查结构

## 9. 禁止事项
- 不得自动决定任务目标
- 不得自动做完整编排
- 不得在信息不足时伪造任务态判断
- 不得引导跳过注册层 / 项目总表
- 不得把辅助建议写成正式既定计划

## 10. 当前边界
这个 skill 的定位是：
- 起手顺序检查器
- 默认读取顺序辅助器
- 起手检查格式规范器

它不是：
- 编排器
- 派单器
- 最终任务路由器

## 11. 一句话收口
> `default-start-checker` 只负责把默认起手顺序检查清楚、补齐、整理出来，不负责替代主入口位做真正的结构编排与任务裁决。
