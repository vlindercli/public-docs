# Timelines

Timelines are VlinderCLI's mechanism for verifiable, forkable agent state. Every interaction produces a content-addressed hash that chains into an append-only Merkle DAG — making the full history immutable, inspectable, and replayable.

## Core Concepts

### Submissions
Each user input is a **submission**. Processing a submission produces a **state hash** — a Merkle DAG node that captures the complete state after all service interactions. The state hash chains to the previous one, forming a verifiable history.

### Sessions
A **session** (`ses-{uuid}`) groups multiple submissions into a logical conversation. Each session is a branch in the Merkle DAG.

### Sequences
Within a single submission, service interactions (inference calls, storage operations) are ordered by **sequence** numbers. This ordering enables deterministic replay of the exact service call chain.

## The Merkle DAG

All agent side effects are tracked in a content-addressed Merkle DAG. Each state hash incorporates:

- The previous state hash
- The submission content
- All service interaction results (ordered by sequence)

This creates a verifiable chain — any tampering with intermediate state breaks the hash chain and is immediately detectable.

Agent data itself lives in the [storage workers](storage-model.md) (SQLite). The Merkle DAG doesn't store the data — it stores the hashes that make the data verifiable.

## Forking

Forking creates a new branch from a historical node in the DAG:

```mermaid
gitGraph
    commit id: "submit-1"
    commit id: "submit-2"
    commit id: "submit-3"
    branch fork
    checkout fork
    commit id: "submit-2b"
    commit id: "submit-3b"
```

After forking from `submit-2`, new submissions create a divergent path. The original history remains untouched. Storage state is restored to match the fork point — this is what makes time-travel debugging work for stateful agents.

## Why Git?

VlinderCLI uses git as the Merkle DAG backend. Git's object model is itself a Merkle DAG — commits chain via parent hashes, and every object is content-addressed by SHA. Rather than building a custom Merkle DAG implementation, VlinderCLI uses one that already exists:

- **Content addressing** (SHA) — every state is uniquely identified
- **Branching** — forking is a native operation
- **Append-only history** — commits are immutable once written
- **Familiar tooling** — `git log`, `git diff`, and standard git tools work on the timeline repository

The timeline repository lives at `~/.vlinder/conversations/`. The `SubmissionId` is the git commit SHA. Sessions map to branches.

Git is the implementation detail, not the abstraction. The timeline API doesn't expose git concepts — it exposes submissions, sessions, and forks. A different Merkle DAG backend could replace git without changing the agent-facing interface.

## See Also

- [Time-Travel Debugging](../how-to/time-travel-debugging.md) — practical workflows
- [CLI: `vlinder timeline`](../reference/cli/timeline.md) — command reference
- [Storage Model](storage-model.md) — how storage integrates with content addressing
