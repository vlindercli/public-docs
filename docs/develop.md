# Develop

Build and run VlinderCLI from source. This is the recommended way to try it while the project is in active development.

## Prerequisites

| Dependency | Purpose | Install |
|-----------|---------|---------|
| **Rust** | Build the CLI | [rustup.rs](https://rustup.rs) |
| **just** | Task runner | `cargo install just` |
| **NATS server** | Message queue | `brew install nats-server` (macOS) or [nats.io/download](https://nats.io/download/) |
| **nats CLI** | Monitor messages | `brew install nats-io/nats-tools/nats` (macOS) or [GitHub releases](https://github.com/nats-io/natscli/releases) |
| **Podman** | Container runtime | `brew install podman` (macOS) or [podman.io](https://podman.io/docs/installation) |
| **Ollama** | Local LLM inference | [ollama.com](https://ollama.com) |

## Clone and build

```bash
git clone https://github.com/vlindercli/vlindercli.git
cd vlindercli
cargo build
```

## Configure

Create `~/.vlinder/config.toml`:

```toml
[logging]
level = "info"

[ollama]
endpoint = "http://localhost:11434"

[queue]
backend = "nats"
nats_url = "nats://localhost:4222"

[distributed]
enabled = true
registry_addr = "http://127.0.0.1:9090"

[distributed.workers]
registry = 1

[distributed.workers.agent]
container = 1

[distributed.workers.inference]
ollama = 1

[distributed.workers.embedding]
ollama = 1

[distributed.workers.storage.object]
sqlite = 1

[distributed.workers.storage.vector]
sqlite = 1
```

## Run (four terminals)

VlinderCLI's distributed architecture uses NATS for message passing between workers. You'll need four terminals:

=== "Terminal 1 — NATS"

    Start the NATS server with JetStream enabled:

    ```bash
    nats-server -js
    ```

    You should see `Server is ready` and `JetStream is enabled`.

=== "Terminal 2 — NATS subscriber"

    Monitor all vlinder messages on the bus:

    ```bash
    nats sub "vlinder.>"
    ```

    This shows every message flowing through the system in real time — dispatches, inference calls, KV operations, agent responses. Invaluable for understanding what's happening.

=== "Terminal 3 — Daemon"

    Start the vlinder daemon (spawns registry, agent, inference, storage workers):

    ```bash
    cargo run -- daemon
    ```

=== "Terminal 4 — CLI"

    Run commands:

    ```bash
    # Register a model
    cargo run -- model add phi3

    # Build and run an agent
    just run echo-container

    # Run the support fleet
    just build-support-fleet
    just support
    ```

## Build agent images

Agents run as OCI containers. Build them with `just`:

```bash
just build-echo-container       # simple echo test
just build-todoapp              # todo list with OpenRouter
just build-support-fleet        # support + code-analyst + log-analyst
```

See all available recipes:

```bash
just --list
```

## What to expect

With all four terminals running, you should see:

- **Terminal 1** (NATS): connection logs as workers subscribe
- **Terminal 2** (subscriber): typed messages flowing — `vlinder.dispatch.*`, `vlinder.infer.*`, `vlinder.kv.*`
- **Terminal 3** (daemon): worker startup logs, registry listening on `:9090`
- **Terminal 4** (CLI): agent output, interactive REPL for fleets
