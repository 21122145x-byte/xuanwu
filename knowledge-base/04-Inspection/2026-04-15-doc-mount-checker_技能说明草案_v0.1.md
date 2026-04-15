# doc-mount-checker 技能说明草案 v0.1

- 日期：2026-04-15
- 起草：粉雪
- 状态：drafting
- 性质：skill 说明草案
- 用途：为 `doc-mount-checker` 提供第一版技能说明，明确触发条件、输入输出、边界、最小工作流与禁止事项。
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-skill候选拆解卡_doc-mount-checker_v0.1.md`
- 下位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-doc-mount-checker_输入输出样例集_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-doc-mount-checker_试跑记录_v0.1.md`

---

## 1. 建议 skill 名称
- `doc-mount-checker`

## 2. 建议 description（触发描述草案）
Comprehensive document mount checker and formatter for formal docs, SOPs, mechanism notes, audit notes, execution cards, and research cards. Use when a document needs to: (1) check whether required mount fields are present, (2) fill missing fields for 上位文档 / 同级关联 / 下位文档 / 所属主线, (3) normalize scattered mount text into the standard structure, or (4) validate whether a formal document exposes its chain position clearly.

## 3. 触发条件
当出现以下任一情况时应触发：
- 用户要求“补文档挂载字段”
- 用户要求“检查这份文档的挂载完不完整”
- 当前产物是正式文档、规则卡、SOP、执行卡、审计意见、研究卡
- 当前文档已有部分挂载，但结构散乱或缺字段

## 4. 不触发条件
以下情况不应触发或不应单独依赖该 skill：
- 正文主体尚未形成
- 文档归属本身仍高度不确定
- 当前任务需要的是治理裁决，而不是挂载字段检查
- 当前内容只是临时草稿、聊天记录、非正式回复

## 5. 输入
最小支持以下输入：
1. 完整文档文本
2. 文档路径 + 文档摘要
3. 已有但散乱的挂载字段块
4. 当前已知主线 / 上位件 / 同位件列表

## 6. 输出
最小输出应限于以下三类：
1. 缺项检查结果
2. 标准挂载字段草稿
3. 整理后的统一挂载字段块

## 7. 标准输出结构
```md
## 文档挂载
- 上位文档：
- 同级关联：
- 下位文档：
- 所属主线：
```

## 8. 最小工作流
1. 识别当前是否属于正式文档对象
2. 检查是否已有挂载字段块
3. 若缺字段，先标出缺项
4. 基于当前上下文补挂载草稿
5. 若链路不确定，保留不确定性，不伪造强关系
6. 输出统一结构版本

## 9. 禁止事项
- 不得伪造并不存在的上位 / 同位 / 下位关系
- 不得在主线不清时强行写死“所属主线”
- 不得替代治理负责人做最终归位裁决
- 不得为了凑完整而乱加下位文档
- 不得把弱关联写成强依赖关系

## 10. 当前边界
这个 skill 的定位是：
- 挂载字段检查器
- 挂载草稿补全器
- 链路格式规范器

它不是：
- 文档归位裁判
- 文档治理放行器
- 主线裁决器

## 11. 一句话收口
> `doc-mount-checker` 只负责把正式文档中的挂载字段检查、补齐和整理出来，不负责替代人去决定文档真正该挂到哪里。
