#!/bin/bash
# Trending Paper Review Series — end-to-end pipeline
# Usage: bash scripts/run-review.sh [arXiv-ID]
# Env:   DRAFT=true to skip auto-publish
set -euo pipefail

ARXIV_ID="${1:-}"
REVIEWER_DIR="$HOME/unktok/dev/unktok-reviewer"
BLOG_DIR="$HOME/dev/t46.github.io"
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
REVIEW_DIR="$SCRIPT_DIR/reviews"
TEMPLATE_DIR="$SCRIPT_DIR/templates"
TODAY=$(date +%Y-%m-%d)
DRAFT="${DRAFT:-false}"

echo "========================================="
echo " Trending Paper Review Series"
echo " $(date)"
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

# Check if already reviewed
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
/opt/homebrew/bin/claude --dangerously-skip-permissions -p "Evaluate this paper: $ARXIV_ID

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

# --- Step 4: Generate blog post ---
echo ""
echo "[Step 4] Generating blog post..."
SLUG=$(echo "$ARXIV_ID" | tr '.' '-')
POST_FILENAME="$TODAY-review-$SLUG.md"
POST_PATH="$BLOG_DIR/_posts/$POST_FILENAME"

cd "$SCRIPT_DIR"
/opt/homebrew/bin/claude --dangerously-skip-permissions -p "You are generating a blog post for the Trending Paper Review Series.

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

# --- Step 5: Publish ---
echo ""
if [ "$DRAFT" = "true" ]; then
    echo "[Step 5] DRAFT MODE — not publishing."
    echo "  Review the post at: $POST_PATH"
    echo "  To publish: cd $BLOG_DIR && git add _posts/$POST_FILENAME && git commit -m 'Add review: $ARXIV_ID' && git push"
else
    echo "[Step 5] Publishing to t46.github.io..."
    cd "$BLOG_DIR"
    git add "_posts/$POST_FILENAME"
    git commit -m "Add trending paper review: $ARXIV_ID"
    git push
    echo "  Published! Will be live at: https://t46.github.io/blogs/review-$SLUG.html"
fi

# --- Done ---
echo ""
echo "========================================="
echo " Review complete: $ARXIV_ID"
echo " Artifacts: $REVIEW_DIR/$ARXIV_ID/"
echo " Blog post: $POST_PATH"
echo "========================================="
