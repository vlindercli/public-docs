# Configuration

VlinderCLI is configured via a TOML file at `~/.vlinder/config.toml`. Every value can be overridden with environment variables.

## Minimal Config

The daemon requires `[queue]` and `[state]` sections:

```toml
# ~/.vlinder/config.toml

[logging]
level = "info"

[ollama]
endpoint = "http://localhost:11434"

[queue]
backend = "nats"
nats_url = "nats://localhost:4222"

[state]
backend = "grpc"
```

## Logging

Control log verbosity:

```toml
[logging]
level = "info"    # trace, debug, info, warn, error
```

The configured level applies to vlinderd only — external crates are suppressed to `warn`.

Logs are written as JSONL to `~/.vlinder/logs/`.

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

Avoid committing your `config.toml` with API keys. Use the environment variable instead:

```bash
export VLINDER_OPENROUTER_API_KEY=sk-or-...
```

## Queue Backend

NATS is the queue backend. It must be running with JetStream enabled.

```toml
[queue]
backend = "nats"
nats_url = "nats://localhost:4222"
nats_creds = "~/.nats.creds"  # optional, for authenticated connections
```

## Environment Variable Overrides

Any config value can be overridden with a `VLINDER_` prefixed environment variable:

```bash
VLINDER_LOGGING_LEVEL=debug vlinder agent run my-agent
```

See [Environment Variables](../reference/environment-variables.md) for the full override table.

## Next Steps

- [Installation](installation.md) — install prerequisites and services
- [config.toml reference](../reference/config-toml.md) — full configuration schema
