# Trending Paper Review Series

Automated pipeline for reviewing trending ML/AI papers using Unktok Reviewer.

## Overview

This repo orchestrates:
1. **Paper selection** from HF Daily Papers / AlphaXiv
2. **Evaluation** via unktok-reviewer (26-agent, 8-phase pipeline)
3. **Blog post generation** from evaluation artifacts
4. **Publishing** to t46.github.io (Jekyll GitHub Pages)

## Quick Start

```bash
# See today's trending papers
bash scripts/fetch-trending.sh

# Run full pipeline (auto-select top paper)
bash scripts/run-review.sh

# Run for specific paper
bash scripts/run-review.sh 2504.12345

# Draft mode (no auto-publish)
DRAFT=true bash scripts/run-review.sh 2504.12345
```

## Dependencies

- `~/unktok/dev/unktok-reviewer/` — evaluation engine
- `~/dev/t46.github.io/` — blog publishing target
- `claude` CLI with `-p` (print mode)
- `curl`, `python3` for API calls

## Review Philosophy

**Rigorous Constructive Criticism**:
- No numerical scores or accept/reject predictions
- Every criticism includes a concrete improvement suggestion
- Two-Layer Analysis: Current State + Development Directions
- Evidence-based claims with explicit references

## Output

- `reviews/<arXiv-ID>/` — full evaluation artifacts (15+ files)
- Blog post at `t46.github.io/_posts/YYYY-MM-DD-review-<ID>.md`

## Python

Use `uv run` for Python commands, `uv add` for packages.
