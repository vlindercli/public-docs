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

The installer already set up Ollama and registered `phi3`. In this tutorial you'll add more models from both sources.

## Step 1: See What You Have

```bash
vlinder model list
```

You should see `phi3` registered from the install step.

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

!!! note
    OpenRouter requires an API key. Set it before browsing:

    ```bash
    export VLINDER_OPENROUTER_API_KEY=sk-or-...
    ```

    Or add it to `~/.vlinder/config.toml`:

    ```toml
    [openrouter]
    api_key = "sk-or-..."
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
phi3 = "ollama://localhost:11434/phi3:latest"
llama3 = "ollama://localhost:11434/llama3:latest"
```

Your agent code can now call `infer()` with either model. The model alias (left side) is what your agent uses; the URI (right side) tells Vlinder where to route the request.

For OpenRouter models, the URI uses the `openrouter://` scheme:

```toml
[requirements.models]
llama-3-8b = "openrouter://openrouter.ai/llama-3-8b"
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
- How to reference models in `agent.toml` using `ollama://` and `openrouter://` URIs

## Next Steps

- [Your First Agent](your-first-agent.md) — scaffold and run your own agent
- [Your First Fleet](your-first-fleet.md) — compose multiple agents with delegation
- [Manage Models](../how-to/manage-models.md) — embedding models and advanced configuration
- [model.toml reference](../reference/model-toml.md) — full manifest schema
