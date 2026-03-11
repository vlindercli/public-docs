# fleet.toml

The fleet manifest declares a group of cooperating agents and their entry point. It lives in the fleet's root directory.

## Full Example

```toml
name = "test-fleet"
entry = "echo"

[agents.echo]
path = "agents/echo-agent"

[agents.upper]
path = "agents/upper-agent"
```

## Field Reference

### Top-level fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | yes | Unique name for the fleet |
| `entry` | string | yes | Key of the agent that serves as the fleet's entry point |

### `[agents.<name>]`

Each agent in the fleet is declared as a table under `[agents]`. The table key is the agent's alias within the fleet.

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `path` | string | yes | Relative path from the fleet directory to the agent's directory (must contain an `agent.toml`) |

## Behavior

- The `entry` field must match one of the keys under `[agents]`.
- All agent paths are resolved relative to the `fleet.toml` location.
- Each referenced directory must contain a valid [`agent.toml`](agent-toml.md).
- The entry agent starts the interactive session; other agents can be delegated to.

## See Also

- [Your First Fleet](../tutorials/your-first-fleet.md) tutorial
- [CLI: `vlinder fleet`](cli/fleet.md)
- [Agents Model](../explanation/agents-model.md) for delegation semantics
