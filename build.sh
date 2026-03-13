#!/usr/bin/env bash
set -euo pipefail

OUT="_site"
rm -rf "$OUT"

# Landing → root
mkdocs build -f landing/mkdocs.cloudflare.yml -d "../$OUT"

# Docs → /docs/
mkdocs build -f docs/mkdocs.cloudflare.yml -d "../$OUT/docs"

# Blog → /blog/
mkdocs build -f blog/mkdocs.cloudflare.yml -d "../$OUT/blog"

# Slides → /slides/ (prebuilt)
cp -r slides/site "$OUT/slides"

# Discord redirect + other redirects
cp _redirects "$OUT/_redirects"

echo "Build complete → $OUT/"
