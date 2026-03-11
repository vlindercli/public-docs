# Reference

Reference documentation is **information-oriented** and provides exact specifications for VlinderCLI's interfaces.

## CLI Commands

See the [CLI command overview](cli/index.md) for a summary of all commands, or jump to a specific command:

- [`vlinder agent`](cli/agent.md) — deploy, run, list, and inspect agents
- [`vlinder fleet`](cli/fleet.md) — deploy and run a fleet of agents
- [`vlinder model`](cli/model.md) — add, list, and remove models
- [`vlinder session`](cli/session.md) — inspect, fork, and promote sessions
- [`vlinder turn`](cli/turn.md) — inspect individual turns
- [`vlinder secret`](cli/secret.md) — manage secrets
- [`vlinder daemon`](cli/daemon.md) — run the vlinder daemon

## Configuration Files

- [`agent.toml`](agent-toml.md) — agent manifest schema
- [`fleet.toml`](fleet-toml.md) — fleet manifest schema
- [`model.toml`](model-toml.md) — model manifest schema
- [`config.toml`](config-toml.md) — global configuration

## Other

- [Environment Variables](environment-variables.md) — `VLINDER_*` override table
- [Services](services.md) — service types, providers, and wire protocols
- [Conversations Repository](conversations-repo.md) — git projection commit format
