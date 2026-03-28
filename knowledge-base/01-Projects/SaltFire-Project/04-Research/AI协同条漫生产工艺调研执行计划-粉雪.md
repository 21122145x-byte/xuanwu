# AI协同条漫生产工艺调研执行计划

> 粉雪执行计划
> 基于：AI协同条漫生产工艺调研方案-v0.1.md
> 更新：2026-03-25

---

## 执行原则

1. **按优先级执行**：MCP exa → agent reach → 爬虫/抓取
2. **遇到卡点先跳过，不死耗**
3. **每条结果记录：来源名称 + URL + 核心内容 + 对我们有什么用 + 可信度**

---

## 执行步骤

### 步骤1：MCP exa 搜索（主线1：工具链全景）

**工具**：mcporter call exa.web_search_exa

**搜索词**：
- 中文：`AI 条漫 制作流程`, `AI 漫画 生产工艺`, `条漫 AI 协同 工具`
- 英文：`AI comic production workflow tools`, `Stable Diffusion comic pipeline`, `ComfyUI comic workflow`

**验收**：拿到工具地图初稿

---

### 步骤2：MCP exa 搜索（主线2：角色一致性方案）

**工具**：mcporter call exa.web_search_exa

**搜索词**：
- 中文：`AI 漫画 角色一致性 LoRA`, `条漫 风格一致性 技术`
- 英文：`AI comic character consistency LoRA workflow`, `comic character consistency ControlNet`

**验收**：拿到一致性方案清单

---

### 步骤3：MCP exa 搜索（主线3：真实坑点）

**工具**：mcporter call exa.web_search_exa

**搜索词**：
- 中文：`AI 漫画 踩坑 返工`, `AI 条漫 失败 经验`
- 英文：`AI comic production mistakes`, `AI comic consistency issues`

**验收**：拿到坑点清单

---

### 步骤4：MCP exa 搜索（主线4：SaltFire专项）

**工具**：mcporter call exa.web_search_exa

**搜索词**：
- 中文：`暗色调 漫画 AI`, `宗教感 神秘感 AI 漫画风格`
- 英文：`dark comic AI workflow`, `prophecy visual AI comic`, `religious aesthetic comic AI`

**验收**：判断SaltFire暗黑美学适配性

---

### 步骤5：整理归并

**动作**：将所有结果写入调研记录文件

**字段**：来源名称 | URL | 类型 | 核心内容 | 对我们有什么用 | 可信度 | SaltFire适配性

---

## 备选方案（遇到卡点时）

| 卡点 | 替代方案 |
|------|---------|
| exa 超时/无结果 | 用 agent reach 搜索 Twitter/Reddit |
| agent reach 也不行 | 用 scrapling-official 抓取已知工具官网 |
| 都失败 | 标记"待手动查证"，继续下一步 |

---

## 结果输出

调研完成后，产出：
1. AI条漫工具地图
2. 角色一致性方案清单
3. 失败案例与坑点清单
4. SaltFire风格适配性判断

---

## 当前状态

- [x] 步骤1：工具链全景搜索
- [x] 步骤2：角色一致性搜索
- [x] 步骤3：坑点搜索
- [x] 步骤4：SaltFire专项搜索
- [x] 步骤5：整理归并（已完成）

**完成时间：2026-03-25 21:24**
