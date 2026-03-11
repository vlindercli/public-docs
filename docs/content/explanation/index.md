# Explanation

Explanation documentation is **understanding-oriented** and helps you learn about the concepts, design decisions, and architecture behind VlinderCLI.

## Topics

| Topic | What it explains |
|-------|-----------------|
| [Architecture](architecture.md) | The Daemon, Registry, Harness, Runtime, and Worker components |
| [Timelines](timelines.md) | Versioned state, forking, content addressing, and time-travel debugging |
| [Queue System](queue-system.md) | Why queues, message flow, service routing, and scaling |
| [Agents Model](agents-model.md) | What agents are, their lifecycle, delegation, and the fleet pattern |
| [Storage Model](storage-model.md) | The three rules, content addressing, and the BYOS pattern |
| [State Store](state-store.md) | The versioned object model behind content addressing |
| [Domain Model](domain-model.md) | Core types, traits, and their relationships |
| [Conversations Repository](conversations-repo.md) | The read-only git projection of the message DAG |
