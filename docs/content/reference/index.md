# Reference

Reference documentation is **information-oriented** and provides exact specifications for VlinderCLI's interfaces.

## CLI Commands

See the [CLI command overview](cli/index.md) for a summary of all commands, or jump to a specific command:

- [`vlinder agent`](cli/agent.md) — run, list, and inspect agents
- [`vlinder fleet`](cli/fleet.md) — run a fleet of agents
- [`vlinder model`](cli/model.md) — add, list, and remove models
- [`vlinder timeline`](cli/timeline.md) — inspect and fork timelines
- [`vlinder daemon`](cli/daemon.md) — run the vlinder daemon

## Configuration Files

- [`agent.toml`](agent-toml.md) — agent manifest schema
- [`fleet.toml`](fleet-toml.md) — fleet manifest schema
- [`model.toml`](model-toml.md) — model manifest schema
- [`config.toml`](config-toml.md) — global configuration

## Other

- [Environment Variables](environment-variables.md) — `VLINDER_*` override table
- [Services](services.md) — inference, embedding, storage queue names and protocols
