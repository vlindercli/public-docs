# VlinderCLI

**Debug and repair AI agents.**

---

## What is VlinderCLI?

Infrastructure to debug and repair AI agent failures.

Rewind to the failure, inspect the exact state, test a fix, and replay.

---

## Core Concepts

- **Agents** — self-contained AI units running in OCI containers
- **Fleets** — groups of cooperating agents with delegation
- **Sessions** — independent Merkle chains with content-addressed history
- **Time-Travel Debugging** — rewind, fork, fix, promote

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
| Storage | Object + vector |

-v-

### Message Flow

1. **Invoke** — CLI sends user input
2. **Request** — agent calls a service
3. **Response** — service returns result
4. **Complete** — agent finishes

---

## Time-Travel Debugging

```text
$ vlinder session list todoapp
$ vlinder session fork ses-abc --from a1b2c3d4 --name fix
$ vlinder agent run todoapp --branch fix
$ vlinder session promote fix
```

Rewind to any completed turn. Fork. Fix. Promote.

---

## Get Started

- [Documentation](https://docs.vlindercli.dev/)
- [GitHub](https://github.com/vlindercli/vlindercli)
- [Blog](https://blog.vlindercli.dev/)
