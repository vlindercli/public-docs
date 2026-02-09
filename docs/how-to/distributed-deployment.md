# Distributed Deployment

VlinderCLI can scale from a single-process local setup to a multi-process distributed deployment using NATS for messaging and gRPC for registry coordination.

## Prerequisites

- [NATS server](https://nats.io/) with JetStream enabled
- VlinderCLI installed on all worker nodes

## Enable Distributed Mode

You can configure distributed mode via `~/.vlinder/config.toml` or environment variables — both are equivalent. Environment variables override the config file.

=== "config.toml"

    ```toml
    [queue]
    backend = "nats"
    nats_url = "nats://your-nats-server:4222"

    [distributed]
    enabled = true
    registry_addr = "http://registry-host:9090"
    ```

=== "Environment variables"

    ```bash
    export VLINDER_QUEUE_BACKEND=nats
    export VLINDER_QUEUE_NATS_URL=nats://your-nats-server:4222
    export VLINDER_DISTRIBUTED_ENABLED=true
    export VLINDER_DISTRIBUTED_REGISTRY_ADDR=http://registry-host:9090
    ```

## Start the Daemon

The daemon acts as the control plane, spawning workers based on configuration:

```bash
vlinder daemon
```

## Configure Workers

Control how many instances of each service to spawn:

```toml
[distributed.workers]
registry = 1

[distributed.workers.agent]
container = 1

[distributed.workers.inference]
ollama = 2          # Scale up inference
openrouter = 1

[distributed.workers.embedding]
ollama = 1

[distributed.workers.storage.object]
sqlite = 1

[distributed.workers.storage.vector]
sqlite = 1
```

Each worker type scales independently. The supervisor spawns the configured number of workers, and all communication flows through the NATS queue.

## Multi-Node Setup

On additional nodes, point to the shared NATS server and registry. Each node runs its own daemon with worker counts appropriate for its role.

Example: a GPU node that only runs inference workers.

=== "config.toml"

    ```toml
    [queue]
    backend = "nats"
    nats_url = "nats://your-nats-server:4222"

    [distributed]
    enabled = true
    registry_addr = "http://registry-host:9090"

    [distributed.workers]
    registry = 0

    [distributed.workers.agent]
    container = 0

    [distributed.workers.inference]
    ollama = 4

    [distributed.workers.embedding]
    ollama = 0

    [distributed.workers.storage.object]
    sqlite = 0

    [distributed.workers.storage.vector]
    sqlite = 0
    ```

=== "Environment variables"

    ```bash
    VLINDER_QUEUE_NATS_URL=nats://your-nats-server:4222 \
    VLINDER_DISTRIBUTED_REGISTRY_ADDR=http://registry-host:9090 \
    VLINDER_WORKERS_INFERENCE_OLLAMA=4 \
    VLINDER_WORKERS_AGENT_CONTAINER=0 \
    vlinder daemon
    ```

## Architecture

In distributed mode:

- **NATS** handles all message routing between workers across processes and nodes
- The **gRPC registry** provides a shared source of truth for agents and models
- **Workers** connect to both NATS and the registry, processing messages from their service queues
- **Agents** are infrastructure-agnostic — the same `agent.toml` works in both modes

See [Architecture](../explanation/architecture.md) and [Queue System](../explanation/queue-system.md) for deeper understanding.

## See Also

- [config.toml reference](../reference/config-toml.md) — full distributed configuration
- [Queue System](../explanation/queue-system.md) — message flow architecture
- [Architecture](../explanation/architecture.md) — component overview
