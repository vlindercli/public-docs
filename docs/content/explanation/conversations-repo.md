# Conversations Repository

The Conversations Repository is a **read-only git projection** of VlinderCLI's message DAG. The DAG Git worker tails the message stream and writes each message as a git commit at `~/.vlinder/conversations/`. This gives you `git log`, `git diff`, and standard git tooling for inspecting agent conversations — without the git repo being part of the system.

The authoritative data lives in the SQL DAG store. The git repo is a visualization aid. Turning it off changes nothing about how the platform operates.

## Why Project to Git?

Developers already know git. By projecting the internal Merkle DAG into git commits, the platform makes its internal structure inspectable with tools everyone has installed. You can browse conversation history, diff between points, and trace the full chain of service interactions — all with standard git commands.

## Git Commit Structure

Every message is a separate git commit. The commit subject follows the format `{type}: {from} → {to}`, with metadata encoded as trailers.

**Invoke commit** (user input):
```
invoke: cli → todoapp

Session: ses-abc12345
Submission: sub-001
```

**Complete commit** (agent response):
```
complete: todoapp → cli

Session: ses-abc12345
Submission: sub-001
State: deadbeef1234...
```

The subject line encodes the message type (`invoke`, `request`, `response`, `complete`) and the sender/receiver pair. The `Submission` trailer groups all messages belonging to the same turn. The `State` trailer on complete messages projects the agent's state hash — the same value stored on the DAG node's `state` field.

## Accumulated Tree Model

Each commit's tree contains **all** previous message directories plus the new one. Directory names follow the pattern `{YYYYMMDD-HHMMSS.mmm}-{sender}-{type}`:

```
tree of commit 3 (complete: todoapp → cli):
├── 20260213-143005.000-cli-invoke/        ← from commit 1
├── 20260213-143006.100-todoapp-complete/   ← from commit 2
├── 20260213-143010.000-cli-invoke/        ← from commit 3 (previous invoke)
├── 20260213-143011.200-todoapp-complete/   ← new in this commit
├── agent.toml
├── platform.toml
└── models/
```

Each message directory contains one file per field — scalar fields as plain text, binary fields as raw blobs, diagnostics as TOML. This accumulated design means every commit is a self-contained snapshot of the entire conversation.

## Reading the Git Log

Because every message is a commit, standard git tools work:

```bash
cd ~/.vlinder/conversations

# See the full conversation timeline
git log --oneline --reverse

# Output:
# a1b2c3d invoke: cli → todoapp
# e5f6789 complete: todoapp → cli
# 0123456 invoke: cli → todoapp
# 789abcd complete: todoapp → cli

# Read a specific message
git log -1 --format=%B a1b2c3d

# Diff between two points in a conversation
git diff a1b2c3d..789abcd
```

## Forking in the Projection

When the platform forks a timeline (via `vlinder session fork`), the DAG Git worker creates a corresponding git branch. This means repair branches are visible in the git projection too — `git branch` shows all timelines, and `git log` on each branch shows the divergent history.

Both branches share commits before the fork point, so the storage cost is minimal.

## See Also

- [Timelines](timelines.md) — the Merkle DAG model and repair workflow
- [State Store](state-store.md) — the versioned store that state hashes point into
- [Conversations Repository reference](../reference/conversations-repo.md) — commit format details
- [Time-Travel Debugging](../how-to/time-travel-debugging.md) — practical repair workflows
