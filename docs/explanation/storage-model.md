# Storage Model

VlinderCLI's storage system is designed around three rules that make agent state reproducible, verifiable, and portable.

## The Three Rules
### 1. All storage is declared

Agents declare their storage requirements in [`agent.toml`](../reference/agent-toml.md). The daemon provisions storage at registration time. There are no hidden side effects.

### 2. All state is content-addressed

Storage operations are tracked as part of the agent's state hash in the [timeline](timelines.md). This means you can verify that any historical state is intact by checking the Merkle DAG.

### 3. Storage is a service, not a library

Agents access storage through the message queue, not by linking a storage library. This decouples the storage backend from the agent code and enables transparent backend swaps.

## Content Addressing
Storage operations produce content hashes that feed into the Merkle DAG. When you fork a timeline, the storage state is part of what gets restored. This is what makes time-travel debugging work for stateful agents — you can rewind to a previous state and the storage contents match.

## Object Storage

Key-value storage for arbitrary data. Each object is identified by a key and stored with its content hash.

**Backends:**

SQLite is the default backend — durable, file-backed, and content-addressed.

## Vector Storage

Similarity search over vector embeddings, powered by [sqlite-vec](https://github.com/asg017/sqlite-vec) (MIT licensed). Agents store embeddings and query by vector similarity. Also backed by SQLite.

## BYOS (Bring Your Own Storage)
The `ObjectStorage` and `VectorStorage` traits define the storage interface. New backends can be added by implementing these traits. Agent code doesn't change — queue routing handles the switch transparently.

## See Also

- [Storage](../how-to/storage.md) how-to guide
- [Services reference](../reference/services.md) — storage service details
- [Timelines](timelines.md) — how content addressing enables time travel
