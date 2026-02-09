---
hide:
  - navigation
  - toc
---

<div class="landing" markdown>
<div class="landing-left" markdown>

# VlinderCLI

**AI agents that can time travel.**

Design, build, run, and observe AI agents.
Debug with time-travel. Scale seamlessly from laptop to cluster.

[Get Started](tutorials/getting-started.md){ .md-button .md-button--primary }
[GitHub](https://github.com/vlindercli/vlindercli){ .md-button }

</div>
<div class="landing-right" markdown>

```title="Build a grocery list, then fork the timeline"
$ vlinder agent run -p agents/todoapp
> add buy milk
> add buy eggs
> add buy carrots

$ vlinder timeline fork 15d739d
Forked at "buy eggs" → fork-15d739d

$ vlinder agent run -p agents/todoapp
Resuming from state sc2…
> list
1. buy milk
2. buy eggs        # no carrots
> add buy bread
```
```title="Two timelines, one store"
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

<p class="landing-caption">main: milk, eggs, carrots &nbsp;·&nbsp; fork: milk, eggs, bread<br>Switch back any time. Nothing is copied or deleted.</p>

</div>
</div>
