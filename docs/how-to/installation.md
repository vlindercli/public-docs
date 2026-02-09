# Installation

## Quick Install

The install script works on both macOS and Linux:

```bash
curl -fsSL https://vlindercli.dev/install.sh | sh
```

The script will:

1. Download the latest vlinder binary for your platform
2. Create `~/.vlinder/` with a default config
3. Check for prerequisites and tell you what's missing
4. Set up NATS and the vlinder daemon as system services
5. Pull the default model and install the support fleet (a reference implementation)

If prerequisites are missing, the script stops after step 3 and prints the install commands you need. Install them, then re-run the script.

### Prerequisites

| Component | Role | Required |
|-----------|------|----------|
| **NATS** | Message queue for distributed agent communication | Yes |
| **Podman** | Container runtime for agents | Yes |
| **Ollama** | LLM inference and embedding | No (but needed for agents that use LLMs) |

=== "macOS"

    ```bash
    brew install nats-server
    brew install podman
    curl -fsSL https://ollama.com/install.sh | sh
    ```

=== "Linux (Debian/Ubuntu)"

    ```bash
    curl -fsSL https://get.nats.io | sh
    sudo apt install -y podman
    curl -fsSL https://ollama.com/install.sh | sh
    ```

=== "Linux (Fedora/RHEL)"

    ```bash
    curl -fsSL https://get.nats.io | sh
    sudo dnf install -y podman
    curl -fsSL https://ollama.com/install.sh | sh
    ```

### What gets installed

After a successful install, you'll see:

```
  Vlinder Installer
  =================

  ✓ Platform     aarch64-apple-darwin
  ✓ Version      v0.1.0
  ✓ Binary       /usr/local/bin/vlinder
  ✓ Data dir     ~/.vlinder
  ✓ Config       ~/.vlinder/config.toml
  ✓ nats-server  found
  ✓ podman       found
  ✓ ollama       found
  ✓ NATS config  ~/.vlinder/nats.conf
  ✓ NATS         started with JetStream (launchd)
  ✓ Service      started (launchd)
  ✓ Model        phi3 pulled and registered
  ✓ Support      fleet installed (reference implementation)

  Vlinder is installed and running.

  Try it:

    vlinder help
```

### Install a specific version

```bash
VLINDER_VERSION=v0.1.0 curl -fsSL https://vlindercli.dev/install.sh | sh
```

## Build from Source

Requires the [Rust toolchain](https://rustup.rs/) and `protobuf-compiler`:

=== "macOS"

    ```bash
    brew install protobuf
    git clone https://github.com/vlindercli/vlindercli.git
    cd vlindercli
    cargo build --release
    cp target/release/vlindercli /usr/local/bin/vlinder
    ```

=== "Linux"

    ```bash
    sudo apt install -y protobuf-compiler
    git clone https://github.com/vlindercli/vlindercli.git
    cd vlindercli
    cargo build --release
    cp target/release/vlindercli /usr/local/bin/vlinder
    ```

You'll still need to install the prerequisites and set up services manually. See the install script for reference.

## Verify Installation

```bash
vlinder --version
```

## Services

The install script sets up two system services that start automatically on login. Ollama manages its own service separately.

| Service | macOS | Linux | Managed by |
|---------|-------|-------|------------|
| **NATS** | `dev.vlinder.nats` (launchd) | `vlinder-nats` (systemd) | Vlinder installer |
| **Vlinder daemon** | `dev.vlinder.daemon` (launchd) | `vlinder` (systemd) | Vlinder installer |
| **Ollama** | `com.ollama.ollama` (launchd) | `ollama` (systemd) | Ollama installer |

=== "macOS"

    ```bash
    # View logs
    tail -f ~/Library/Logs/vlinder/daemon.log
    tail -f ~/Library/Logs/vlinder/nats.log

    # Stop services
    launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/dev.vlinder.daemon.plist
    launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/dev.vlinder.nats.plist
    ```

=== "Linux"

    ```bash
    # View logs
    journalctl --user -u vlinder
    journalctl --user -u vlinder-nats

    # Stop services
    systemctl --user stop vlinder
    systemctl --user stop vlinder-nats

    # Disable auto-start
    systemctl --user disable vlinder
    systemctl --user disable vlinder-nats
    ```

If NATS was already running as a service (e.g., via Homebrew), the installer skips NATS service creation and uses your existing setup. Ensure JetStream is enabled in your NATS config.

## Directory Structure

After installation, `~/.vlinder/` contains:

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

- [Getting Started](../tutorials/getting-started.md) — full tutorial from install to first agent
- [Configuration](configuration.md) — customize logging and providers
- [Manage Models](manage-models.md) — add models for inference

## See Also

- [Environment Variables](../reference/environment-variables.md) — `VLINDER_DIR` and other overrides
- [config.toml reference](../reference/config-toml.md) — full configuration schema
