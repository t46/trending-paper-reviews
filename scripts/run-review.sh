#!/bin/bash
# Trending Paper Review Series — end-to-end pipeline
# Usage: bash scripts/run-review.sh [--blog] [--draft] [arXiv-ID]
# Flags:
#   --blog   : also publish to t46.github.io blog (secondary output)
#   --draft  : skip all auto-publish (commit/push). Implies no site push, no blog push.
# Env:    DRAFT=true is also honored for backward compatibility.
#
# Primary output: the trending-paper-reviews site (https://t46.github.io/trending-paper-reviews/)
# Blog publication on t46.github.io is OPT-IN via --blog.

set -euo pipefail

# ---- Parse arguments ----
PUBLISH_BLOG=false
DRAFT="${DRAFT:-false}"
ARXIV_ID=""

for arg in "$@"; do
    case "$arg" in
        --blog) PUBLISH_BLOG=true ;;
        --draft) DRAFT=true ;;
        --*) echo "Unknown flag: $arg" >&2; exit 2 ;;
        *) ARXIV_ID="$arg" ;;
    esac
done

# ---- Resolve `claude` binary ----
CLAUDE_BIN="${CLAUDE_BIN:-$(command -v claude || true)}"
if [ -z "$CLAUDE_BIN" ]; then
    if [ -x "/opt/homebrew/bin/claude" ]; then
        CLAUDE_BIN="/opt/homebrew/bin/claude"
    elif [ -x "/usr/local/bin/claude" ]; then
        CLAUDE_BIN="/usr/local/bin/claude"
    else
        echo "ERROR: claude binary not found in PATH or standard install locations." >&2
        echo "  Set CLAUDE_BIN=/path/to/claude or install Claude Code." >&2
        exit 1
    fi
fi

REVIEWER_DIR="$HOME/unktok/dev/unktok-reviewer"
BLOG_DIR="$HOME/dev/t46.github.io"
SITE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
REVIEW_DIR="$SITE_DIR/reviews"
TEMPLATE_DIR="$SITE_DIR/templates"
TODAY=$(date +%Y-%m-%d)

echo "========================================="
echo " Trending Paper Review Series"
echo " $(date)"
echo " claude: $CLAUDE_BIN"
echo " site:   $SITE_DIR (PRIMARY)"
if [ "$PUBLISH_BLOG" = "true" ]; then
    echo " blog:   $BLOG_DIR (also publishing)"
else
    echo " blog:   skipped (pass --blog to enable)"
fi
echo "========================================="

# --- Step 1: Paper selection ---
if [ -z "$ARXIV_ID" ]; then
    echo ""
    echo "[Step 1] Auto-selecting from HF Daily Papers..."
    ARXIV_ID=$(curl -s "https://huggingface.co/api/daily_papers" | \
        python3 -c "import json,sys; papers=json.load(sys.stdin); print(papers[0]['paper']['id'])")
    echo "  Selected: $ARXIV_ID"
else
    echo ""
    echo "[Step 1] Paper: $ARXIV_ID"
fi

if [ -d "$REVIEW_DIR/$ARXIV_ID" ]; then
    echo "  WARNING: $ARXIV_ID has already been reviewed. Overwriting."
fi

# --- Step 2: Run unktok-reviewer pipeline ---
echo ""
echo "[Step 2] Running unktok-reviewer evaluation..."
echo "  This may take 30-60 minutes for the full 26-agent pipeline."

rm -rf "$REVIEWER_DIR/artifacts"
mkdir -p "$REVIEWER_DIR/artifacts"

cd "$REVIEWER_DIR"
"$CLAUDE_BIN" --dangerously-skip-permissions -p "Evaluate this paper: $ARXIV_ID

Execute all phases sequentially from Phase-1 through Phase-8-2.
Follow the workflow-controller for phase routing.
Proceed automatically without asking for confirmation between phases.
Save all artifacts to the artifacts/ directory as specified by each phase."

# --- Step 3: Archive artifacts ---
echo ""
echo "[Step 3] Archiving artifacts..."
mkdir -p "$REVIEW_DIR/$ARXIV_ID"
cp -r "$REVIEWER_DIR/artifacts/"* "$REVIEW_DIR/$ARXIV_ID/" 2>/dev/null || {
    echo "  ERROR: No artifacts found. The evaluation may have failed."
    exit 1
}
echo "  Archived to: reviews/$ARXIV_ID/"
echo "  Files: $(ls "$REVIEW_DIR/$ARXIV_ID/" | wc -l | tr -d ' ') artifacts"

# --- Step 4 (PRIMARY): Generate site review HTML + update index.html ---
echo ""
echo "[Step 4] PRIMARY: Generating site review HTML and updating index.html..."

SLUG=$(echo "$ARXIV_ID" | tr '.' '-')
SITE_HTML_PATH="$SITE_DIR/$SLUG.html"
INDEX_PATH="$SITE_DIR/index.html"
SITE_TEMPLATE="$TEMPLATE_DIR/site_review.html"

if [ ! -f "$SITE_TEMPLATE" ]; then
    echo "  ERROR: site template missing at $SITE_TEMPLATE" >&2
    exit 1
fi

cd "$SITE_DIR"
"$CLAUDE_BIN" --dangerously-skip-permissions -p "You are generating a static HTML review page for the Trending Paper Review Series site.

Read these files:
1. reviews/$ARXIV_ID/paper_metadata.md — title, authors, arXiv ID, abstract
2. reviews/$ARXIV_ID/comprehensive_evaluation_report.md — overall assessment (if present)
3. reviews/$ARXIV_ID/critical_review.md — main critical analysis (REQUIRED)
4. reviews/$ARXIV_ID/strengths_analysis.md — strengths (if present)
5. reviews/$ARXIV_ID/weaknesses_analysis.md — concerns (if present)
6. reviews/$ARXIV_ID/improvement_roadmap.md — improvement suggestions (if present)
7. templates/site_review.html — output HTML template with placeholders

Generate the final HTML review page at: $SITE_HTML_PATH

Replace ALL of the following placeholders in the template:
- {{TITLE}} — full paper title (HTML-escaped)
- {{TITLE_SHORT}} — short title or model name (e.g. 'HiVLA') for the <title> tag
- {{AUTHORS_SHORT}} — first 3-4 authors then 'et al.' if more
- {{MONTH_YEAR}} — e.g. 'April 2026'
- {{ARXIV_ID}} — the arXiv ID
- {{RECOMMENDATION}} — 'Major Revision' / 'Minor Revision' / 'Accept' / 'Reject' (descriptive only — NO numerical scores)
- {{VERDICT_SUMMARY}} — 1-3 sentence summary of the verdict
- {{OVERVIEW_PARAGRAPHS}} — Paper overview as HTML <p> tags
- {{STRENGTHS_PARAGRAPHS}} — Key strengths as HTML <p> tags (each strength: <p><strong>Strength title.</strong> details</p>)
- {{CONCERNS_PARAGRAPHS}} — Key concerns as HTML <p> tags (each concern: <p><strong>Concern title.</strong> evidence. <em>To address this</em>, ...</p>)
- {{IMPROVEMENTS_PARAGRAPHS}} — Top improvements as HTML <p> tags (numbered: <p><strong>1. Title.</strong> details</p>)

Important:
- Use ONLY descriptive quality levels — no numerical scores, no accept/reject predictions in the body
- Every concern MUST include a constructive 'To address this' improvement suggestion
- Use HTML entities (&mdash; &rarr; &middot; &amp;) where appropriate
- Match the tone and structure of the existing $SITE_DIR/2604-06425.html and $SITE_DIR/2604-14125.html
- Do NOT include any other commentary in the output file — only the final HTML

Then UPDATE the file: $INDEX_PATH

The index.html contains the marker block:
    <!-- REVIEWS_START -->
    ...existing review cards in date-descending order...
    <!-- REVIEWS_END -->

INSERT a new <a class='review-card'> for $ARXIV_ID at the TOP (immediately after <!-- REVIEWS_START -->), so date-descending order is preserved. Use this card structure exactly:

        <a href=\"$SLUG.html\" class=\"review-card\">
            <h3>SHORT_TITLE_OR_MODEL_NAME</h3>
            <p class=\"meta\">
                AUTHORS_SHORT &middot; MONTH_YEAR &middot;
                arXiv:$ARXIV_ID
            </p>
            <p class=\"summary\">2-3 sentence punchy summary capturing the verdict and the most distinctive finding.</p>
        </a>

Do NOT remove or modify any existing review card. Do NOT change any other part of index.html (header, footer, styles, feedback section).
"

if [ ! -f "$SITE_HTML_PATH" ]; then
    echo "  ERROR: site HTML was not generated at $SITE_HTML_PATH" >&2
    exit 1
fi

echo "  Site HTML: $SITE_HTML_PATH"
echo "  Index updated: $INDEX_PATH"

# --- Step 5 (PRIMARY publish): commit & push site ---
echo ""
if [ "$DRAFT" = "true" ]; then
    echo "[Step 5] DRAFT MODE — site changes NOT pushed."
    echo "  To publish manually: cd $SITE_DIR && git add $SLUG.html index.html && git commit -m 'site: add review $ARXIV_ID' && git push"
else
    echo "[Step 5] PRIMARY: Publishing site to GitHub Pages..."
    cd "$SITE_DIR"
    git add "$SLUG.html" "index.html"
    git commit -m "site: add review $ARXIV_ID"
    git push origin main
    echo "  Live URL: https://t46.github.io/trending-paper-reviews/$SLUG.html"
fi

# --- Step 6 (OPTIONAL): Blog post ---
if [ "$PUBLISH_BLOG" = "true" ]; then
    echo ""
    echo "[Step 6] OPTIONAL: Generating blog post for t46.github.io..."

    POST_FILENAME="$TODAY-review-$SLUG.md"
    POST_PATH="$BLOG_DIR/_posts/$POST_FILENAME"

    cd "$SITE_DIR"
    "$CLAUDE_BIN" --dangerously-skip-permissions -p "You are generating a blog post for the Trending Paper Review Series.

Read the following files:
1. reviews/$ARXIV_ID/paper_metadata.md (or any metadata file) for title, authors, abstract
2. reviews/$ARXIV_ID/comprehensive_evaluation_report.md for the overall assessment
3. reviews/$ARXIV_ID/critical_review.md for critical analysis
4. reviews/$ARXIV_ID/strengths_analysis.md for key strengths
5. reviews/$ARXIV_ID/weaknesses_analysis.md for key concerns
6. reviews/$ARXIV_ID/improvement_roadmap.md for improvement suggestions
7. templates/blog_post.md for the output format and structure

Generate a Jekyll blog post following the template format exactly.
Write the output to: $POST_PATH

Important:
- Use the exact HTML style from the template (sections, h3 with sect symbols, etc.)
- Keep the post between 1500-2500 words
- No numerical scores — use descriptive quality levels only
- Every concern must include a constructive improvement suggestion
- Include the series introduction block
" \
        --add-dir "$BLOG_DIR"

    if [ "$DRAFT" = "true" ]; then
        echo "  DRAFT MODE — blog post written but not pushed: $POST_PATH"
    else
        echo "  Publishing blog post..."
        cd "$BLOG_DIR"
        git add "_posts/$POST_FILENAME"
        git commit -m "Add trending paper review: $ARXIV_ID"
        git push
        echo "  Blog live at: https://t46.github.io/blogs/review-$SLUG.html"
    fi
fi

# --- Done ---
echo ""
echo "========================================="
echo " Review complete: $ARXIV_ID"
echo " Artifacts: $REVIEW_DIR/$ARXIV_ID/"
echo " Site page: $SITE_HTML_PATH"
if [ "$PUBLISH_BLOG" = "true" ]; then
    echo " Blog post: $POST_PATH"
fi
echo "========================================="
