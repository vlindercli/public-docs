# Observability

VlinderCLI writes structured JSONL logs and uses NATS subjects you can subscribe to for real-time message tracing.

## Log Files

Logs are written to `~/.vlinder/logs/` as JSONL.

Set the log level in [`config.toml`](../reference/config-toml.md) or via environment variable:

```bash
VLINDER_LOGGING_LEVEL=debug vlinder agent run my-agent
```

## Inspecting Logs with jq

### View recent errors

```bash
cat ~/.vlinder/logs/vlinder.$(date +%Y-%m-%d).jsonl | jq 'select(.level == "ERROR")'
```

### Filter by agent

```bash
cat ~/.vlinder/logs/vlinder.*.jsonl | jq 'select(.fields.agent == "echo-agent")'
```

### Show message flow

```bash
cat ~/.vlinder/logs/vlinder.*.jsonl | jq 'select(.fields.message_type | IN("RequestMessage", "ResponseMessage"))'
```

### Trace a specific submission

```bash
cat ~/.vlinder/logs/vlinder.*.jsonl | jq 'select(.fields.submission_id == "abc123")'
```

## NATS Message Tracing

All messages flow through NATS subjects. Subscribe in real time using `nats sub` to watch the system work.

### Subject format

Messages follow this pattern:

```
vlinder.{timeline}.{submission}.{type}.{...dimensions}
```

| Subject pattern | Description |
|-----------------|-------------|
| `vlinder.{t}.{s}.invoke.{harness}.{runtime}.{agent}` | User input → agent |
| `vlinder.{t}.{s}.req.{agent}.{svc}.{backend}.{op}.{seq}` | Agent → service |
| `vlinder.{t}.{s}.res.{svc}.{backend}.{agent}.{op}.{seq}` | Service → agent |
| `vlinder.{t}.{s}.delegate.{caller}.{target}` | Agent → agent |
| `vlinder.{t}.{s}.complete.{agent}.{harness}` | Agent → harness |

### Watch all messages

```bash
nats sub "vlinder.>"
```

### Watch inference requests only

```bash
nats sub "vlinder.*.*.req.*.infer.>"
```

### Watch delegation

```bash
nats sub "vlinder.*.*.delegate.>"
```

## Message Types

Every interaction produces a sequence of messages:

1. **Invoke** — the CLI sends user input to the entry agent
2. **Request** — the agent calls a service (e.g., inference, embedding, storage)
3. **Response** — the service returns the result
4. **Complete** — the agent finishes and returns its response to the CLI

For fleets, **Delegate** messages appear when the entry agent hands off work to another agent, which then produces its own Request/Response/Complete cycle.

## Correlating Logs with Sessions

Use the submission ID to connect log entries with session turns:

```bash
# Find the submission ID from a session
vlinder session get ses-abc12345

# Filter logs for that submission
cat ~/.vlinder/logs/vlinder.*.jsonl | jq 'select(.fields.submission_id == "<sha>")'

# Or watch it live on NATS
nats sub "vlinder.*.<sha>.>"
```

## See Also

- [Configuration](configuration.md) — setting log levels
- [Time-Travel Debugging](time-travel-debugging.md) — using sessions alongside logs
- [Queue System](../explanation/queue-system.md) — how NATS subjects are structured
