# agent.toml

The agent manifest declares an agent's identity, runtime, requirements, and configuration. It lives in the agent's directory (e.g., `my-agent/agent.toml`).

## Full Example

```toml
name = "echo-agent"
description = "Test agent that echoes input"
runtime = "container"
executable = "localhost/echo-agent:latest"

[requirements]
services = ["infer"]

[requirements.models]
phi3 = "ollama://localhost:11434/phi3:latest"

[[mounts]]
host_path = "/data"
guest_path = "/mnt/data"
read_only = false

[prompts]
system = "You are a helpful assistant."
```

## Field Reference

### Top-level fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | yes | Unique name for the agent |
| `description` | string | no | Human-readable description |
| `runtime` | string | yes | Execution runtime. Currently only `"container"` is supported |
| `executable` | string | yes | OCI image reference (e.g., `localhost/my-agent:latest`) or `file://` URI |

### `[requirements]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `services` | array of strings | `[]` | Service names this agent requires (e.g., `["infer", "embed", "storage"]`) |

### `[requirements.models]`

Key-value pairs where the key is the model alias used by the agent and the value is the model's resource URI.

| Key | Value | Description |
|-----|-------|-------------|
| *model alias* | Resource URI | Maps an agent-local model name to a registered model's URI |

### `[[mounts]]`

Optional filesystem mounts. Each entry is a table in the TOML array.

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `host_path` | string | yes | Path on the host filesystem |
| `guest_path` | string | yes | Mount point inside the agent container |
| `read_only` | boolean | no | Whether the mount is read-only (default: `false`) |

### `[prompts]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `system` | string | — | System prompt override for the agent |

## See Also

- [Your First Agent](../tutorials/your-first-agent.md) tutorial
- [CLI: `vlinder agent run`](cli/agent.md)
- [Services reference](services.md) for available service names
