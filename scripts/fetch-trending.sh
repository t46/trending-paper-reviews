#!/bin/bash
# Fetch trending papers from HF Daily Papers and AlphaXiv
set -euo pipefail

echo "=== Hugging Face Daily Papers ==="
echo ""
curl -s "https://huggingface.co/api/daily_papers" | python3 -c "
import json, sys
papers = json.load(sys.stdin)
for i, p in enumerate(papers[:10], 1):
    paper = p.get('paper', {})
    pid = paper.get('id', '?')
    title = paper.get('title', '?')
    upvotes = p.get('numUpvotes', 0)
    comments = p.get('numComments', 0)
    print(f'{i:2d}. [{pid}] {title}')
    print(f'    upvotes={upvotes}  comments={comments}')
    print()
"

echo ""
echo "=== Usage ==="
echo "  bash scripts/run-review.sh <arXiv-ID>     # Review a specific paper"
echo "  bash scripts/run-review.sh                 # Auto-select top paper"
echo "  DRAFT=true bash scripts/run-review.sh ...  # Draft mode (no auto-publish)"
