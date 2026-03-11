# VlinderCLI

**AI agents that can time travel.**

<small>*a.k.a. "Highly observable, replayable AI agents via type systems, pure functions,
event sourcing, DDD, and Merkle DAGs in Rust."*<br>
<br>...but nobody would click on that.</small>

Ashwin Bilgi

---

## Demo

...else you won't believe me.

---

## The Problem

LLMs are fundamentally **non-deterministic**.

Even with pinned weights, GPU vector math randomness and temperature values
mean identical inputs produce different outputs.

Public models are worse. You can't even pin them to a version.
"Opus 4.6" is a pricing indicator, not a deterministic behaviour guarantee.

---

## Non-Determinism in Production

Non-deterministic system in production?
You need to **watch it closely** and **react fast**.

Wrong flight booked. Wrong price quoted.
Real-world consequences.

So what stops you from reacting fast?

---

## Coupling

<small>If your agent ships agentic processing **and** business logic,
you are slower to react.
<br><br>
More code to test. More teams involved. More consensus to ship a fix.
<br><br>
A focused component is easier to change than a monolith.</small>

<br>*Principle: Keep agents small. Single Responsibility Principle.*

---

## Isolate the Fault Domain

<small>Small isn't enough. You need to **isolate failure boundaries**.
<br><br>
The **Bulkhead Pattern**: watertight compartments in a ship.
A breach in one doesn't sink the whole vessel.
<br><br>
Your LLM agent is one compartment.
The rest of your system is another.</small>

<br>*Principle: Isolate failure boundaries. Bulkhead Pattern.*

---

## Contracts

<small>Isolation doesn't mean silence.
Agents still need to communicate their effects.
<br><br>
A **contract**: a published format for state changes,
without knowing who consumes it or how.</small>

<br>*Principle: Publish state changes through contracts.*

---

## Push, Not Pull

<small>Two mechanisms: **pull** (polling) or **push** (emitting events).
<br><br>
LLMs are slow. Polling a slow system means
repetitive traffic and blocked consumers spinning for nothing.
<br><br>
Agents should **push**.</small>

<br>*Principle: Push state changes. Don't wait for pull.*

---

## Queues Over Webhooks

<small>

| | Webhooks | Queue |
|---|----------|-------|
| Subscriber tracking | Agent's problem | Not agent's problem |
| Retry on failure | Agent gets fat | Queue handles it |
| Coupling | Tight | None |

A message queue keeps the agent lean. Fire and forget.</small>

<br>*Principle: Use message queues. Fire and forget.*

---

## Capture Everything

<small>The queue message can contain just the state change. Useful.
<br><br>
But what's more useful? The **complete state** at that moment:
<br><br>
All variables in memory.
Container stdout/stderr.
Software versions.
Full debugging context.
<br><br>
More information beats less information. Every time.</small>

<br>*Principle: Capture complete state, not just changes.*

---

## Content-Addressable Storage

<small>Storing complete state on every event leads to disk explosion.
But most state doesn't change between events.
<br><br>
The fix: the address of data is its **content hash**.
100 files with the same content = **one file on disk**,
with fixed-size pointers.
<br><br>
CAS makes capturing everything affordable.</small>

<br>*Principle: Deduplicate with content-addressable storage.*

---

## Events Form a DAG

<small>State transitions are directional. A leads to B, or A leads to C. Never circular.
<br><br>
This is a **Directed Acyclic Graph**.
<br><br>
Every event in your system is a node.
Every causal relationship is an edge.</small>

<br>*Principle: Model events as a DAG.*

---

## DAG + CAS = Merkle DAG

<small>We already have content-addressable storage. Now we have a DAG.
<br><br>
Combine them: a **Merkle DAG**.
Every node is content-addressed. Every edge is verifiable.
<br><br>
Same data structure as **git**.</small>

<br>*Principle: Use Merkle DAGs to store state and relationships.*

---

## The Transactional Outbox

Every write goes to **both** the database and the queue. Atomically.

Same data in N+2 stores:

1. Database.
2. Queue.
3. Every queue consumer.

Iron-clad guarantees.

<br>*Principle: Both succeed, or neither does.*

---

## Time Travel = Changing a Pointer

<small>
Complete system state stored as content-addressed nodes
forming a Merkle DAG in the database.<br><br>
To time travel:<br><br>
<strong>View</strong> the graph offline.<br>
<strong>Pick</strong> where you want to go offline.<br>
<strong>Change</strong> HEAD by making an API call to production.
</small>

<br>*Principle: Time travel works exactly like git.*

---

## VlinderCLI

**The agent framework for engineers who:**

<small>

- **...think AI, the actual technology, is really cool,**
- **...absolutely hate how everyone uses it,**
- **...are terrified of running it unsupervised in production,**
- **and will absolutely be the ones on the incident call at 3 AM when it hallucinates a refund policy that doesn't exist.**

</small>

<small>*(This tagline needs work. So does the project. Come help with either.)*</small>

---

<img src="logo.png" alt="VlinderCLI" style="max-height: 200px; border: none; box-shadow: none; display: block; margin: 0 auto;">

[vlindercli.dev](https://vlindercli.dev) | [docs](https://docs.vlindercli.dev) | [blog](https://blog.vlindercli.dev) | [slides](https://slides.vlindercli.dev)

[github.com/vlindercli/vlindercli](https://github.com/vlindercli/vlindercli) | [discord](https://discord.vlindercli.dev)
