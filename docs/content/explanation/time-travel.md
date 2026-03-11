# Time Travel

When an AI agent gets something wrong, you need to go back, understand what happened, and try again. VlinderCLI makes this possible because every interaction is recorded as a content-addressed DAG node — so any historical state is always addressable and restorable.

## How It Works

A conversation is a chain of turns. Each turn is an invoke → complete cycle — user input in, agent response out. At the end of each turn, the `CompleteMessage` carries a `state` field: the content-addressed hash of the agent's KV state.

To go back in time:

1. Pick a completed turn in the conversation history
2. Fork a new timeline from that point
3. The platform restores the agent's state from the hash on that turn
4. Continue — the agent picks up from the restored state as if the bad turns never happened

The agent doesn't know it's on a forked timeline. It receives an invocation with restored state and processes it like any other turn.

## The Workflow

The `vlinder session` commands make this concrete:

1. `vlinder session list <agent>` — find the session
2. `vlinder session get <session-id>` — browse turns, identify where things went wrong
3. `vlinder session fork <session-id> --from <hash> --name <branch>` — create a timeline from a known-good turn
4. Continue the conversation on the new timeline
5. `vlinder session promote <branch>` — seal the old timeline, make the new one canonical

The branch name ties the workflow together. Multiple forks of the same session can exist independently.

## Forking, Not Just Retrying

Because the DAG is content-addressed, you're not limited to retrying the same input. Fork a completed turn and try a different model, a different prompt, a different approach entirely. Compare results across timelines.

Multiple divergent timelines can coexist from the same fork point. The old timeline is preserved for auditing — nothing is deleted.

## Finer Granularity via Fleets

Time travel operates at the turn boundary. If a turn made five service calls and the third produced a bad result, you retry the entire turn.

For finer control, decompose complex work into a [fleet](agents-model.md#fleets) of smaller agents. Each agent has its own turns. What was one big turn with five service calls becomes five agents with independently addressable turns.

## See Also

- [Timelines](timelines.md) — sessions, forking, and the Merkle DAG
- [State Store](state-store.md) — how state restoration works
- [Agents Model](agents-model.md) — fleets and delegation
