# VlinderCLI

**AI agents that can time travel.**

---

## What is VlinderCLI?

Design, build, run, and observe AI agents.

Debug with time-travel. Scale seamlessly from laptop to cluster.

---

## Core Concepts

- **Agents** — self-contained AI units running in OCI containers
- **Fleets** — groups of cooperating agents with delegation
- **Timelines** — git-backed Merkle DAG for verifiable history
- **Time-Travel Debugging** — checkout, repair, promote

---

## Architecture

Queue-based, protocol-first design.

Every component communicates through typed messages over NATS.

-v-

### Workers

| Worker | Role |
|--------|------|
| Registry | Source of truth (gRPC) |
| Agent | OCI container execution |
| Inference | LLM text generation |
| Embedding | Vector embeddings |
| Storage | Object + vector (SQLite) |

-v-

### Message Flow

1. **Invoke** — CLI sends user input
2. **Request** — agent calls a service
3. **Response** — service returns result
4. **Complete** — agent finishes

---

## Time-Travel Debugging

```text
$ vlinder timeline log
$ vlinder timeline checkout b3c4d5e
$ vlinder timeline repair -p agents/todoapp
$ vlinder timeline promote
```

Fork from any point. Nothing is deleted.

---

## Get Started

- [Documentation](https://docs.vlindercli.dev/)
- [GitHub](https://github.com/vlindercli/vlindercli)
- [Blog](https://blog.vlindercli.dev/)
