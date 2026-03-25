# AI协同条漫生产工艺调研方案-v0.1

## 一、调研目标

本轮调研不再验证“AI 能不能做条漫”，
而是要把 AI 协同条漫生产的真实工具链、真实流程、真实案例、真实坑点尽可能摸全。

核心要回答 4 个问题：

1. 现在业内都在用哪些工具链做 AI 协同漫画 / 条漫
2. 一条真实可跑通的生产流程长什么样
3. 哪些环节已经成熟，哪些环节仍然是坑
4. 哪些方案适合后续直接试，哪些只适合参考

---

## 二、搜索工具优先级

本轮搜索**不要用 web_search 起手**。

按以下优先级执行：

1. **MCP 内搜索工具**（优先）
2. **agent reach**（次优先）
3. **爬虫 / 抓取工具**（保底）

执行原则：
- 优先用 MCP 跑一轮
- 遇到卡点先跳过，不在单点卡死
- 记录每次卡点与替代路径
- 结果必须尽量附原始来源名称 + URL

---

## 三、调研范围

本轮建议覆盖 5 类来源：

### 1）专业漫画 / 条漫网站
看真实创作者、真实教程、真实工作流分享。

### 2）专业技术网站
看工具链、工程化方案、自动化工作流、ComfyUI / SD / LoRA / ControlNet 等。

### 3）代码社区 / 开源平台
重点看 GitHub、Hugging Face、模型页、workflow repo、agent 项目。

### 4）社交平台 / 创作者社区
看真实使用经验、踩坑记录、返工案例、效率变化。

### 5）工具产品站 / 应用站
包括 app、skill、脚本、插件、SaaS、agent、workflow 产品页。

---

## 四、重点站点池

### 中文站点
- GitHub
- CSDN
- 少数派
- 即刻
- 知乎
- Bilibili
- 小红书
- 优设网
- 站酷
- 36kr / 三文娱 / 虎嗅
- 开源中国
- 掘金

### 英文站点
- GitHub
- Hugging Face
- Reddit
- YouTube
- Medium
- Substack
- X / Twitter
- Product Hunt
- ComfyUI workflow 社区
- Civitai
- art / comic workflow 博客

### 特别纳入
- GitHub
- Moltbook（如有相关工作流 / 工具页 / 教程页）
- 各类 app / skill / agent / script 页面

---

## 五、搜索主线

### 主线 1：AI 条漫 / 漫画生产工具链
找：生成工具、控制工具、排版工具、一致性工具、流程编排工具。

### 主线 2：AI 协同生产流程
找：从脚本到成品的完整流程、团队怎么拆工序、哪些环节必须人工、哪些环节可自动化。

### 主线 3：角色 / 风格一致性方案
找：LoRA、ControlNet、IP-Adapter、reference image、seed consistency、局部重绘、batch workflow。

### 主线 4：条漫 / 漫画专用工作流
找：comic workflow、webtoon workflow、vertical comic pipeline、storytelling workflow、panel to long-strip workflow。

### 主线 5：真实案例与踩坑记录
找：创作者复盘、失败案例、工具对比、效率变化、返工点。

### 主线 6：Agent / 自动化协同
找：AI agent 在漫画生产里的应用、prompt orchestration、multi-agent visual pipeline、script-to-comic automation、comic production agent。

---

## 六、SaltFire 定向补充维度

除了通用搜索，还要单独验证 SaltFire 这类暗黑美学与预言感题材是否适配当前工具链。

### 需要额外判断：
- 这套工具链对“盐 / 火 / 预言感 / 神谕感 / 天意包装”是否适配
- 多数偏日漫 / 韩风案例，是否能迁移到 SaltFire 这种暗黑美学
- 黑白 + 单色点缀、宗教感、神秘感风格是否能稳定实现

### 重点补充关键词（中文）
- 暗色调漫画 AI 制作
- 预言 / 神谕 视觉化 AI
- 宗教感 / 神秘感 AI 漫画风格
- 黑白 + 单色点缀 条漫风格
- AI 漫画 失败 返工
- AI 条漫 踩坑 角色一致性

### 重点补充关键词（英文）
- dark comic AI workflow
- prophecy visual design AI comic
- religious aesthetic comic AI
- black white accent color webtoon style
- AI comic failure case study
- comic consistency issues AI

---

## 七、中文搜索关键词

### 基础类
- AI 条漫 制作流程
- AI 漫画 制作流程
- AI 连环漫画 工作流
- AI 漫画 生产工艺
- 条漫 AI 协同
- AI 条漫 工作流
- AI 漫画 工作流
- AI 漫画 角色一致性
- AI 条漫 风格一致性
- AI 长图漫画 制作

### 工具类
- Midjourney 条漫
- Stable Diffusion 条漫
- ComfyUI 条漫 工作流
- LoRA 漫画 角色一致性
- ControlNet 漫画 工作流
- IP-Adapter 漫画
- AI 漫画 排版 工具
- AI 漫画 app
- AI 漫画 脚本 工具
- AI 漫画 agent

### 技术类
- 漫画 角色一致性 LoRA
- 条漫 风格一致性 技术
- AI 漫画 局部重绘
- 漫画 批量生图 workflow
- script to comic 工作流
- 文生图 漫画 分镜
- 漫画 prompt 模板
- 漫画工作流 节点

### 案例 / 经验类
- AI 条漫 实战
- AI 漫画 复盘
- AI 漫画 踩坑
- AI 漫画 创作经验
- AI 条漫 创作者
- AI 漫画 从脚本到成品
- AI 漫画 效率提升
- AI 漫画 返工

### 产品 / 自动化类
- AI 漫画 生产平台
- AI 漫画 SaaS
- AI 漫画 agent 工作流
- AI 漫画 自动化脚本
- AI 漫画 skill
- AI 漫画 插件
- AI 漫画 app 推荐

---

## 八、英文搜索关键词

### 基础类
- AI comic production workflow
- AI webtoon workflow
- AI comic pipeline
- AI assisted comic creation
- vertical comic AI workflow
- long strip comic AI workflow
- script to comic workflow
- AI storytelling comic pipeline

### 工具类
- Midjourney comic workflow
- Stable Diffusion comic workflow
- ComfyUI comic workflow
- LoRA comic character consistency
- ControlNet comic generation
- IP-Adapter comic workflow
- comic layout AI tool
- AI comic app
- AI comic generator workflow
- comic agent workflow

### 技术类
- comic character consistency AI
- visual consistency comic generation
- AI comic panel generation
- webtoon style consistency workflow
- prompt engineering for comics
- comic storyboard to image workflow
- batch comic generation pipeline
- multi image consistency comic AI

### 经验 / 复盘类
- how creators use AI for comics
- AI comic creator workflow
- AI comic case study
- AI comic production lessons
- AI webtoon creator pipeline
- AI comic mistakes
- AI comic production bottlenecks
- AI comic post production workflow

### 代码 / 自动化类
- github AI comic workflow
- github comic generation pipeline
- github webtoon AI tool
- open source AI comic generator
- comic production agent github
- multi-agent comic generation
- automated comic workflow
- comic pipeline script github

---

## 九、执行顺序

### 第一轮：确认工具链全景
目标：拉出工具地图和主流路线。

### 第二轮：确认真实流程
目标：拉出 3–5 套可参考生产流程。

### 第三轮：确认一致性与返工方案
目标：确认“最痛环节”的可解法。

### 第四轮：确认真实创作者经验与失败案例
目标：避免只看工具广告页，专门记录坑点。

---

## 十、每条结果需要记录的字段

- 来源名称
- URL
- 类型（工具 / 教程 / 案例 / 复盘 / repo / 产品）
- 核心内容
- 对我们有什么用
- 可信度判断（高 / 中 / 低）
- 是否与 SaltFire 风格适配（是 / 否 / 待验证）
- 主要坑点（如有）

---

## 十一、预期产出

本轮调研完成后，至少形成 4 份东西：

1. AI 条漫工具地图
2. AI 协同生产流程对照表
3. 一致性控制方案清单
4. 可直接试跑的工具 / 工作流 shortlist

并新增一类必须产出：

5. **失败案例与坑点清单**

---

## 十二、一句话收口

本轮调研的目标，不是再证明 AI 很强，
而是把 AI 协同条漫生产，从概念认知推进到：

**哪些工具能直接试、哪些流程能直接跑、哪些坑必须提前避开。**
