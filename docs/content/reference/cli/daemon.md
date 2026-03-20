# vlinderd

Start the supervisor process manager.

```
vlinderd
```

Starts the Supervisor, which spawns and manages all worker processes. The startup sequence is ordered by dependency:

1. **Secret** — starts first (agent identity management)
2. **Registry** — gRPC server, waits for health check before proceeding
3. **State** — gRPC server for DAG and state queries
4. **Catalog** — gRPC server for model catalog queries
5. **Harness** — gRPC bridge between CLI and daemon, waits for health check
6. **Remaining workers** — agent runtimes, inference, storage, DAG git, session viewer

Each worker is a separate `vlinderd` process launched with a `VLINDER_WORKER_ROLE` environment variable. Worker counts are configured in `config.toml` under `[distributed.workers]`.

See [Architecture](../../explanation/architecture.md) for the full Supervisor + Workers model.

## See Also

- [Architecture](../../explanation/architecture.md) — supervisor and worker components
- [config.toml](../config-toml.md) — worker counts and service addresses
- [Distributed Deployment](../../how-to/distributed-deployment.md) — multi-node setup
