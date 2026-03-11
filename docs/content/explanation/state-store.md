# State Store

The State Store is a content-addressed, append-only store that versions every change to an agent's key-value storage. It uses a Merkle DAG object model — values, snapshots, and commits — giving each agent a complete, verifiable history of its state.

This is the mechanism behind the "All state is content-addressed" rule in the [Storage Model](storage-model.md). When you [rewind to a previous turn](time-travel.md), the `state` field on the DAG node points into this store — that's how the platform knows exactly what to restore.

## Three Rules

The State Store follows three rules from which everything else — crash safety, isolation, undo, fork, time travel — falls out as a consequence.

### 1. Immutable objects

Writes create new objects. Old objects are never modified or deleted. A `kv_put` does not overwrite — it appends a new version. The old version still exists, keyed by its content hash.

### 2. Content addressing

Every object is identified by a SHA-256 hash of its content and lineage. Same content in the same context produces the same hash. The platform computes the hash — agents receive it as the return value of each write.

### 3. Platform-managed pointers

"Current state" is a pointer managed by the platform. The data doesn't move — the perspective does. On success, the pointer advances to the latest state commit. On failure, it stays where it was. No explicit transactions needed.

## The Object Model

The object model has three layers — the same pattern git uses for blobs, trees, and commits:

| Layer | Purpose |
|-------|---------|
| Value | Content bytes, keyed by SHA-256 hash |
| Snapshot | Path → value hash mapping at a point in time |
| State commit | Snapshot hash + parent commit hash |
| State pointer | The agent's current state (recorded on complete messages) |

All inserts are idempotent — content-addressed objects are safe to write multiple times.

## How a Write Works

A single `kv_put("/todos.json", new_data)` produces three objects:

```
1. Hash new_data                          → value_hash
2. Clone parent snapshot, update entry    → snapshot' { "/todos.json" → value_hash }
3. Create state commit: snapshot' + parent → commit_b

Before:  HEAD → commit_a → snapshot_a → { "/todos.json" → old_hash }
After:   HEAD → commit_b → snapshot_b → { "/todos.json" → value_hash }

commit_a still exists. old_hash still exists.
```

Multiple writes within a single invocation chain naturally:

```
HEAD → commit_a (initial state)

kv_put("/todos.json", v2)       → commit_b
kv_put("/config.json", cfg)     → commit_c

Success: HEAD → commit_c (pointer advances)
Failure: HEAD → commit_a (pointer doesn't move)
```

Each state commit's hash incorporates its parent, forming a hash chain — the same Merkle chain structure as git commits.

## How a Read Works

`kv_get("/todos.json")` resolves through the current state pointer:

```
state commit hash → snapshot_hash
    → path "/todos.json" → value_hash
        → content bytes
```

Within an invocation, the pointer advances locally — the agent sees its own writes immediately. Other agents and sessions see the last committed head. This is snapshot isolation, emergent from immutability.

## Linking Messages to State

The `CompleteMessage` carries an optional `state` field — the state commit hash at the end of that invocation. This is the bridge between the message DAG and the State Store.

```
CompleteMessage:
    agent: todoapp    session: ses-001    submission: sub-001    state: abc123

State Store:
    state_commits: { hash: "abc123", snapshot_hash: "snap456", parent_hash: "" }
    state_snapshots: { hash: "snap456", entries: {"/todos.json": "val789"} }
    state_values: { hash: "val789", content: [buy milk, walk dog] }
```

Given any DAG node, you can resolve the agent's complete KV state at that point by following the `state` field into the State Store.

## Why This Enables Time Travel

When you fork from a previous turn:

1. **Fork** identifies the target DAG node
2. The platform reads the `state` field from that node
3. The state hash points to a state commit in the State Store
4. The state commit points to a snapshot — the complete path → value mapping at that point
5. The agent is initialized with that state hash, so all reads resolve through the historical snapshot

Because values are immutable and content-addressed, the historical state is always intact — nothing was overwritten or deleted. The State Store doesn't need to "restore" anything; it just reads from a different pointer.

## What Falls Out

These capabilities are consequences of the three rules, not separately implemented features:

| Capability | Mechanism |
|------------|-----------|
| **Crash safety** | Pointer doesn't advance on failure |
| **Isolation** | Concurrent invocations read from their own pointer |
| **Undo** | Move pointer backward |
| **Time travel** | Point at any historical state commit |
| **Fork** | Two pointers from the same parent |
| **Audit** | Walk the commit chain |

## Isolation

Each agent gets its own State Store — there is no shared state between agents. The storage location is derived from the agent's `object_storage` URI declared in `agent.toml`.

## See Also

- [Storage Model](storage-model.md) — the three rules and storage types
- [Timelines](timelines.md) — how state hashes chain into the Merkle DAG
- [Conversations Repository](conversations-repo.md) — the read-only git projection
- [Time-Travel Debugging](../how-to/time-travel-debugging.md) — practical workflows using state restoration
- [Storage](../how-to/storage.md) — how-to guide for agents using KV and vector storage
