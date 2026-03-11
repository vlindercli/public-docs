# VlinderCLI

**Debug and repair AI agents.**

When AI agents fail, rewind to the failure, inspect the exact state, test a fix, and replay.

---

## How It Works

```text
$ vlinder agent run todoapp        # agent fails
$ vlinder session fork wired-pig-543e \
    --from a1b2c3d4 --name fix     # rewind to before the failure
$ vlinder agent run todoapp --branch fix   # replay with fix
$ vlinder session promote fix      # promote the fixed timeline
```

Every decision your agent makes is captured as a content-addressed Merkle DAG — same data model as git.
Nothing is lost. Both timelines are preserved.

---

## Links

- [vlindercli.dev](https://vlindercli.dev/) — home
- [docs.vlindercli.dev](https://docs.vlindercli.dev/) — documentation
- [blog.vlindercli.dev](https://blog.vlindercli.dev/) — blog
- [github.com/vlindercli/vlindercli](https://github.com/vlindercli/vlindercli) — source code
- [discord.vlindercli.dev](https://discord.vlindercli.dev/) — community
