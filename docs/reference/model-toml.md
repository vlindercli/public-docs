# model.toml

Model manifests are created automatically when you add a model via `vlinder model add`. They live in `~/.vlinder/models/<name>-model.toml`.

## Full Example

```toml
name = "phi3"
type = "inference"
engine = "ollama"
model_path = "ollama://localhost:11434/phi3"
digest = "sha256:abcdef1234567890..."
```

## Field Reference

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | yes | Unique name for the model |
| `type` | string | yes | Model type: `"inference"` or `"embedding"` |
| `engine` | string | yes | Engine that runs this model (see table below) |
| `model_path` | string | yes | Engine-specific resource URI |
| `digest` | string | no | Content hash for integrity verification |

### Engine values by type

| Type | Valid engines |
|------|-------------|
| `inference` | `ollama`, `openrouter` |
| `embedding` | `ollama` |

### `model_path` URI formats

| Engine | Format | Example |
|--------|--------|---------|
| `ollama` | `ollama://<host>:<port>/<model>` | `ollama://localhost:11434/phi3` |
| `openrouter` | `openrouter://<model>` | `openrouter://meta-llama/llama-3-8b-instruct` |

## See Also

- [CLI: `vlinder model`](cli/model.md) for managing models
- [Manage Models](../how-to/manage-models.md) how-to guide
