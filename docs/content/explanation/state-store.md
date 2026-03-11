# State Store

The State Store is a content-addressed, append-only SQLite database that versions every change to an agent's key-value storage. It mirrors git's object model — values, snapshots, and commits — giving each agent a complete, verifiable history of its state.

This is the mechanism behind the "All state is content-addressed" rule in the [Storage Model](storage-model.md). When you [repair a timeline](../how-to/time-travel-debugging.md), the `State:` trailer on the conversation commit points into this store — that's how the platform knows exactly what to restore.

## Three Rules

The State Store follows three rules from which everything else — crash safety, isolation, undo, fork, time travel — falls out as a consequence.

### 1. Immutable objects

Writes create new objects. Old objects are never modified or deleted. A `kv_put` does not overwrite — it appends a new version. The old version still exists, keyed by its content hash.

### 2. Content addressing

Every object is identified by a SHA-256 hash of its content and lineage. Same content in the same context produces the same hash. The platform computes the hash — agents receive it as the return value of each write.

### 3. Platform-managed pointers

"Current state" is a pointer managed by the platform. The data doesn't move — the perspective does. On success, the pointer advances to the latest state commit. On failure, it stays where it was. No explicit transactions needed.

## The Object Model

Git has blobs (content), trees (directory listings), and commits (tree + parent). The State Store uses the same structure in SQLite:

| Git | State Store | SQLite table | Purpose |
|-----|-------------|--------------|---------|
| Blob | Value | `state_values` | Content bytes, keyed by SHA-256 hash |
| Tree | Snapshot | `state_snapshots` | Path → value hash mapping at a point in time |
| Commit | State commit | `state_commits` | Snapshot hash + parent commit hash |
| HEAD | State pointer | `State:` trailer | The agent's current state (recorded on conversation commits) |

All inserts are idempotent (`INSERT OR IGNORE`) — content-addressed objects are safe to write multiple times.

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
state commit hash → state_commits table → snapshot_hash
    → state_snapshots table → path "/todos.json" → value_hash
        → state_values table → content bytes
```

Within an invocation, the pointer advances locally — the agent sees its own writes immediately. Other agents and sessions see the last committed head. This is snapshot isolation, emergent from immutability.

## Linking Conversations to State

The conversation repository (git) and the State Store (SQLite) are two parallel timelines. They connect at turn boundaries via the `State:` trailer on complete messages:

```
Conversation (git):
    invoke: cli → todoapp        Session: ses-001  Submission: sub-001
    complete: todoapp → cli      Session: ses-001  Submission: sub-001  State: abc123

State Store (SQLite):
    state_commits: { hash: "abc123", snapshot_hash: "snap456", parent_hash: "" }
    state_snapshots: { hash: "snap456", entries: {"/todos.json": "val789"} }
    state_values: { hash: "val789", content: [buy milk, walk dog] }
```

The `State: abc123` trailer is the bridge. Given any conversation commit, you can look up its `State:` trailer and resolve the agent's complete KV state at that point.

## Why This Enables Time Travel

When you run `vlinder timeline checkout` + `repair`:

1. **Checkout** moves HEAD to a historical conversation commit
2. **Repair** reads the `State:` trailer from that commit
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

## Storage Location

The State Store SQLite file is derived from the agent's `object_storage` URI declared in `agent.toml`:

- `sqlite:///path/to/data.db` → state store at `/path/to/state.db` (sibling file)
- `memory://` → temporary file (tests only, does not persist)

Each agent gets its own State Store — there is no shared state between agents.

## See Also

- [Storage Model](storage-model.md) — the three rules and storage types
- [Timelines](timelines.md) — how state hashes chain into the Merkle DAG
- [Conversations Repository](conversations-repo.md) — the git side of the two-store model
- [Time-Travel Debugging](../how-to/time-travel-debugging.md) — practical workflows using state restoration
- [Storage](../how-to/storage.md) — how-to guide for agents using KV and vector storage
