# Drama Engine 对 SaltFire B 位的借鉴判断表-v0.1

## 一、结论先行

`Drama Engine` 不是漫画生产系统，
也不是条漫工作台。

但它非常适合作为 SaltFire 的 **B 位主样本**，
因为它真正强的不是“生成内容”，而是：

- 多 Agent 协同
- 理解层拆分
- 动态 prompt 组装
- 委派机制
- 上下文 / 状态管理
- 长上下文裁剪与作用域控制

一句话说：
**如果 openOii 告诉我们“多 Agent 生产怎么跑”，那 Drama Engine 告诉我们的就是“多 Agent 的脑子怎么搭”。**

---

## 二、判断维度总表

| 维度 | Drama Engine 当前表现 | 对 SaltFire 的借鉴判断 |
|---|---|---|
| 多 Agent 协作框架 | 完整，支持 moderator / companion / deputy / actions / delegation | **可直接借** |
| 理解层组织 | 强，支持 context、world state、dynamic prompt、scoping | **可直接借** |
| 长上下文处理 | 强，支持 summary / scope / 裁剪 | **可直接借** |
| 结构化委派 | 强，可将复杂任务拆给 deputies 执行 | **可直接借** |
| 项目级状态管理 | 有 world state + context 思路 | **可改造借** |
| 视觉生成能力 | 无 | **不适用** |
| 条漫工作台能力 | 无 | **不适用** |
| 领域理解内容 | 通用叙事 / 写作框架，不含 SaltFire 专项理解 | **必须自建内容层** |

---

## 三、哪些可以直接借

### 3.1 Moderator / 调度逻辑
Drama Engine 的 moderator 机制非常适合 SaltFire 路线 C。

可直接借的点：
- 谁先说话 / 谁接下一棒
- 根据上下文与动作判断下一 Agent
- 避免所有 Agent 同时争夺主导权

对 SaltFire 的意义：
- 后续不再需要人工一直盯着“下一步谁接”
- 可以让 Script / Director / Visual 按条件进入各自阶段

---

### 3.2 Companion / Deputy 模式
Drama Engine 最值钱的一点，是它不把所有能力都堆成大 Agent。

它允许：
- 主 Agent 维持人格 / 主职责
- Deputy 执行专项动作
- 复杂任务通过 deputation 拆开

对 SaltFire 的意义：
- Script / Research Agent 下可以挂：术语解释 deputy、命题提取 deputy、禁入项检查 deputy
- Director Agent 下可以挂：切口压缩 deputy、结构校验 deputy、钩子检查 deputy
- Visual Agent 下可以挂：风格约束 deputy、一致性检查 deputy、提示词打包 deputy

这比把所有能力都做成大 Agent 更灵活，也更适合逐步演化。

---

### 3.3 动态 prompt 组装
Drama Engine 不是一次性丢 prompt，
而是根据上下文动态拼装：
- 当前任务
- 说话者身份
- 参与者信息
- 已知材料
- 世界状态
- 当前 action

对 SaltFire 的意义：
- 可以把术语表、禁入项、保留项、世界钩子、角色状态按需注入
- 避免每次重写 prompt
- 避免前后世界规则漂移

这是 SaltFire 理解层最需要的能力之一。

---

### 3.4 上下文与 world state
Drama Engine 的 `Context` + `world state` 思路非常适合 SaltFire。

对 SaltFire 的意义：
- 世界规则不再散落在 prompt 里
- 术语解释可以沉淀为事实层
- 当前样本保留项 / 禁入项可以放入状态层
- 当前轮次的理解重点可以被后续 Agent 继续沿用

这会是 SaltFire 路线 C 的关键基础设施。

---

### 3.5 长上下文裁剪与 scoping
Drama Engine 提供了：
- 内容太长时 summary
- 范围裁剪（句、段、全文、局部）
- reply functions 控制裁剪策略

对 SaltFire 的意义：
- 后续不可能每次都把整部《盐火预言》喂进去
- 必须控制“取哪段、保什么、丢什么、压到什么颗粒度”

这一层非常适合直接迁移到 SaltFire B 位。

---

## 四、哪些可以改造后借

### 4.1 NPC / shell 的概念模型
Drama Engine 目前是面向“叙事伙伴 / 写作伙伴”场景，
它的 Companion 设计带有角色人格与对话属性。

SaltFire 不一定需要完整保留这种人格化 companion 模式，
但可以改造借：
- 把人格化 companion 改成“职能化 agent”
- 保留 shell / deputy / action 这些机制

### 4.2 交互聊天导向
Drama Engine 强在 chat orchestration，
SaltFire 后续不一定以聊天为主界面。

但可改造借：
- 将聊天调度逻辑转成工作流调度逻辑
- 将对话上下文转成项目状态上下文

---

## 五、哪些不建议直接借

### 5.1 领域内容层
Drama Engine 不负责 SaltFire 这种项目的世界理解答案。

它能给的是：
- 方法
- 骨架
- 调度
- 上下文系统

它给不了的是：
- 神谕到底意味着什么
- 哪个新词第一次出场最该先被看见
- 哪层命题最值得先压出来

所以：
**SaltFire 的内容理解层必须自建。**

### 5.2 视觉执行层
Drama Engine 没有图像、条漫、分镜、工作台等执行能力。

所以它不能替代：
- VisualAgent
- Storyboard editor
- 工作台层样本

---

## 六、对 SaltFire 三颗脑子的映射判断

| SaltFire 角色 | Drama Engine 的对应价值 | 借鉴判断 |
|---|---|---|
| Script / Research Agent | Context / world state / dynamic prompt / delegation | **强借鉴** |
| Director Agent | Companion + deputy + action 的任务拆分方式 | **中强借鉴** |
| Visual Agent | 无直接对应 | **不适用** |
| Human Decision | Moderator 之外的最终判断仍需人类保留 | **需保留人类主权** |

---

## 七、最终判断

### Drama Engine 最适合 SaltFire 的位置
它最适合：

> **做 SaltFire 路线 C 的理解层与协同层方法底盘。**

### 它最不适合做什么
它不适合：
- 当条漫生产工作台
- 当视觉生成系统
- 当现成的 SaltFire 世界理解器

---

## 八、一句话收口

**Drama Engine 的价值，不在于它能替 SaltFire 理解世界，而在于它告诉我们：面对复杂叙事项目，Agent 的脑子应该怎么被组织起来。**
