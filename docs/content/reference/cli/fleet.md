# vlinder fleet

Create and run fleets of agents.

## Subcommands

### `vlinder fleet run`

Run a deployed fleet interactively.

```
vlinder fleet run <NAME>
```

| Argument | Description |
|----------|-------------|
| `NAME` | Name of the deployed fleet |

The entry-point agent starts an interactive session and can delegate work to other agents in the fleet.

### `vlinder fleet deploy`

Deploy a fleet manifest to the registry.

```
vlinder fleet deploy [OPTIONS]
```

| Option | Default | Description |
|--------|---------|-------------|
| `-p`, `--path` | current directory | Path to the directory containing `fleet.toml` |

Loads the fleet manifest, resolves all referenced agent directories, and registers each agent with the registry.

### `vlinder fleet new`

Create a new fleet from a template.

```
vlinder fleet new <NAME>
```

| Argument | Description |
|----------|-------------|
| `NAME` | Fleet name (becomes the directory name) |

Creates a `<NAME>/` directory containing a skeleton `fleet.toml`.

```bash
vlinder fleet new my-fleet
cd my-fleet
mkdir -p agents
vlinder agent new python agents/coordinator
vlinder agent new python agents/researcher
# edit fleet.toml to register both agents
vlinder fleet deploy
vlinder fleet run my-fleet
```

## See Also

- [fleet.toml reference](../fleet-toml.md) for the manifest schema
- [Your First Fleet](../../tutorials/your-first-fleet.md) tutorial
- [Agents Model](../../explanation/agents-model.md) for how delegation works
