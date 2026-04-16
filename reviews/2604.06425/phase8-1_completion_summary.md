# Phase 8-1 Completion Summary: Improvement Roadmap
# Neural Computers (arXiv:2604.06425)

## Status: COMPLETE

---

## Summary

Phase 8-1 synthesized all identified issues from Phases 4-2, 5-2, 7-0, 7-1, and 7-2 into a prioritized improvement roadmap organized into four tiers: Critical (must address), High-Impact (should address), Recommended (could address), and Optional Enhancements.

---

## Issues Consolidated and Categorized

**Total Issues Addressed**: 28 distinct findings drawn from CFR final state (CRITICAL: 3, HIGH: 10, MEDIUM: 15)

**Organized Into 24 Improvement Recommendations (R1-R24)** across 4 priority tiers.

### By Category:
- Citation and Attribution: R2, R3, R5 (Tier 1); R10, R12 (Tier 2) — 5 recommendations
- New Experiments: R1, R4 (Tier 1); R6, R7, R8 (Tier 2); R13, R14, R18, R23 (Tier 3) — 9 recommendations
- Statistics and Rigor: R7 (Tier 2); R17, R18 (Tier 3) — overlapping with above
- Code and Reproducibility: R9 (Tier 2); R19, R21 (Tier 3 and Tier 4) — 3 recommendations
- Writing and Presentation: R11, R12 (Tier 2); R15, R16, R22, R24 (Tier 3 and Tier 4) — 6 recommendations
- Methodology: R6 (Tier 2); R13, R20 (Tier 3 and Tier 4) — 3 recommendations

---

## Priority Distribution

| Tier | Label | Recommendations | CFR Findings Addressed |
|------|-------|-----------------|----------------------|
| Tier 1 | Critical | R1-R5 | All 3 CRITICAL + 2 HIGH |
| Tier 2 | High Impact | R6-R12 | 7 HIGH findings |
| Tier 3 | Recommended | R13-R19 | 5 MEDIUM findings |
| Tier 4 | Optional | R20-R24 | Remaining MEDIUM/LOW |

---

## Key Improvement Recommendations

### Most Impactful (Tier 1)

1. **R1 — Closed-Loop Experiment**: Add minimal 5-10 step autoregressive evaluation for NC_CLIGen to provide any empirical support for the NC-primitive claim. No new training required; estimated 1-2 weeks compute.

2. **R2 — Citation Set Completion and Paradigm Reframing**: Add GameNGen, DIAMOND, AVID, DWS to paper body with substantive characterization; reframe NC_GUIWorld as domain extension of established paradigm rather than paradigm origination. Writing-only; 3 days.

3. **R3 — NeuralOS Code Attribution**: Add paper-body disclosure in Section 3.2.1 of NeuralOS code derivation for the GUIWorld pipeline. Writing-only; half a day.

4. **R4 — Zero-Shot Wan2.1 Baseline**: Evaluate base Wan2.1 on CLIGen Clean before fine-tuning; add as a row to Tables 2-4. Single evaluation run; 1-2 days.

5. **R5 — CNC Conditions Application**: Apply the four CNC conditions to NC_CLIGen, NC_GUIWorld, GameNGen, and DIAMOND in a formal table. Writing and analysis; 1-2 days.

### Highest Impact-to-Effort (Quick Wins)

- R3 (half a day, resolves a CRITICAL component)
- R11 (half a day, resolves inference speed gap)
- R17 (half a day, resolves documentation gap for headline result)
- R4 (1-2 days, resolves structurally required control condition)
- R8 (1-2 days, resolves attribution gap for reprompting result)

---

## Roadmap Highlights

### Minimum Viable Revision Path
- Duration: 4-5 weeks
- New training required: None
- Addresses: All 3 CRITICAL findings, 7 of 10 HIGH findings
- Composition: Writing-only Tier 1 tasks (R2, R3, R5) + evaluation-only experiments (R1, R4, R8) + Tier 2 writing and measurement tasks

### Comprehensive Revision Path
- Duration: 3-4 months
- New training required: R6 (capacity-controlled baseline), R7 (multi-seed runs), R13 (external mode completion), R20 (S-slot ablation)
- Addresses: All Tiers 1, 2, and 3

### Dependency Structure
- R2 (citations) should be completed before R5 (CNC conditions application) for coherence
- R3 can be done independently and in parallel with all others
- R4 and R8 are independent evaluation runs that can start immediately
- R7 (multi-seed training) is the longest-lead-time item; should be started first among Tier 2 items
- R9 (code release) is independent of all analysis tasks

---

## Cross-Cutting Themes Identified

1. **Attribution and Citation Pattern**: Five recommendations (R2, R3, R5, R10, R12) address the systematic pattern of paradigm-origination framing through selective attribution — collectively the most important cluster of improvements.

2. **Claims vs. Evidence Calibration**: Three recommendations (R1, R4, R8) address the structural problem where paper claims systematically exceed what the experiments demonstrate.

3. **Statistical Reporting Deficit**: R7 and related items address systemic absence of variance reporting; large-effect findings are unaffected, but the architectural hierarchy claims require validation.

4. **Reproducibility Infrastructure**: R9, R19, R21 together close the gap between the current code release and functional reproducibility for NC_CLIGen training experiments.

---

## Two-Layer Analysis Summary

**Current State**: The paper has three classes of claims at three evidential levels. Well-supported claims (NC_CLIGen novelty, SVG cursor supervision, data quality, caption tier effect) are durable and will survive revision. Directional but statistically unvalidated claims (injection mode hierarchy, meta-action encoding) provide useful guidance but need variance reporting for validation. Claims that outrun evidence (NC-primitive framing, pioneering paradigm origination) require either new evidence (closed-loop evaluation) or accurate reframing (paradigm extension, not origination).

**Development Directions**: With 4-5 weeks of focused revision addressing Tiers 1 and 2, the paper can resolve all three CRITICAL concerns and the majority of HIGH concerns, resulting in a paper that: (a) accurately represents its position in the prior-work landscape; (b) provides at least minimal empirical support for the runtime claim; (c) accurately attributes its data pipeline; (d) provides validated or qualified architectural recommendations. The paper's genuine strengths — NC_CLIGen novelty, SVG cursor supervision, NC/CNC conceptual framework, data quality finding — are unaffected by any revision and constitute a solid and publishable core contribution.

---

## Files Created During Phase 8-1

| File | Description |
|------|-------------|
| `artifacts/improvement_roadmap.md` | Full prioritized improvement roadmap (primary deliverable) |
| `artifacts/phase8-1_completion_summary.md` | This file |

---

## Confirmation: Phase 8-1 Tasks Complete

- [x] Prerequisites verified (phase7-2_completion_summary.md exists and reviewed)
- [x] All prior phase artifacts reviewed (weaknesses_analysis.md, comparative_analysis.md, critical_review.md, critical_findings_registry.md)
- [x] All 28 issues consolidated from prior phases
- [x] Issues categorized across 6 category types (Citation/Attribution, Experimental Design, Statistics, Reproducibility, Presentation, Methodology)
- [x] Priority matrix applied (Impact x Feasibility → Priority tier)
- [x] 24 improvement recommendations created (R1-R24)
- [x] Each recommendation includes: Problem Statement, Why It Matters, Recommended Improvement, Expected Outcome
- [x] Four priority tiers created: Critical (Tier 1), High Impact (Tier 2), Recommended (Tier 3), Optional (Tier 4)
- [x] Effort estimates provided for each recommendation
- [x] Dependency relationships mapped
- [x] Minimum Viable Revision path defined (4-5 weeks, no new training)
- [x] Comprehensive Revision path defined (3-4 months with new training)
- [x] Quick Wins table created (highest impact-to-effort recommendations)
- [x] Cross-cutting themes identified (4 themes)
- [x] Two-Layer Analysis applied (Current State + Development Directions)
- [x] No numerical scores used
- [x] No acceptance/rejection prediction made
- [x] All recommendations specific and actionable
- [x] Recommendations grounded in evidence from prior phases
- [x] Improvement roadmap saved to artifacts/improvement_roadmap.md
- [x] Phase completion summary saved to artifacts/phase8-1_completion_summary.md
