# registry-maintainer 技能说明草案 v0.1

- 日期：2026-04-15
- 起草：粉雪
- 状态：drafting
- 性质：skill 说明草案
- 用途：为 `registry-maintainer` 提供第一版技能说明，明确触发条件、输入输出、边界、最小工作流与禁止事项。
- 版本目录：轻量治理线 / 当前阶段总收口_v0.1
- 所属层级：候选 skill / 其余候选链
- 当前阶段：候选链已形成 / 当前优先级后置
- 上位文档：
  - `2026-04-15-skill候选拆解卡_registry-maintainer_v0.1.md`
- 下位文档：
  - `2026-04-15-registry-maintainer_输入输出样例集_v0.1.md`
  - `2026-04-15-registry-maintainer_试跑记录_v0.1.md`

---

## 1. 建议 skill 名称
- `registry-maintainer`

## 2. 建议 description（触发描述草案）
Comprehensive registry maintainer for capability registries, mechanism inventories, skill mappings, and candidate skill chains. Use when a new mechanism/skill/candidate needs to: (1) be checked against existing registry docs, (2) be written back into capability lists or mapping tables, (3) update its status across related docs, or (4) normalize scattered registry maintenance actions into a structured update plan without replacing human judgment about status or promotion.

## 3. 触发条件
当出现以下任一情况时应触发：
- 用户要求把某对象回写进注册层
- 新机制 / 新 skill / 新候选 skill 出现后需要同步多个表
- 旧对象状态发生变化，需要更新注册层条目
- 当前对象挂载了，但注册层相关文档还没同步

## 4. 不触发条件
以下情况不应触发或不应单独依赖该 skill：
- 当前对象状态还没判断清楚
- 当前需要的是审计 / 放行 / 升格裁决
- 当前任务是大规模注册层重构而不是单对象维护
- 当前对象只是临时讨论，还不应正式落表

## 5. 输入
最小支持以下输入：
1. 对象名称
2. 对象类型
3. 当前状态
4. 当前已知文档链
5. 当前是否已验证 / 已 accepted / 已试跑

## 6. 输出
最小输出应限于以下几类：
1. 应更新表项检查结果
2. 现役能力清单回写草稿
3. 映射表回写草稿
4. 状态更新建议
5. 缺失回挂提醒

## 7. 建议输出结构（示意）
```md
- 对象名称：
- 对象类型：
- 当前建议状态：
- 应更新文档：
- 当前缺失动作：
- 建议下一步：
```

## 8. 最小工作流
1. 识别对象属于哪一类
2. 检查对象当前已进入哪些注册层文档
3. 指出缺失更新动作
4. 输出回写与同步建议
5. 若状态仍不确定，保留不确定性，不自动升格
6. 输出统一注册维护块

## 9. 禁止事项
- 不得自动把候选对象升格成现役
- 不得自动判定完整 / 未完成 / 慎用
- 不得伪造已验证 / 已 accepted 状态
- 不得自动批量改写整套注册层文档
- 不得把弱关联对象强行写入高优先级注册入口

## 10. 当前边界
这个 skill 的定位是：
- 注册层回写辅助器
- 注册层同步检查器
- 注册维护格式规范器

它不是：
- 对象升格裁判
- 现役状态裁判
- 自动治理重构器

## 11. 一句话收口
> `registry-maintainer` 只负责帮助注册层对象回写、同步、检查和整理，不负责替代人去做对象状态裁决与升格判断。
