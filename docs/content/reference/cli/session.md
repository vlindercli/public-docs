# vlinder session

Inspect and manage agent sessions.

Sessions are independent Merkle chains — each session is an island with its own submission history. See [Timelines](../../explanation/timelines.md) for the full model.

## Subcommands

### `vlinder session list`

List sessions for an agent.

```
vlinder session list <AGENT_NAME>
```

| Argument | Description |
|----------|-------------|
| `AGENT_NAME` | Name of the agent |

### `vlinder session get`

Show turns and messages in a session.

```
vlinder session get <SESSION_ID>
```

| Argument | Description |
|----------|-------------|
| `SESSION_ID` | Session ID (e.g., `wired-pig-543e`) |

### `vlinder session fork`

Create a named branch from a point in the DAG.

```
vlinder session fork <SESSION_ID> --from <HASH> --name <BRANCH>
```

| Argument / Option | Description |
|-------------------|-------------|
| `SESSION_ID` | Session ID containing the fork point |
| `--from` | Canonical hash of the DAG node to fork from |
| `--name` | Branch name for the new timeline |

Creates a new timeline branch, restoring agent state to the specified point. Use this to rewind to a completed turn and try a different path.

### `vlinder session promote`

Seal the old timeline and promote a branch.

```
vlinder session promote <BRANCH>
```

| Argument | Description |
|----------|-------------|
| `BRANCH` | Branch name to promote |

Seals the parent timeline and relabels it as `broken-YYYY-MM-DD`. The promoted branch becomes the active timeline. Nothing is deleted — the old timeline is preserved.

### `vlinder session branches`

List branches (timelines) forked from a session.

```
vlinder session branches <SESSION_ID>
```

| Argument | Description |
|----------|-------------|
| `SESSION_ID` | Session ID |

## See Also

- [Time-Travel Debugging](../../how-to/time-travel-debugging.md) how-to guide
- [Timelines](../../explanation/timelines.md) explanation
- [Time Travel](../../explanation/time-travel.md) explanation
