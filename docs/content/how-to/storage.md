# Storage

VlinderCLI provides two storage systems for agents: **object storage** (key-value) and **vector storage** (embedding similarity search).

## Object Storage

Object storage lets agents read and write data by key. Declare it in `agent.toml`:

```toml
object_storage = "sqlite://data/objects.db"
```

Relative paths are resolved against the agent's manifest directory. The agent can then use the bridge helpers:

| Function | Description |
|----------|-------------|
| `kv_put(key, content)` | Write content to a key |
| `kv_get(key)` | Read content from a key |
| `kv_list(prefix)` | List keys under a prefix |
| `kv_delete(key)` | Delete a key |

Object storage is content-addressed — each write produces a state hash that integrates with the DAG for time-travel debugging.

## Vector Storage

Vector storage lets agents store and search embeddings for semantic search. Declare it in `agent.toml` alongside an embedding service:

```toml
vector_storage = "sqlite://data/vectors.db"

[requirements.models]
nomic-embed = "nomic-embed-text"

[requirements.services.embed]
provider = "ollama"
protocol = "openai"
models = ["nomic-embed-text:latest"]
```

Bridge helpers:

| Function | Description |
|----------|-------------|
| `embed(text)` | Generate an embedding vector |
| `vector_store(key, vector, metadata)` | Store a vector with metadata |
| `vector_search(vector, limit)` | Find nearest vectors |
| `vector_delete(key)` | Delete a stored vector |

## Using Both Together

A full-featured agent might use both storage systems:

```toml
object_storage = "sqlite://data/objects.db"
vector_storage = "sqlite://data/vectors.db"

[requirements.models]
inference_model = "claude-sonnet"
embedding_model = "nomic-embed-text"

[requirements.services.infer]
provider = "openrouter"
protocol = "anthropic"
models = ["anthropic/claude-3.5-sonnet"]

[requirements.services.embed]
provider = "ollama"
protocol = "openai"
models = ["nomic-embed-text:latest"]
```

## Storage Backends

The storage URI scheme selects the backend. Each backend has its own strengths and platform constraints — the choice of backend is a meaningful architectural decision, not a transparent swap.

All backends implement content-addressed versioning, which is what makes time-travel debugging possible. The specific constraints and capabilities vary by backend.

## See Also

- [Services reference](../reference/services.md) — service types and providers
- [Storage Model](../explanation/storage-model.md) — design philosophy and content addressing
- [agent.toml](../reference/agent-toml.md) — declaring requirements
