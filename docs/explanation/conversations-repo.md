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

Every turn is a separate git commit. The commit message format encodes the message type and metadata as trailers.

**User input commit:**
```
user

What is the capital of France?

Session: ses-abc12345
```

**Agent response commit:**
```
agent

The capital of France is Paris.

Session: ses-abc12345
Submission: a1b2c3d4e5f6...
State: deadbeef1234...
```

The `Submission` trailer links the response to its input (the user commit SHA). The `State` trailer records the Merkle DAG state hash at that point — this is what enables [time-travel debugging](../how-to/time-travel-debugging.md).

## Reading the Git Log

Because every turn is a commit, standard git tools work:

```bash
cd ~/.vlinder/conversations

# See the full conversation timeline
git log --oneline --reverse

# Output:
# a1b2c3d user
# e5f6789 agent
# 0123456 user
# 789abcd agent

# Read a specific turn
git log -1 --format=%B a1b2c3d

# See which sessions have activity
git log --oneline -- '*_researcher_*.json'

# Diff between two points in a conversation
git diff a1b2c3d..789abcd
```

## Branching and Forking

Sessions map to the git branch they're on. When you fork a timeline with `vlinder timeline fork <sha>`, the store creates a new branch:

```
main:        user → agent → user → agent
                              ↘
fork-a1b2c3d:                  user → agent  (divergent path)
```

The `latest_state_for_agent()` function naturally follows the current branch — forks are transparent. An agent on a forked branch sees only the history up to the fork point plus any new turns on that branch.

## See Also

- [Timelines](timelines.md) — the Merkle DAG model built on top of this repo
- [Conversations Repository reference](../reference/conversations-repo.md) — session JSON schema and commit format
- [Time-Travel Debugging](../how-to/time-travel-debugging.md) — practical workflows using forks
