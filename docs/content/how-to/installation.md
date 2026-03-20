# Installation

## Prerequisites

| Component | Role | Required |
|-----------|------|----------|
| **Rust toolchain** | Building from source | Yes |
| **protobuf-compiler** | Protobuf code generation (gRPC) | Yes |
| **NATS** | Message queue for agent communication | Yes (must be running) |
| **Podman** | Container runtime for agents | Yes |
| **Ollama** | LLM inference and embedding | Yes for agents that use LLMs (must be running) |

!!! warning "Runtime services"
    NATS and Ollama are not just install-time dependencies — they must be **running** when you start the daemon. The daemon will fail to start without NATS, and agents that use LLMs will fail without Ollama.

=== "macOS"

    ```bash
    # Rust toolchain (use rustup, not brew's rust package)
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"

    # Build tools
    brew install protobuf

    # Runtime dependencies
    brew install nats-server
    brew install podman

    # Ollama (optional, needed for LLM agents)
    # Install from https://ollama.com
    ```

=== "Linux (Debian/Ubuntu)"

    ```bash
    # Rust toolchain (use rustup, not apt's rustc package)
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"

    # Build tools
    sudo apt install -y protobuf-compiler

    # Runtime dependencies
    curl -fsSL https://get.nats.io | sh
    sudo apt install -y podman

    # Ollama (optional, needed for LLM agents)
    curl -fsSL https://ollama.com/install.sh | sh
    ```

=== "Linux (Fedora/RHEL)"

    ```bash
    # Rust toolchain (use rustup, not dnf's rust package)
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"

    # Build tools
    sudo dnf install -y protobuf-compiler

    # Runtime dependencies
    curl -fsSL https://get.nats.io | sh
    sudo dnf install -y podman

    # Ollama (optional, needed for LLM agents)
    curl -fsSL https://ollama.com/install.sh | sh
    ```

=== "Linux (Arch)"

    ```bash
    # Rust toolchain (use rustup, not pacman's rust package — pacman's is often outdated)
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"

    # Build tools
    sudo pacman -S protobuf

    # Runtime dependencies
    curl -fsSL https://get.nats.io | sh
    sudo pacman -S podman

    # Ollama (optional, needed for LLM agents)
    curl -fsSL https://ollama.com/install.sh | sh
    ```

## Build from Source

```bash
git clone https://github.com/vlindercli/vlindercli.git
cd vlindercli
cargo build --release
```

Install the binaries:

=== "macOS"

    ```bash
    cp target/release/vlinder /usr/local/bin/vlinder
    cp target/release/vlinderd /usr/local/bin/vlinderd
    ```

=== "Linux"

    ```bash
    sudo cp target/release/vlinder /usr/local/bin/vlinder
    sudo cp target/release/vlinderd /usr/local/bin/vlinderd
    ```

Or add the build output to your PATH instead:

```bash
export PATH="$PWD/target/release:$PATH"
```

## Bootstrap

Create the data directory and a minimal config:

```bash
mkdir -p ~/.vlinder/{agents,conversations,logs}
```

Create `~/.vlinder/config.toml`:

```toml
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

!!! note "The `[state]` section is required"
    The daemon will fail to start without `[state]`. Both `[queue]` and `[state]` are mandatory sections.

## Start Services

You need three services running before you can use vlinder. Open separate terminals for each:

### Terminal 1: NATS

Start NATS with JetStream enabled:

```bash
nats-server -js
```

### Terminal 2: Ollama (if using LLM agents)

```bash
ollama serve
```

Pull the models your agents need:

```bash
ollama pull nomic-embed-text   # embedding model
ollama pull phi3                # inference model (example)
```

### Terminal 3: Vlinder Daemon

```bash
vlinderd
```

### Terminal 4: CLI

```bash
vlinder agent list
```

## Directory Structure

After setup, `~/.vlinder/` contains:

```
~/.vlinder/
├── config.toml         # Global configuration
├── nats.conf           # NATS config (JetStream enabled)
├── nats-data/          # NATS JetStream storage
├── agents/             # Agent data and storage
├── conversations/      # Conversations git projection
├── logs/               # JSONL log files
├── registry.db         # Registry database
└── dag.db              # DAG database
```

## Next Steps

- [Getting Started](../tutorials/getting-started.md) — full tutorial from build to first agent
- [Configuration](configuration.md) — customize logging and providers
- [Manage Models](manage-models.md) — add models for inference
