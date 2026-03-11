# vlinder model

Manage models from catalogs.

## Subcommands

### `vlinder model add`

Add a model from a catalog.

```
vlinder model add <NAME> [OPTIONS]
```

| Argument / Option | Default | Description |
|-------------------|---------|-------------|
| `NAME` | *required* | Name of the model to add |
| `--catalog` | `ollama` | Catalog to pull from |
| `--endpoint` | — | Custom endpoint URL for the model provider |

Resolves the model from the specified catalog, registers it with the registry, and creates a model manifest file at `~/.vlinder/models/<name>-model.toml`.

### `vlinder model available`

List models available in a catalog.

```
vlinder model available [FILTER] [OPTIONS]
```

| Argument / Option | Default | Description |
|-------------------|---------|-------------|
| `FILTER` | — | Optional substring to filter model names |
| `--catalog` | `all` | Catalog to query |
| `--endpoint` | — | Custom endpoint URL |

Queries the catalog API and displays available models.

### `vlinder model list`

List models registered locally.

```
vlinder model list
```

Displays all models registered with the registry, showing name, type (`inference` or `embedding`), and provider.

### `vlinder model remove`

Remove a registered model.

```
vlinder model remove <NAME>
```

| Argument | Description |
|----------|-------------|
| `NAME` | Name of the model to remove |

Removes the model manifest and deregisters the model from the registry.

## See Also

- [model.toml reference](../model-toml.md) for the manifest schema
- [Manage Models](../../how-to/manage-models.md) how-to guide
