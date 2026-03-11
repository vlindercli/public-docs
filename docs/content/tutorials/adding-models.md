# Adding Models

In this tutorial, you'll explore model catalogs, add models from both Ollama and OpenRouter, and use them in an agent.

**Time:** ~10 minutes

**Prerequisites:** [Getting Started](getting-started.md) complete. Verify the daemon is running:

```bash
vlinder agent list
```

If this errors with "Cannot reach registry", the daemon isn't running.

## Two Model Sources

VlinderCLI supports two model catalogs:

| Catalog | Runs | Cost | Best for |
|---------|------|------|----------|
| **Ollama** | Locally on your machine | Free | Development, privacy, offline work |
| **OpenRouter** | Cloud API | Pay per token | Larger models, production quality |

## Step 1: See What You Have

```bash
vlinder model list
```

## Step 2: Browse Available Models

### Ollama

See what's available locally through Ollama:

```bash
vlinder model available --catalog ollama
```

Filter by name:

```bash
vlinder model available llama --catalog ollama
```

### OpenRouter

Browse cloud models via OpenRouter:

```bash
vlinder model available --catalog openrouter
```

OpenRouter requires an API key:

```bash
export VLINDER_OPENROUTER_API_KEY=sk-or-...
```

## Step 3: Add an Ollama Model

Pull a model through Ollama first, then register it with Vlinder:

```bash
ollama pull llama3
vlinder model add llama3
```

The `--catalog ollama` flag is optional — Ollama is the default catalog.

Verify it's registered:

```bash
vlinder model list
```

## Step 4: Add an OpenRouter Model

With your API key configured, add a cloud model:

```bash
vlinder model add llama-3-8b --catalog openrouter
```

This registers the model without downloading anything — inference happens via the OpenRouter API.

## Step 5: Use a Model in Your Agent

Open your agent's `agent.toml` and add the new model to the requirements:

```toml title="agent.toml"
[requirements.models]
phi3 = "phi3"
llama3 = "llama3"
```

The key (left side) is the alias your agent code uses. The value (right side) is the model's registry name. For simple cases where the alias matches the name, you can use the array form:

```toml
[requirements]
models = ["phi3", "llama3"]
```

## Step 6: Remove a Model

```bash
vlinder model remove llama3
```

This deregisters the model from Vlinder. It doesn't delete the Ollama model from disk — you can re-add it anytime.

## What You Learned

- VlinderCLI has two model catalogs: Ollama (local) and OpenRouter (cloud)
- How to browse available models with `vlinder model available`
- How to add and remove models with `vlinder model add` and `vlinder model remove`
- How to reference models in `agent.toml` by registry name

## Next Steps

- [Your First Agent](your-first-agent.md) — scaffold and run your own agent
- [Your First Fleet](your-first-fleet.md) — compose multiple agents with delegation
- [Manage Models](../how-to/manage-models.md) — embedding models and advanced configuration
- [model.toml reference](../reference/model-toml.md) — full manifest schema
