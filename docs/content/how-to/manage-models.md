# Manage Models

VlinderCLI uses models for inference (text generation) and embedding (vector search). Models are registered from catalogs and referenced in `agent.toml`.

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

## Add an Embedding Model

Embedding models are used for vector storage and semantic search. Add one from Ollama:

```bash
ollama pull nomic-embed-text
vlinder model add nomic-embed-text
```

The model type (inference or embedding) is detected automatically from the catalog.

Reference it in `agent.toml`:

```toml
[requirements]
services = ["infer", "embed"]

[requirements.models]
phi3 = "ollama://localhost:11434/phi3:latest"
nomic-embed = "ollama://localhost:11434/nomic-embed-text:latest"
```

Your agent can then call `embed(text)` to generate vectors.

## Use a Custom Ollama Endpoint

By default, Vlinder connects to Ollama at `http://localhost:11434`. To use a different endpoint:

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

!!! warning
    Removing a model that's referenced by a deployed agent will cause that agent to fail on inference requests.

## Referencing Models in agent.toml

Models are referenced by URI in the `[requirements.models]` table:

```toml
[requirements.models]
phi3 = "ollama://localhost:11434/phi3:latest"
llama-3-8b = "openrouter://openrouter.ai/llama-3-8b"
nomic-embed = "ollama://localhost:11434/nomic-embed-text:latest"
```

The key (left side) is the alias your agent code uses. The URI (right side) tells Vlinder which backend to route to.

## See Also

- [Adding Models tutorial](../tutorials/adding-models.md) — first introduction
- [model.toml reference](../reference/model-toml.md) — manifest schema
- [CLI: `vlinder model`](../reference/cli/model.md) — full command reference
- [agent.toml](../reference/agent-toml.md) — declaring model requirements
