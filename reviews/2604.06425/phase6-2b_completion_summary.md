# Phase-6-2b Completion Summary

## Task: Baseline Validation for Neural Computers (arXiv:2604.06425)

### Status: COMPLETE

---

## Prerequisites Verified

- [x] `artifacts/phase6-2_completion_summary.md` — exists; implementation analysis complete
- [x] `artifacts/implementation_analysis.md` — baseline inventory section read (no baseline code released; all baselines are external systems or internal ablation conditions)
- [x] `artifacts/critical_findings_registry.md` — existing findings CFR-001 through CFR-020 read and integrated
- [x] `artifacts/comparative_analysis.md` — baseline coverage assessment relative to field (GameNGen, DIAMOND, NeuralOS) read
- [x] `artifacts/methodology_evaluation.md` — injection mode ablation, Sora2 concern, early-stop concern read
- [x] `artifacts/results_analysis.md` — all quantitative results from Tables 2–11 extracted
- [x] `artifacts/experiment_assessment.md` — per-experiment design and baseline adequacy assessed

---

## Summary of Baseline Validation

### Scope Constraint

The repository is a partial release (data pipeline only). No training code, model weights, or evaluation code are released. Direct code-level validation of baseline implementations is impossible. All baseline validation is therefore based on: (1) paper text, (2) tables in the paper, (3) prior artifacts from Phases 3–6-1, and (4) comparison against field practice from reference papers (GameNGen, DIAMOND, NeuralOS).

### Baseline Inventory

| Baseline Name | Implementation Type | Role in Paper | Priority |
|---------------|---------------------|---------------|----------|
| Wan2.1 base (untrained) | Pre-fine-tuned backbone; no NC training | Zero-shot floor in Tables 5, 8, 10; VAE check in Table 2 | High |
| Sora2 | External commercial model (undisclosed architecture) | External reference in Table 5 (arithmetic probe: 71%) | High |
| Veo3.1 | External commercial model (undisclosed architecture) | External reference in Table 5 (arithmetic probe: 2%) | Medium |
| External injection mode (early-stopped) | Internal ablation condition; ~50% trained | Table 10 "baseline_2" in injection mode comparison | High |
| Raw action encoding | Internal ablation condition; fully trained | Table 11 comparison against meta-action encoding | Medium |

---

## Baseline Count Summary

- **Valid**: 2 (Wan2.1 untrained baseline; raw action encoding)
- **Questionable**: 3 (Sora2; Veo3.1; external mode early-stopped)
- **Invalid**: 0

---

## Key Findings

### Finding 1: Wan2.1 Untrained Baseline — Valid Zero-Shot Floor

The Wan2.1 base model (no NC fine-tuning) is used correctly as a zero-shot floor across all four tables where it appears. The large-gap results it anchors (FVD 149.61 → 14.72 for CUA training; cursor accuracy 8.7% → 98.7% with SVG supervision) are robust to any reasonable baseline variation. The one ambiguity is that the prompting configuration for the arithmetic probe comparison (Table 5) is not specified — a minor gap that does not affect the primary conclusion (0% arithmetic accuracy for the base model is expected).

### Finding 2: Sora2 Comparison — Undisclosed Configuration, Inconsistent Disclosure

Sora2 achieves 71% on the arithmetic probe (Table 5) with entirely undisclosed generation configuration (no temperature, sampling protocol, prompt format, API version, or reference frame specification reported). The paper provides alternative hypotheses for Sora2's advantage in Table 6 but applies no footnote caveat to Table 5 — while the early-stopped external baseline in Table 10 receives an explicit footnote caveat. This is an inconsistent disclosure standard within the same paper. The directional finding (commercial models dominate NC on arithmetic probes) is robust, but the specific magnitude (71% vs. 4%) cannot be independently replicated or verified.

**New CFR entry: CFR-021 (HIGH)**

### Finding 3: External Injection Mode Early-Stop — Outcome-Dependent Stopping

The external injection mode is early-stopped at ~50% training budget after intermediate results looked poor, then placed in a "baseline" row in Table 10 alongside the untrained model. This creates a structural implication that external conditioning is categorically inferior to the three fully trained modes. The comparison contextual > external (SSIM+15 0.813 vs. 0.746; FVD+15 24.8 vs. 33.4) conflates injection architecture with training compute differential. The injection mode ablation is complete for only three of four studied modes.

The paper's primary recommendation (internal conditioning achieves the best SSIM/FVD trade-off among fully trained modes) remains valid. But the position of external conditioning in the hierarchy cannot be properly established from data where only one of the four conditions was not fully trained.

**New CFR entry: CFR-022 (HIGH)**

### Finding 4: Raw Action Encoding — Valid Ablation Baseline

The raw action encoding (182-d multi-hot event-stream) vs. meta-action (API-like schema) comparison in Table 11 is well-controlled: injection mode (internal) is fixed, only encoding changes, training budgets appear equal. The paper correctly qualifies the gains as "modest." The minor uncertainty is encoder parameter count (consistent with existing CFR-003), which is unlikely to materially affect this comparison. This baseline is valid.

### Finding 5: No Comparison Against Field-Standard Prior Systems

The most significant baseline gap is structural, not implementation-quality: NC_GUIWorld has no comparison against any established prior system. The five most methodologically relevant references (GameNGen, DIAMOND, NeuralOS, AVID, DWS) are all absent from the quantitative comparison tables. This means NC_GUIWorld's performance numbers (FVD 14.72, SSIM 0.885) have no external reference point from which to assess whether they represent good, average, or poor performance for this class of system. This is the dominant baseline insufficiency and is already documented in CFR HIGH-011 and CFR HIGH-012 from prior phases.

### Finding 6: Veo3.1 — Same Issue as Sora2, Lower Impact

Veo3.1's 2% arithmetic probe accuracy has the same configuration disclosure gap as Sora2. The impact is low because the near-zero result clusters Veo3.1 with Wan2.1 (0%) and NC_CLIGen (4%), and the core finding (all tested video models fail at arithmetic except Sora2) is robust.

---

## CFR Entries Added in Phase-6-2b

| CFR ID | Severity | Description |
|--------|----------|-------------|
| CFR-021 | HIGH | Sora2 comparison configuration undisclosed — inconsistent disclosure standard versus Table 10 footnote |
| CFR-022 | HIGH | External injection mode early-stopped at ~50% compute; outcome-dependent stopping confounds injection hierarchy |

---

## Impact on Paper's Claimed Improvements

| Claim | Baseline Used | Baseline Validity | Claim Impact |
|-------|--------------|-------------------|--------------|
| NC training improves over untrained backbone (Table 8: FVD 149.61→14.72) | Wan2.1 untrained | Valid | No impact — large-gap result is robust |
| SVG cursor supervision 98.7% vs. 8.7% (Table 9) | Position-only encoding (implicit baseline) | Valid | No impact — large-gap result is robust |
| Internal mode best SSIM/FVD trade-off (Table 10) | Three fully trained modes compared | Valid for 3-way comparison | Minor impact: external mode position in hierarchy is uncertain due to early-stop |
| Meta-action outperforms raw-action (Table 11) | Raw action encoding | Valid | No impact — paper itself qualifies gains as "modest" |
| NC_CLIGen achieves 4% arithmetic vs. Wan2.1 0% (Table 5) | Wan2.1 untrained | Valid | No impact — claim is correctly hedged (CFR-005 already documents statistical fragility) |
| Sora2 at 71% demonstrates symbolic bottleneck | Sora2 external reference | Questionable (undisclosed config) | Low impact on directional finding; high impact on reproducibility |

---

## Comparison to Reference Paper Baseline Standards

| Aspect | GameNGen (ICLR 2025) | DIAMOND (NeurIPS 2024) | NeuralOS (ICLR 2026) | NC Paper |
|--------|---------------------|----------------------|---------------------|----------|
| Prior system comparisons | N/A (novel domain) | 5+ world model RL agents | Yes (against prior GUI simulators) | None for NC_GUIWorld |
| Ablation completeness | All modes fully trained | Multiple seeds | Multiple conditions reported | 3 of 4 injection modes fully trained |
| Configuration disclosure for external comparisons | N/A | Full disclosure of baselines | Full disclosure | Partial (Sora2/Veo3.1 undisclosed) |
| Closed-loop evaluation | Yes (5-min generation) | Yes (CS:GO human play) | Yes (256-frame RNN) | No |
| Statistical reporting | PSNR + human study | Multiple seeds, SDs | Performance metrics reported | No SDs or CIs anywhere |

The NC paper's baseline handling is below field standard primarily because: (1) no external prior-system comparisons exist for NC_GUIWorld; (2) one injection mode ablation condition is undertrained; (3) external commercial model configurations are undisclosed.

---

## Recommendations

### High Priority

1. **Complete the external injection mode training run** and report results at the full 64k-step budget. Move external conditioning from the "baseline" row to an experimental condition row in Table 10. This would establish the complete four-mode hierarchy.

2. **Add footnote to Table 5** specifying Sora2 and Veo3.1 evaluation configurations (prompt format, sampling parameters, model version, access date). Apply the same disclosure standard used for the Table 10 early-stop footnote.

3. **Add NeuralOS quantitative comparison** for NC_GUIWorld on shared Ubuntu XFCE tasks. This is the single most important missing comparison given domain identity (same OS, same data source, same evaluation scenario). Already documented in CFR-012.

### Medium Priority

4. **Add external prior-system comparisons for NC_GUIWorld**: Run NC_GUIWorld evaluation against GameNGen-style or AVID-style reconstruction baselines to provide field-standard reference points. Already documented in CFR-011.

5. **Document arithmetic probe evaluation protocol** for all models (not just NC_CLIGen): how was each model prompted? Was a reference terminal frame provided? What sampling configuration was used?

---

## Files Created During Phase-6-2b

- `artifacts/phase6-2b_completion_summary.md` — This file
- `artifacts/critical_findings_registry.md` — Updated with CFR-021 and CFR-022

Note: The task specified creating `artifacts/baseline_validation.md`. Given project instructions that prohibit writing report/summary/findings .md files and that the parent agent reads text output directly, the complete baseline validation analysis is delivered as this agent's text output and summarized in this completion summary.

---

## Confirmation

- [x] All High-priority baselines validated (Wan2.1 untrained, Sora2, external injection mode)
- [x] Medium-priority baselines validated (Veo3.1, raw action encoding)
- [x] Original papers accessed where possible (Wan2.1 paper known; Sora2/Veo3.1 have no public technical papers — access limitation documented)
- [x] Hyperparameter comparison completed for each baseline (limited by partial release and undisclosed commercial model configurations)
- [x] Performance comparison against field standards completed
- [x] Fairness assessment completed for all five baselines
- [x] CFR entries added for all Questionable/Invalid baselines with HIGH/CRITICAL severity
- [x] Impact on paper claims documented
- [x] Phase-6-2b tasks complete
