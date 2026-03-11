# vlinder timeline

Inspect, navigate, and repair timelines.

Timelines are content-addressed submission histories backed by a Merkle DAG. Each user submission produces a state hash; each session is a branch. See [Timelines](../../explanation/timelines.md) for the full model.

## Subcommands

### `vlinder timeline log`

Show the timeline log.

```
vlinder timeline log [OPTIONS]
```

| Option | Default | Description |
|--------|---------|-------------|
| `--agent` | — | Filter timeline entries to a specific agent name |

Displays a chronological log of all submissions (user inputs and agent responses) with their commit SHAs, timestamps, and state hashes. Optionally filter to a single agent.

### `vlinder timeline fork`

Fork the timeline from a historical point.

```
vlinder timeline fork <COMMIT_SHA>
```

| Argument | Description |
|----------|-------------|
| `COMMIT_SHA` | The commit SHA to fork from |

Creates a new branch in the timeline starting from the specified commit. This restores the system state to that historical point, allowing you to replay from there or take a different path.

### `vlinder timeline route`

Show all commits for a session in chronological order.

```
vlinder timeline route <SESSION_ID>
```

| Argument | Description |
|----------|-------------|
| `SESSION_ID` | The session ID to show (e.g. `ses-abc12345`) |

Displays every commit matching the given session — invoke, request, response, and complete messages — in chronological order. Useful for tracing the full chain of messages within a single submission.

### `vlinder timeline checkout`

Move HEAD to a specific point in the timeline.

```
vlinder timeline checkout <TARGET>
```

| Argument | Description |
|----------|-------------|
| `TARGET` | Git commit SHA or ref to move HEAD to |

Moves HEAD to the target commit (detached). Prints the commit's Session, Submission, and State trailers so you know exactly where you are. Typically followed by `timeline repair`.

### `vlinder timeline repair`

Branch from current position and re-execute the agent.

```
vlinder timeline repair [OPTIONS]
```

| Option | Default | Description |
|--------|---------|-------------|
| `-p, --path` | current directory | Path to the agent directory |

Requires detached HEAD (from a prior `checkout`). Creates a `repair-YYYY-MM-DD` branch, restores agent state from the `State:` trailer, deploys the agent, and enters the REPL so you can continue the conversation from that point.

### `vlinder timeline promote`

Promote the current branch to main.

```
vlinder timeline promote
```

No arguments. Labels the old `main` as `broken-YYYY-MM-DD`, moves `main` to the current HEAD, and switches to `main`. Refuses if already on main. Nothing is deleted — the old timeline is preserved under the `broken-` label.

## See Also

- [Time-Travel Debugging](../../how-to/time-travel-debugging.md) how-to guide
- [Timelines](../../explanation/timelines.md) explanation
