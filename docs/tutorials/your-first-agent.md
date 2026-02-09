# Your First Agent

In this tutorial, you'll scaffold a new agent from a template, explore the generated code, build the container, and run it interactively.

**Time:** ~10 minutes

**Prerequisites:** [Development setup](../develop.md) complete. Podman and Ollama running.

## Step 1: Scaffold the Agent

Use `vlinder agent new` to create a project from a template. Pick any language you're comfortable with:

```bash
vlinder agent new python my-agent
```

Available languages: `python`, `golang`, `js`, `ts`, `java`, `dotnet`.

This creates a `my-agent/` directory with everything you need:

```
my-agent/
├── agent.toml   # Agent manifest
├── agent.py     # Agent source code
├── Dockerfile   # Container image definition
├── build.sh     # Build script
└── README.md    # Template documentation
```

## Step 2: Explore agent.toml

```bash
cd my-agent
```

Open `agent.toml` — the manifest that tells Vlinder what your agent needs:

```toml title="agent.toml"
name = "my-agent"
description = "A starter agent — greets users, remembers names, and fetches fun facts."
runtime = "container"
executable = "localhost/my-agent:latest"
object_storage = "sqlite://data/objects.db"

[requirements]
services = ["infer", "kv"]

[requirements.models]
phi3 = "ollama://localhost:11434/phi3:latest"
```

Key fields:

- **`name`** — identifies the agent in the registry
- **`runtime`** — always `"container"` (agents run as OCI containers)
- **`executable`** — the container image reference
- **`object_storage`** — SQLite-backed key-value storage for persisting data
- **`requirements.services`** — platform services the agent uses (`infer` for LLM, `kv` for storage)
- **`requirements.models`** — maps model aliases to Ollama endpoints

## Step 3: Explore the Agent Code

The generated source file implements an HTTP server on port 8080. Vlinder sends user messages as POST requests and reads the plain-text response.

The template includes a **bridge helper library** — one function per platform service:

| Function | Endpoint | Description |
|----------|----------|-------------|
| `infer(prompt, max_tokens)` | `/infer` | LLM completion |
| `embed(text)` | `/embed` | Text embedding |
| `kv_get(path)` | `/kv/get` | Read from storage |
| `kv_put(path, content)` | `/kv/put` | Write to storage (base64) |
| `kv_list(prefix)` | `/kv/list` | List storage keys |
| `kv_delete(path)` | `/kv/delete` | Delete from storage |
| `vector_store(key, vector, metadata)` | `/vector/store` | Store vector |
| `vector_search(vector, limit)` | `/vector/search` | Search vectors |
| `vector_delete(key)` | `/vector/delete` | Delete vector |
| `delegate(agent, input)` | `/delegate` | Delegate to another agent |
| `wait(handle)` | `/wait` | Wait for delegation result |

The agent calls these helpers to talk to the **bridge** — a sidecar HTTP server that Vlinder runs alongside your container. The bridge URL is provided via the `VLINDER_BRIDGE_URL` environment variable.

The template's main logic:

- **"my name is Alice"** → stores the name in KV storage
- **"who am i?"** → retrieves the name from KV storage
- **"surprise me"** → asks the LLM for a fun fact via inference

## Step 4: Build the Container

```bash
./build.sh
```

This runs `podman build` to create the container image at `localhost/my-agent:latest`.

## Step 5: Run the Agent

```bash
vlinder agent run
```

Vlinder loads `agent.toml`, validates that `phi3` is available via Ollama, starts the container, and opens an interactive REPL.

Try it out:

```
> my name is Alice
Nice to meet you, Alice! I'll remember that.

> who am i?
You're Alice!

> surprise me
The shortest war in recorded history lasted 38 minutes, between Britain and Zanzibar in 1896.
```

## Step 6: Verify the Timeline

After running your agent, check that interactions were recorded:

```bash
vlinder timeline log --agent my-agent
```

Every conversation turn is stored in a git-backed timeline, enabling [time-travel debugging](../how-to/time-travel-debugging.md).

## Step 7: Make It Your Own

1. Edit the source file — change the message handler to implement your logic
2. Update `agent.toml` — change the name, description, models, and services
3. Rebuild with `./build.sh`
4. Run again with `vlinder agent run`

## What You Learned

- How to scaffold a new agent with `vlinder agent new`
- The structure of an [`agent.toml`](../reference/agent-toml.md) manifest
- How agents communicate with platform services via bridge helpers
- How to build and run an agent container
- How interactions are recorded in the timeline

## Next Steps

- [Your First Fleet](your-first-fleet.md) — compose agents into a fleet with delegation
- [Storage](../how-to/storage.md) — advanced storage patterns
- [Services reference](../reference/services.md) — all available platform services
- [agent.toml reference](../reference/agent-toml.md) — full field reference
