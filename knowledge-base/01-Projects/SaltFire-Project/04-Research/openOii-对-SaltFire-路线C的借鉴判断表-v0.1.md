# openOii 对 SaltFire 路线 C 的借鉴判断表-v0.1

## 一、结论先行

`openOii` 可以作为 SaltFire 路线 C 的**唯一主参考样本**，
但它适合借的是：

- 协同架构
- 状态流转
- 反馈重跑机制
- 工作台组织方式

它不适合直接照搬的是：

- 漫剧 / 视频导向目标
- 对高术语密度内容的理解层
- 对 SaltFire 神谕感 / 新秩序 / 压迫感的专门转译

一句话说：
**openOii 值得借骨架，不值得直接借灵魂。**

---

## 二、判断维度总表

| 维度 | openOii 当前表现 | 对 SaltFire 的借鉴判断 |
|---|---|---|
| 多 Agent 架构 | 完整，分工明确，有 Onboarding / Director / Scriptwriter / Review 等层 | **可直接借** |
| 理解层 | 有结构，但更偏通用漫剧理解，不够 SaltFire 深理解 | **可改造借** |
| 导演层 | 有规划能力，但更偏影视/漫剧结构，不是条漫入口结构 | **可改造借** |
| 编剧层 | 强在分镜脚本化和增量修改，但偏漫剧脚本，不是条漫阅读结构 | **可改造借** |
| 视觉层 | 后续可接，但当前更服务于视频链路 | **部分可借** |
| 反馈路由 | ReviewAgent 很强，支持 incremental/full、target_ids 精细控制 | **可直接借** |
| 工作台层 | 无限画布、实时预览、精细重生成、配置管理 | **可直接借** |
| 终局目标 | 漫剧 / 视频成品导向 | **不建议借** |

---

## 三、哪些可以直接借

### 3.1 多 Agent 分层结构
openOii 已经证明：
- Onboarding / Director / Scriptwriter / Review 这种层次是成立的
- 不是一个大模型硬做全流程，而是把不同职责拆开

对 SaltFire 的意义：
- 路线 C 完全可以采用“理解层 → 结构层 → 生成层 → 反馈层”的多层协作结构

### 3.2 Review / 反馈重跑机制
这是 openOii 最值得直接借的部分之一。

它已经具备：
- feedback_type
- start_agent
- mode（incremental / full）
- target_ids（精细化重跑）

对 SaltFire 的意义：
- 后续样本试读后，可以精确决定“从哪一层重跑”“只改哪一段”
- 不必每次整张样本推倒重来

### 3.3 工作台与交互层
openOii 的工作台思路值得直接借：
- 无限画布
- 配置管理
- 实时预览
- 单项重生成

对 SaltFire 的意义：
- 后续如果路线 C 从 C-lite 继续放大，这些都是必要层

---

## 四、哪些可以改造后借

### 4.1 DirectorAgent
openOii 的 Director 已经不是“脚本质检员”，
但它更偏：
- setup / confrontation / resolution
- themes / stakes / conflicts
- 影视/漫剧的导演规划

对 SaltFire 来说还不够。

SaltFire 需要的 Director 还要额外处理：
- 第一张入口该先让读者看见什么
- 哪个新词语第一次出现反而会成为优势
- 神谕感如何先被看见、再被理解
- 哪些内容必须禁入第一张样本

**判断：可借结构，不可借内容能力定义。**

### 4.2 ScriptwriterAgent
openOii 的 Scriptwriter 很强，
它能：
- 输出 characters
- 输出 shots
- 支持 preserve_ids 增量修改
- 对接 image_prompt / video_prompt

但问题在于：
它的方向是**漫剧脚本化**，不是**条漫入口化**。

对 SaltFire 来说，需要改成：
- 更强调图文关系
- 更强调滑动阅读节奏
- 更强调“入口”而不是“镜头脚本完整性”

**判断：可借结构化输出与增量机制，不可直接借脚本目标。**

---

## 五、哪些不建议直接借

### 5.1 视频终局导向
openOii 的后段明显往：
- VideoGeneratorAgent
n- VideoMergerAgent
- 视频成片导出
去走。

而 SaltFire 当前阶段的目标是：
**条漫入口样本**，不是视频成片。

所以：
- 视频链路现在不该进入主干
- 否则会把验证重点从“世界入口”带偏到“影视完成度”

### 5.2 通用内容理解逻辑
openOii 的理解层更适合：
- 通用故事理解
- 影视化分镜组织
- 用户创意故事扩展

SaltFire 的问题则是：
- 高术语密度
- 神谕 / 天意包装
- 新秩序的可见化
- 压迫与敬畏并存的情绪结构

这部分目前看不到现成可借能力，
**必须自建。**

---

## 六、对三颗脑子的映射判断

| SaltFire 角色 | openOii 对应层 | 借鉴判断 |
|---|---|---|
| Script / Research Agent | Onboarding + Director + 通用理解层 | **部分可借，必须补深理解** |
| Director Agent | DirectorAgent | **可借结构，必须重写职责** |
| Visual Agent | Scriptwriter + 后续图像链路 | **可借生成组织，不可直接借目标** |
| Human Decision | 实时预览 + 精细重生成 | **值得保留并强化** |

---

## 七、最终判断

### openOii 最适合 SaltFire 借什么
1. 多 Agent 协同骨架
2. 状态流转与层次划分
3. Review 的反馈重跑机制
4. 工作台化思路

### openOii 最不适合 SaltFire 直接借什么
1. 漫剧 / 视频导向终局
2. 通用故事理解层
3. 条漫入口之外的影视化逻辑

---

## 八、一句话收口

**openOii 对 SaltFire 路线 C 的价值，不在于它已经是答案，而在于它证明了“协同骨架”怎么搭；SaltFire 真正要自己做的，是把这副骨架换上自己的脑子。**
