# Manage Models

VlinderCLI uses models for inference (text generation) and embedding (vector search). Models are registered from catalogs and referenced by name in `agent.toml`.

For a first introduction, see the [Adding Models](../tutorials/adding-models.md) tutorial.

## Browse Available Models

Query a catalog to see what you can add:

```bash
# All catalogs
vlinder model available

# Filter by name
vlinder model available llama

# Specific catalog
vlinder model available --catalog openrouter
```

## Add a Model

Add from Ollama (default catalog):

```bash
ollama pull phi3
vlinder model add phi3
```

Add from OpenRouter:

```bash
vlinder model add llama-3-8b --catalog openrouter
```

## Add an Embedding Model

Embedding models are used for vector storage and semantic search:

```bash
ollama pull nomic-embed-text
vlinder model add nomic-embed-text
```

The model type (inference or embedding) is detected automatically from the catalog.

## Use a Custom Ollama Endpoint

```bash
vlinder model add phi3 --endpoint http://192.168.1.50:11434
```

Or set it permanently in `~/.vlinder/config.toml`:

```toml
[ollama]
endpoint = "http://192.168.1.50:11434"
```

## Configure OpenRouter

Set your API key via environment variable:

```bash
export VLINDER_OPENROUTER_API_KEY=sk-or-...
```

Or in `~/.vlinder/config.toml`:

```toml
[openrouter]
api_key = "sk-or-..."
```

Then add models from the OpenRouter catalog:

```bash
vlinder model add llama-3-8b --catalog openrouter
```

## List and Remove Models

List all registered models:

```bash
vlinder model list
```

Remove a model:

```bash
vlinder model remove phi3
```

Removing deregisters the model from Vlinder. It doesn't delete the Ollama model from disk.

## Referencing Models in agent.toml

Models are referenced by registry name. Two forms are supported:

**Table form** — alias differs from registry name:

```toml
[requirements.models]
inference_model = "claude-sonnet"
embedding_model = "nomic-embed-text"
```

**Array form** — alias equals registry name:

```toml
[requirements]
models = ["phi3", "nomic-embed-text"]
```

The alias (left side in table form) is what your agent code uses. The value (right side) is the model's registry name.

## See Also

- [Adding Models tutorial](../tutorials/adding-models.md) — first introduction
- [model.toml reference](../reference/model-toml.md) — manifest schema
- [CLI: `vlinder model`](../reference/cli/model.md) — full command reference
- [agent.toml](../reference/agent-toml.md) — declaring model requirements
