# vlinder daemon

Start the supervisor process manager.

```
vlinder daemon
```

Starts the Supervisor, which spawns and manages all worker processes. The Supervisor:

1. Starts the Registry worker and waits for it to become healthy
2. Spawns the remaining workers (agent, inference, embedding, storage)
3. Monitors worker lifecycle — restarts workers that crash
4. Runs a Session Viewer HTTP server on port 7777

Each worker is a separate `vlinder daemon` process launched with a `VLINDER_WORKER_ROLE` environment variable. See [Architecture](../../explanation/architecture.md) for the full Supervisor + Workers model.

## See Also

- [Architecture](../../explanation/architecture.md) — supervisor and worker components
- [Distributed Deployment](../../how-to/distributed-deployment.md) — multi-node setup
- [Configuration](../../how-to/configuration.md) — worker counts and queue settings
