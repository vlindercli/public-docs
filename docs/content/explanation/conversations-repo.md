# Conversations Repository

Every conversation turn in VlinderCLI is persisted in a git repository at `~/.vlinder/conversations/`. This repository records user inputs and agent responses as git commits, forming the interaction history that agents use for context across turns.

It does not store agent side effects (vector embeddings, object storage data). Those live in the [storage backends](storage-model.md) (SQLite). The conversations repo tracks the turns and the state hashes that link to the Merkle DAG — not the data itself.

## Why a Git Repository?

The conversations repo serves two purposes:

1. **Conversation persistence** — session state survives restarts. When you resume an agent, it picks up where it left off by loading the session file and replaying history into the prompt.

2. **Merkle DAG backend** — git's commit chain provides the content-addressed, append-only history that powers [timelines](timelines.md). Each commit SHA is a submission ID; each branch is a session timeline. Forking a timeline is a `git checkout -b`.

## What's on Disk

The repository contains one JSON file per session:

```
~/.vlinder/conversations/
├── .git/
├── 2026-02-08T14-30-05Z_researcher_abc12345.json
├── 2026-02-09T09-15-22Z_coordinator_def67890.json
└── 2026-02-09T11-00-00Z_researcher_1a2b3c4d.json
```

Filenames follow the pattern `{datetime}_{agent}_{short_session_id}.json`. The datetime is filesystem-safe (hyphens instead of colons). The short session ID is the first 8 characters of the UUID.

## Session Lifecycle

A session file tracks the state of a single conversation:

1. **Created** when you start an interactive session (`vlinder agent run` or `vlinder fleet run`)
2. **Updated** on every turn — user input sets the `open` field, agent response clears it and appends to `history`
3. **Committed** to git after every update — user inputs and agent responses are separate commits

The `open` field is a transaction marker:

- `open: null` — conversation is at rest, all turns complete
- `open: "some question"` — user has submitted input, agent hasn't responded yet

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

The subject line encodes the message type (`invoke`, `request`, `response`, `complete`) and the sender/receiver pair. The `Submission` trailer groups all messages belonging to the same turn. The `State` trailer on complete messages records the agent's state hash at that point — this is what enables [time-travel debugging](../how-to/time-travel-debugging.md).

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

This accumulated design means every commit is a self-contained snapshot of the entire conversation. It also means `git cherry-pick` works without conflicts — each message occupies a unique timestamped directory, so commits never touch the same paths. Top-level metadata files (`agent.toml`, `platform.toml`, `models/`) are regenerated fresh on each commit.

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

# Read a specific turn
git log -1 --format=%B a1b2c3d

# See which sessions have activity
git log --oneline -- '*_researcher_*.json'

# Diff between two points in a conversation
git diff a1b2c3d..789abcd
```

## Branching and Forking

Sessions map to the git branch they're on. Branching happens in two ways:

- **`vlinder timeline fork <sha>`** — creates a branch at any commit (low-level)
- **`vlinder timeline checkout` + `repair`** — checks out a commit, creates a `repair-YYYY-MM-DD` branch, restores state, and enters the REPL (recommended for debugging)

After a repair, `vlinder timeline promote` relabels the old `main` as `broken-YYYY-MM-DD` and moves `main` to the repair branch:

```
main (after promote):     invoke → complete → invoke → complete (repaired)
                                                ↗
broken-2026-02-13:        invoke → complete → invoke → complete (original)
```

Both branches share commits before the fork point. The `latest_state_for_agent()` function naturally follows the current branch — forks are transparent. An agent on a repair branch sees only the history up to the fork point plus any new turns on that branch.

## See Also

- [Timelines](timelines.md) — the Merkle DAG model built on top of this repo
- [State Store](state-store.md) — the SQLite store that State: trailers point into
- [Conversations Repository reference](../reference/conversations-repo.md) — session JSON schema and commit format
- [Time-Travel Debugging](../how-to/time-travel-debugging.md) — practical workflows using checkout/repair/promote
