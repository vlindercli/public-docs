# Configuration

VlinderCLI is configured via a TOML file at `~/.vlinder/config.toml`. Every value can be overridden with environment variables.

## Default Config

The installer creates this config automatically. If you need to recreate it:

```toml
# ~/.vlinder/config.toml

[logging]
level = "info"

[ollama]
endpoint = "http://localhost:11434"

[queue]
backend = "nats"
nats_url = "nats://localhost:4222"
```

## Logging

Control log verbosity:

```toml
[logging]
level = "info"    # trace, debug, info, warn, error
```

Logs are written as JSONL to `~/.vlinder/logs/vlinder.<date>.jsonl` with 7-day rolling retention.

## Model Providers

### Ollama (local)

```toml
[ollama]
endpoint = "http://localhost:11434"
```

### OpenRouter (remote)

```toml
[openrouter]
endpoint = "https://openrouter.ai/api/v1"
api_key = "sk-or-..."
```

!!! warning
    Avoid committing your `config.toml` with API keys. Use the environment variable instead:
    ```bash
    export VLINDER_OPENROUTER_API_KEY=sk-or-...
    ```

## Queue Backend

The installer configures NATS as the queue backend. NATS is required for agent communication and must be running with JetStream enabled (the installer handles this).

```toml
[queue]
backend = "nats"
nats_url = "nats://localhost:4222"
```

An in-memory queue (`backend = "memory"`) exists for development and testing but does not support distributed deployments.

## Environment Variable Overrides

Any config value can be overridden with a `VLINDER_` prefixed environment variable:

| Variable | Config key | Default |
|----------|-----------|---------|
| `VLINDER_LOGGING_LEVEL` | `logging.level` | `info` |
| `VLINDER_OLLAMA_ENDPOINT` | `ollama.endpoint` | `http://localhost:11434` |
| `VLINDER_OPENROUTER_ENDPOINT` | `openrouter.endpoint` | `https://openrouter.ai/api/v1` |
| `VLINDER_OPENROUTER_API_KEY` | `openrouter.api_key` | (empty) |
| `VLINDER_QUEUE_BACKEND` | `queue.backend` | `nats` |
| `VLINDER_QUEUE_NATS_URL` | `queue.nats_url` | `nats://localhost:4222` |

Example:

```bash
VLINDER_LOGGING_LEVEL=debug vlinder agent run -p ./my-agent
```

## Next Steps

- [Installation](installation.md) — install prerequisites and services
