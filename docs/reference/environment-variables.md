# Environment Variables

All [`config.toml`](config-toml.md) values can be overridden via environment variables using the `VLINDER_` prefix.

## Variable Reference

| Variable | Config equivalent | Default | Description |
|----------|-------------------|---------|-------------|
| `VLINDER_DIR` | — | `~/.vlinder` | Base directory for all VlinderCLI data |
| `VLINDER_LOGGING_LEVEL` | `logging.level` | `warn` | Application log level (`trace`, `debug`, `info`, `warn`, `error`) |
| `VLINDER_LOGGING_LLAMA_LEVEL` | `logging.llama_level` | `error` | llama.cpp / ggml log level |
| `VLINDER_OLLAMA_ENDPOINT` | `ollama.endpoint` | `http://localhost:11434` | Ollama server URL |
| `VLINDER_OPENROUTER_ENDPOINT` | `openrouter.endpoint` | `https://openrouter.ai/api/v1` | OpenRouter API endpoint |
| `VLINDER_OPENROUTER_API_KEY` | `openrouter.api_key` | — | OpenRouter API key |
| `VLINDER_QUEUE_BACKEND` | `queue.backend` | `nats` | Queue backend |
| `VLINDER_QUEUE_NATS_URL` | `queue.nats_url` | `nats://localhost:4222` | NATS server URL |
| `VLINDER_DISTRIBUTED_ENABLED` | `distributed.enabled` | `false` | Enable distributed mode |
| `VLINDER_DISTRIBUTED_REGISTRY_ADDR` | `distributed.registry_addr` | `http://127.0.0.1:9090` | Registry gRPC address |
| `VLINDER_WORKERS_REGISTRY` | `distributed.workers.registry` | `1` | Registry worker count |
| `VLINDER_WORKERS_AGENT_CONTAINER` | `distributed.workers.agent.container` | `1` | Agent container runtime workers |
| `VLINDER_WORKERS_INFERENCE_OLLAMA` | `distributed.workers.inference.ollama` | `1` | Ollama inference workers |
| `VLINDER_WORKERS_INFERENCE_OPENROUTER` | `distributed.workers.inference.openrouter` | `0` | OpenRouter inference workers |
| `VLINDER_WORKERS_EMBEDDING_OLLAMA` | `distributed.workers.embedding.ollama` | `1` | Ollama embedding workers |
| `VLINDER_WORKERS_STORAGE_OBJECT_SQLITE` | `distributed.workers.storage.object.sqlite` | `1` | SQLite object storage workers |
| `VLINDER_WORKERS_STORAGE_VECTOR_SQLITE` | `distributed.workers.storage.vector.sqlite` | `1` | SQLite vector storage workers |

## Precedence

Environment variables take precedence over values in `config.toml`. This is useful for CI/CD, containers, and per-session overrides:

```bash
VLINDER_LOGGING_LEVEL=debug vlinder agent run -p ./my-agent
```

## See Also

- [config.toml reference](config-toml.md) for the full configuration file format
- [Configuration](../how-to/configuration.md) how-to guide
