---
hide:
  - navigation
  - toc
---

<div class="landing" markdown>
<div class="landing-left" markdown>

# VlinderCLI

**Debug and repair AI agents.**

When AI agents fail, rewind to the failure, inspect the exact state, test a fix, and replay.
Every decision your agent makes is captured. Nothing is lost.

[Get Started](https://docs.vlindercli.dev/tutorials/getting-started/){ .md-button .md-button--primary }
[Contribute](https://docs.vlindercli.dev/contribute/){ .md-button .md-button--contribute }

</div>
<div class="landing-right" markdown>

```title="Agent fails. Rewind. Fork. Fix. Continue."
$ vlinder agent run todoapp
> add buy milk
> add buy eggs
> add buy carrots    # wrong — should be bread

$ vlinder session fork wired-pig-543e \
    --from a1b2c3d4 --name fix-groceries

$ vlinder agent run todoapp --branch fix-groceries
Resuming from state a1b2c3d4…
> list
1. buy milk
2. buy eggs        # rewound past carrots
> add buy bread    # fixed
```
```title="Both timelines preserved"
$ vlinder session branches wired-pig-543e
main             → milk, eggs, carrots
fix-groceries    → milk, eggs, bread

$ vlinder session promote fix-groceries
Old main sealed as broken-2026-03-11.
```

<p class="landing-caption">Rewind to any completed turn. Fork. Fix. Promote.<br>The old timeline is sealed, never deleted.</p>

</div>
</div>
