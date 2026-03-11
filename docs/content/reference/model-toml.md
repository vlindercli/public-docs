# model.toml

Model manifests are created automatically when you add a model via `vlinder model add`. They live in `~/.vlinder/models/<name>-model.toml`.

## Full Example

```toml
name = "phi3"
type = "inference"
provider = "ollama"
model_path = "ollama://localhost:11434/phi3"
```

## Field Reference

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | no | Display name for the model |
| `type` | string | yes | Model type: `"inference"` or `"embedding"` |
| `provider` | string | yes | Backend provider: `"ollama"` or `"openrouter"` |
| `model_path` | string | yes | Provider-specific resource URI or local file path |

### `model_path` URI formats

| Provider | Format | Example |
|----------|--------|---------|
| `ollama` | `ollama://<host>:<port>/<model>` | `ollama://localhost:11434/phi3` |
| `openrouter` | `openrouter://<model>` | `openrouter://meta-llama/llama-3-8b-instruct` |
| Local file | `file://<path>` or bare path | `file:///models/my-model.gguf` |

File paths (bare or `file://`) are resolved relative to the manifest directory.

## See Also

- [CLI: `vlinder model`](cli/model.md) for managing models
- [Manage Models](../how-to/manage-models.md) how-to guide
