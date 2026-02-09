# vlinder fleet

Create and run fleets of agents.

## Subcommands

### `vlinder fleet new`

Create a new fleet.

```
vlinder fleet new <NAME>
```

| Argument | Description |
|----------|-------------|
| `NAME` | Fleet name (becomes the directory name) |

Creates a `<NAME>/` directory containing a skeleton `fleet.toml`. Add agents using `vlinder agent new <language> agents/<agent-name>`, then register them in `fleet.toml`.

```bash
vlinder fleet new my-fleet
cd my-fleet
mkdir -p agents
vlinder agent new python agents/coordinator
vlinder agent new python agents/researcher
# edit fleet.toml to register both agents
vlinder fleet run
```

### `vlinder fleet run`

Run a fleet interactively.

```
vlinder fleet run [OPTIONS]
```

| Option | Default | Description |
|--------|---------|-------------|
| `-p`, `--path` | `.` (current directory) | Path to the directory containing `fleet.toml` |

The fleet manifest (`fleet.toml`) is loaded from the specified path. All referenced agent directories are resolved, and each agent is registered with the registry. The entry-point agent starts an interactive session and can delegate work to other agents in the fleet.

## See Also

- [fleet.toml reference](../fleet-toml.md) for the manifest schema
- [Your First Fleet](../../tutorials/your-first-fleet.md) tutorial
- [Agents Model](../../explanation/agents-model.md) for how delegation works
