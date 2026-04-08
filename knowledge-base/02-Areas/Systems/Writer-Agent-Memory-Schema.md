# Writer-Agent Memory Schema v1

## 目标

定义 Writer-Agent 在 MemOS 中使用的最小记忆单元结构，支持：
- 分层记忆
- 精准召回
- 反馈回写
- 生命周期管理

---

## 一、Memory Object 标准字段

每条记忆至少包含以下字段：

- `id`
- `type`
- `scope`
- `topic`
- `content`
- `source`
- `confidence`
- `lifecycle`
- `retrieval_trigger`
- `project`
- `updated_at`
- `last_verified`

---

## 二、字段定义

### `id`
唯一标识。

### `type`
可选值：
- `identity`
- `project`
- `task`
- `learning`
- `feedback`

### `scope`
可选值：
- `global`
- `project`
- `chapter`
- `draft`
- `session`

### `topic`
主题标签，建议使用固定短词：
- `opening`
- `character_intro`
- `pace`
- `exposition`
- `revision`
- `hook`
- `dialogue`
- `worldbuilding`

### `content`
真正被召回的内容，必须是可执行描述，不写空话。

### `source`
来源说明，建议固定写法：
- `user_confirmed`
- `project_doc`
- `feedback_review`
- `blind_test`
- `self_review`
- `handoff`

### `confidence`
可选值：
- `high`
- `medium`
- `low`

### `lifecycle`
可选值：
- `permanent`
- `project_only`
- `temporary`
- `decay`

### `retrieval_trigger`
触发召回的任务类型或场景，建议使用数组：
- `write_opening`
- `write_scene`
- `outline_chapter`
- `revise_draft`
- `pre_review`
- `post_feedback`
- `switch_project`

### `project`
项目名；非项目记忆可为空。

### `updated_at`
最后更新时间。

### `last_verified`
最近一次被验证有效的时间。

---

## 三、五类记忆对象

## 1. Identity Memory

### 用途
存稳定创作人格与长期偏好。

### 示例
```json
{
  "id": "identity-opening-001",
  "type": "identity",
  "scope": "global",
  "topic": "opening",
  "content": "开头优先给人物压力，不先堆世界设定。",
  "source": "user_confirmed",
  "confidence": "high",
  "lifecycle": "permanent",
  "retrieval_trigger": ["write_opening", "revise_draft"],
  "project": "",
  "updated_at": "2026-03-18",
  "last_verified": "2026-03-18"
}
```

---

## 2. Project Memory

### 用途
存当前项目中的设定事实、人物边界、结构状态。

### 示例
```json
{
  "id": "saltfire-lizhao-intro-001",
  "type": "project",
  "scope": "project",
  "topic": "character_intro",
  "content": "黎照第一次出场必须先作为低位高敏岗位中的人出现，而不是功能性设定载体。",
  "source": "project_doc",
  "confidence": "high",
  "lifecycle": "project_only",
  "retrieval_trigger": ["write_opening", "write_scene", "revise_draft"],
  "project": "SaltFire-Project",
  "updated_at": "2026-03-18",
  "last_verified": "2026-03-18"
}
```

---

## 3. Task Memory

### 用途
存本轮任务目标与临时约束。

### 示例
```json
{
  "id": "task-outline-ch2-001",
  "type": "task",
  "scope": "session",
  "topic": "outline",
  "content": "当前任务是第二章大纲，重点强化人物选择，不扩写世界设定。",
  "source": "handoff",
  "confidence": "high",
  "lifecycle": "temporary",
  "retrieval_trigger": ["outline_chapter"],
  "project": "SaltFire-Project",
  "updated_at": "2026-03-18",
  "last_verified": "2026-03-18"
}
```

---

## 4. Learning Memory

### 用途
存修订后形成的可复用规则。

### 示例
```json
{
  "id": "learning-exposition-001",
  "type": "learning",
  "scope": "global",
  "topic": "exposition",
  "content": "高压场景下整段说明会削弱抓力，优先用动作、环境和职业压力漏出设定。",
  "source": "feedback_review",
  "confidence": "high",
  "lifecycle": "permanent",
  "retrieval_trigger": ["write_opening", "write_scene", "revise_draft"],
  "project": "",
  "updated_at": "2026-03-18",
  "last_verified": "2026-03-18"
}
```

---

## 5. Feedback Memory

### 用途
存尚未完全升格为长期规则的反馈记录。

### 示例
```json
{
  "id": "feedback-ch1-pace-001",
  "type": "feedback",
  "scope": "draft",
  "topic": "pace",
  "content": "第一章前两段说明感过重，人物进入太晚，抓力不足。",
  "source": "blind_test",
  "confidence": "medium",
  "lifecycle": "project_only",
  "retrieval_trigger": ["revise_draft", "post_feedback"],
  "project": "SaltFire-Project",
  "updated_at": "2026-03-18",
  "last_verified": "2026-03-18"
}
```

---

## 四、召回规则 SOP

## SOP-01：按任务类型召回

### `write_opening`
优先召回：
1. `identity/opening`
2. `project/character_intro`
3. `learning/exposition`
4. 最近相关 `feedback`

### `outline_chapter`
优先召回：
1. 当前项目结构类 `project`
2. 当前任务 `task`
3. 节奏 / 钩子类 `learning`

### `revise_draft`
优先召回：
1. 该稿件相关 `feedback`
2. 相关 `learning`
3. 当前项目角色 / 设定边界 `project`

### `switch_project`
优先保留：
1. `identity`
2. 通用 `learning`

优先清空：
1. `task`
2. 上一项目 `project_only`
3. 上一项目 `feedback`

---

## 五、回写规则 SOP

每次有效反馈进入系统前，必须转换为：

1. **问题定位**
2. **错误类型**
3. **修正原则**
4. **记忆级别判断**

### 级别判断规则

#### 升为 `identity`
当它是稳定审美 / 长期创作原则时。

#### 升为 `project`
当它只适用于当前项目设定或人物边界时。

#### 升为 `learning`
当它是跨项目可复用的写作规律时。

#### 保留为 `feedback`
当它仍是一次性问题记录，尚未验证可泛化时。

---

## 六、执行限制

1. `content` 必须可执行，禁止空泛句子
2. 同一条规则若连续 3 次验证有效，可提升 `confidence`
3. `temporary` 记忆在任务结束后默认清空
4. `project_only` 不得跨项目召回
5. 未验证的灵感不得直接升为 `identity`

---

## 七、最小实施动作

### 动作 1
先建立 20 条以内核心 Memory Object：
- 5 条 `identity`
- 8 条 `project`
- 4 条 `learning`
- 3 条 `feedback`

### 动作 2
先只支持 3 类触发：
- `write_opening`
- `outline_chapter`
- `revise_draft`

### 动作 3
每次改稿后至少新增 1 条 `learning` 或 `feedback`

---

## 八、一句话原则

**Writer-Agent 记忆不追求存得多，而追求：在对的任务里，召回对的规则。**
