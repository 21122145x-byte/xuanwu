# 玄武 Step 2 实施记录｜runtime assembly capability surface v1

- 日期：2026-04-09
- 执行对象：玄武
- 性质：实施记录 / 入口判断 / 后续持续更新宿主
- 所属主线：Runtime Pipeline / runtime assembly 第一轮
- 对应阶段：Step 2 `capability-surface`
- 当前状态：第一刀已实施，并通过最小复验
- 上位文档：
  - `/Users/xiaojingbo/.openclaw/workspace/shaun-wiki/91-Curie-Knowledge-Base/Runtime-Pipeline/01-Notes/2026-04-09-runtime-assembly-第一轮施工说明交接文档_v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/Runtime-Pipeline/01-Notes/2026-04-09-runtime-assembly-Step2-行动卡_v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-玄武实施入口判断_runtime-assembly-第一轮_v1.md`
- 关联前序：
  - `/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-玄武-Step1实施记录_runtime-assembly-context-assembly_v1.md`

---

## 一、当前阶段说明
这份文档当前仍不是 Step 2 的完工记录，
但已经从“纯入口判断”推进到：
> **入口判断已落 + 第一刀最小宿主已实施 + 最小复验已完成。**

当前本文既记录：
- Step 2 的正式主输入源判断
- 不建议误选点
- 第一刀最稳新增落点

也开始记录：
- 实际新增文件
- 最小测试
- 最小类型校验
- 当前边界与已知问题

---

## 二、Step 2 当前目标
根据 Curie 交接文档与行动卡，Step 2 当前目标不是进入 tool execution 主链，
而是先收回 capability 面解释权：

### 本步完成后应能回答
1. 当前能力面有哪些项
2. 哪些是 `available / limited / deferred`
3. 模型理论上看见的能力面是什么

### 本步执行纪律
- 本轮只收 capability 输入解释权
- 不顺手进入 tool execution 主链
- 不顺手扩 provider compat / request shaping / governance
- 如果来源分叉太多，优先收主来源，旁支记录后停止

---

## 三、入口判断结果（当前）

### 1. 当前最像正式主输入源的宿主
**判定：**
- `src/plugins/capability-provider-runtime.ts`

**当前最核心函数：**
- `resolvePluginCapabilityProviders(...)`

### 判断理由
1. 它是当前插件能力提供者解析的统一宿主
2. 多类 capability provider registry 都在复用它
3. 它更接近 capability source 本体，而不是某类单能力分支的消费点
4. 用它作为 Step 2 的主输入源，更符合“先收 capability 输入解释权”的边界

一句话收口：
> **Step 2 的第一刀更应围绕 `resolvePluginCapabilityProviders(...)` 做统一 surface 包装，而不是围绕某个单项 provider registry 或工具细节做 patch。**

---

## 四、当前已识别的分支消费面
以下文件当前已识别为 capability source 的分支消费面，而不是 Step 2 第一刀主宿主：

- `src/media-understanding/provider-registry.ts`
- `src/tts/provider-registry.ts`
- `src/image-generation/provider-registry.ts`
- `src/video-generation/provider-registry.ts`
- `src/realtime-voice/provider-registry.ts`
- `src/realtime-transcription/provider-registry.ts`
- `src/plugins/memory-embedding-provider-runtime.ts`

### 当前判断
这些文件说明：
- `resolvePluginCapabilityProviders(...)` 已经是多类能力分支的共用来源
- `provider-registry.ts` 们更像 capability 的下游消费层
- 不应误判为 Step 2 的第一刀主输入宿主

---

## 五、当前不建议误选的点

### 1. 各类 `provider-registry.ts`
**原因：**
- 这些是单能力分支消费面
- 不是 capability surface 总装配宿主

### 2. tool / schema / provider compat 细部函数
例如：
- `resolveToolCallArgumentsEncoding`
- `normalizeProviderToolSchemasWithPlugin`
- `supportsModelTools`
- `createOpenClawCodingTools`
- `collectAllowedToolNames`

**原因：**
- 它们更接近 tool execution / provider compat / request shaping
- 一旦从这里切，容易顺手滑进 Step 3 或 tool governance

### 3. `toolsAllow` / cron payload 一类约束入口
**原因：**
- 这些属于 capability 裁剪 / 约束层
- 不是 capability source 本体

一句话：
> **Step 2 不应从“能力怎么被裁剪 / 怎么被编码 / 怎么被执行”开始，而应先从“能力从哪里被解析出来”开始。**

---

## 六、当前最稳的最小落点
### 新增宿主（建议）
- `src/runtime/capability-surface.ts`

### 当前最稳的第一刀
由 `capability-surface.ts` 去做：
- 包装 / 汇总 `resolvePluginCapabilityProviders(...)`
- 再把 capability 输入解释成统一 `CapabilitySurface`

### 当前后续风险（新增）
当前入口判断虽然已经把第一刀压对到了：
- `resolvePluginCapabilityProviders(...)`

但后续实施仍有一个需要显式防守的误滑：

> **把 Step 2 做成“provider capability source 汇总”，而不是“模型理论上看见的 capability surface 解释”。**

这两者不是一回事。

#### 当前风险点
- `resolvePluginCapabilityProviders(...)` 解决的是 capability provider source
- 但 Step 2 的交付目标不是把 provider source 罗列出来
- Step 2 真正要交付的是：
  - `CapabilitySurfaceItem`
  - `availability`（如 `available / limited / deferred`）
  - 模型理论可见能力面

也就是说，中间还差一层明确的：
> **surface translation**

#### 当前约束口径
因此后续实施时必须明确区分两层：
1. **source layer**
   - provider / plugin capability source 从哪来
2. **surface layer**
   - 模型理论上看见的能力项是什么
   - 这些能力项当前是 `available / limited / deferred` 中的哪一种

#### 玄武执行提醒
后续如果开始写 `src/runtime/capability-surface.ts`，不能停在：
- “把 `resolvePluginCapabilityProviders(...)` 的结果返回出去”

而必须再往前压一层，至少把它翻译成：
- capability item
- source
- availability
- 面向模型的可见解释

一句话收口：
> **Step 2 的第一刀可以从 provider capability source 起，但第一轮成立标准不是“source 被汇总了”，而是“source 已被翻译成模型理论可见的 capability surface”。**

### 当前不建议
- 直接改造 `capability-provider-runtime.ts` 成新的总装配层
- 直接在单类 `provider-registry.ts` 上做 capability surface
- 直接进入 tools / providers / schemas 的深层消费逻辑

---

## 七、当前备选点
### 备选 1：`src/agents/pi-tools.ts`
**性质：** tool inventory / effective tools 更靠近“模型能看见什么工具”

**为什么不是当前第一刀：**
- 太容易把 Step 2 误做成 tool execution / tool inventory patch
- 会把 capability surface 与 tool surface 混案

### 备选 2：`src/agents/channel-tools.ts`
**性质：** channel-specific message tool capabilities 的消费层

**为什么不是当前第一刀：**
- 过于 channel-specific
- 不具备 capability surface 主入口普适性

### 备选 3：各类 `provider-registry.ts`
**性质：** 单能力分支 registry

**为什么不是当前第一刀：**
- 只能解释某一类能力，不足以承接 Step 2 的统一 surface

---

## 八、当前最小结论
截至当前，玄武对 Step 2 的最稳判断是：

> **Step 2 capability surface 的正式主输入源，应先判定为 `src/plugins/capability-provider-runtime.ts` 的 `resolvePluginCapabilityProviders(...)`；第一轮最稳新增落点应为 `src/runtime/capability-surface.ts`，由其对 capability source 做统一解释包装，而不是直接从单类 provider registry、tool inventory、或 execution/compat 细部切入。**

---

## 九、当前已实施的第一刀（新增）
### 1. 已新增最小宿主
已在源码仓新增：
- `src/runtime/capability-surface.ts`
- `src/runtime/capability-surface.test.ts`

### 2. 当前第一刀做了什么
当前最小宿主已完成：
- 以 `resolvePluginCapabilityProviders(...)` 作为 source layer 输入
- 做最小的 `source -> surface translation`
- 输出最小 `CapabilitySurface` / `CapabilitySurfaceItem`

当前最小 item 已包含：
- `key`
- `kind`
- `source`
- `providerCount`
- `availability`
- `modelVisible`

### 3. 当前复验结果
已完成：
- 新增测试：`src/runtime/capability-surface.test.ts`
- 全量类型检查：`tsc -p tsconfig.json --noEmit`

复验口径：
- 新增测试退出码：`0`
- 全量类型检查退出码：`0`

当前可以成立为：
> **Step 2 第一刀最小宿主已落地，并通过最小测试与全量类型检查。**

### 4. 当前新增接线（补记）
已在：
- `src/agents/pi-embedded-runner/run/attempt.ts`

完成 Step 2 的下一小步：
- 在 pre-session assembly band 读取 `buildCapabilitySurface(...)`
- 将其翻译为最小 runtime capability labels
- 并入 `runtimeCapabilities`

当前口径：
> **Step 2 已从“仅有 capability-surface 宿主”推进到“最小挂点已接入 run/attempt.ts 邻接区”，但仍未进入 execution 主链深处，也未触碰 Step 3。**

### 5. 当前最小可见消费验证（新增）
在保持边界不扩张的前提下，本轮又补了一层最小可见消费：

#### 已在：
- `src/agents/pi-embedded-runner/run/attempt.ts`
- `src/agents/pi-embedded-runner/run.ts`
- `src/agents/pi-embedded-runner/types.ts`
- `src/agents/pi-embedded-runner/run/types.ts`

#### 当前新增内容
- `attempt.ts` 会将 `capabilitySurface` 带出到 attempt result
- `run.ts` 成功路径 `agentMeta` 会并入 `capabilitySurface` 的最小摘要

当前最小摘要包含：
- `present`
- `totalItems`
- `availableCount`
- `limitedCount`
- `deferredCount`

#### 当前边界
- 未把 `capabilitySurface` 并入 `systemPromptReport`
- 未扩写 broader report / observability
- 未进入 Step 3 request shaping

当前可以成立为：
> **Step 2 已从“最小挂点接线”推进到“runtime meta 邻接解释”，即 capability surface 的最小摘要已进入成功路径 `agentMeta`。**

### 6. 当前 prompt 邻接解释（新增）
在保持 Step 2 边界不滑入 Step 3 的前提下，本轮继续补了一层更明确的 prompt 邻接解释：

#### 已在：
- `src/config/sessions/types.ts`
- `src/agents/system-prompt-report.ts`
- `src/agents/pi-embedded-runner/run/attempt.ts`

#### 当前新增内容
- `SessionSystemPromptReport` 新增可选 `capabilitySurface` 摘要位
- `buildSystemPromptReport(...)` 现在可接收 `capabilitySurface` 并输出最小统计
- `attempt.ts` 已把现有 `capabilitySurface` 带入 `buildSystemPromptReport(...)`

当前 prompt 邻接摘要仅包含：
- `totalItems`
- `availableCount`
- `limitedCount`
- `deferredCount`

#### 当前边界
- 仍未进入 request shaping
- 仍未扩 broader observability / governance
- 仍未把 Step 2 做成 Step 3 的提前并线

当前可以成立为：
> **Step 2 已从“runtime meta 邻接解释”继续推进到“prompt 邻接解释”，即 capability surface 的最小摘要已进入 `systemPromptReport`。**

### 7. 当前主链消费闭环验证（新增）
在已形成 runtime meta + prompt 邻接解释的基础上，本轮继续补了一层最小闭环验证：

#### 已在：
- `src/agents/pi-embedded-runner/run/helpers.ts`
- `src/agents/pi-embedded-runner/run.ts`
- `src/agents/pi-embedded-runner/run/helpers.test.ts`
- `src/agents/system-prompt-report.test.ts`

#### 当前新增内容
- 新增 `buildCapabilitySurfaceAgentMeta(...)`
  - 统一收口 run meta 侧的 capability surface 摘要逻辑
- `run.ts` 成功路径改为通过 helper 生成 `agentMeta.capabilitySurface`
- `system-prompt-report.test.ts` 已补 capability surface 摘要校验
- 新增 `run/helpers.test.ts`，校验 run meta 摘要统计

#### 当前验证结果
- focused tests 退出码：`0`
- 全量类型检查退出码：`0`

#### 当前边界
- 仍未进入 Step 3
- 仍未扩 broader runtime governance / observability
- 当前只是在 Step 2 内把 source → surface → attempt 接线 → runtime meta / prompt report 摘要 的最小闭环验证补齐

当前可以成立为：
> **Step 2 已具备最小主链消费闭环验证：run meta 摘要与 prompt report 摘要都已有对应实现与 focused tests 支撑。**

### 8. Curie 三项必补项推进结果（新增）
在 Curie 的 Step 2 审阅合并件指出 3 个工程性必补项后，玄武已按最小单元逐个推进：

#### 必补项 A｜capability item 精度
本轮已推进一刀：
- `CapabilitySurfaceItem` 不再只停在粗 `kind`
- 新增更贴近模型理论可见面的 `item` 字段
- `runtime labels` 现改按 `item` 输出，而不再只按粗类别输出

当前口径：
> **item 精度已从“粗能力族”向“理论可见能力项”推进一层。**

#### 必补项 B｜`limited` 语义
本轮已落地：
- `CapabilitySurfaceInput` 新增 `availabilityOverrides`
- `buildCapabilitySurface(...)` 现在可显式把已存在 provider 的能力项标成 `limited`
- 已补 focused test，验证：
  - provider 存在
  - availability 可为 `limited`
  - runtime label 也会相应变为 `capability:<item>=limited`

当前口径：
> **`limited` 已不再只是占位词，而是具备显式输入与可验证输出的真语义。**

#### 必补项 C｜`modelVisible` 强度
本轮已落地：
- `CapabilitySurfaceInput` 新增 `modelVisibleOverrides`
- `modelVisible` 不再只等于 `providerCount > 0`
- 当前规则为：
  - 有 override → 以 override 为准
  - 无 override → 以 `availability !== "deferred"` 为默认可见性
- 已补 focused test，验证：
  - capability 可以 `available`
  - 但 `modelVisible = false`

当前口径：
> **`modelVisible` 已不再只是 source/provider 存在性的弱代理，而具备独立可控的可见性判断入口。**

#### 当前验证结果
- `capability-surface` focused tests：通过
- 全量类型检查：通过

一句话收口：
> **Curie 指出的 3 个工程性必补项，当前都已按最小单元推进，并完成最小复验。**

## 十、当前还没做什么
- 尚未把 Step 2 接到 `runEmbeddedPiAgent` 主链
- 尚未形成更完整的 capability source 到 runtime 主消费点的接线闭环
- 尚未输出 Step 2 的 before / after 主链验证结果
- 尚未进入 Step 2 的后续更细 capability item 解释扩充

所以当前文档应写成：
> **Step 2 入口判断已成立；第一刀最小宿主已实施并通过最小复验；其最小挂点已接入 `run/attempt.ts` 的 pre-session assembly band，且最小摘要已进入成功路径 `agentMeta` 与 `systemPromptReport`；最小主链消费闭环验证已补齐；Curie 指出的 3 个工程性必补项也已按最小单元推进并完成复验；后续更深主链接线仍未开始。**

---

## 十、后续更新规则
若继续推进 Step 2，后续在本文继续补：
1. 实际改动落点
2. 最小 export / schema
3. 最小验证结果
4. 已知问题
5. 与 Curie 行动卡的偏差说明

---

## 十一、5 字段 handoff
- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-玄武-Step2实施记录_runtime-assembly-context-assembly_v1.md`
- **What**
  - 作为 Step 2 capability surface 的实施记录宿主，当前先记录入口判断：正式主输入源、分支消费面、不建议误选点与最小新增落点。
- **How to verify**
  - 检查文档是否明确：Step 2 为什么先从 `resolvePluginCapabilityProviders(...)` 开始、为什么不从 `provider-registry.ts` / `pi-tools.ts` / execution 细部开始、以及为什么建议新增 `src/runtime/capability-surface.ts`。
- **Known Issues**
  - 当前仅完成入口判断，尚未开始 Step 2 代码实施。
  - 后续实施存在一个关键误滑风险：可能停在 `provider capability source` 汇总，而没有完成到“模型理论可见 capability surface”的翻译层。
- **Next Steps**
  - 在守住边界的前提下，若继续推进 Step 2，则应在当前已形成的最小闭环验证与 A/B/C 必补项补齐基础上，判断是否还需要补更强的主链消费证据，或停止在此并准备进入 Step 3。


## 十一、主消费点与接线路径判断（新增）
### 1. 当前最像主消费点的宿主
**判定：**
- `src/agents/pi-embedded-runner/run/attempt.ts`

### 当前判断理由
Step 2 的 capability surface 虽然其 source layer 起点在：
- `src/plugins/capability-provider-runtime.ts`
- `resolvePluginCapabilityProviders(...)`

但真正更接近“模型理论上看见的能力面”的消费侧，不是 source registry 本身，
而是 embedded run attempt 中围绕以下几类逻辑形成的能力材料化链：
- tool materialization
- builtIn/custom tools 组装
- provider tool schema / compat 处理
- system prompt / tool visibility 邻接面
- `createAgentSession(...)` 前的有效能力输入面

也就是说：
> **Step 2 的 source 宿主与消费宿主不是同一个点。**

source layer：
- `resolvePluginCapabilityProviders(...)`

当前更像主消费点的宿主：
- `src/agents/pi-embedded-runner/run/attempt.ts`

---

### 2. 当前最稳接线路径
玄武当前判断，Step 2 后续最稳的接线路径应写成：

1. `src/runtime/capability-surface.ts`
   - 负责把 `resolvePluginCapabilityProviders(...)` 产出的 source layer 翻译成最小 `CapabilitySurface`
2. `src/agents/pi-embedded-runner/run/attempt.ts`
   - 作为当前更像 runtime 主消费点的宿主
   - 在 tool materialization / session create 邻接区读取 `CapabilitySurface`
3. 暂不深入 execution 主链
   - 不顺手进入 tool execution lifecycle
   - 不顺手扩到 request shaping / Step 3

一句话：
> **Step 2 不应停在 `capability-provider-runtime.ts`，而应由 `capability-surface.ts` 完成 source → surface 翻译，再把 surface 接到 `run/attempt.ts` 这类更接近“模型实际看见能力面”的消费宿主。**

---

### 3. 当前不建议误选的主消费点
#### 不建议误选 1：`src/plugins/capability-provider-runtime.ts`
**原因：**
- 它是 source layer
- 不是模型理论可见 capability surface 的主消费宿主

#### 不建议误选 2：`src/agents/pi-tools.ts`
**原因：**
- 太容易把 Step 2 误做成 tool inventory / execution patch
- capability surface 与 effective tool surface 不能直接混案

#### 不建议误选 3：`src/agents/channel-tools.ts`
**原因：**
- 过于 channel-specific
- 只能解释某类 message tool capability，不足以承接统一 surface

---

### 4. 当前最小结论更新
截至当前，Step 2 应区分两层：
- **主输入源**：`resolvePluginCapabilityProviders(...)`
- **主消费点**：`src/agents/pi-embedded-runner/run/attempt.ts` 邻接的 capability materialization 区

因此 Step 2 的下一小步，不应再是继续扩大 source registry，
而应是：
> **判断 `CapabilitySurface` 在 `run/attempt.ts` 中最小应该挂到哪一段邻接区，才能既被主链看见，又不滑入 tool execution / request shaping。**



## 十二、最小挂点判断（新增）
### 1. 当前最稳的最小挂点
当前判断，`CapabilitySurface` 在 `run/attempt.ts` 中最稳的最小挂点，不应落在：
- source registry 本身
- `createAgentSession(...)` 之后的执行期
- tool execution / provider compat 深层细部

而应落在：
> **tool materialization / tool visibility / system prompt 邻接区形成的 pre-session assembly band**

### 2. 为什么是这里
因为 Step 2 当前要交付的是：
- 模型理论上看见的 capability surface

而不是：
- provider capability source 本身
- tool execution lifecycle
- provider request shaping 参数

因此当前最稳挂点必须同时满足两件事：
1. 已离开 source layer
   - 不能还停在 `resolvePluginCapabilityProviders(...)`
2. 还没掉进 execution / request 深层
   - 不能已经进入 `createAgentSession(...)` 之后的 runtime 执行期

### 3. 当前不建议挂的点
#### 不建议 1：`capability-provider-runtime.ts`
- 原因：过早，仍是 source layer

#### 不建议 2：`createAgentSession(...)` 之后
- 原因：过晚，已进入 session/runtime 执行态

#### 不建议 3：`pi-tools.ts` / `channel-tools.ts` / provider compat 细部
- 原因：过偏，容易把 Step 2 混成 tool inventory / execution / compat patch

### 4. 当前接线路径更新
因此当前最稳的 Step 2 接线路径应写成：
1. `src/runtime/capability-surface.ts`
   - 负责 source → surface translation
2. `src/agents/pi-embedded-runner/run/attempt.ts`
   - 在 pre-session assembly band 读取 `CapabilitySurface`
3. 暂不继续深入 execution / request shaping
   - 不顺手进入 tool lifecycle
   - 不顺手进入 Step 3

### 5. 一句话收口
> **Step 2 的最小挂点，应判在 `run/attempt.ts` 中“tool materialization / tool visibility / system prompt 邻接区”的 pre-session assembly band，而不是 source registry 本身，也不是 `createAgentSession()` 之后的执行期。**

