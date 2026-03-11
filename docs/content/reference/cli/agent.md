# vlinder agent

Manage and run agents.

## Subcommands

### `vlinder agent run`

Run a deployed agent interactively.

```
vlinder agent run <NAME> [OPTIONS]
```

| Argument / Option | Description |
|-------------------|-------------|
| `NAME` | Name of the deployed agent |
| `--branch` | Optional timeline branch to resume from |

Starts an interactive REPL session with the named agent. The agent must already be deployed (see `vlinder agent deploy`).

### `vlinder agent deploy`

Deploy an agent manifest to the registry.

```
vlinder agent deploy [OPTIONS]
```

| Option | Default | Description |
|--------|---------|-------------|
| `-p`, `--path` | current directory | Path to the directory containing `agent.toml` |

Loads the agent manifest, validates requirements against the registry (models, services, runtimes), and registers the agent.

### `vlinder agent list`

List all deployed agents.

```
vlinder agent list
```

Displays agents registered with the registry, showing their name, runtime, and status.

### `vlinder agent get`

Show details for a specific agent.

```
vlinder agent get <NAME>
```

| Argument | Description |
|----------|-------------|
| `NAME` | Name of the agent to inspect |

### `vlinder agent new`

Create a new agent from a template.

```
vlinder agent new <LANGUAGE> <NAME>
```

| Argument | Description |
|----------|-------------|
| `LANGUAGE` | Template language (see table below) |
| `NAME` | Agent name (becomes the directory name and `agent.toml` name) |

Creates a `<NAME>/` directory containing a ready-to-build agent project: `agent.toml`, source file, `Dockerfile`, `build.sh`, and `README.md`.

**Available templates:**

| Language | Value |
|----------|-------|
| Python | `python` |
| Go | `golang` |
| JavaScript | `js` |
| TypeScript | `ts` |
| Java | `java` |
| .NET | `dotnet` |

```bash
vlinder agent new python my-agent
cd my-agent
./build.sh
vlinder agent deploy
vlinder agent run my-agent
```

## See Also

- [agent.toml reference](../agent-toml.md) for the manifest schema
- [Your First Agent](../../tutorials/your-first-agent.md) tutorial
