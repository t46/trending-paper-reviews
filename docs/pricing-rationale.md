# Reviewer Pricing Rationale

## Decision

Launch the D Hybrid offer:

- Trending Paper Review (TPR): free public review series and proof-of-work funnel.
- Pay-per private review: JPY 10,000 per paper.
- Reviewer Pro: JPY 50,000 per month, up to 10 private reviews.

## Rationale

TPR already demonstrates the review philosophy in public: constructive criticism, no numerical scores, and no accept/reject labels. Keeping it free lets researchers inspect real outputs before trusting a private review.

JPY 10,000 per paper is the entry product. It is high enough to avoid casual, low-signal requests, but low enough for an individual researcher or small team to buy one review before submission or revision.

JPY 50,000 per month is the continuity product. At up to 10 papers, the nominal unit price is JPY 5,000 per paper, which rewards recurring lab/team usage while keeping the public anchor at JPY 10,000.

This structure matches the current operating constraint: TPR production already exists, while billing, quota management, and customer operations can remain manual during Phase 1.

## Phase 1 Operating Assumptions

- Requests arrive through the public GitHub issue CTA.
- Director confirms fit, timeline, and payment path manually.
- Delivery is private Markdown unless otherwise agreed.
- Stripe Checkout, subscription billing, and quota tracking are later implementation steps.
