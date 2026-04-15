# Trending Paper Review Series

Automated rigorous reviews of trending ML/AI papers using [Unktok Reviewer](https://github.com/unktok/unktok-reviewer), a 26-agent, 8-phase evaluation pipeline.

**Philosophy**: *Rigorous Constructive Criticism* — no numerical scores, no accept/reject predictions, just evidence-based analysis and actionable improvement suggestions.

## Quick Start

```bash
# See today's trending papers
bash scripts/fetch-trending.sh

# Review a specific paper
bash scripts/run-review.sh 2504.12345

# Auto-select and review top trending paper
bash scripts/run-review.sh

# Draft mode (generates post but doesn't publish)
DRAFT=true bash scripts/run-review.sh 2504.12345
```

## How It Works

1. **Select**: Fetches trending papers from [Hugging Face Daily Papers](https://huggingface.co/papers) and [AlphaXiv](https://www.alphaxiv.org/)
2. **Evaluate**: Runs the full Unktok Reviewer pipeline (26 agents, 8 phases) — includes literature analysis, methodology evaluation, effect size calculations, code-paper consistency checks, and Devil's Advocate review
3. **Publish**: Generates a blog post and publishes to [t46.github.io](https://t46.github.io)

## Review Archive

Each review's full artifacts (15+ files) are archived in `reviews/<arXiv-ID>/`.

## Published Reviews

Reviews are published at [t46.github.io](https://t46.github.io) with the tag `trending-paper-review-series`.
