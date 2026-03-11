# Environment Variables

All [`config.toml`](config-toml.md) values can be overridden via environment variables using the `VLINDER_` prefix.

## Variable Reference

### General

| Variable | Config equivalent | Default | Description |
|----------|-------------------|---------|-------------|
| `VLINDER_DIR` | — | `~/.vlinder` | Base directory for all VlinderCLI data |
| `VLINDER_WORKER_ROLE` | — | — | Worker role for daemon child processes (set by supervisor) |

### Logging

| Variable | Config equivalent | Default | Description |
|----------|-------------------|---------|-------------|
| `VLINDER_LOGGING_LEVEL` | `logging.level` | `warn` | Log level (`trace`, `debug`, `info`, `warn`, `error`) |

### Providers

| Variable | Config equivalent | Default | Description |
|----------|-------------------|---------|-------------|
| `VLINDER_OLLAMA_ENDPOINT` | `ollama.endpoint` | `http://localhost:11434` | Ollama server URL |
| `VLINDER_OPENROUTER_ENDPOINT` | `openrouter.endpoint` | `https://openrouter.ai/api/v1` | OpenRouter API endpoint |
| `VLINDER_OPENROUTER_API_KEY` | `openrouter.api_key` | — | OpenRouter API key |

### Queue

| Variable | Config equivalent | Default | Description |
|----------|-------------------|---------|-------------|
| `VLINDER_QUEUE_BACKEND` | `queue.backend` | — | Queue backend: `nats` |
| `VLINDER_QUEUE_NATS_URL` | `queue.nats_url` | `nats://localhost:4222` | NATS server URL |
| `VLINDER_QUEUE_NATS_CREDS` | `queue.nats_creds` | — | Path to NATS `.creds` file |

### State

| Variable | Config equivalent | Default | Description |
|----------|-------------------|---------|-------------|
| `VLINDER_STATE_BACKEND` | `state.backend` | — | State backend: `grpc` |

### Distributed

| Variable | Config equivalent | Default | Description |
|----------|-------------------|---------|-------------|
| `VLINDER_DISTRIBUTED_REGISTRY_BACKEND` | `distributed.registry_backend` | `grpc` | Registry backend |
| `VLINDER_DISTRIBUTED_REGISTRY_ADDR` | `distributed.registry_addr` | `http://127.0.0.1:9090` | Registry gRPC address |
| `VLINDER_DISTRIBUTED_STATE_ADDR` | `distributed.state_addr` | `http://127.0.0.1:9092` | State service gRPC address |
| `VLINDER_DISTRIBUTED_HARNESS_ADDR` | `distributed.harness_addr` | `http://127.0.0.1:9091` | Harness gRPC address |
| `VLINDER_DISTRIBUTED_SECRET_ADDR` | `distributed.secret_addr` | `http://127.0.0.1:9093` | Secret store gRPC address |
| `VLINDER_DISTRIBUTED_CATALOG_ADDR` | `distributed.catalog_addr` | `http://127.0.0.1:9094` | Catalog service gRPC address |

### Workers

| Variable | Config equivalent | Default | Description |
|----------|-------------------|---------|-------------|
| `VLINDER_WORKERS_REGISTRY` | `distributed.workers.registry` | `1` | Registry worker count |
| `VLINDER_WORKERS_HARNESS` | `distributed.workers.harness` | `1` | Harness worker count |
| `VLINDER_WORKERS_AGENT_CONTAINER` | `distributed.workers.agent.container` | `1` | Container runtime workers |
| `VLINDER_WORKERS_AGENT_LAMBDA` | `distributed.workers.agent.lambda` | `0` | Lambda runtime workers |
| `VLINDER_WORKERS_INFERENCE_OLLAMA` | `distributed.workers.inference.ollama` | `1` | Ollama inference workers |
| `VLINDER_WORKERS_INFERENCE_OPENROUTER` | `distributed.workers.inference.openrouter` | `0` | OpenRouter inference workers |
| `VLINDER_WORKERS_STORAGE_OBJECT_SQLITE` | `distributed.workers.storage.object.sqlite` | `1` | Object storage workers |
| `VLINDER_WORKERS_STORAGE_VECTOR_SQLITE` | `distributed.workers.storage.vector.sqlite` | `1` | Vector storage workers |
| `VLINDER_WORKERS_DAG_GIT` | `distributed.workers.dag_git` | `1` | DAG git worker count |
| `VLINDER_WORKERS_SESSION_VIEWER` | `distributed.workers.session_viewer` | `1` | Session viewer worker count |

### Runtime

| Variable | Config equivalent | Default | Description |
|----------|-------------------|---------|-------------|
| `VLINDER_RUNTIME_IMAGE_POLICY` | `runtime.image_policy` | `mutable` | Image resolution: `mutable` or `pinned` |
| `VLINDER_RUNTIME_PODMAN_SOCKET` | `runtime.podman_socket` | `auto` | Podman socket path |
| `VLINDER_RUNTIME_SIDECAR_IMAGE` | `runtime.sidecar_image` | `localhost/vlinder-podman-sidecar:latest` | Sidecar container image |
| `VLINDER_RUNTIME_LAMBDA_REGION` | `runtime.lambda_region` | `us-east-1` | AWS region for Lambda |
| `VLINDER_RUNTIME_LAMBDA_MEMORY_MB` | `runtime.lambda_memory_mb` | `512` | Lambda memory in MB |
| `VLINDER_RUNTIME_LAMBDA_TIMEOUT_SECS` | `runtime.lambda_timeout_secs` | `300` | Lambda timeout in seconds |
| `VLINDER_RUNTIME_LAMBDA_VPC_SUBNET_IDS` | `runtime.lambda_vpc_subnet_ids` | — | Comma-separated VPC subnet IDs |
| `VLINDER_RUNTIME_LAMBDA_VPC_SECURITY_GROUP_IDS` | `runtime.lambda_vpc_security_group_ids` | — | Comma-separated VPC security group IDs |

## Precedence

Environment variables take precedence over values in `config.toml`. This is useful for CI/CD, containers, and per-session overrides:

```bash
VLINDER_LOGGING_LEVEL=debug vlinder agent run my-agent
```

## See Also

- [config.toml reference](config-toml.md) for the full configuration file format
