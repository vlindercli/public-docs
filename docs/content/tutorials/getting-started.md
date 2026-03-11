# Getting Started

In this tutorial, you'll clone the VlinderCLI repository, build it from source, and explore the available commands.

**Time:** ~10 minutes

**Prerequisites:** macOS or Linux, a terminal, and the Rust toolchain.

## Step 1: Clone and Build

```bash
git clone https://github.com/vlindercli/vlindercli.git
cd vlindercli
cargo build --release
cp target/release/vlinder /usr/local/bin/vlinder
```

See the [Installation](../how-to/installation.md) guide for prerequisite details (NATS, Podman) and bootstrapping `~/.vlinder/`.

## Step 2: Explore Commands

Run `vlinder help` to see the available subcommands:

```bash
vlinder help
```

You'll see commands for running agents, managing fleets, working with models, inspecting timelines, and starting the daemon.

## Next Steps

- [Your First Agent](your-first-agent.md) — scaffold and run your own agent
- [Configuration](../how-to/configuration.md) — customize logging and providers
- [Architecture](../explanation/architecture.md) — understand the component model
