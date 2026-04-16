# minimal-unit-builder 技能说明草案 v0.1

- 日期：2026-04-15
- 起草：粉雪
- 状态：drafting
- 性质：skill 说明草案
- 用途：为 `minimal-unit-builder` 提供第一版技能说明，明确触发条件、输入输出、边界、最小工作流与禁止事项。
- 版本目录：轻量治理线 / 当前阶段总收口_v0.1
- 所属层级：候选 skill / 三张主焦点
- 当前阶段：真实样例试跑前收口 / accepted-for-pretrial
- 上位文档：
  - `2026-04-15-skill候选拆解卡_minimal-unit-builder_v0.1.md`
- 下位文档：
  - `2026-04-15-minimal-unit-builder_输入输出样例集_v0.1.md`
  - `2026-04-15-minimal-unit-builder_试跑记录_v0.1.md`

---

## 1. 建议 skill 名称
- `minimal-unit-builder`

## 2. 建议 description（触发描述草案）
Comprehensive minimal-unit builder for task decomposition, subagent dispatch preparation, and unit-level execution planning. Use when a task needs to: (1) check whether a proposed unit is truly minimal, (2) compress a broad task into a dispatchable minimal unit, (3) normalize scattered unit ideas into a standard minimal-unit structure, or (4) detect pseudo-units that are still too broad for safe dispatch.

## 3. 触发条件
当出现以下任一情况时应触发：
- 用户要求“压成最小单元”
- 用户要求“检查这个单元是不是还太厚”
- 当前需要给 subagent 派一个可执行、可回收的单元
- 当前派单想法散乱，需要整理成统一最小单元结构

## 4. 不触发条件
以下情况不应触发或不应单独依赖该 skill：
- 当前阶段目标还没锁定
- 当前需要的是完整编排，而不是单元生成
- 当前问题本身还是厚问题，应回上层重编排
- 当前其实只是正文写作，不是任务拆分

## 5. 输入
最小支持以下输入：
1. 当前目标 / 当前阶段
2. 当前任务草稿或派单草稿
3. 期望产物类型
4. 当前并入 / 回收位置（若已知）

## 6. 输出
最小输出应限于以下三类：
1. 单元厚度检查结果
2. 标准最小单元草稿
3. 整理后的统一单元结构块

## 7. 建议输出结构（示意）
```md
- 单元目标：
- 输入边界：
- 期望产物：
- 回收位置：
- 当前不做什么：
```

## 8. 最小工作流
1. 识别当前是否已具备单元化前提
2. 检查当前草稿是否仍过厚 / 伪单元化
3. 若缺项，先指出缺项
4. 生成最小单元草稿
5. 若仍需重编排，显式指出不适合直接派发
6. 输出统一结构版本

## 9. 禁止事项
- 不得把厚问题伪装成最小单元
- 不得在目标未锁定时强行生成单元
- 不得省略期望产物与回收位置
- 不得替代主入口位决定并发 / 串行策略
- 不得把“可写成 prompt”误当成“已适合派发”

## 10. 当前边界
这个 skill 的定位是：
- 最小单元检查器
- 最小单元草稿生成器
- 单元结构规范器

它不是：
- 自动项目拆解器
- 自动阶段编排器
- 最终派单裁决器

## 11. 一句话收口
> `minimal-unit-builder` 只负责把最小单元结构检查、补齐、整理出来，不负责替代主入口位做完整项目拆分与派单裁决。
