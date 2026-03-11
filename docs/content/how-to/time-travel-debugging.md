# Time-Travel Debugging

VlinderCLI records every agent interaction as a node in a content-addressed DAG. This enables you to inspect history, rewind to any completed turn, fork a new timeline, and continue from there.

## View Session History

List sessions for an agent:

```bash
vlinder session list my-agent
```

Inspect a specific session's turns and messages:

```bash
vlinder session get ses-abc12345
```

## Inspect a Turn

To see every message in a single turn (invoke, requests, responses, complete):

```bash
vlinder turn get sub-001
```

This shows all DAG nodes belonging to the submission in order — useful for understanding exactly what happened during a turn.

## Fork from a Known-Good Point

Identify the DAG node hash you want to rewind to using `vlinder session get`, then fork:

```bash
vlinder session fork ses-abc12345 --from a1b2c3d4 --name fix-typo
```

This creates a new timeline branch called `fix-typo`, restoring agent state to that point.

## Continue on the Forked Timeline

Run the agent on the forked branch:

```bash
vlinder agent run my-agent --branch fix-typo
```

You're now in the REPL at the historical state. Continue the conversation, taking a different path.

## Promote the Fixed Timeline

After verifying the forked branch works correctly, promote it:

```bash
vlinder session promote fix-typo
```

This seals the old timeline (relabeled as `broken-YYYY-MM-DD`) and makes the forked branch the active one. Nothing is deleted — the old timeline is preserved.

## Workflow Example

```bash
# 1. Run your agent
vlinder agent run todoapp

# 2. Something goes wrong — inspect the session
vlinder session list todoapp
vlinder session get wired-pig-543e

# 3. Find the last good turn and fork
vlinder session fork wired-pig-543e --from a1b2c3d4 --name fix-2026-03-11

# 4. Run the agent on the forked branch
vlinder agent run todoapp --branch fix-2026-03-11

# 5. Promote the fixed timeline
vlinder session promote fix-2026-03-11
```

## How It Works

- Every message (invoke, request, response, complete) is recorded as a node in a content-addressed Merkle DAG stored in SQL
- Each completed turn produces a state hash — the agent's exact state at that point
- Forking creates a new timeline branch, restoring the agent's state from the DAG
- The conversations git repo at `~/.vlinder/conversations/` provides a read-only projection for browsing with standard git tools

For the full design, see [Time Travel](../explanation/time-travel.md) and [Timelines](../explanation/timelines.md).

## See Also

- [CLI: `vlinder session`](../reference/cli/session.md) — command reference
- [CLI: `vlinder turn`](../reference/cli/turn.md) — turn inspection
- [Time Travel](../explanation/time-travel.md) — rewind, fork, continue model
- [Timelines](../explanation/timelines.md) — Merkle DAG and content addressing
- [Observability](observability.md) — inspecting logs alongside sessions
