# Services

Services are the capabilities available to agents at runtime. Agents declare their service requirements in [`agent.toml`](agent-toml.md), and the platform routes requests to the appropriate worker via typed messages on the queue.

## Service Types

| Service type | TOML key | Description |
|--------------|----------|-------------|
| Inference | `infer` | Text generation via LLM |
| Embedding | `embed` | Vector embedding generation |
| Object Storage | `kv` | Persistent key-value storage |
| Vector Storage | `vec` | Similarity search over vector embeddings |

## Providers

Each service type supports one or more backend providers. The agent manifest declares which provider and wire protocol to use per service.

### Inference

| Provider | Description |
|----------|-------------|
| `ollama` | Local inference via Ollama server |
| `openrouter` | Cloud inference via OpenRouter API |

### Embedding

| Provider | Description |
|----------|-------------|
| `ollama` | Local embedding via Ollama server |
| `openrouter` | Cloud embedding via OpenRouter API |

### Object Storage

Backend: SQL — file-backed, durable, content-addressed.

### Vector Storage

Backend: SQL via [sqlite-vec](https://github.com/asg017/sqlite-vec) — similarity search over vector embeddings.

## Wire Protocols

Agents communicate with services using a declared wire protocol. This determines the request/response shape the agent speaks.

| Protocol | Description |
|----------|-------------|
| `openai` | OpenAI-compatible Chat Completion / Embeddings API |
| `anthropic` | Anthropic Messages API |

## Declaring Services

Services are declared in `agent.toml` under `[requirements.services.<type>]`:

```toml
[requirements.services.infer]
provider = "openrouter"
protocol = "anthropic"
models = ["anthropic/claude-3.5-sonnet"]

[requirements.services.embed]
provider = "ollama"
protocol = "openai"
models = ["nomic-embed-text:latest"]
```

Invalid combinations (e.g., an unrecognized provider or service type) fail at parse time.

## Message Routing

All service interactions use typed messages on the queue. The agent sends a `RequestMessage` specifying the service, backend, and operation. The platform routes it to the correct worker via the `RoutingKey`. The worker processes the request and returns a `ResponseMessage`.

See [Queue System](../explanation/queue-system.md) for routing details and NATS subject mapping.

## See Also

- [agent.toml](agent-toml.md) — declaring service requirements
- [Domain Model](../explanation/domain-model.md) — `ServiceBackend` and `Operation` types
- [Queue System](../explanation/queue-system.md) — message types and routing
