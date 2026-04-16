# Phase 3-4 Completion Summary

## Status: COMPLETE

---

## Summary of Results Analysis

Analyzed all 10 numbered experiments across NC_CLIGen (Experiments 1–6) and NC_GUIWorld (Experiments 7–10), extracting exact numeric values from Tables 2–11. Performed effect size analysis for all main comparisons, assessed claim support, evaluated statistical rigor, and examined qualitative evidence and visualization quality.

The paper contains a clear two-tier result structure: (1) decisive large-effect results that are robust to measurement uncertainty, and (2) small-gap results that are numerically present but lack the statistical grounding to confirm whether they reflect real differences. The paper's most important concrete findings — SVG cursor supervision (98.7% accuracy), CUA data quality advantage (FVD 14.72 vs. 20.37–48.17 for random data), and the symbolic computation bottleneck — are strongly supported. The injection mode architectural recommendation (internal is best) rests partly on a SSIM margin of 0.006 that is likely negligible.

---

## Effect Size Analysis Summary

12 main comparisons analyzed across all tables.

| Category | Count | Interpretation |
|---|---|---|
| Large (d > 0.8 est.) | 7 | Cursor accuracy, FVD CUA vs. baselines, PSNR caption effect, OCR training progression, contextual-to-internal FVD |
| Medium (d ~0.5–0.8 est.) | 1 | SSIM caption effect (Semantic to Detailed) |
| Small (d ~0.2–0.5 est.) | 2 | Arithmetic probe NC_CLIGen vs. Wan2.1; FVD meta vs. raw-action encoding |
| Negligible (d < 0.2 est.) | 2 | SSIM internal vs. residual (0.006 Δ); SSIM meta vs. raw-action (0.016 Δ) |

SD is not reported for any comparison; all Cohen's d values are estimates based on field norms.

**New CFR entries from effect size analysis**: CFR-007 (HIGH, SSIM internal vs. residual negligible), CFR-008 (MEDIUM, meta vs. raw encoding small).

---

## Key Strengths (with Development Directions)

1. **SVG cursor supervision finding (Experiment 8)**: The 8.7% to 98.7% cursor accuracy gap (Table 9) is the paper's most decisive individual result — unambiguous, large effect, clean one-variable design. Development direction: add closed-loop cursor accuracy to confirm the precision transfers beyond oracle conditioning.

2. **Data quality over quantity finding (Experiment 7)**: CUA 110h achieves FVD 14.72 vs. Random Fast 48.17 and Random Slow 20.37 with 12.7x less data (Table 8). Directionally robust despite the action density confound (CFR-006). Development direction: density-matched Random Fast subsampling to isolate the confound.

3. **Caption ablation (Experiment 3)**: Clean 1-variable ablation with monotonic 4.99 dB PSNR progression (21.90 to 26.89 dB, Table 3). Development direction: add bootstrap CIs and report evaluation sample size; add Wan2.1 zero-shot baseline row.

4. **Injection depth ablation (Experiment 9)**: Contextual to internal injection shows meaningful FVD improvement (24.8 to 14.5, -41.5%). Development direction: complete external baseline training run; report per-mode parameter counts to resolve confound (HIGH-003 / CFR-007).

5. **Intellectual honesty in reporting**: Early-stopped external baseline disclosed in footnote; reprompting disclaimed as steerability not reasoning; SSIM plateau (Experiment 2) reported as a negative training result.

---

## Key Concerns (with Improvement Suggestions)

1. **Systemic absence of statistical reporting (CFR-009, HIGH)**: No table (Tables 2–11) reports SDs, CIs, or significance tests. No experiment is repeated with a different random seed. Improvement: at minimum, report bootstrap CIs for Tables 3, 8, and 10 (the three most consequential tables); run Tables 10–11 ablations with 2–3 seeds.

2. **Internal vs. residual SSIM gap likely negligible (CFR-007, HIGH)**: SSIM Δ = 0.006 between the two best injection modes (estimated d ~0.06–0.15). The central architectural recommendation ("internal is best") rests partly on this gap. LPIPS reversal means no single mode dominates all three metrics. Improvement: report per-metric SDs for Tables 10–11; frame recommendation on FVD (stronger evidence) rather than SSIM.

3. **Open-loop-only evaluation (CFR-004, HIGH, existing)**: All 10 experiments use oracle-conditioned rollout. The NC runtime primitive claim (latent state persistence under self-generated inputs) is entirely unmeasured. Improvement: minimal closed-loop test on 50–100 scripted CLIGen Clean tasks at 3–5 autoregressive steps; qualitatively characterize error accumulation.

4. **Reprompting result lacks data table (CFR-010, MEDIUM)**: Figure 6's 83% result (+79 pp, the paper's largest improvement) is reported in a bar chart without sample size, CI, or evaluation protocol. Improvement: convert to a data table equivalent to Table 5 with sample size, CI, and protocol specification.

5. **Arithmetic probe statistical fragility (CFR-005, MEDIUM, existing)**: 4/100 vs. 0/100 at n=100 yields overlapping 95% Wilson CIs ([1.1%, 9.9%] vs. [0%, 3.6%]). Improvement: draw 5 independent 100-sample batches from the 1,000-problem pool; report mean ± std.

6. **Parameter count confound in injection mode ablation (HIGH-003, existing)**: Internal mode adds new CA_action sub-layers; reported parameter counts are absent. Improvement: report per-mode added parameter counts; discuss the capacity contribution to performance.

---

## CFR Entries Added in Phase 3-4

| ID | Severity | Brief Description |
|---|---|---|
| CFR-007 | HIGH | SSIM internal vs. residual Δ=0.006 likely negligible (estimated d ~0.06–0.15); architectural recommendation uncertain on one metric |
| CFR-008 | MEDIUM | Meta vs. raw-action encoding improvements are negligible-to-small (estimated d ~0.16–0.40); "modest" acknowledged by authors |
| CFR-009 | HIGH | Systemic absence of statistical reporting across all Tables 2–11; no SDs, CIs, or significance tests; no multiple seeds |
| CFR-010 | MEDIUM | Reprompting 83% result reported in bar chart without data table, sample size, or CI |

**Total CFR entries after Phase 3-4**: 10 entries (6 HIGH: HIGH-001, HIGH-002, HIGH-003, CFR-004, CFR-007, CFR-009; 4 MEDIUM: MEDIUM-001, MEDIUM-002, CFR-005, CFR-006, CFR-008, CFR-010)

Note: MEDIUM-001 and MEDIUM-002 are from Phase 3-2; CFR-005, CFR-006 from Phase 3-3; CFR-007 through CFR-010 from Phase 3-4. Entry count is 12 total (6 HIGH + 4 MEDIUM from prior phases + 2 new MEDIUM from this phase = 6 HIGH + 6 MEDIUM = 12).

---

## Items to Cascade to Phase-4-2

- CFR-009 (systemic no statistics) is the most consequential quality concern for peer reviewers; affects all numerical comparisons
- CFR-007 (internal vs. residual SSIM) undermines the central GUIWorld architectural recommendation — reviewers will question whether internal is genuinely better than residual
- CFR-004 (open-loop only) — fundamental gap between metrics and NC runtime primitive claim
- CFR-010 (reprompting in bar chart) — highest-magnitude result has lowest verifiability
- Missing Wan2.1 zero-shot row in Table 3 — cannot assess fine-tuning benefit without it
- External baseline early-stop in Table 10 — asymmetric training budget confounds depth comparison
- HIGH-003 (parameter count confound) — injection mode ablation conclusion affected

**Strongest results to highlight as genuine contributions**:
- SVG cursor supervision (98.7%, Table 9) — decisive, large effect, clean design
- CUA data quality advantage (FVD 14.72 vs. 20.37–48.17, Table 8) — robust even with density confound caveat
- Symbolic computation bottleneck (Table 5) — robustly demonstrated across four models

---

## Items to Cascade to Phase-7-1

- Decisive contributions: SVG cursor supervision design, CUA data quality finding, four-mode injection ablation, CLIGen data pipeline
- Most important qualification for all results: open-loop oracle conditioning, not closed-loop autonomous operation
- Character accuracy ceiling (54%) and native arithmetic accuracy (4%) are honest benchmarks of current NC limitations — should be presented as such in final report
- The paper's intellectual honesty signals (Experiment 2 plateau, Experiment 6 steerability caveat, Table 10 footnote) are genuinely positive attributes
- Effect size analysis reveals two tiers: (1) large-effect, defensible results, (2) small-gap, statistically unsupported results — this distinction should structure the final assessment

---

## Files Created in Phase 3-4

- `/Users/s30825/unktok/dev/unktok-reviewer/artifacts/results_analysis.md`
- `/Users/s30825/unktok/dev/unktok-reviewer/artifacts/phase3-4_completion_summary.md`
- Updated: `/Users/s30825/unktok/dev/unktok-reviewer/artifacts/critical_findings_registry.md` (added CFR-007 HIGH, CFR-008 MEDIUM, CFR-009 HIGH, CFR-010 MEDIUM)

---

## Confirmation

Phase 3-4 tasks are complete:
- [x] Prerequisites verified (phase3-3_completion_summary.md exists; CFR read at phase start)
- [x] CFR read at phase start (9 existing entries)
- [x] All 10 experiment results extracted from Tables 2–11 with exact values
- [x] Effect Size Summary Table created with all main comparisons (12 comparisons)
- [x] Cohen's d estimated for each comparison; SD absence noted as systemic limitation
- [x] CFR entries added for d < 0.2 (CFR-007, HIGH) and d < 0.5 (CFR-008, MEDIUM)
- [x] Each major claim assessed against results with evidence and development directions
- [x] Performance analysis (absolute, relative, strengths, limitations, trade-offs) completed
- [x] Validity assessment (internal, external, robustness) completed
- [x] Statistical rigor assessed (systemic gap documented as CFR-009)
- [x] Cherry-picking and selective reporting analysis completed
- [x] Ablation study analysis completed (coverage and gaps identified)
- [x] Qualitative analysis completed (visualizations, failure cases)
- [x] Results presentation assessed
- [x] Two-Layer Analysis (Current State + Development Directions) applied throughout
- [x] 4 new CFR entries added (2 HIGH, 2 MEDIUM)
- [x] results_analysis.md created
- [x] phase3-4_completion_summary.md created

---

## Next Phase

Phase 3-5a/b/c: Literature Analysis / Related Work Assessment
