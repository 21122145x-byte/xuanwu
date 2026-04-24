# Skill / MCP / Runtime Pipeline / Harness 关系卡
## v0.1

- **当前文件角色**：过渡术语澄清件
- **后续去向建议**：并入统一术语卡，或在相关主文与接口卡稳定后归档。

- **当前法位说明**：本文件当前按“过渡术语澄清件”理解，不再作为 Program 核心附件组默认成员。
- **后续去向建议**：并入统一术语卡，或在相关主文与接口卡稳定后归档。

- **状态**：draft  
- **性质**：关系澄清卡 / 术语边界卡  
- **适用范围**：用于澄清团队当前系统中 Skill、MCP、Runtime Pipeline、Harness 的定义、所处层级与彼此关系，避免在 Program 编写阶段混层。  
- **上位依据**：
  - `团队协作宪法与治理总纲-v2.3-能力前置补丁版.md`
  - `Program-团队协作运行主协议.md`
- **说明**：本卡只回答三件事：它们分别是什么；在当前系统里分别处于哪一层；它们之间是什么关系，谁不替代谁。

---

## 一、四者分别是什么

### 1. Skill 是什么
Skill 是团队内部沉淀的**可调用能力单元**。

它通常包含：
- 能力定义
- 适用范围与边界
- 使用说明
- 必要脚本 / 模板 / SOP / Prompt 派生方式

在当前系统里，Skill 更接近：

> **团队能力层的标准能力包。**

它解决的是：
- 哪些能力不应长期停留在聊天里
- 哪些做法应被沉淀成稳定能力单元
- 后续执行应优先调用什么，而不是反复现场拼 prompt

---

### 2. MCP 是什么
MCP（Model Context Protocol）是**能力接入协议 / 标准接口层**。

它的作用不是定义团队制度，也不是定义项目推进，而是：

> **把外部能力、外部资源或某类服务，以标准接口方式暴露给可兼容的客户端 / 运行时调用。**

在当前系统语境里，MCP 更接近：
- 一种能力接入方式
- 一种服务暴露协议
- 一种接口层，而不是团队主治理层

当前已确认：
- 系统内存在 MCP 配置与运行痕迹
- 至少存在 `MiniMax` MCP 服务
- OpenClaw 自身也具备 `openclaw mcp` 能力

因此，MCP 在当前系统里不应被视为“没有”，但也不应直接等同于团队的主能力层。

---

### 3. Runtime Pipeline 是什么
Runtime Pipeline 是正式任务进入持续运行后，在某个承载框架内部用于负责：
- 状态流转
- 执行推进
- 交接
- 恢复
- 验证
- 回收

的**运行链路 / 推进链路**。

它解决的是：

> **任务闭环如何持续运行，而不是只在聊天里被临时续命。**

在当前系统里，Runtime Pipeline 更准确地说，不是独立宿主，而是：

> **Harness 内部的运行推进机制。**

它承载的不是“某个能力是什么”，而是“某个任务在承载框架里怎样持续跑起来”。

---

### 4. Harness 是什么
Harness 是某种**执行承载框架 / 运行容器 / 调用壳**，用于把运行时、能力接口、外部服务、执行环境以及内部推进链路接起来。

它更像：
- 某种运行承载结构
- 某种能力接线器
- 某种执行容器
- 某种把内部 pipeline 与外部能力一起组织起来的框架

它关注的不是制度，也不是项目计划，而是：

> **某类运行能力最终由什么承载、内部如何推进、外部如何接入、整体如何被调起。**

在当前系统里，Harness 更接近：

> **承载框架 / 容器层。**

---

## 二、在当前系统里分别处于哪一层

为避免混层，当前系统里可暂按以下口径理解：

```text
Charter / Program
  ↓ 定义原则、运行协议与项目推进边界

能力层
  - Skill

接口层
  - MCP

承载框架层
  - Harness
    └─ 内部运行推进机制：Runtime Pipeline

执行层
  - SOP / Runbook / Checklist / Prompt
```

更简化地说：

| 对象 | 当前主要层位 | 主要回答的问题 |
|---|---|---|
| Skill | 能力层 | 团队有哪些应被沉淀、可被直接调用的能力单元？ |
| MCP | 接口层 | 某种能力或服务以什么标准方式接入和暴露？ |
| Runtime Pipeline | Harness 内部推进机制 | 任务闭环在承载框架里怎样持续推进、流转、交接、恢复？ |
| Harness | 承载框架层 | 这些能力、接口与内部运行机制最终由什么执行壳 / 容器 / 框架承接？ |

注意：

- 这四者都**不属于宪章层正文**  
- 也都**不等于 Prompt**  
- 它们是 Program 编写时必须澄清的运行结构与能力结构对象

---

## 三、它们之间是什么关系

### 1. Skill 与 MCP 的关系
Skill 和 MCP 不是一回事。

- **Skill** 偏团队内部能力沉淀
- **MCP** 偏标准接口与服务暴露

关系可以是：
- 某个 Skill 内部调用某个 MCP 服务
- 某个稳定能力既可以被沉淀为 Skill，也可以通过 MCP 方式对外暴露

但二者不互相替代。

一句话：

> **Skill 解决“能力是什么”，MCP 解决“能力怎么接进来 / 暴露出去”。**

---

### 2. Skill 与 Runtime Pipeline 的关系
Skill 不负责推进整个任务闭环；Runtime Pipeline 不负责定义每个能力单元。

关系是：
- Runtime Pipeline 在推进某个任务阶段时，可以调用某个 Skill
- Skill 为 Runtime Pipeline 提供稳定能力支持

一句话：

> **Skill 是能力单元，Runtime Pipeline 是推进链路。**

---

### 3. MCP 与 Runtime Pipeline 的关系
MCP 不是任务推进协议；Runtime Pipeline 也不是能力接入协议。

关系是：
- Runtime Pipeline 可在运行过程中调用由 MCP 暴露的外部能力
- MCP 为 Runtime Pipeline 提供某些接口能力，但不决定任务如何流转

一句话：

> **MCP 提供接入面，Runtime Pipeline 负责把任务跑起来。**

---

### 4. Harness 与 Runtime Pipeline 的关系
这两者最容易混。

区别是：
- **Runtime Pipeline** 更偏运行逻辑与推进链
- **Harness** 更偏承载框架，是把推进链、能力调用与接口接入组织起来的宿主

关系是：
- Runtime Pipeline 通常不是独立宿主
- Runtime Pipeline 更像 Harness 的内部核心组成之一
- Harness 内部可以包含一条或多条 Runtime Pipeline，用于承接不同任务闭环

一句话：

> **Runtime Pipeline 是 Harness 里面“怎么跑”的那条链，Harness 是把这条链和能力接起来的承载框架。**

---

### 5. Harness 与 Skill / MCP 的关系
Harness 本身不定义能力内容，但它可以承接：
- Skill 的调用
- MCP 服务的接入
- Runtime Pipeline 的运行
- 其他运行时能力

一句话：

> **Harness 不等于能力本身，而是把内部推进链与外部能力接起来的承载框架。**

---

## 四、谁不替代谁

### 1. Skill 不替代 MCP
Skill 不是标准协议层；MCP 也不是团队能力包。

### 2. MCP 不替代 Skill
即使某能力有 MCP 服务，也不等于它已经变成团队内部可治理、可复用、可维护的 Skill。

### 3. Runtime Pipeline 不替代 Skill
运行链路不能代替能力沉淀；否则所有能力都会重新散落回流程里。

### 4. Skill 不替代 Runtime Pipeline
即使 Skill 很强，也不能单独承担正式任务闭环的状态流转、交接与恢复。

### 5. Harness 不替代 Runtime Pipeline
Harness 是更大的承载框架，但不能因为有承载框架，就等于已经拥有清楚的内部推进链。

### 6. Runtime Pipeline 不替代 Harness
有推进链不等于已经有稳定宿主；Runtime Pipeline 通常只是 Harness 的内部组成，而不是完整承载框架本身。

### 7. MCP 不替代 Harness
MCP 是接口接入层，不等于实际运行承载结构。

### 8. Harness 不替代 Skill / MCP
Harness 连接能力，但不定义能力内容，也不定义接口标准。

---

## 五、当前系统里的最稳理解

如果只用一句话压住当前系统：

> **Skill 是能力包，MCP 是接口层，Harness 是承载框架，Runtime Pipeline 是 Harness 内部的推进链。**

再展开一点：

- 团队要把可长期复用的稳定能力，优先沉淀为 **Skill**  
- 外部能力或服务可以通过 **MCP** 方式接入或暴露  
- 正式任务闭环要在 **Harness** 内部，由 **Runtime Pipeline** 承担持续推进  
- Harness 再把内部推进链与外部能力接起来

---

## 六、对 Program 编写的直接约束

在后续 Program 编写中，至少应避免以下混写：

1. 不把 **Skill** 写成任务推进机制  
2. 不把 **MCP** 写成团队治理原则  
3. 不把 **Runtime Pipeline** 写成单个能力定义  
4. 不把 **Harness** 写成项目计划  
5. 不把这四者中的任何一个，误写成 Prompt

Program 层应负责说明：
- 它们在当前系统里如何配合
- 哪些任务依赖哪类承载
- 哪些能力应优先 skill 化
- 哪些接口通过 MCP 或其他方式接入
- 哪类正式闭环由 runtime pipeline + harness 承接

---

## 七、一句话结论

这四者不是同义词，也不是同层对象。

> **Skill 管能力，MCP 管接入，Harness 管承载框架，Runtime Pipeline 管 Harness 内部推进。**
