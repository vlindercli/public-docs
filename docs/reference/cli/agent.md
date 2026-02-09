# vlinder agent

Manage and run agents.

## Subcommands

### `vlinder agent run`

Run an agent interactively.

```
vlinder agent run [OPTIONS]
```

| Option | Default | Description |
|--------|---------|-------------|
| `-p`, `--path` | `.` (current directory) | Path to the directory containing `agent.toml` |

The agent manifest (`agent.toml`) is loaded from the specified path, validated against the registry (checking that required models, services, and runtimes are available), and then executed in an interactive REPL session.

### `vlinder agent list`

List all deployed agents.

```
vlinder agent list
```

Displays a table of agents registered with the registry, showing their name, runtime, and current status.

### `vlinder agent get`

Show details for a specific agent.

```
vlinder agent get <NAME>
```

| Argument | Description |
|----------|-------------|
| `NAME` | Name of the agent to inspect |

Displays the full agent configuration including its resource ID, runtime, requirements, mounted services, and storage configuration.

### `vlinder agent new`

Create a new agent from a template.

```
vlinder agent new <LANGUAGE> <NAME>
```

| Argument | Description |
|----------|-------------|
| `LANGUAGE` | Template language (see table below) |
| `NAME` | Agent name (becomes the directory name and `agent.toml` name) |

Creates a `<NAME>/` directory containing a ready-to-build agent project: `agent.toml`, source file, `Dockerfile`, `build.sh`, and `README.md`. The template includes bridge helper functions for every platform service.

**Available templates:**

| Language | Value | Template repo |
|----------|-------|---------------|
| Python | `python` | [vlindercli/vlinder-agent-python](https://github.com/vlindercli/vlinder-agent-python) |
| Go | `golang` | [vlindercli/vlinder-agent-golang](https://github.com/vlindercli/vlinder-agent-golang) |
| JavaScript | `js` | [vlindercli/vlinder-agent-js](https://github.com/vlindercli/vlinder-agent-js) |
| TypeScript | `ts` | [vlindercli/vlinder-agent-ts](https://github.com/vlindercli/vlinder-agent-ts) |
| Java | `java` | [vlindercli/vlinder-agent-java](https://github.com/vlindercli/vlinder-agent-java) |
| .NET | `dotnet` | [vlindercli/vlinder-agent-dotnet](https://github.com/vlindercli/vlinder-agent-dotnet) |

```bash
vlinder agent new python my-agent
cd my-agent
./build.sh
vlinder agent run
```

## See Also

- [agent.toml reference](../agent-toml.md) for the manifest schema
- [Your First Agent](../../tutorials/your-first-agent.md) tutorial
