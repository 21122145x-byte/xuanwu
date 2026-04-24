# Harness 法位与治理-运行解耦说明
## v0.1

- **状态**：draft  
- **性质**：结构说明 / 法位说明 / 解耦说明文档  
- **适用范围**：团队治理体系、runtime pipeline、gateway、外部运行承载框架之间的结构关系说明  
- **目的**：明确 Harness 的法位，解释为什么它不是 gateway 的附属补丁，也不是 workflow 的别名，而是治理体系与真实运行世界之间的承载框架  
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

---

## 一、核心结论

Harness 的法位应理解为：

> **外部运行承载框架。**

它负责把内部治理体系定义出来的任务结构、运行要求与交接裁决口径，接到真实运行世界中去承载。

因此：
- **五层治理体系** 在内部  
- **Harness** 在外部  
- **runtime pipeline** 是 Harness 内部的推进机制  
- **gateway** 只是接入点之一，不应继续独占运行宿主位

---

## 二、为什么必须提出 Harness

Harness 不是为了让结构更漂亮，而是为了解决已经真实发生过的问题。

### 现实依据 1：尝试将 ACP / Codex 拉到 gateway 外部运行
在试运行 runtime pipeline 时，曾尝试通过 ACP 拉起外部 Codex 运行。

虽然当时因 OpenClaw `v2026.4.15` 的 bug 未能成功拉起，但这次尝试已经说明：

- 真正的运行承载需求已经在逼系统走向 gateway 外部  
- gateway 不适合作为唯一运行宿主  
- 外部运行承载不是附加优化，而是必要方向

换句话说：

> **即使那次失败，行为本身已经证明“运行承载必须解耦出 gateway”这一判断。**

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
这份文档实际上已经在长出 Harness 的早期形态：

- 单消费者约束  
- claim / lease / send / writeback  
- final-hop executor  
- queue / handoff / projection 分层

这已经不是单纯 workflow 文档，而是在定义：

> **一个独立的运行承载框架应该如何存在。**

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
gateway 是接入点之一，但 Harness 不是 gateway 的别名或附属补丁。

### 6. Harness 不是 runtime pipeline 本身
runtime pipeline 是 Harness 内部的推进机制，不是整个承载框架的总称。

---

## 五、Harness 是谁

Harness 应定义为：

> **任务运行承载框架。**

它负责回答：

1. 任务最终挂在哪个外部运行宿主上  
2. 长期生命运行体靠什么持续存在  
3. runtime pipeline 在哪个承载框架内部推进  
4. 真实运行中的摩擦如何被显式回传到治理层

因此，Harness 的职责不是制定规则，而是：

> **承接规则，并让规则在真实运行世界里可持续存在。**

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
Harness 负责把内部治理定义好的结构接入真实运行世界：

- session / ACP / gateway / 外部 runner / 其他执行环境  
- 长期生命运行体  
- 持续消费 job 的执行位  
- 日志、恢复点、状态推进、摩擦暴露

因此：

> **五层治理体系是内部治理结构，Harness 是外部运行承载框架。**

---

## 七、runtime pipeline 在这套结构里的法位

runtime pipeline 不应被理解成治理总纲，也不应被理解成与治理体系并列的总宿主。

它更准确的法位是：

> **Harness 内部的推进机制。**

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

---

## 八、gateway 的正确法位

当前 OpenClaw 的结构性问题之一，是大量运行都压在 gateway 上。

这会导致：
- gateway 过重  
- 运行承载、调度、接入、部分治理判断耦在一起  
- runtime pipeline 难以独立  
- 外部运行世界难以真正接入

因此，gateway 的正确法位应收敛为：

> **接入点之一。**

而不是：

> **唯一运行宿主。**

这意味着后续结构应默认：
- gateway 可以接任务  
- gateway 可以转发 / 编排 / 接入  
- 但任务最终由哪个 Harness 承载，不应由 gateway 独占决定

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

[外部承载层]
Harness
  └─ runtime pipeline
      ├─ 状态推进
      ├─ 派发回收
      ├─ 日志轨迹
      ├─ 阻塞恢复
      └─ 摩擦回传

        ↓ 通过 gateway / ACP / 外部 runner / 其他执行壳接入真实世界

[接入点]
Gateway / ACP / 外部 runner / 其他执行环境
```

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

---

## 十一、设计约束

若后续继续沿 Harness 方向推进，至少应坚持以下约束：

### 1. 治理规则不硬编码进 Harness
Harness 承接规则，不私自改写规则。

### 2. runtime pipeline 只作为 Harness 内部推进链
不把它上升成对外总纲，也不让它替代治理体系。

### 3. gateway 只作为接入点之一
不再默认等于唯一宿主。

### 4. 冲突必须回传
当运行现实与治理结构冲突时，应回传 Program / Charter 修订链，而不是由实现层静默吞掉。

### 5. workflow 不承担宿主职责
workflow 可组织任务，不承担长期生命运行体的承载责任。

---

## 十二、对后续推进的直接启示

如果继续推进 runtime 线，主增量不应再是继续堆更多 workflow 或补更多治理材料，而应集中回答：

1. Harness 的最小宿主形态是什么  
2. resident executor 是否就是当前 Harness 的早期形态  
3. gateway 之外如何稳定挂载长期生命运行体  
4. runtime pipeline 如何在 Harness 内部保持可替换、可恢复、可审计

---

## 十三、一句话结论

> **五层治理体系负责定义任务与协作的内部治理结构；Harness 负责把这些结构接到外部运行世界；runtime pipeline 是 Harness 内部的推进机制；gateway 只是接入点之一，不应继续独占运行宿主位。**
