# handoff-checker 技能说明草案 v0.1

- 日期：2026-04-15
- 起草：粉雪
- 状态：drafting
- 性质：skill 说明草案
- 用途：为 `handoff-checker` 提供第一版技能说明，明确触发条件、输入输出、边界、最小工作流与禁止事项。
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-skill候选拆解卡_handoff-checker_v0.1.md`
- 同位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/01-Constitution/团队协作宪法与治理总纲.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/01-Constitution/跨Agent协作流转执行卡.md`
- 下位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-handoff-checker_输入输出样例集_v0.1.md`
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-15-handoff-checker_试跑记录_v0.1.md`

---

## 1. 建议 skill 名称
- `handoff-checker`

## 2. 建议 description（触发描述草案）
Comprehensive handoff checker and formatter for formal deliverables and cross-agent handoffs. Use when a document, SOP, report, plan, mechanism note, or handoff message needs to: (1) check whether the 5 required handoff fields are present, (2) fill in missing fields, (3) normalize scattered handoff text into the standard structure, or (4) validate whether a formal cross-agent handoff is structurally complete.

## 3. 触发条件
当出现以下任一情况时应触发：
- 用户要求“补 5 字段 handoff”
- 用户要求“检查交接是否完整”
- 当前产物是长文、方案、SOP、规则卡、机制文档、报告等正式文档
- 当前内容要进入正式跨 Agent 交接
- 当前消息已有部分 handoff，但结构散乱或缺字段

## 4. 不触发条件
以下情况不应触发或不应单独依赖该 skill：
- 正文主体尚未形成，只剩空壳
- 用户需要的是内容审计 / 放行结论，而非 handoff 检查
- 当前任务是闲聊、轻量问答、非正式回复
- 当前内容高度不确定，补 handoff 会强迫制造虚假确定性

## 5. 输入
最小支持以下输入：
1. 完整文档文本
2. 文档摘要 + 文件路径
3. 正式交接消息草稿
4. 已有但散乱的 handoff 文本

## 6. 输出
最小输出应限于以下三类：
1. 缺项检查结果
2. 标准 5 字段 handoff 草稿
3. 整理后的统一 handoff 块

## 7. 标准输出结构
```md
- **Where**
- **What**
- **How to verify**
- **Known Issues**
- **Next Steps**
```

## 8. 最小工作流
1. 识别当前是否属于正式产物 / 正式交接
2. 检查是否已有 5 字段 handoff
3. 若缺字段，先标出缺项
4. 基于现有内容补 handoff 草稿
5. 若内容不确定，显式保留不确定性，不伪造结论
6. 输出统一结构版本

## 9. 禁止事项
- 不得伪造正文中不存在的已完成结论
- 不得把未知问题写成已解决
- 不得把应由审计位决定的结论写成既成事实
- 不得替代主文 / 正文主体内容创作
- 不得在没有文件路径 / 文档定位信息时假造 Where

## 10. 当前边界
这个 skill 的定位是：
- 结构检查器
- handoff 草稿补全器
- 格式规范器

它不是：
- 审计器
- 放行器
- 真实性裁判
- 内容质量裁判

## 11. 一句话收口
> `handoff-checker` 只负责把正式交付与正式交接中的 handoff 结构补齐、检查和整理，不负责替代内容真实性与放行判断。
