# Distributed Deployment

VlinderCLI can scale from a single-process local setup to a multi-process distributed deployment using NATS for messaging and gRPC for service coordination.

## Prerequisites

- [NATS server](https://nats.io/) with JetStream enabled
- VlinderCLI installed on all worker nodes

## Configure the Daemon

Point all workers at the shared NATS server and gRPC services:

=== "config.toml"

    ```toml
    [queue]
    backend = "nats"
    nats_url = "nats://your-nats-server:4222"

    [state]
    backend = "grpc"

    [distributed]
    registry_addr = "http://registry-host:9090"
    state_addr = "http://registry-host:9092"
    harness_addr = "http://registry-host:9091"
    secret_addr = "http://registry-host:9093"
    catalog_addr = "http://registry-host:9094"
    ```

=== "Environment variables"

    ```bash
    export VLINDER_QUEUE_NATS_URL=nats://your-nats-server:4222
    export VLINDER_DISTRIBUTED_REGISTRY_ADDR=http://registry-host:9090
    export VLINDER_DISTRIBUTED_STATE_ADDR=http://registry-host:9092
    export VLINDER_DISTRIBUTED_HARNESS_ADDR=http://registry-host:9091
    ```

## Start the Daemon

```bash
vlinderd
```

## Configure Workers

Control how many instances of each service to spawn:

```toml
[distributed.workers]
registry = 1
harness = 1
dag_git = 1
session_viewer = 1

[distributed.workers.agent]
container = 1
lambda = 0

[distributed.workers.inference]
ollama = 2          # Scale up inference
openrouter = 1

[distributed.workers.storage.object]
sqlite = 1

[distributed.workers.storage.vector]
sqlite = 1
```

Each worker type scales independently. Setting a count to `0` disables that worker type. The supervisor spawns the configured number of workers, and all communication flows through the NATS queue.

## Multi-Node Setup

On additional nodes, point to the shared NATS server and gRPC services. Each node runs its own daemon with worker counts appropriate for its role.

Example: a GPU node that only runs inference workers.

=== "config.toml"

    ```toml
    [queue]
    backend = "nats"
    nats_url = "nats://your-nats-server:4222"

    [state]
    backend = "grpc"

    [distributed]
    registry_addr = "http://registry-host:9090"
    state_addr = "http://registry-host:9092"
    harness_addr = "http://registry-host:9091"
    secret_addr = "http://registry-host:9093"
    catalog_addr = "http://registry-host:9094"

    [distributed.workers]
    registry = 0
    harness = 0
    dag_git = 0
    session_viewer = 0

    [distributed.workers.agent]
    container = 0

    [distributed.workers.inference]
    ollama = 4

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
    VLINDER_WORKERS_REGISTRY=0 \
    VLINDER_WORKERS_HARNESS=0 \
    vlinderd
    ```

## Architecture

In distributed mode:

- **NATS** handles all message routing between workers across processes and nodes
- **gRPC services** (registry, state, harness, secret, catalog) provide shared coordination
- **Workers** connect to both NATS and the gRPC services, processing messages from their service queues
- **Agents** are infrastructure-agnostic — the same `agent.toml` works regardless of deployment topology

See [Architecture](../explanation/architecture.md) and [Queue System](../explanation/queue-system.md) for deeper understanding.

## See Also

- [config.toml reference](../reference/config-toml.md) — full configuration schema
- [Queue System](../explanation/queue-system.md) — message flow architecture
- [Architecture](../explanation/architecture.md) — component overview
