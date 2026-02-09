# Getting Started

In this tutorial, you'll install VlinderCLI, verify the setup, and run the bundled support agent.

**Time:** ~10 minutes

**Prerequisites:** macOS or Linux, and a terminal.

## Step 1: Install VlinderCLI

Follow the [Installation](../how-to/installation.md) guide to build from source, install prerequisites (NATS, Podman), and bootstrap `~/.vlinder/`.

## Step 2: Verify

With NATS and the vlinder daemon running, verify:

```bash
vlinder agent list
```

This connects to the daemon and shows deployed agents. You should see the support fleet's agents listed.

## Step 3: Run the Support Agent

VlinderCLI ships with a bundled support fleet. Try it:

```bash
vlinder support
```

You'll see an interactive REPL. Ask it a question about VlinderCLI and press Enter.

!!! tip
    Type `exit` or press `Ctrl+C` to end the session.

## Step 4: View the Timeline

After your conversation, inspect what happened:

```bash
vlinder timeline log
```

Each entry shows a commit SHA, timestamp, and agent name — every interaction is recorded in a git-backed timeline.

## What Just Happened?

1. The vlinder daemon (already running as a service) received your request
2. The support fleet's entry agent loaded and started in a container
3. Your inputs were routed through NATS to the agent runtime
4. Each interaction was committed to the timeline at `~/.vlinder/conversations/`

## Next Steps

- [Your First Agent](your-first-agent.md) — scaffold and run your own agent
- [Configuration](../how-to/configuration.md) — customize logging and providers
- [Architecture](../explanation/architecture.md) — understand the component model
