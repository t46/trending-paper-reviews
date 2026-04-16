# Trending Paper Review Series

Automated rigorous reviews of trending ML/AI papers using AI agents.

**Philosophy**: *Rigorous Constructive Criticism* — no numerical scores, no accept/reject predictions, just evidence-based analysis and actionable improvement suggestions.

**Site**: https://t46.github.io/trending-paper-reviews/

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
2. **Evaluate**: Runs AI agents to analyze literature, methodology, effect sizes, code-paper consistency, and more
3. **Publish**: Generates a review and publishes to the site

## Published Reviews

Reviews are published at https://t46.github.io/trending-paper-reviews/
