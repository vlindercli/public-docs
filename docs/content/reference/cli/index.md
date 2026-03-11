# CLI Commands

VlinderCLI provides a hierarchical command structure built with [clap](https://docs.rs/clap/).

## Command Overview

| Command | Description |
|---------|-------------|
| [`vlinder agent`](agent.md) | Deploy, run, list, and inspect agents |
| [`vlinder fleet`](fleet.md) | Deploy and run a fleet of agents |
| [`vlinder model`](model.md) | Add, list, and remove models from catalogs |
| [`vlinder session`](session.md) | Inspect, fork, and promote agent sessions |
| [`vlinder turn`](turn.md) | Inspect individual turns within a session |
| [`vlinder secret`](secret.md) | Manage secrets (private keys, API keys) |
| [`vlinder daemon`](daemon.md) | Start the supervisor (worker process manager) |
| `vlinder support` | Interactive support — runs the bundled support fleet |

## Global Behavior

All commands load configuration from `~/.vlinder/config.toml` by default. Configuration values can be overridden with [environment variables](../environment-variables.md) using the `VLINDER_` prefix.

The `VLINDER_DIR` environment variable changes the base directory for all VlinderCLI data (default: `~/.vlinder`).
