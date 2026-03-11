# Time-Travel Debugging

VlinderCLI records every agent interaction as a commit in a git-based timeline. This enables you to inspect history, travel back to any point, repair from there, and promote the fixed timeline to main.

## View the Timeline

Show the full system timeline:

```bash
vlinder timeline log
```

Filter to a specific agent:

```bash
vlinder timeline log --agent echo-agent
```

Each entry shows the commit SHA, timestamp, agent name, and submission summary.

## Inspect a Submission

To see every message in a single submission (invoke, requests, responses, complete), use `route` with the session ID:

```bash
vlinder timeline route ses-abc12345
```

This shows all commits for that session in chronological order — useful for understanding exactly what happened during a turn.

## Travel Back to a Known-Good Point

Identify the commit you want to return to using `timeline log`, then checkout:

```bash
vlinder timeline checkout b3c4d5e
```

This moves HEAD to that commit (detached) and prints the Session, Submission, and State trailers so you can confirm you're at the right point.

## Repair and Continue

Once you've checked out a known-good commit, create a repair branch and re-enter the REPL:

```bash
vlinder timeline repair -p agents/todoapp
```

This:

1. Creates a `repair-YYYY-MM-DD` branch from the current detached HEAD
2. Restores the agent's state from the `State:` trailer on that commit
3. Deploys the agent and enters the REPL

You can now continue the conversation from the historical point, taking a different path.

## Promote the Repaired Timeline

After verifying the repair branch works correctly, make it the new main:

```bash
vlinder timeline promote
```

This labels the old `main` as `broken-YYYY-MM-DD` (nothing is deleted), moves `main` to the current HEAD, and switches to `main`.

## Workflow Example

```bash
# 1. Run your agent
vlinder agent run -p agents/todoapp

# 2. Check the timeline (filter to high-level view)
vlinder timeline log --oneline --grep="^invoke:" --grep="^complete:"

# 3. Checkout the last good point
vlinder timeline checkout b3c4d5e
# At: complete: todoapp → cli
# Session:    ses-abc12345
# Submission: sub-003
# State:      a1b2c3d4...
#
# Use 'vlinder timeline repair' to re-execute from this point.

# 4. Repair — branch off and re-execute
vlinder timeline repair -p agents/todoapp
# Created branch 'repair-2026-02-13' from b3c4d5e
# Session:    ses-abc12345
# Submission: sub-003
# State:      a1b2c3d4...
# Restoring state a1b2c3d4…
#
# vlinder> (you're now in the REPL at the historical state)

# 5. Promote the repair branch to main
vlinder timeline promote
# Old main labeled as 'broken-2026-02-13'.
# Promoted 'repair-2026-02-13' to main.
```

## How It Works

- Conversations are stored in `~/.vlinder/conversations/` as a git repository
- Each message (invoke, response, complete) becomes a git commit with trailers: `Session`, `Submission`, and `State`
- The `State:` trailer records the agent's state hash at that point — this is what enables state restoration during repair
- Checkout detaches HEAD; repair creates a branch and restores state from the trailer
- Promote relabels branches — nothing is deleted, both timelines are preserved

For the full design, see [Timelines (Explanation)](../explanation/timelines.md).

## See Also

- [CLI: `vlinder timeline`](../reference/cli/timeline.md) — command reference
- [Timelines](../explanation/timelines.md) — versioned state and content addressing
- [Conversations Repository](../explanation/conversations-repo.md) — git commit structure and accumulated tree model
- [Observability](observability.md) — inspecting logs alongside timelines
