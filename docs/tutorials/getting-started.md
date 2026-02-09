# Getting Started

In this tutorial, you'll install VlinderCLI, verify the setup, and run the bundled support agent.

**Time:** ~10 minutes

**Prerequisites:** macOS or Linux, and a terminal.

## Step 1: Install VlinderCLI

```bash
curl -fsSL https://vlindercli.dev/install.sh | sh
```

The script downloads the vlinder binary, creates `~/.vlinder/` with a default config, and checks for prerequisites.

If **NATS** or **Podman** aren't installed, the script stops and prints the install commands you need. Install them, then re-run the script.

See [Installation](../how-to/installation.md) for full details, prerequisites, and platform-specific instructions.

## Step 2: Verify

After a successful install, NATS and the vlinder daemon are running as system services. Verify:

```bash
vlinder agent list
```

This connects to the daemon and shows deployed agents (empty for a fresh install).

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
