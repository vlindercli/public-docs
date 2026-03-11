# Services

Services are the capabilities available to agents at runtime. Agents declare their service requirements in [`agent.toml`](agent-toml.md) and the supervisor routes requests to the appropriate worker via the message queue.

## Available Services

| Service | Queue name | Description |
|---------|-----------|-------------|
| Inference | `infer` | Text generation via LLM |
| Embedding | `embed` | Vector embedding generation |
| Object Storage | `storage` | Persistent key-value object storage |
| Vector Storage | `storage` | Similarity search over vector embeddings |

## Inference

Generates text from a prompt using a registered model.

**Backends:**

| Backend | Engine | Description |
|---------|--------|-------------|
| Ollama | `ollama` | Local inference via Ollama server |
| OpenRouter | `openrouter` | Remote inference via OpenRouter API |

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `max_tokens` | integer | `1024` | Maximum tokens to generate |
| `temperature` | float | `0.7` | Sampling temperature |

## Embedding

Generates vector embeddings for text input, used for semantic search via vector storage.

**Backends:**

| Backend | Engine | Description |
|---------|--------|-------------|
| Ollama | `ollama` | Local embedding via Ollama server |

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `dimensions` | integer | `768` | Embedding vector dimensions |

## Object Storage

Persistent key-value storage for agent data.

**Backend:** SQLite — file-backed, durable, content-addressed.

## Vector Storage

Similarity search over vector embeddings, powered by [sqlite-vec](https://github.com/asg017/sqlite-vec) (MIT licensed).

**Backend:** SQLite via sqlite-vec.

## Message Flow

All service interactions use typed messages on the queue:

1. **Agent** sends a `RequestMessage` to the service queue
2. **Worker** processes the request and sends a `ResponseMessage` back

See [Queue System](../explanation/queue-system.md) for the full message flow.

## See Also

- [agent.toml](agent-toml.md) — declaring service requirements
- [Storage](../how-to/storage.md) how-to guide
- [Storage Model](../explanation/storage-model.md) explanation
