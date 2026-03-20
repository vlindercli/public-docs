# Getting Started

In this tutorial, you'll clone the VlinderCLI repository, build it from source, and run your first command.

**Time:** ~15 minutes

**Prerequisites:** macOS or Linux, a terminal. All other dependencies are installed in Step 1.

## Step 1: Install Prerequisites

Follow the [Installation](../how-to/installation.md) guide to install:

- Rust toolchain (via rustup)
- protobuf-compiler
- NATS
- Podman
- Ollama (if your agents use LLMs)

## Step 2: Clone and Build

```bash
git clone https://github.com/vlindercli/vlindercli.git
cd vlindercli
cargo build --release
export PATH="$PWD/target/release:$PATH"
```

## Step 3: Bootstrap

Create the config directory and a minimal config file. See [Installation — Bootstrap](../how-to/installation.md#bootstrap) for the full config template.

```bash
mkdir -p ~/.vlinder/{agents,conversations,logs}
```

Create `~/.vlinder/config.toml` with at least `[queue]` and `[state]` sections.

## Step 4: Start Services

You need three terminals:

**Terminal 1 — NATS:**
```bash
nats-server -js
```

**Terminal 2 — Ollama** (if using LLM agents):
```bash
ollama serve
```

**Terminal 3 — Vlinder daemon:**
```bash
vlinderd
```

## Step 5: Verify

In a fourth terminal:

```bash
vlinder agent list
```

You should see an empty list — no agents deployed yet.

## Next Steps

- [Your First Agent](your-first-agent.md) — scaffold and run your own agent
- [Adding Models](adding-models.md) — pull and register inference/embedding models
- [Configuration](../how-to/configuration.md) — customize logging and providers
- [Architecture](../explanation/architecture.md) — understand the component model
