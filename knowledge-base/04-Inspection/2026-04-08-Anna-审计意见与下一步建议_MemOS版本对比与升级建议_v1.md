# Anna 审计意见与下一步建议｜MemOS 版本对比与升级建议 v1

- 日期：2026-04-08
- 审计人：Anna
- 审计对象：`2026-04-08-玄武-MemOS版本对比与升级建议-交接文档-v1.md`
- 当前结论：**不直接通过，先返工事实核验**


## 文档挂载
- 上位文档：/Users/xiaojingbo/.openclaw/workspace-system-guardian/knowledge_base/04-Inspection/2026-04-08-玄武-MemOS版本对比与升级建议-交接文档-v1.md
- 同级关联：/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-08-玄武-MemOS版本事实核验清单-v1.md；/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-08-Anna-审计意见与下一步建议_MemOS版本对比与升级建议_v2.md
- 下位文档：/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-08-MemOS版本对比与升级建议_可审版_v2.md
- 所属主线：MemOS 版本对比与升级建议初审 / 事实核验前置审计

---

## 一、审计结论

### 总判断
**当前不直接通过。**

不是升级方向错误，而是文档中的几条基础事实与当前已知运行口径发生冲突，尚不足以直接作为升级执行依据。

当前我接受的结论是：

> **MemOS 升级方向可以进入评估，但必须先完成“当前真实版本 / 当前真实加载路径 / 当前真实 slot 与 config 状态”的事实核验。**

当前我不接受的结论是：
- 直接确认当前版本就是 `1.0.3`
- 直接确认当前加载路径就是 `/opt/homebrew/lib/node_modules/@memtensor/memos-local-openclaw-plugin/`
- 直接写成“auto-recall 核心功能正常工作”
- 直接把本文档当作升级执行依据

---

## 二、当前已成立的部分

### 1. 升级方向可讨论
从较老的 `1.0.x` 稳定版向更新稳定版评估升级，这个方向本身成立。

### 2. 升级收益方向基本合理
当前文档提到的几类潜在收益，方向上成立：
- `registerContextEngine` 接法更稳定
- native binding 覆盖更全
- 版本管理更完整

### 3. 升级后需要做记忆完整性验证
这条成立，而且建议保留为升级后的必做项。

### 4. 版本升级不应被误写成当前 timeout 根因
当前将“版本偏老”与 `fenxue-backup timeout` 保持边界分离，这条方向是对的。

---

## 三、当前仍未成立的部分

### 1. 当前真实版本未核死
现有文档写：
- 当前版本：`1.0.3`

但当前已知链路中曾出现过：
- `memos-local-openclaw-plugin = 1.0.7`
- `plugins.installs.memos-local-openclaw-plugin.version = 1.0.7`

因此：
> **当前真实运行版本未核死。**

### 2. 当前真实加载路径未核死
现有文档写：
- 安装路径：`/opt/homebrew/lib/node_modules/@memtensor/memos-local-openclaw-plugin/`

但当前已知配置链曾指向：
- `~/.openclaw/extensions/memos-local-openclaw-plugin`

因此：
> **必须区分 npm 路径、全局路径、当前真实加载路径，当前不能混写。**

### 3. “核心功能正常工作”写得过满
当前文档写：
> auto-recall 核心功能在 v1.0.3 上正常工作。

这句话当前不能直接成立。

更准确的口径应是：
> **基础召回 / 注入链存在且可触发，但 recall 健康性、边界控制与污染风险仍存在已知问题。**

### 4. 当前文档不足以直接作为升级执行依据
在“版本 / 路径 / slot / config”四项未核死前，升级命令只能算候选动作，不能算可直接执行动作。

---

## 四、最小返工要求

### 返工 1：钉死当前真实版本
至少交叉核以下来源：
- `plugins.installs`
- 实际加载日志
- 当前加载目录 `package.json`
- 当前运行时 status / plugin 列表

### 返工 2：钉死当前真实加载路径
必须明确区分：
- npm 发布来源
- 全局安装目录
- OpenClaw 当前实际加载目录

### 返工 3：钉死当前 slot 与 config 状态
至少核清：
- `plugins.slots.memory`
- `plugins.entries["memos-local-openclaw-plugin"]`
- 当前 config 是否仍兼容升级目标版本

### 返工 4：收紧功能表述
将“核心功能正常工作”改为更克制的事实口径：
- 能触发
- 不等于健康
- 不等于边界正确
- 不等于可继续长期信任

---

## 五、下一步建议

### 1. 先出“版本事实核验版”
先把以下四件事压实：
1. 当前真实版本
2. 当前真实加载路径
3. 当前真实 memory slot 绑定
4. 当前 config 兼容状态

### 2. 再出“升级建议版”
只有事实核死后，才能继续讨论：
- 是否批准升级
- 如何升级
- 升级后如何验收

### 3. 升级后记忆完整性验证应列为必做项
这条不建议只写成“可选建议”，应提升为：
> **升级后必做项。**

---

## 六、一句话收口

> **当前这份《MemOS 版本对比与升级建议》不直接通过：升级方向可以评估，但“当前版本 / 当前路径 / 当前功能状态”三条基础事实尚未钉死，必须先返工成事实核验版，再谈升级执行。**
