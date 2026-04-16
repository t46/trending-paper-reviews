# Phase 7-0 Completion Summary: Devil's Advocate Review

## Status: COMPLETE

## Paper: Neural Computers (arXiv:2604.06425)

---

## Summary of Devil's Advocate Review

The Phase-7-0 Devil's Advocate review challenged all 25 prior CFR entries, identified 2 new issues, and escalated 3 findings (including 1 newly synthesized pattern finding). The review found that prior phases were too lenient on the runtime claim gap and the citation integrity issue, and too harsh on the LLM caption quality and SSIM noise findings.

---

## Findings Reviewed and Challenged

- Total CFR entries reviewed: 25
- Classifications challenged: 18 (all non-CRITICAL entries)
- Escalations recommended: 3
- Downgrades recommended: 4
- Severity standardizations: 2 (non-standard "MAJOR" → standard HIGH)
- New issues identified: 2

---

## Final CFR Statistics (After DA Review)

| Severity | Count | Entries |
|----------|-------|---------|
| CRITICAL | 3 | HIGH-004 (escalated), HIGH-011 (escalated), CFR-PATTERN-A (new) |
| HIGH | 10 | HIGH-001, HIGH-003, HIGH-009, HIGH-012, CFR-015, CFR-016, CFR-019, CFR-023, CFR-024, CFR-026 (new) |
| MEDIUM | 15 | MEDIUM-001, MEDIUM-002, HIGH-002 (down), HIGH-007 (down), CFR-005, CFR-006, CFR-008, CFR-010, CFR-013, CFR-014, CFR-017, CFR-018, CFR-020, CFR-021 (down), CFR-022 (down), CFR-025, CFR-027 (new) |
| LOW | 0 | — |

---

## Key Escalations

### 1. HIGH-004 → CRITICAL
The open-loop evaluation gap was already HIGH but deserved CRITICAL. The paper's entire "running computer" framing — the sole differentiator from GameNGen, DIAMOND, and NeuralOS — requires closed-loop behavior. Every experiment uses oracle conditioning. The NC-specific property (runtime state persistence through self-generated inputs) has no experimental support in any of the 10 experiments. Disclosure of this limitation does not reduce severity.

### 2. HIGH-011 → CRITICAL
The project blog confirms author awareness of GameNGen. Omission from paper body is a presentation decision, not a knowledge gap. For a paper claiming to pioneer a paradigm, deliberate exclusion of the most directly comparable paradigm-establishing paper is a CRITICAL related-work integrity issue.

### 3. CFR-PATTERN-A (NEW, CRITICAL)
Synthesized from: HIGH-001, HIGH-011, HIGH-012, CFR-024, CFR-014. Five findings individually classified HIGH/MEDIUM combine into a CRITICAL pattern: systematic omission of comparative context (citations, code attribution, mathematical equivalence) that creates a misleading impression of paradigm originality. GameNGen omitted despite project blog awareness; NeuralOS code derived but undisclosed in paper body; NC formalism mathematically equivalent to GameNGen's formalism without acknowledgment.

---

## Key Downgrades

### HIGH-002 → MEDIUM (LLM Caption Quality)
CLIGen Clean (all controlled experiments, 8 of 10) uses scripted captions. LLM caption issue affects only exploratory CLIGen General and the caption tier ablation. Architecture validity is not contingent on LLM caption quality.

### HIGH-007 → MEDIUM (SSIM Delta = 0.006)
The FVD hierarchy (internal 14.5 < residual 18.8) is robust and points the same direction. SSIM is one metric of three. The architectural recommendation survives on FVD regardless of the noise-level SSIM difference.

### CFR-021 → MEDIUM (Sora2 Config)
71% vs. 4% gap is robust to any plausible configuration variation. Presentation concern, not validity concern.

### CFR-022 → MEDIUM (External Early-Stop)
Explicitly disclosed in Table 10 footnote. Three fully trained modes are sufficient for the injection hierarchy recommendation.

---

## New Issues Found

### CFR-026 (HIGH): Missing Zero-Shot Wan2.1 Baseline
Tables 2-4 have no zero-shot Wan2.1 row, making it impossible to attribute NC_CLIGen's PSNR/accuracy results to fine-tuning rather than the pretrained model's base capability. Structurally required for the core NC_CLIGen empirical claim.

### CFR-027 (MEDIUM): Reprompting Comparison with Base Wan2.1 Absent
The "steerability as RL alternative" interpretation requires showing NC_CLIGen + reprompting outperforms Wan2.1 + reprompting, not just that reprompting improves NC_CLIGen.

---

## Patterns Identified

### Pattern A: Paradigm Claim Integrity (CRITICAL)
Cluster of five findings showing systematic omission of comparative context to maximize appearance of paradigm originality. No individual finding reaches CRITICAL; combined pattern does.

### Pattern B: Injection Mode Ablation Compound Weakness (HIGH/MEDIUM combined)
HIGH-003 (parameter confound) + CFR-007/MEDIUM (SSIM noise) + HIGH-009 (no statistics) + CFR-022/MEDIUM (external underfitted) simultaneously affect the injection mode ablation. The FVD hierarchy is the only reliable finding from Table 10. The full four-mode recommendation should be treated as directional, not definitive.

---

## What Prior Phases Got Right (DA Confirms)

- NC_CLIGen verified novel domain: confirmed, no prior work across ~250 candidates
- SVG cursor supervision (d > 5.0): confirmed decisive, no prior work
- HIGH-009 (no statistics): correctly identified as systemic HIGH
- CFR-019 (missing captioning pipeline): correctly identified as HIGH
- HIGH-012 (NeuralOS treatment): correctly identified as HIGH

---

## Files Created

- `artifacts/devils_advocate_review.md` — Full DA review document
- `artifacts/phase7-0_completion_summary.md` — This file

## Files Updated

- `artifacts/critical_findings_registry.md` — 3 escalations, 4 downgrades, 2 standardizations, 2 new entries, 1 new pattern entry, resolution/escalation logs added

---

## Next Phase

Phase 7-1: Final Report synthesis
