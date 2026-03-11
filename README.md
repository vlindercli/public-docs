# VlinderCLI

**Debug and repair AI agents.**

When AI agents fail, teams spend hours reconstructing what happened — tracing prompts, logs, and external actions to find the root cause. VlinderCLI captures every decision your agent makes, so you can rewind to the exact failure, inspect state, test a fix, and replay.

- **Rewind** — go back to the exact step where the failure happened
- **Experiment** — branch execution and test alternative prompts, models, or code
- **Repair** — correct downstream actions and replay the workflow
- **Deploy** — works with existing agent frameworks and cloud infrastructure

## Documentation

| Site | URL |
|------|-----|
| Landing page | [vlindercli.dev](https://vlindercli.dev) |
| Docs | [docs.vlindercli.dev](https://docs.vlindercli.dev) |
| Blog | [blog.vlindercli.dev](https://blog.vlindercli.dev) |
| Slides | [slides.vlindercli.dev](https://slides.vlindercli.dev) |

## Repository structure

| Directory | Description |
|-----------|-------------|
| `landing/` | Product landing page |
| `docs/` | Documentation (tutorials, how-to, explanation, reference) |
| `blog/` | Blog |
| `slides/` | Presentations (reveal.js) |

## Development

Each site can be served independently:

```bash
cd landing && pip install -r requirements.txt && mkdocs serve
cd docs    && pip install -r requirements.txt && mkdocs serve
cd blog    && pip install -r requirements.txt && mkdocs serve
cd slides  && pip install -r requirements.txt && mkslides serve content/
```

## Deployment

Each directory is a separate Vercel project, auto-deployed on push to `main`.

## License

Apache 2.0 — see [LICENSE](LICENSE).
