# Time-Travel Debugging

VlinderCLI records every agent interaction as a commit in a git-based timeline. This enables you to inspect history, fork from any point, and replay with different inputs.

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

## Fork from a Historical Point

Identify the commit you want to fork from using `timeline log`, then:

```bash
vlinder timeline fork abc123def
```

This creates a new branch from the specified commit. The system state is restored to that point, and you can submit new inputs that diverge from the original history.

## Workflow Example

```bash
# 1. Run your agent and have a conversation
vlinder agent run -p ./my-agent

# 2. Check the timeline
vlinder timeline log
# commit a1b2c3d  2024-01-15 10:30  echo-agent  "What is Rust?"
# commit d4e5f6a  2024-01-15 10:31  echo-agent  "Explain ownership"
# commit b7c8d9e  2024-01-15 10:32  echo-agent  "How do lifetimes work?"

# 3. Fork from the second interaction
vlinder timeline fork d4e5f6a

# 4. Now re-run the agent — you're back at the state after "Explain ownership"
vlinder agent run -p ./my-agent
```

## How It Works

- Conversations are stored in `~/.vlinder/conversations/` as a git repository
- Each user submission becomes a git commit with the submission ID as the commit SHA
- Each agent response includes a state hash (Merkle DAG) for integrity verification
- Forking creates a git branch, enabling parallel exploration paths

For the full design, see [Timelines (Explanation)](../explanation/timelines.md).

## See Also

- [CLI: `vlinder timeline`](../reference/cli/timeline.md) — command reference
- [Timelines](../explanation/timelines.md) — versioned state and content addressing
- [Observability](observability.md) — inspecting logs alongside timelines
