# Conversations Repository

The conversations repository is a read-only git projection of VlinderCLI's message DAG, located at `~/.vlinder/conversations/` (or `$VLINDER_DIR/conversations/`). The DAG Git worker writes each message as a git commit. Created automatically on first use.

The authoritative data lives in the SQL DAG store. The git repo is a visualization aid — turning it off changes nothing about how the platform operates.

## Git Commit Format

Every message is a separate git commit. The commit subject follows the format `{type}: {from} → {to}`, with metadata encoded as trailers.

### Invoke Commit (User Input)

```
invoke: cli → todoapp

Session: ses-abc12345
Submission: sub-001
```

### Complete Commit (Agent Response)

```
complete: todoapp → cli

Session: ses-abc12345
Submission: sub-001
State: deadbeef1234...
```

### Request / Response Commits (Service Interactions)

```
request: todoapp → infer

Session: ses-abc12345
Submission: sub-001
```

```
response: infer → todoapp

Session: ses-abc12345
Submission: sub-001
```

### Trailers

| Trailer | Description |
|---------|-------------|
| `Session` | Session ID (`ses-{uuid}`) |
| `Submission` | Submission ID — groups all messages belonging to the same turn |
| `State` | Agent state hash at completion (on `complete` commits only) |

## Accumulated Tree Model

Each commit's tree contains **all** previous message directories plus the new one. Directory names follow the pattern `{YYYYMMDD-HHMMSS.mmm}-{sender}-{type}`:

```
tree of commit 4 (complete: todoapp → cli):
├── 20260213-143005.000-cli-invoke/
├── 20260213-143006.100-todoapp-request/
├── 20260213-143006.500-infer-response/
├── 20260213-143007.200-todoapp-complete/
├── agent.toml
├── platform.toml
└── models/
```

Each message directory contains one file per field — scalar fields as plain text, binary fields as raw blobs, diagnostics as TOML. Every commit is a self-contained snapshot of the entire conversation.

## Branches

| Branch | Purpose |
|--------|---------|
| `main` | Default timeline |
| Named branches | Forked timelines created by `vlinder session fork` |

When the platform forks a timeline, the DAG Git worker creates a corresponding git branch. Both branches share commits before the fork point.

## Reading the Git Log

```bash
cd ~/.vlinder/conversations

# Full conversation timeline
git log --oneline --reverse

# Output:
# a1b2c3d invoke: cli → todoapp
# e5f6789 request: todoapp → infer
# 0123456 response: infer → todoapp
# 789abcd complete: todoapp → cli

# Read a specific message
git log -1 --format=%B a1b2c3d

# Diff between two points
git diff a1b2c3d..789abcd
```

## See Also

- [Conversations Repository explanation](../explanation/conversations-repo.md) — design rationale
- [Timelines](../explanation/timelines.md) — the Merkle DAG model
- [Time-Travel Debugging](../how-to/time-travel-debugging.md) — practical fork workflows
