# CLI Commands

VlinderCLI provides a hierarchical command structure built with [clap](https://docs.rs/clap/).

## Command Overview

| Command | Description |
|---------|-------------|
| [`vlinder agent`](agent.md) | Run, list, and inspect agents |
| [`vlinder fleet`](fleet.md) | Create and run a fleet of agents |
| [`vlinder model`](model.md) | Add, list, and remove models from catalogs |
| [`vlinder timeline`](timeline.md) | Inspect and fork timelines |
| [`vlinder daemon`](daemon.md) | Start the supervisor (worker process manager) |
| [`vlinder support`](support.md) | Launch the interactive support fleet |

## Global Behavior

All commands load configuration from `~/.vlinder/config.toml` by default. Configuration values can be overridden with [environment variables](../environment-variables.md) using the `VLINDER_` prefix.

The `VLINDER_DIR` environment variable changes the base directory for all VlinderCLI data (default: `~/.vlinder`).
