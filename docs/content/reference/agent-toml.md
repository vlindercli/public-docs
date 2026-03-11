# agent.toml

The agent manifest declares an agent's identity, runtime, requirements, and configuration. It lives in the agent's directory (e.g., `my-agent/agent.toml`).

## Full Example

```toml
name = "finqa"
description = "Financial Q&A agent"
source = "https://github.com/example/finqa"
runtime = "container"
executable = "localhost/finqa:latest"

object_storage = "sqlite:///data/objects.db"
vector_storage = "sqlite:///data/vectors.db"

[requirements.models]
inference_model = "claude-sonnet"
embedding_model = "nomic-embed"

[requirements.services.infer]
provider = "openrouter"
protocol = "anthropic"
models = ["anthropic/claude-3.5-sonnet"]

[requirements.services.embed]
provider = "ollama"
protocol = "openai"
models = ["nomic-embed-text:latest"]

[requirements.mounts.knowledge]
s3 = "vlinder-support/v0.1.0/"
path = "/knowledge"

[prompts]
intent_recognition = "Classify the user's intent."
answer_generation = "Answer the user's question using the provided context."
```

## Field Reference

### Top-level fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | yes | Unique name for the agent |
| `description` | string | yes | Human-readable description |
| `source` | string | no | Source URL (e.g., a git repository) |
| `runtime` | string | yes | Execution runtime: `"container"` or `"lambda"` |
| `executable` | string | yes | Runtime-specific executable reference (see below) |
| `object_storage` | string | no | Resource URI for object (key-value) storage |
| `vector_storage` | string | no | Resource URI for vector (similarity search) storage |

**`executable`** depends on the runtime:
- **Container** — OCI image reference (e.g., `localhost/my-agent:latest`)
- **Lambda** — AWS Lambda function identifier
- **File-based runtimes** — `file://` URI or bare path, resolved relative to the manifest directory

**Storage URIs** use a scheme to select the backend (e.g., `sqlite:///path/to/db`, `memory://name`, `s3://bucket/prefix`). Relative paths in `sqlite://` URIs are resolved against the manifest directory.

### `[requirements]`

The requirements section declares what the agent needs. All subsections are optional — omit what the agent doesn't use.

### `[requirements.models]`

Model declarations support two forms:

**Table form** — alias differs from registry name:

```toml
[requirements.models]
inference_model = "claude-sonnet"
embedding_model = "nomic-embed"
```

**Array form** — alias equals registry name:

```toml
[requirements]
models = ["claude-sonnet", "nomic-embed"]
```

The key (or array element) is the alias the agent uses internally. The value is the model's registry name.

### `[requirements.services.<type>]`

Service declarations bind a service type to a provider and wire protocol. The `<type>` key is one of:

| Service type | Description |
|--------------|-------------|
| `infer` | LLM inference |
| `embed` | Text embedding |
| `kv` | Object (key-value) storage |
| `vec` | Vector (similarity search) storage |

Each service entry has:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `provider` | string | yes | Backend provider: `"ollama"` or `"openrouter"` |
| `protocol` | string | yes | Wire protocol: `"openai"` or `"anthropic"` |
| `models` | array of strings | no | Model names available through this service |

Invalid combinations (e.g., an unrecognized provider or protocol) fail at parse time.

### `[requirements.mounts.<name>]`

S3 mount declarations. Each named mount maps an S3 bucket (or prefix) to a read-only directory inside the agent container, backed by s3fs-fuse.

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `s3` | string | yes | S3 bucket and optional prefix (e.g., `"my-bucket/v0.1.0/"`) |
| `path` | string | yes | Mount point inside the container (e.g., `"/knowledge"`) |
| `endpoint` | string | no | S3-compatible endpoint URL (defaults to AWS) |
| `secret` | string | no | Credential reference for private buckets |

Inline form is also valid:

```toml
[requirements.mounts]
knowledge = { s3 = "my-bucket/v0.1.0/", path = "/knowledge" }
```

### `[prompts]`

Application-specific prompt overrides. All fields are optional strings.

| Field | Description |
|-------|-------------|
| `intent_recognition` | Intent classification prompt |
| `query_expansion` | Query expansion prompt |
| `answer_generation` | Answer generation prompt |
| `map_summarize` | Map-phase summarization prompt |
| `reduce_summaries` | Reduce-phase summarization prompt |
| `direct_summarize` | Direct summarization prompt |

## See Also

- [Your First Agent](../tutorials/your-first-agent.md) tutorial
- [CLI: `vlinder agent`](cli/agent.md)
- [Services reference](services.md) for service types and providers
- [fleet.toml reference](fleet-toml.md) for multi-agent setups
