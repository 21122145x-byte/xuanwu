# 半自动任务 heartbeat 模板 v1

- 适用协议：`/Users/xiaojingbo/.openclaw/workspace/knowledge-base/04-Inspection/2026-04-11-半自动任务执行协议_v1.md`
- 用途：统一记录半自动任务的保活信号与流转信号，避免把 alive 误写成 flowing

## 使用原则
- heartbeat 负责观察、记录、暴露停滞，不替代主链业务判断。
- heartbeat 必须区分：
  - `alive_signal`
  - `flow_signal`
- 仅出现 `alive_signal` 不代表业务链在推进。

## 推荐日志格式

```md
[YYYY-MM-DD HH:mm:ss CST] alive_signal: <worker/session/task record 仍在更新>
[YYYY-MM-DD HH:mm:ss CST] flow_signal: <status advanced to sent-to-audit>
[YYYY-MM-DD HH:mm:ss CST] flow_signal: <audit accepted handoff as audit-in-progress>
[YYYY-MM-DD HH:mm:ss CST] stalled_at_gate: <review-ready>
[YYYY-MM-DD HH:mm:ss CST] heartbeat-stop: <观察终止条件>
```

## 标准写法

### A. 仅证明还活着
```md
[2026-04-11 01:30:00 CST] alive_signal: memory revision loop active
```

### B. 证明阶段真正流转
```md
[2026-04-11 01:42:00 CST] flow_signal: status advanced from review-ready to sent-to-audit
```

### C. 暴露假活跃
```md
[2026-04-11 01:50:00 CST] alive_signal: worker artifacts present and status card unchanged
[2026-04-11 01:50:00 CST] stalled_at_gate: review-ready
```

### D. 终止说明
```md
[2026-04-11 02:10:00 CST] heartbeat-stop: observation stopped because package reached stable review-ready state
```

## 重要边界
- `stable review-ready` 只表示 heartbeat 的观察终止条件成立。
- `stable review-ready` **不等于** 业务链已经稳定闭合。
- 只有出现新的 `flow_signal`，才可说明阶段门发生了真实推进。
