# config.toml

Global VlinderCLI configuration. Located at `~/.vlinder/config.toml` (or `$VLINDER_DIR/config.toml`).

All values can be overridden with [environment variables](environment-variables.md).

## Full Example

```toml
[logging]
level = "warn"
llama_level = "error"

[ollama]
endpoint = "http://localhost:11434"

[openrouter]
endpoint = "https://openrouter.ai/api/v1"
api_key = "sk-or-..."

[queue]
backend = "nats"
nats_url = "nats://localhost:4222"

[distributed]
enabled = true
registry_addr = "http://127.0.0.1:9090"

[distributed.workers]
registry = 1

[distributed.workers.agent]
container = 1

[distributed.workers.inference]
ollama = 1
openrouter = 0

[distributed.workers.embedding]
ollama = 1

[distributed.workers.storage.object]
sqlite = 1

[distributed.workers.storage.vector]
sqlite = 1
```

## Sections

### `[logging]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `level` | string | `"warn"` | Application log level: `trace`, `debug`, `info`, `warn`, `error` |
| `llama_level` | string | `"error"` | Log level for llama.cpp / ggml output |

### `[ollama]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `endpoint` | string | `"http://localhost:11434"` | Ollama server URL |

### `[openrouter]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `endpoint` | string | `"https://openrouter.ai/api/v1"` | OpenRouter API endpoint |
| `api_key` | string | — | OpenRouter API key |

### `[queue]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `backend` | string | `"nats"` | Queue backend: `"nats"` |
| `nats_url` | string | `"nats://localhost:4222"` | NATS server URL |

### `[distributed]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `enabled` | boolean | `false` | Enable distributed mode |
| `registry_addr` | string | `"http://127.0.0.1:9090"` | gRPC address of the registry service |

### `[distributed.workers]`

Worker counts control how many instances of each service type to spawn.

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `registry` | integer | `1` | Registry worker count |

#### `[distributed.workers.agent]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `container` | integer | `1` | Container runtime worker count |

#### `[distributed.workers.inference]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `ollama` | integer | `1` | Ollama inference workers |
| `openrouter` | integer | `0` | OpenRouter inference workers |

#### `[distributed.workers.embedding]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `ollama` | integer | `1` | Ollama embedding workers |

#### `[distributed.workers.storage.object]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `sqlite` | integer | `1` | SQLite object storage workers |

#### `[distributed.workers.storage.vector]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `sqlite` | integer | `1` | SQLite vector storage workers |

## See Also

- [Configuration](../how-to/configuration.md) how-to guide
- [Environment Variables](environment-variables.md) for override syntax
- [Distributed Deployment](../how-to/distributed-deployment.md) for multi-process setups
