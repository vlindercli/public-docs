# Storage

VlinderCLI provides two storage systems for agents: **object storage** (file-like key-value) and **vector storage** (embedding similarity search). Both default to SQLite.

## Object Storage

Object storage lets agents read and write files by path. Declare it in `agent.toml`:

```toml
object_storage = "sqlite://data/objects.db"

[requirements]
services = ["get_file", "put_file", "list_files"]
```

This creates a SQLite database at `data/objects.db` relative to the agent's data directory. The agent can then use the bridge helpers:

| Function | Description |
|----------|-------------|
| `kv_put(path, content)` | Write content to a path |
| `kv_get(path)` | Read content from a path |
| `kv_list(prefix)` | List keys under a prefix |
| `kv_delete(path)` | Delete a key |

Object storage is content-addressed — each write produces a state hash that integrates with the timeline for time-travel debugging.

## Vector Storage

Vector storage lets agents store and search embeddings for semantic search. Declare it alongside an embedding model:

```toml
vector_storage = "sqlite://data/vectors.db"

[requirements]
services = ["embed", "store_embedding", "search_by_vector"]

[requirements.models]
nomic-embed = "ollama://localhost:11434/nomic-embed-text:latest"
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

[requirements]
services = ["infer", "embed", "get_file", "put_file", "list_files", "store_embedding", "search_by_vector"]

[requirements.models]
phi3 = "ollama://localhost:11434/phi3:latest"
nomic-embed = "ollama://localhost:11434/nomic-embed-text:latest"
```

## Storage Backend

SQLite is the default and only user-facing backend. Data is file-backed, survives restarts, and is content-addressed for timeline integration.

## See Also

- [Services reference](../reference/services.md) — full list of service names
- [Storage Model](../explanation/storage-model.md) — design philosophy and content addressing
- [agent.toml](../reference/agent-toml.md) — declaring requirements
