# Harness 法位与治理-运行解耦说明
## v0.2 修订建议稿

- **状态**：draft  
- **性质**：结构说明 / 法位说明 / 解耦说明文档  
- **适用范围**：团队治理体系、runtime pipeline、gateway、ACP、外部 harness / runner、执行宿主环境之间的结构关系说明  
- **目的**：明确 Harness 的法位，解释为什么它不是 gateway 的附属补丁，也不是 workflow 的别名，而是治理体系与真实运行世界之间的外部运行承载框架抽象  
- **上位依据**：  
  - `README.md`  
  - `团队协作宪法与治理总纲.md`  
  - `Program-团队协作运行主协议.md`  
  - `Program与runtime-pipeline接口卡.md`  
  - `任务级Program文件规范卡.md`  
- **相关运行文档**：  
  - `/Users/xiaojingbo/.openclaw/workspace-fenxue/runtime/system/README.md`  
  - `/Users/xiaojingbo/.openclaw/workspace-fenxue/runtime/system/runtime-pipeline-overall-correction-v1.md`  
  - `/Users/xiaojingbo/.openclaw/workspace-fenxue/runtime/system/resident-executor-design-v1.md`  
  - `/Users/xiaojingbo/.openclaw/workspace-fenxue/runtime/system/checkpoint-runtime-protocol-v0.1.md`  
  - `/Users/xiaojingbo/.openclaw/workspace-fenxue/docs/network.md`  
  - `/Users/xiaojingbo/.openclaw/workspace-fenxue/docs/tools/acp-agents.md`  
  - `/Users/xiaojingbo/.openclaw/workspace-fenxue/docs/tools/lobster.md`

---

## 一、核心结论

Harness 的法位更准确应理解为：

> **治理视角下的外部运行承载框架抽象。**

它负责把内部治理体系定义出来的任务结构、运行要求与交接裁决口径，接到真实运行世界中去承载。

这里的“承载”不是指某一个现成单体模块，而是指一组需要被明确分层的外部运行要素，包括：
- 控制中枢
- 会话层
- 执行层
- 宿主环境

因此：
- **五层治理体系** 在内部  
- **Harness** 是外部运行承载框架的治理抽象  
- **runtime pipeline** 是 Harness 内部的推进 / 编排机制  
- **gateway** 是控制中枢与主要接入点之一，但不应继续独占运行宿主位

---

## 二、为什么必须提出 Harness

Harness 不是为了让结构更漂亮，而是为了解决已经真实发生过的问题。

### 现实依据 1：尝试将 ACP / Codex 拉到 gateway 外部运行
在试运行 runtime pipeline 时，曾尝试通过 ACP 拉起外部 Codex 运行。

虽然当时因 OpenClaw `v2026.4.15` 的 bug 未能成功拉起，但这次尝试已经说明：

- 真正的运行承载需求已经在逼系统走向 gateway 之外  
- gateway 不适合作为唯一执行宿主  
- 外部运行承载不是附加优化，而是必要方向

换句话说：

> **即使那次失败，行为本身已经证明“运行承载必须从 gateway 唯一宿主位解耦出来”这一判断。**

### 现实依据 2：长期生命 runtime keeper 试跑失败，仅存活约 5 分钟
富贵曾按之前轻治理 workflow 尝试生成一个长期生命的 runtime keeper，但结果失败，仅存活约 5 分钟。

这件事说明：

- workflow 可以组织任务  
- workflow 可以编排、转交、版本化  
- 但 workflow 不能承担长期生命运行体的宿主职责

换句话说：

> **workflow ≠ harness**  
> **治理编排 ≠ 运行承载**

这证明当前系统缺的不是更多 workflow，而是一个真正承接长期生命运行体的外部承载层。

---

## 三、当前已有 runtime 文档所暴露出的真实缺口

从已有 runtime pipeline 文档回读，问题已经非常一致：

### 1. `runtime-pipeline-overall-correction-v1.md` 的判断
这份文档已经明确指出：

- system side 的 detection / response-prep 已经成立  
- 真正断口在 assistant execution 常驻化  
- 当前系统是“可运行的半自动 runtime pipeline”，不是完全闭环的自动 runtime system

这意味着当前缺的不是继续加更多层，而是：

> **补出一个独立、可持续的运行承载位。**

### 2. `resident-executor-design-v1.md` 的方向
这份文档实际上已经在长出 Harness 执行承载层的早期形态：

- 单消费者约束  
- claim / lease / send / writeback  
- final-hop executor  
- queue / handoff / projection 分层

这已经不是单纯 workflow 文档，而是在定义：

> **一个独立的执行承载层应该如何存在。**

但这里需要压准：

> **resident executor 更像 Harness 执行承载层的早期形态或组成部分，不宜直接等同整个 Harness。**

### 3. `Program与runtime-pipeline接口卡.md` 的边界
该接口卡已经给出关键边界：

- Program 定义“怎么跑”  
- runtime pipeline 负责“让它真实跑起来”  
- 冲突必须回传，不能由实现层私自吞掉

这说明：

> **治理与运行本来就该通过薄接口连接，而不是相互吞并。**

---

## 四、Harness 不是谁

为了避免误解，先定义 Harness 不是什么。

### 1. Harness 不是 Charter
它不定义团队上位原则、边界与裁决精神。

### 2. Harness 不是 Program
它不定义默认运行主协议，也不决定任务如何进入闭环。

### 3. Harness 不是 Project Plan / SOP / Prompt
它不承担项目安排、动作做法或单轮执行指令。

### 4. Harness 不是 workflow
它不等于任务编排流程，更不等于轻治理线或版本卡。

### 5. Harness 不是 gateway
gateway 是控制中枢与主要接入点之一，但 Harness 不是 gateway 的别名，也不是 gateway 的附属补丁。

### 6. Harness 不是 runtime pipeline 本身
runtime pipeline 是 Harness 内部的推进 / 编排机制，不是整个承载框架的总称。

### 7. Harness 不是单一现成模块名
在当前 OpenClaw 本地 docs 语境里，更直接可见的是：
- Gateway
- ACP session
- acpx / adapter / harness runtime
- workflow runtime
- runtime host / workspace

因此，Harness 更适合被视为：

> **对这些外部运行承载要素进行治理抽象后的总称。**

---

## 五、Harness 是谁

Harness 更准确应定义为：

> **治理视角下的任务外部运行承载框架抽象。**

它负责回答：

1. 任务最终挂在哪个外部运行承载体系上  
2. 长期生命运行体靠什么持续存在  
3. runtime pipeline 在哪个承载框架内部推进  
4. 真实运行中的摩擦如何被显式回传到治理层

因此，Harness 的职责不是制定规则，而是：

> **承接规则，并让规则在真实运行世界里可持续存在。**

更细地说，它承接的不是一个点，而是至少四层：

1. **控制层**：如 gateway / session control plane  
2. **会话层**：如 ACP session / 原生 sub-agent session  
3. **执行层**：如 acpx / adapter / harness runtime / executor  
4. **宿主层**：如 runtime host / cwd / auth / workspace

---

## 六、内部治理体系与外部运行世界的关系

### 1. 五层治理体系在内部
五层治理体系负责定义内部治理结构：

- Charter：上位原则与边界  
- Program：默认运行主协议  
- Project Plan：本轮推进安排  
- SOP / Runbook / Checklist：动作规范  
- Prompt：单次执行壳

必要时，再由：
- `任务级Program文件规范卡.md`  
- 任务级 `program.md`

承接某个具体任务的独立闭环结构。

### 2. Harness 在外部
Harness 负责把内部治理定义好的结构接入真实运行世界。

但这里不应把 gateway / ACP / 外部 runner / host 简单压成同层并列，而应拆成：

- **gateway**：控制中枢与主要接入点之一  
- **ACP / 其他 session 机制**：会话控制层  
- **外部 runner / harness runtime / executor**：执行层  
- **runtime host / workspace / auth 环境**：宿主环境层

因此：

> **五层治理体系是内部治理结构，Harness 是外部运行承载框架的治理抽象。**

---

## 七、runtime pipeline 在这套结构里的法位

runtime pipeline 不应被理解成治理总纲，也不应被理解成与治理体系并列的总宿主。

它更准确的法位是：

> **Harness 内部的推进 / 编排机制。**

它主要负责：

- 状态推进  
- 派发与回收  
- 日志与轨迹  
- 阻塞记录与恢复点  
- 对治理结构的现实摩擦回传

它不负责：

- 发明 Charter 原则  
- 发明 Program 规则  
- 自行改写状态机口径  
- 静默吞掉治理与现实冲突  
- 冒充控制中枢或执行宿主

---

## 八、gateway 的正确法位

当前 OpenClaw 的结构性问题之一，是大量运行都压在 gateway 上。

这会导致：
- gateway 过重  
- 控制、接入、部分调度与部分执行宿主判断耦在一起  
- runtime pipeline 难以独立  
- 外部运行世界难以真正接入

因此，gateway 的正确法位应收敛为：

> **控制中枢与主要接入点之一。**

而不是：

> **唯一运行宿主。**

这意味着后续结构应默认：
- gateway 可以接任务  
- gateway 可以转发 / 编排 / 接入  
- gateway 持有 control plane  
- 但任务最终由哪个外部执行承载层与宿主环境承接，不应由 gateway 独占定义

---

## 九、推荐的整体结构

推荐结构如下：

```text
[内部治理层]
README
Charter
Program
Project Plan
SOP / Prompt
task-level program.md

        ↓ 定义最小运行要求

[治理-运行接口层]
Program与runtime-pipeline接口卡
任务级 program.md 中的状态 / 角色 / 交接映射

        ↓ 接入

[外部运行承载抽象]
Harness
  ├─ control layer
  │   └─ gateway / session control plane
  ├─ session layer
  │   └─ ACP / sub-agent / other session binding
  ├─ execution layer
  │   └─ acpx / adapter / harness runtime / executor
  ├─ host layer
  │   └─ runtime host / workspace / cwd / auth
  └─ runtime pipeline
      ├─ 状态推进
      ├─ 派发回收
      ├─ 日志轨迹
      ├─ 阻塞恢复
      └─ 摩擦回传
```

这张图要表达的是：

- Harness 不是单层实体，而是外部运行承载体系的治理抽象  
- runtime pipeline 属于 Harness 内部  
- gateway 属于 control layer，不等于整个 Harness  
- executor / runner / host 也不能被压扁成“接入点”同义词

---

## 十、为什么这种解耦是必要的

### 1. 防止治理被 gateway 反向定义
如果所有运行最终都只能挂 gateway，那么治理层的很多设计最后都会被压回“gateway 现在能不能这么跑”。

这会让治理失去独立性。

### 2. 防止 workflow 假装自己是宿主
workflow 可以编排，但不能养活长期生命运行体。

如果不引入 Harness，系统会反复误把编排层当承载层。

### 3. 防止 runtime pipeline 被误认成对外总层
runtime pipeline 负责推进，不负责定义整体治理结构与外部承载法位。

### 4. 为长期生命运行体预留宿主
长期生命 keeper、resident executor、外部 Codex / ACP runner 等，都需要一个真正的承载层，而不是临时寄生在主会话或 gateway 上。

### 5. 防止控制层、执行层、宿主层被压扁成一层
如果 gateway / ACP / runner / host 不分层，后续所有法位讨论都会不断混淆“谁负责路由、谁负责会话、谁负责执行、谁负责宿主”。

---

## 十一、设计约束

若后续继续沿 Harness 方向推进，至少应坚持以下约束：

### 1. 治理规则不硬编码进 Harness
Harness 承接规则，不私自改写规则。

### 2. runtime pipeline 只作为 Harness 内部推进链
不把它上升成对外总纲，也不让它替代治理体系。

### 3. gateway 是控制中枢，不等于唯一宿主
不再默认 gateway = 整个运行承载层。

### 4. 冲突必须回传
当运行现实与治理结构冲突时，应回传 Program / Charter 修订链，而不是由实现层静默吞掉。

### 5. workflow 不承担宿主职责
workflow 可组织任务，不承担长期生命运行体的承载责任。

### 6. 会话层、执行层、宿主层必须分层表达
不要把 ACP、runner、workspace、host 混写成同一层。

---

## 十二、对后续推进的直接启示

如果继续推进 runtime 线，主增量不应再是继续堆更多 workflow 或补更多治理材料，而应集中回答：

1. Harness 的最小宿主形态是什么  
2. resident executor 是否是 Harness 执行承载层的早期形态  
3. gateway 之外如何稳定挂载长期生命运行体  
4. runtime pipeline 如何在 Harness 内部保持可替换、可恢复、可审计  
5. ACP / native sub-agent / other runner 如何进入同一承载分层图，而不是彼此互相冒名

---

## 十三、一句话结论

> **五层治理体系负责定义任务与协作的内部治理结构；Harness 负责作为治理视角下的外部运行承载框架抽象，把这些结构接到真实运行世界；runtime pipeline 是 Harness 内部的推进机制；gateway 是控制中枢与主要接入点之一，不应继续独占运行宿主位。**
