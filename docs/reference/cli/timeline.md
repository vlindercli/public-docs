# vlinder timeline

Inspect and fork timelines.

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

## See Also

- [Time-Travel Debugging](../../how-to/time-travel-debugging.md) how-to guide
- [Timelines](../../explanation/timelines.md) explanation
