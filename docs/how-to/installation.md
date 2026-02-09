# Installation

## Prerequisites

| Component | Role | Required |
|-----------|------|----------|
| **Rust toolchain** | Building from source | Yes |
| **protobuf-compiler** | Protobuf code generation | Yes |
| **NATS** | Message queue for distributed agent communication | Yes |
| **Podman** | Container runtime for agents | Yes |
| **Ollama** | LLM inference and embedding | No (but needed for agents that use LLMs) |

=== "macOS"

    ```bash
    # Build tools
    brew install protobuf
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # Runtime dependencies
    brew install nats-server
    brew install podman
    ```

=== "Linux (Debian/Ubuntu)"

    ```bash
    # Build tools
    sudo apt install -y protobuf-compiler
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # Runtime dependencies
    curl -fsSL https://get.nats.io | sh
    sudo apt install -y podman
    ```

=== "Linux (Fedora/RHEL)"

    ```bash
    # Build tools
    sudo dnf install -y protobuf-compiler
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # Runtime dependencies
    curl -fsSL https://get.nats.io | sh
    sudo dnf install -y podman
    ```

## Build from Source

```bash
git clone https://github.com/vlindercli/vlindercli.git
cd vlindercli
cargo build --release
cp target/release/vlindercli /usr/local/bin/vlinder
```

## Bootstrap

Create the data directory and a default config:

```bash
mkdir -p ~/.vlinder/{agents,conversations,logs,registry}
```

Create `~/.vlinder/config.toml`:

```toml
[distributed]
enabled = true

[distributed.workers.agent]
container = 1

[distributed.workers.inference]
ollama = 1

[queue]
backend = "nats"
```

## Start Services

### NATS

Start NATS with JetStream enabled:

=== "macOS (launchd)"

    ```bash
    # Create a minimal NATS config
    cat > ~/.vlinder/nats.conf << 'EOF'
    listen: 127.0.0.1:4222
    jetstream {
      store_dir: ~/.vlinder/nats-data
    }
    EOF

    nats-server -c ~/.vlinder/nats.conf -D &
    ```

=== "Linux (systemd)"

    ```bash
    nats-server -js -p 4222 &
    ```

### Vlinder Daemon

```bash
vlinder daemon
```

## Verify

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
├── conversations/      # Timeline git repository
├── logs/               # JSONL log files
└── registry/           # Registry data
```

## Next Steps

- [Getting Started](../tutorials/getting-started.md) — full tutorial from build to first agent
- [Configuration](configuration.md) — customize logging and providers
- [Manage Models](manage-models.md) — add models for inference
