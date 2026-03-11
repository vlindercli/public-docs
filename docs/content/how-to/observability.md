# Observability

VlinderCLI writes structured JSONL logs and uses NATS subjects you can subscribe to for real-time message tracing.

## Log Files

Logs are written to `~/.vlinder/logs/vlinder.<date>.jsonl` with 7-day rolling retention.

Set the log level in [`config.toml`](../reference/config-toml.md) or via environment variable:

```bash
VLINDER_LOGGING_LEVEL=debug vlinder agent run -p ./my-agent
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

All messages flow through NATS subjects. You can subscribe to them in real time using `nats sub` to watch the system work.

### Subject format

Messages follow this pattern:

| Subject | Description |
|---------|-------------|
| `vlinder.<sub>.invoke.<harness>.<runtime>.<agent>` | CLI sends user input to an agent |
| `vlinder.<sub>.req.<agent>.<service>.<backend>.<op>.<seq>` | Agent requests a service (infer, kv, embed, etc.) |
| `vlinder.<sub>.res.<service>.<backend>.<agent>.<op>.<seq>` | Service responds to the agent |
| `vlinder.<sub>.delegate.<from>.<to>` | Agent delegates to another agent |
| `vlinder.<sub>.complete.<agent>.<harness>` | Agent completes and returns its response |

Where `<sub>` is the submission ID that ties all messages in a single interaction together.

### Watch all messages

```bash
nats sub "vlinder.>"
```

### Watch a specific agent

```bash
nats sub "vlinder.*.*.*.*.my-agent.>"
```

### Watch inference requests only

```bash
nats sub "vlinder.*.req.*.infer.>"
```

### Watch delegation

```bash
nats sub "vlinder.*.delegate.>"
```

## Message Types

Every interaction produces a sequence of messages:

1. **Invoke** — the CLI sends user input to the entry agent
2. **Request** — the agent calls a service (e.g., `infer`, `kv`, `embed`)
3. **Response** — the service returns the result
4. **Complete** — the agent finishes and returns its response to the CLI

For fleets, **Delegate** messages appear when the entry agent hands off work to another agent, which then produces its own Request/Response/Complete cycle.

## Correlating Logs with Timelines

Use the submission ID to connect log entries with timeline commits:

```bash
# Find the submission ID from the timeline
vlinder timeline log --agent my-agent

# Then filter logs for that submission
cat ~/.vlinder/logs/vlinder.*.jsonl | jq 'select(.fields.submission_id == "<sha>")'

# Or watch it live on NATS
nats sub "vlinder.<sha>.>"
```

## See Also

- [Configuration](configuration.md) — setting log levels
- [Time-Travel Debugging](time-travel-debugging.md) — using timelines alongside logs
- [Queue System](../explanation/queue-system.md) — how NATS subjects are structured
