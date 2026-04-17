# Trending Paper Review Series

Automated rigorous reviews of trending ML/AI papers using AI agents.

**Philosophy**: *Rigorous Constructive Criticism* — no numerical scores, no accept/reject predictions, just evidence-based analysis and actionable improvement suggestions.

**Site (primary output)**: https://t46.github.io/trending-paper-reviews/

## Editorial policy

This series rejects the traditional peer-review framing. **The following labels and their analogues are prohibited everywhere in our outputs (HTML body, blog posts, summary cards):**

- "Major Revision", "Minor Revision", "Accept", "Reject"
- "Recommendation: ...", "Verdict: ..." (as categorical prefixes)
- Any other phrasing that compresses an evaluation into an editorial-decision label

These labels are artifacts of legacy journal/conference workflows where a binary editorial decision was the deliverable. In this series there *is no editorial decision* — we are not gatekeeping publication. The verdict box at the top of each review surfaces the **substance** (the paper's most consequential strength + the most important improvement direction) as free-form prose, not as a category. Constructive critique and concrete improvement suggestions are the entire deliverable.

If you are forking or adapting `templates/site_review.html` or `scripts/run-review.sh`, preserve this policy.

## Output policy

- **The site is the primary output.** Every review must be published to https://t46.github.io/trending-paper-reviews/ as a static HTML page (`<arxiv-id-dashed>.html`) and listed in `index.html`.
- **The blog (`t46.github.io`) is a secondary, opt-in output.** Blog publication is disabled by default; pass `--blog` to enable it.
- Past reviews missing from the site can be regenerated manually from `reviews/<arxiv-id>/` artifacts using the same template (`templates/site_review.html`).

## Quick Start

```bash
# Site-only (default): generates HTML, updates index.html, commits & pushes
bash scripts/run-review.sh 2604.14125

# Site + blog
bash scripts/run-review.sh --blog 2604.14125

# Auto-select top trending paper from HF Daily Papers
bash scripts/run-review.sh

# Draft mode: generate everything locally but do not push (no site, no blog publish)
bash scripts/run-review.sh --draft 2604.14125
DRAFT=true bash scripts/run-review.sh 2604.14125   # equivalent
```

`scripts/run-review.sh` will resolve the `claude` binary via `command -v claude` (or `CLAUDE_BIN` env var, or standard install paths). No hard-coded paths.

## Pipeline (current)

1. **Select**: arXiv ID arg, or auto-select from [Hugging Face Daily Papers](https://huggingface.co/papers).
2. **Evaluate**: Runs the full unktok-reviewer multi-phase pipeline (~30–60 min).
3. **Archive**: Copies all artifacts into `reviews/<arxiv-id>/`.
4. **Site (PRIMARY)**: Generates `<arxiv-id-dashed>.html` from `templates/site_review.html` and inserts a card into `index.html` between the `<!-- REVIEWS_START -->` / `<!-- REVIEWS_END -->` markers (date-descending order).
5. **Site publish**: `git add` + `git commit` + `git push origin main`. GitHub Pages deploys automatically within ~1–2 minutes.
6. **Blog (OPTIONAL)**: With `--blog`, additionally generates a Jekyll post under `_posts/` in `~/dev/t46.github.io/` and pushes it.

## Templates

- `templates/site_review.html` — site review HTML template (used for every review; placeholders: `{{TITLE}}`, `{{ARXIV_ID}}`, `{{VERDICT_SUMMARY}}` (free-form prose, no editorial labels), `{{OVERVIEW_PARAGRAPHS}}`, `{{STRENGTHS_PARAGRAPHS}}`, `{{CONCERNS_PARAGRAPHS}}`, `{{IMPROVEMENTS_PARAGRAPHS}}`, etc.).
- `templates/blog_post.md` — Jekyll blog post template (used only with `--blog`).

## Published Reviews

See https://t46.github.io/trending-paper-reviews/

## Backfilling missed reviews

If a review exists under `reviews/<arxiv-id>/` but is not on the site, regenerate it:

```bash
# (Manual one-shot, until a backfill subcommand is added.)
# Use templates/site_review.html as a base and craft <arxiv-id-dashed>.html,
# then add a new <a class="review-card"> entry between
# <!-- REVIEWS_START --> and the previous top entry in index.html.
```
