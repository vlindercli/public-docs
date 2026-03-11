# VlinderCLI Documentation

Public documentation for [VlinderCLI](https://github.com/vlindercli/vlindercli), built with [MkDocs Material](https://squidfunk.github.io/mkdocs-material/).

This monorepo contains three sites:

| Directory | Subdomain | Description |
|-----------|-----------|-------------|
| `landing/` | [vlindercli.dev](https://vlindercli.dev) | Product landing page |
| `docs/` | [docs.vlindercli.dev](https://docs.vlindercli.dev) | Documentation (tutorials, how-to, explanation, reference) |
| `blog/` | [blog.vlindercli.dev](https://blog.vlindercli.dev) | Blog |
| `slides/` | [slides.vlindercli.dev](https://slides.vlindercli.dev) | Presentations (reveal.js) |

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
