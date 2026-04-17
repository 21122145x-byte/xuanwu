# revision-needed-router｜SKILL 正文审查意见 v0.1

- 日期：2026-04-17
- 审查人：Anna
- 状态：completed
- 性质：正式 `SKILL.md` 正文审查意见
- 用途：对 `revision-needed-router` 的 `SKILL.md` 正文草案 v0.1 做首轮正文审查，只判断：复杂度红线是否真正写进正文、定位是否足够硬、是否保留复杂场景出口、以及当前是否接受进入可定版态。
- 版本目录：轻量治理线 / 当前阶段总收口_v0.1
- 所属层级：审计与回写
- 当前阶段：路径 2 / `revision-needed-router` 正文审查

---

## 一、审查对象

- `2026-04-17-revision-needed-router_SKILL正文草案_v0.1.md`

本轮只审第三张正文，不回第一张，不扩第二张。

---

## 二、审查问题

本轮只回答四件事：
1. 复杂度红线是否已经真正写进正文
2. “默认最近有效判断面 / 不默认上提 / 允许待人工确认”的定位是否足够硬
3. 是否仍保留复杂场景下的“建议 / 依据 / 待确认点”出口
4. 当前是接受进入可定版态，还是仍需修订

---

## 三、正文审查结论

### 结论 1：复杂度红线已经真正写进正文
**判断：成立。**

#### 证据
当前正文已经把关键复杂度红线直接写入：
- default to the nearest valid judgment surface
- do not escalate upward by default
- cross-layer rollback must allow human confirmation
- multi-branch or concurrent rollback must not be flattened into a fake single line
- concurrent review surfaces must not be treated as if the nearest valid surface were naturally unique
- after acceptance, route to the next effective action
- do not absorb other judgment layers

#### 审查判断
这些红线已经不只停在风险审查意见，而是进入了正式正文主结构。这个点成立。

---

### 结论 2：“默认最近有效判断面 / 不默认上提 / 允许待人工确认”的定位足够硬
**判断：成立。**

#### 证据
当前正文已经同时在以下层面把这条定位写硬：
- description
- what this skill does
- what this skill must not do
- hard boundaries
- working rule
- risk note

尤其是：
- 不默认上提
- 不假装最近有效判断面天然唯一
- 高复杂场景下允许 suggestion + evidence + pending confirmation points

#### 审查判断
目前第三张的核心定位已经足够硬，不再是提示语，而是正文级能力边界。

---

### 结论 3：复杂场景出口仍然保留
**判断：成立。**

#### 证据
正文保留了：
- `Human confirmation points`
- hard boundaries 中的：
  - complex scenes must allow outputs like suggestion, evidence, and pending confirmation points
- working rule 第 6 条：
  - If complexity is high, provide suggestion + evidence + pending confirmation points

#### 审查判断
这说明第三张没有被写成“复杂场景也必须给一条确定路线”的伪自动路由器，而仍保留了复杂度克制出口。

---

### 结论 4：接受进入可定版态
**判断：接受。**

#### 原因
当前第三张已经同时具备：
- 复杂度红线已进正文
- 最近有效判断面 / 不默认上提定位已写硬
- 保留复杂场景下的“建议 / 依据 / 待确认点”出口
- 已明确拒绝自动上提、伪单线、伪唯一判断面

也就是说，它当前已经不再停在：
- 只是风险识别对
- 只是边界工作面成立

而已经进入：
- 正式正文结构成立
- 且复杂度保险丝已经写进正文

因此我接受它进入：
> **可定版态（ready-to-stabilize）**

---

## 四、当前主要剩余风险

### 主风险
- 高复杂回退链样本仍不足

### 具体表现
后续仍需继续压测：
- 一个 `revision-needed` 同时牵动多个上位判断面
- 两条补件链并行推进但回审顺序不同
- accepted 与新的 `revision-needed` 在相邻节点交错出现

也就是说：
> **当前主风险已经从正文结构问题，转为复杂样本补强问题。**

---

## 五、正式口径

- **复杂度红线是否进正文**：是
- **核心定位是否足够硬**：是
- **是否保留复杂场景出口**：是
- **当前结论**：**接受进入可定版态**

---

## 六、一句话收口

> `revision-needed-router` 的正式 `SKILL.md` 正文草案已经把复杂度红线写进正文，也守住了“不默认上提、复杂场景允许待人工确认”的定位；
> 我现在接受其进入可定版态。

---

## 七、5 字段 handoff
- **Where**
  - `/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/轻量治理线/当前阶段总收口_v0.1/04-审计与回写/2026-04-17-revision-needed-router_SKILL正文审查意见_v0.1.md`
- **What**
  - 对第三张 `revision-needed-router` 的正式 `SKILL.md` 正文草案完成首轮正文审查，并给出“接受进入可定版态”的结论。
- **How to verify**
  - 检查文档是否明确回答：复杂度红线是否进正文、定位是否够硬、是否保留复杂场景出口、是否接受进入可定版态。
- **Known Issues**
  - 高复杂回退链样本仍不足，后续仍需继续补强复杂样本验证。
- **Next Steps**
  - 以“可定版态”继续收敛正文，并转向更复杂回退链样本补强。 
