# Anna 审计意见与下一步建议｜runtime assembly 第一轮并读总判断 v1

- 日期：2026-04-09
- 审计人：Anna
- 审计对象：
  - `/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/Runtime-Pipeline/01-Notes/2026-04-09-runtime-assembly-第一轮验收与总结复盘_v1.md`
  - `/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-09-玄武-runtime-assembly-第一轮总收口执行记录_交Anna_交Curie验收件_v1.md`
- 当前结论：**条件通过；第一轮可先收口，但必须按“最小闭环成立 + 3绿1黄”收口，且 Curie 需补第二轮生产目标与周期卡。**

## 文档挂载
- 上位文档：/Users/xiaojingbo/.openclaw/workspace-curie/knowledge_base/03-Notes/2026-04-07-OpenClaw-Runtime-Pipeline方案_compat-first工程推进版_v3.md
- 同级关联：/Users/xiaojingbo/.openclaw/workspace/knowledge-base/03-Notes/2026-04-07-Anna-审计意见与下一步建议_OpenClaw-Runtime-Pipeline-compat-first工程推进版-v3.md
- 下位文档：待补：Curie-runtime-assembly-第二轮生产目标与周期卡；待补：第二轮验收口径卡；待补：第一轮正式收口入口页
- 所属主线：OpenClaw Runtime Pipeline / runtime assembly 第一轮并读审计

---

## 一、总判断

**条件通过。**

当前将 Curie 侧复盘与玄武侧总收口执行记录并读后，可成立的最稳口径是：

> **runtime assembly 第一轮可以先收口。**
>
> **但这个收口只能按“最小闭环成立 + 3 绿 1 黄”收，不能写成“第一轮全绿完成”。**

两边材料并不冲突，而是层级不同：
- **玄武**交的是执行/实现层口径：第一轮最小闭环已成立
- **Curie**交的是验收/解释层口径：Step 1 未全过，Step 2 / 3 / 4 已过

这两条可以同时成立。

---

## 二、我认可的部分

### 1. 第一轮最小闭环成立
这一点从两边材料并读后可以成立。

当前已真实具备：
- `contextAssembly`
- `capabilitySurface`
- `requestParams`
- `runtimeAssembly`

且：
- `runtimeAssembly` 已进入最终成功返回块 `meta`
- Step 4 最后一格缺口已闭合

所以玄武这条可以成立：
> **第一轮最小闭环已完成。**

### 2. Step 2 / 3 / 4 已过
Curie 侧对 Step 2 / 3 / 4 的验收口径当前可接受。

当前没有足够证据支持把这三步拖回开放施工态，
也没有必要为了 Step 1 的残留返工整轮。

### 3. Step 1 未全过
这条也必须成立。

当前仍未被完全钉死的包括：
- `effective body` / `effectiveAgentBody` 等价解释位
- `sender` 统一解释面

所以 Curie 这句是对的：
> **Step 1 不是整步失效，而是未全过。**

### 4. 第一轮不应再膨胀补洞
两边都基本守住了这一条：
- 不把第一轮再拖回开放施工
- 不顺手把 timeout / incomplete / observability / governance 一次做厚

这条边界当前守得住。

---

## 三、当前要压住的边界

### 1. “最小闭环成立”不能被偷换成“第一轮全部通过”
这是当前最重要的口径风险。

后续正式流转时，必须明确区分：

#### 实现口径
> **第一轮最小闭环成立。**

#### 验收口径
> **第一轮验收颜色为 3 绿 1 黄，不是 4 绿。**

如果不区分这两层，后面一定会被写串。

### 2. Curie 当前的问题不在技术判断，而在生产计划缺失
这次并读后，我认为 Curie 当前最大的断点不是：
- 技术判断错了
- 验收方向错了

而是：
> **她没有把“第一轮收口后，第二轮要生产什么、周期多久、交什么件”压成生产计划。**

当前她写了：
- 下一轮只围绕 Step 1
- 不扩大
- 不返工 Step 2 / 3 / 4

但没写清：
- 第二轮到底生产什么稳定产物
- 周期是单日、两天、还是一个小阶段
- 完成后交什么正式件
- 哪些事项明确不进入本轮

这就是你会觉得“下一步动作没写清”的根因。

### 3. 玄武当前问题不大，主要缺口在 Curie 的收口位
玄武已经把：
- 接线完成事实
- 代码闭环事实
- 当前边界

交代得比较清楚。

当前真正需要补件的是 Curie：
> **把第二轮生产目标与周期写出来。**

---

## 四、正式审计结论

## 已成立
- 第一轮最小闭环成立
- Step 2 / 3 / 4 已过
- Step 1 未全过
- 第一轮可先收口
- 第一轮不应继续膨胀返工

## 仍未成立
- 第一轮全绿完成
- Step 1 已通过
- `effective body` 解释位已统一钉死
- sender 统一解释已完全收平
- 第二轮生产目标与周期已清楚

---

## 五、下一步建议

### 1. 第一轮正式收口，但统一用一句口径
建议后续统一写成：

> **runtime assembly 第一轮已完成最小闭环，可先收口；但验收颜色仍为 3 绿 1 黄，其中 Step 1 残留转入第二轮解释面补平项。**

不要再分散写成不同版本，避免下游偷换口径。

### 2. 要求 Curie 补一张《第二轮生产目标与周期卡》
这是当前最该补的件。

这张卡至少要写清 5 件事：
1. **第二轮目标**：只打 Step 1 的哪两个残留点
2. **第二轮产物**：做完后要交哪几份正式件
3. **第二轮周期**：单日 / 两天 / 本周内，何时回交验收
4. **第二轮不做事项**：哪些明确不进本轮
5. **下一阶段门槛**：什么情况下才能说 Step 1 全过 / 第一轮尾欠补平

### 3. 第二轮当前建议只打 Step 1
当前不建议同时打开：
- timeout / incomplete 旁支返回块
- 更大 observability 闭环
- 更大 runtime governance 扩写
- runtime meta / prompt 邻接的大范围扩写

当前建议：
> **第二轮只打 Step 1 残留解释面。**

### 4. 玄武后续进入第二轮时，只按 Curie 补清后的生产卡施工
也就是说：
- Curie 先补生产计划
- 玄武再按计划施工
- Anna 再按补件后的验收口径验收

不要再让施工位自己现场决定“下一轮到底做多大”。

---

## 六、一句话收口

> **当前并读后的总判断是：runtime assembly 第一轮可以正式收口，但只能按“最小闭环成立 + 3 绿 1 黄”收；玄武的问题不大，当前主要缺口在 Curie——她必须把第二轮到底生产什么、周期多久、交什么件，压成独立生产目标与周期卡。**

---

## 七、5 字段 handoff

- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-09-Anna-审计意见与下一步建议_runtime-assembly-第一轮并读总判断_v1.md`
- **What**
  - 将 Curie 侧第一轮复盘与玄武侧第一轮总收口执行记录并读后，形成 Anna 的统一审计判断，明确第一轮收口口径与 Curie 需补的第二轮生产计划缺口。
- **How to verify**
  - 检查文档是否明确：1）“最小闭环成立”与“3绿1黄”两层口径；2）玄武与 Curie 材料不冲突但层级不同；3）Curie 当前缺的是第二轮生产目标与周期卡。
- **Known Issues**
  - 当前仍无 Curie 明确的第二轮生产目标、周期、交付件定义；Step 1 的 `effective body` / sender 解释面也仍未全收平。
- **Next Steps**
  - 要求 Curie 补《第二轮生产目标与周期卡》；玄武后续按该卡施工；Anna 再做下一轮验收。
