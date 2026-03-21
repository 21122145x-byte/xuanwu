# Agent任务追踪机制 v1.0

**目标**：解决Agent卡顿/无响应/超时问题，确保任务可追踪、可干预、可复盘

---

## 一、任务生命周期

```
[分发] → [确认] → [执行] → [检查点] → [完成/阻塞]
   ↓        ↓        ↓          ↓           ↓
  带依赖  收到确认  进度更新   自动巡检   产出提交
```

---

## 二、任务分发规范

### 2.1 任务模板

```markdown
## 任务：xxx

**负责人**：@anna / @粉雪 / @旺财
**截止时间**：2026-03-17 10:00
**优先级**：P0/P1/P2

### 依赖文件（必须提供完整路径）
- [ ] 文件1：`/path/to/file1.md`
- [ ] 文件2：`/path/to/file2.md`

### 产出要求
- 产出位置：`/path/to/output/`
- 产出格式：Markdown表格/文档/清单
- 验收标准：xxx

### 检查点（自动触发）
| 时间 | 检查内容 | 超时动作 |
|------|----------|----------|
| T+30min | 收到确认？ | 重发任务 |
| T+2h | 进度50%？ | 富贵介入询问 |
| T-2h（截止前） | 能完成？ | 评估延期或支援 |
| 截止时 | 产出提交？ | 标记阻塞 |

### 阻塞升级
- 30min无响应 → 重发任务
- 2h无进度 → 富贵询问
- 4h无产出 → 通知Shaun
- 截止未完成 → 标记为阻塞，进入复盘
```

### 2.2 依赖文件路径规范

**禁止**："架构方案在知识库里"
**必须**："架构方案：`/Users/xiaojingbo/.openclaw/workspace/knowledge-base/01-Projects/SaltFire-Project/AI-Writing-Team-Architecture.md`"

---

## 三、Agent状态监控

### 3.1 状态定义

| 状态 | 定义 | 颜色 |
|------|------|------|
| 待确认 | 任务已分发，等待Agent确认收到 | 🟡 |
| 执行中 | Agent已确认，正在执行 | 🔵 |
| 检查点 | 到达检查点，等待进度更新 | 🟠 |
| 已完成 | 产出已提交，验收通过 | 🟢 |
| 阻塞 | 超时/卡顿/无法完成 | 🔴 |
| 延期 | 申请延期，待批准 | ⚪ |

### 3.2 自动巡检机制

**巡检频率**：每30分钟
**巡检对象**：所有"执行中"和"检查点"状态的任务
**巡检动作**：
1. 检查Agent最近会话时间
2. 检查产出目录是否有更新
3. 检查Agent内存文件是否有记录

```bash
# 巡检脚本示例
check_agent_status() {
    agent=$1
    last_session=$(find ~/.openclaw/agents/$agent/sessions -name "*.jsonl" -mtime -0.02)
    if [ -z "$last_session" ]; then
        echo "⚠️ $agent 30分钟内无会话记录"
        return 1
    fi
    
    # 检查是否有错误/超时标记
    if grep -q "error\|timeout" "$last_session" 2>/dev/null; then
        echo "🔴 $agent 可能遇到错误"
        return 2
    fi
    
    echo "🟢 $agent 正常"
    return 0
}
```

---

## 四、阻塞处理流程

```
发现阻塞
    ↓
判断类型
    ├── API卡顿（Anna）→ 切换备用模型/等待恢复
    ├── 等待确认（粉雪）→ 主动推进，减少确认点
    ├── 找不到文件 → 提供完整路径
    └── 任务不明确 → 重新拆解
    ↓
干预动作
    ├── 自动重发任务
    ├── 富贵介入询问
    ├── 通知Shaun决策
    └── 标记延期或取消
    ↓
记录阻塞原因
```

---

## 五、复盘模板

每个阻塞任务必须复盘：

```markdown
## 阻塞复盘：xxx任务

**阻塞时间**：2026-03-17 10:00
**Agent**：Anna
**任务**：知识库结构 + 审校清单

### 阻塞原因
- [ ] 依赖文件未提供完整路径
- [ ] Agent API卡顿
- [ ] 任务过于复杂，未拆解
- [ ] Agent等待确认才继续
- [ ] 其他：xxx

### 发现过程
- 富贵10:30检查进度，发现Anna在搜索"架构方案"
- 日志显示Anna找了30分钟没找到文件
- 实际文件位置：xxx

### 解决方案
- 立即提供完整路径
- Anna在10分钟内完成任务

### 预防措施
- [ ] 任务分发时必须附带完整路径
- [ ] 建立常用文件路径索引
- [ ] 优化Agent搜索范围
```

---

## 六、工具实现

### 6.1 任务追踪表

位置：`knowledge-base/99-Meta/Task-Tracker.md`

```markdown
| 任务 | Agent | 截止 | 状态 | 检查点 | 产出位置 |
|------|-------|------|------|--------|----------|
| 竞品分析 | 粉雪 | 3-17 10:00 | 🟢完成 | - | xxx |
| 知识库结构 | Anna | 3-17 10:00 | 🟢完成 | T+2h询问 | xxx |
| 审校清单 | Anna | 3-17 10:00 | 🟢完成 | - | xxx |
```

### 6.2 自动巡检Cron

```json
{
  "task-monitor": {
    "schedule": "*/30 * * * *",
    "action": "check_all_active_tasks",
    "alert_threshold": {
      "no_response": "30min",
      "no_progress": "2h",
      "stuck": "4h"
    }
  }
}
```

### 6.3 快速检查命令

```bash
# 检查Agent最近活动
openclaw sessions list | grep -E "anna|粉雪|旺财"

# 检查Agent日志
tail -100 ~/.openclaw/agents/anna/sessions/latest.jsonl

# 检查产出目录
ls -lt ~/.openclaw/workspace/knowledge-base/01-Projects/SaltFire-Project/
```

---

## 七、本次案例应用

### Anna任务复盘

**问题**：Anna卡在找"架构方案"文件30分钟
**根因**：任务分发时未提供完整路径
**解决**：富贵提供路径 `AI-Writing-Team-Architecture.md`
**产出**：
- ✅ 知识库结构已建立
- ✅ 审校清单已创建：`Text-Review-Checklist.md`

### 改进措施

1. **立即**：所有任务必须附带完整文件路径
2. **短期**：建立《常用文件路径索引》
3. **长期**：开发自动巡检脚本

---

_Last updated: 2026-03-17 by 富贵_
