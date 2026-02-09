# Your First Fleet

In this tutorial, you'll compose two agents into a fleet — a coordinator that triages input and a researcher that answers questions. You'll see how delegation works between agents.

**Time:** ~20 minutes

**Prerequisites:** Completed [Your First Agent](your-first-agent.md). Podman and Ollama running.

## Step 1: Scaffold the Fleet

```bash
vlinder fleet new my-fleet
```

This creates a `my-fleet/` directory with a starter `fleet.toml`.

```bash
cd my-fleet
```

## Step 2: Add Two Agents

Use `vlinder agent new` to scaffold agents inside the fleet:

```bash
mkdir -p agents
vlinder agent new python agents/coordinator
vlinder agent new python agents/researcher
```

Your directory now looks like this:

```
my-fleet/
├── fleet.toml
└── agents/
    ├── coordinator/
    │   ├── agent.toml
    │   ├── agent.py
    │   ├── Dockerfile
    │   ├── build.sh
    │   └── README.md
    └── researcher/
        ├── agent.toml
        ├── agent.py
        ├── Dockerfile
        ├── build.sh
        └── README.md
```

## Step 3: Wire Up fleet.toml

Open `fleet.toml` and replace the commented-out template with your agents:

```toml title="fleet.toml"
name = "my-fleet"
entry = "coordinator"

[agents.coordinator]
path = "agents/coordinator"

[agents.researcher]
path = "agents/researcher"
```

- **`entry`** — the agent that receives user input
- **`agents.<name>.path`** — relative path to each agent's directory (must contain an `agent.toml`)

## Step 4: Add Delegation to the Coordinator

The scaffolded agents work standalone, but in a fleet the coordinator should delegate to the researcher. Open `agents/coordinator/agent.py` and modify the request handler to use the `delegate()` and `wait()` bridge helpers:

```python title="agents/coordinator/agent.py (handle_request)"
def handle_request(user_input):
    lower = user_input.lower()

    # Delegate research questions to the researcher agent
    if any(word in lower for word in ["what", "why", "how", "explain"]):
        handle = delegate("researcher", user_input)
        return wait(handle)

    # Handle greetings directly
    return infer(f"Respond briefly to: {user_input}")
```

The coordinator now routes questions to the researcher and handles everything else itself. Both `delegate()` and `wait()` are already available from the template's bridge helpers.

## Step 5: Build the Containers

```bash
podman build -t localhost/my-fleet-coordinator:latest agents/coordinator/
podman build -t localhost/my-fleet-researcher:latest agents/researcher/
```

Update the `executable` field in each `agent.toml` to match these image names:

```toml title="agents/coordinator/agent.toml"
executable = "localhost/my-fleet-coordinator:latest"
```

```toml title="agents/researcher/agent.toml"
executable = "localhost/my-fleet-researcher:latest"
```

## Step 6: Run the Fleet

```bash
vlinder fleet run
```

Vlinder loads `fleet.toml`, deploys both agents, and starts an interactive session with the coordinator.

Try it out:

```
❯ hello
Hello! How can I help you today?

❯ what is the fastest land animal?
The cheetah is the fastest land animal, reaching speeds up to 70 mph.
```

The first message is handled directly by the coordinator. The second is delegated to the researcher — the coordinator recognizes it as a question and passes it along.

## Step 7: Observe Delegation

Inspect the timeline to see both agents' interactions:

```bash
# See all interactions
vlinder timeline log

# Filter to just the researcher
vlinder timeline log --agent researcher
```

## What You Learned

- How to scaffold a fleet with `vlinder fleet new`
- How to add agents to a fleet using `vlinder agent new`
- How to write a [`fleet.toml`](../reference/fleet-toml.md) manifest
- How the entry agent delegates work to other agents using `delegate()` and `wait()`
- How to observe delegation in the timeline

## Next Steps

- [Agents Model](../explanation/agents-model.md) — understand delegation semantics
- [Observability](../how-to/observability.md) — deeper log inspection
- [Distributed Deployment](../how-to/distributed-deployment.md) — scale your fleet across nodes
