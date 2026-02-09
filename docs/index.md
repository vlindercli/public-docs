---
hide:
  - navigation
  - toc
---

<div class="hero" markdown>

# VlinderCLI

**AI agents that can time travel.**

Model, build, run, and observe AI agents. Debug with time-travel. Scale seamlessly from laptop to cluster.

```bash
curl -fsSL https://vlindercli.dev/install.sh | sh
```

[Get Started](develop.md){ .md-button .md-button--primary }
[GitHub](https://github.com/vlindercli/vlindercli){ .md-button }

</div>

---

## See it in action

Every agent interaction is recorded. Every state change is versioned. Go back to any point and take a different path.

=== "1. Build a list"

    ```
    $ vlinder agent run -p agents/todoapp
    > add buy milk
    Added: buy milk
    > add buy eggs
    Added: buy eggs
    > add buy carrots
    Added: buy carrots
    ```

=== "2. Fork the timeline"

    ```
    $ vlinder timeline log
      d30357d  user  add buy milk
      6228441 agent  Added: buy milk             State: sc1
      2a1ceef  user  add buy eggs
      15d739d agent  Added: buy eggs             State: sc2
      9f4c36e  user  add buy carrots
      0b1f368 agent  Added: buy carrots          State: sc3

    $ vlinder timeline fork 15d739d
    Forked timeline at 15d739d → branch fork-15d739d
    ```

    Go back to the moment after "buy eggs" — before carrots were added.

=== "3. Take a different path"

    ```
    $ vlinder agent run -p agents/todoapp
    Resuming from state sc2…
    > list
    1. buy milk
    2. buy eggs

    > add buy bread
    Added: buy bread
    ```

    No carrots. The agent sees only what existed at the fork point.

=== "4. Two timelines, one store"

    ```
    $ git log --oneline --graph --all
    * 3acba82 (HEAD -> fork-15d739d) agent
    * ec7f26b user
    | * 0b1f368 (main) agent
    | * 9f4c36e user
    |/
    * 15d739d agent
    * 2a1ceef user
    * 6228441 agent
    * d30357d user
    ```

    ```
    main:  milk, eggs, carrots
    fork:  milk, eggs, bread
    ```

    Switch back to `main` any time — carrots return, bread disappears. Nothing is copied or deleted. Both timelines read from the same append-only store, just from different points.
