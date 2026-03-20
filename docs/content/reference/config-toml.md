# config.toml

Global VlinderCLI configuration. Located at `~/.vlinder/config.toml` (or `$VLINDER_DIR/config.toml`).

All values can be overridden with [environment variables](environment-variables.md).

## Full Example

```toml
[logging]
level = "info"

[ollama]
endpoint = "http://localhost:11434"

[openrouter]
endpoint = "https://openrouter.ai/api/v1"
api_key = "sk-or-..."

[queue]
backend = "nats"
nats_url = "nats://localhost:4222"
nats_creds = "~/.nats.creds"

[state]
backend = "grpc"

[distributed]
registry_addr = "http://0.0.0.0:9090"
state_addr = "http://0.0.0.0:9092"
harness_addr = "http://0.0.0.0:9091"
secret_addr = "http://0.0.0.0:9093"
catalog_addr = "http://0.0.0.0:9094"

[distributed.workers]
registry = 1
harness = 1
dag_git = 1
session_viewer = 1

[distributed.workers.agent]
container = 1
lambda = 0

[distributed.workers.inference]
ollama = 1
openrouter = 0

[distributed.workers.storage.object]
sqlite = 1

[distributed.workers.storage.vector]
sqlite = 1

[runtime]
image_policy = "mutable"
podman_socket = "auto"
sidecar_image = "localhost/vlinder-podman-sidecar:latest"
```

## Sections

### `[logging]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `level` | string | `"warn"` | Log level: `trace`, `debug`, `info`, `warn`, `error`. Applies to vlinderd only — external crates are suppressed to `warn`. |

### `[ollama]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `endpoint` | string | `"http://localhost:11434"` | Ollama server URL |

### `[openrouter]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `endpoint` | string | `"https://openrouter.ai/api/v1"` | OpenRouter API endpoint |
| `api_key` | string | — | OpenRouter API key |

### `[queue]`

Required section — the daemon refuses to start without it.

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `backend` | string | — | Queue backend: `"nats"` |
| `nats_url` | string | `"nats://localhost:4222"` | NATS server URL |
| `nats_creds` | string | — | Optional path to a NATS `.creds` file for authenticated connections |

### `[state]`

Required section — the daemon refuses to start without it.

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `backend` | string | — | State backend: `"grpc"` |

### `[distributed]`

gRPC addresses for inter-worker communication. All workers connect to these services at startup.

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `registry_addr` | string | `"http://0.0.0.0:9090"` | Registry gRPC address |
| `state_addr` | string | `"http://0.0.0.0:9092"` | State service gRPC address |
| `harness_addr` | string | `"http://0.0.0.0:9091"` | Harness gRPC address (CLI → daemon) |
| `secret_addr` | string | `"http://0.0.0.0:9093"` | Secret store gRPC address |
| `catalog_addr` | string | `"http://0.0.0.0:9094"` | Catalog service gRPC address |

### `[distributed.workers]`

Worker counts control how many instances of each service type to spawn. Setting a count to `0` disables that worker type.

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `registry` | integer | `1` | Registry worker count |
| `harness` | integer | `1` | Harness worker count |
| `dag_git` | integer | `1` | DAG git worker count (singleton recommended) |
| `session_viewer` | integer | `1` | Session viewer worker count |

#### `[distributed.workers.agent]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `container` | integer | `1` | Container runtime workers (Podman) |
| `lambda` | integer | `0` | Lambda runtime workers (AWS) |

#### `[distributed.workers.inference]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `ollama` | integer | `1` | Ollama inference workers |
| `openrouter` | integer | `0` | OpenRouter inference workers |

#### `[distributed.workers.storage.object]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `sqlite` | integer | `1` | Object storage workers |

#### `[distributed.workers.storage.vector]`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `sqlite` | integer | `1` | Vector storage workers |

### `[runtime]`

Container and Lambda runtime configuration.

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `image_policy` | string | `"mutable"` | Image resolution: `"mutable"` (use tag) or `"pinned"` (use content-addressed digest) |
| `podman_socket` | string | `"auto"` | Podman socket: `"auto"` (probe filesystem), `"disabled"` (CLI only), or an absolute path |
| `sidecar_image` | string | `"localhost/vlinder-podman-sidecar:latest"` | OCI image for the sidecar container |
| `lambda_region` | string | `"us-east-1"` | AWS region for Lambda functions |
| `lambda_memory_mb` | integer | `512` | Lambda memory allocation in MB |
| `lambda_timeout_secs` | integer | `300` | Lambda execution timeout in seconds |
| `lambda_vpc_subnet_ids` | array of strings | `[]` | VPC subnet IDs for Lambda ENI placement |
| `lambda_vpc_security_group_ids` | array of strings | `[]` | VPC security group IDs for Lambda ENIs |

## See Also

- [Environment Variables](environment-variables.md) for override syntax
- [Architecture](../explanation/architecture.md) for worker types and startup sequence
- [Distributed Deployment](../how-to/distributed-deployment.md) for multi-node setups
