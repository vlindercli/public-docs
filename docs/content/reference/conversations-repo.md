# Conversations Repository

The conversations repository is a git repo at `~/.vlinder/conversations/` (or `$VLINDER_DIR/conversations/`) that stores conversation turns. Created automatically on first use.

## Directory Structure

```
~/.vlinder/conversations/
├── .git/
├── {datetime}_{agent}_{short_id}.json
├── {datetime}_{agent}_{short_id}.json
└── ...
```

## Filename Format

```
{datetime}_{agent}_{short_id}.json
```

| Component | Format | Example |
|-----------|--------|---------|
| `datetime` | `YYYY-MM-DDTHH-MM-SSZ` (filesystem-safe UTC) | `2026-02-08T14-30-05Z` |
| `agent` | Agent name from `agent.toml` | `researcher` |
| `short_id` | First 8 chars of session UUID | `abc12345` |

Example: `2026-02-08T14-30-05Z_researcher_abc12345.json`

## Session JSON Schema

```json
{
  "open": "What about its population?",
  "session": "ses-abc12345-6789-0abc-def0-123456789abc",
  "agent": "researcher",
  "history": [
    {
      "user": "Tell me about Paris",
      "submission": "a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2",
      "at": "2026-02-08T14:30:05Z"
    },
    {
      "agent": "Paris is the capital of France, known for the Eiffel Tower and its rich cultural history.",
      "at": "2026-02-08T14:30:47Z"
    },
    {
      "user": "What about its population?",
      "submission": "f6e5d4c3b2a1f6e5d4c3b2a1f6e5d4c3b2a1f6e5",
      "at": "2026-02-08T14:31:02Z"
    }
  ]
}
```

### Top-level Fields

| Field | Type | Description |
|-------|------|-------------|
| `open` | `string \| null` | Current unanswered input. `null` when conversation is at rest. |
| `session` | `string` | Session ID. Format: `ses-{uuid}`. |
| `agent` | `string` | Agent name this session belongs to. |
| `history` | `array` | Completed conversation turns (see below). |

### History Entry: User

| Field | Type | Description |
|-------|------|-------------|
| `user` | `string` | The user's input text. |
| `submission` | `string` | Git commit SHA of the user input commit. |
| `at` | `string` | UTC ISO 8601 timestamp. |

### History Entry: Agent

| Field | Type | Description |
|-------|------|-------------|
| `agent` | `string` | The agent's response text. |
| `at` | `string` | UTC ISO 8601 timestamp. |

History entries are untagged — distinguish them by checking for the `user` or `agent` key.

## Git Commit Format

Each turn (user input or agent response) is a separate git commit. The commit message encodes the type and metadata.

### User Input Commit

```
user

<user input text>

Session: <session_id>
```

| Trailer | Value |
|---------|-------|
| `Session` | Session ID (`ses-{uuid}`) |

The commit SHA becomes the `SubmissionId` used throughout the system.

### Agent Response Commit

```
agent

<agent response text>

Session: <session_id>
Submission: <user_commit_sha>
State: <state_hash>
```

| Trailer | Value |
|---------|-------|
| `Session` | Session ID (`ses-{uuid}`) |
| `Submission` | SHA of the corresponding user input commit |
| `State` | Merkle DAG state hash (optional, present when state tracking is active) |

## Branches

| Branch | Purpose |
|--------|---------|
| `main` | Default timeline |
| `fork-{short_sha}` | Forked timeline created by `vlinder timeline fork` |

## See Also

- [Conversations Repository explanation](../explanation/conversations-repo.md) — how it works and why
- [Timelines](../explanation/timelines.md) — the Merkle DAG model
- [Time-Travel Debugging](../how-to/time-travel-debugging.md) — practical fork workflows
