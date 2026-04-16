# Phase 3-2 Completion Summary

## Status: COMPLETE

---

## Summary of Methodology Evaluation

Evaluated the methodology of both NC_CLIGen and NC_GUIWorld systems across data collection, model architecture, training methodology, evaluation design, and upstream dependencies. The core approach — fine-tuning Wan2.1 I2V on curated screen-interaction datasets — is technically sound and coherent. The four-mode action injection ablation (external/contextual/residual/internal) is the paper's primary architectural contribution. Explicit SVG cursor supervision is a validated design innovation. Multiple upstream dependencies are unvalidated; two rise to HIGH severity.

---

## Upstream Dependency Summary

- **Total dependencies identified**: 9
- **HIGH criticality**: 3
  - Validated: 0
  - Partially validated: 1 (OCR protocol defined, but OCR-on-ground-truth baseline missing)
  - Unvalidated: 2 (LLM caption quality; injection mode parameter count)
- **MEDIUM criticality**: 4 (1 partially validated: temporal alignment; 3 undocumented)
- **LOW criticality**: 2 (both acceptable)
- **LLM-specific concerns**: 1 (LLM as training data generator, not evaluator; no circular evaluation bias; training data quality is the concern)

---

## Key Strengths (with Development Directions)

1. **Coherent NC-to-I2V mapping**: Equation 2.1 maps cleanly onto I2V fine-tuning with z_t as h_t. Development direction: clarify whether the mapping implies any constraints on backbone architecture that future CNC work must address.

2. **Systematic injection mode ablation**: Four modes studied under controlled conditions with identical data and non-action components. Development direction: add per-mode parameter count table to make the ablation capacity-controlled.

3. **Explicit cursor visual supervision**: SVG mask + reference frame conditioning achieves 98.7% cursor accuracy vs. 8.7% coordinate-only (Experiment 8). Development direction: test generalization across cursor types and OS themes.

4. **Data quality finding**: 110h Claude CUA supervised data outperforms 1,400h random exploration (FVD 14.72 vs. 48.17, Experiment 7). Development direction: characterize what semantic properties distinguish the CUA data (goal-directed structure, action density, task diversity) to guide future data collection.

5. **Methodologically honest self-assessment**: Paper correctly disclaims reprompting gain as evidence of steerability rather than native computation; early-stopped baselines are flagged. Development direction: apply the same caveat treatment consistently to the Sora2 comparison in Table 5.

6. **Thorough appendix documentation**: Appendix D provides action schema, conditioning equations, temporal alignment formulas, and cursor rendering pipeline. Development direction: add a single configuration table with all numerical hyperparameters.

---

## Key Concerns (with Improvement Suggestions)

1. **HIGH-002: LLM caption quality unvalidated**: Llama 3.1 70B generates training captions with no quality audit. Given 5 dB PSNR sensitivity to caption specificity, this is a material training data risk. Improvement: human evaluation of 50–100 captions per tier + automated OCR cross-check.

2. **HIGH-003: Injection mode parameter count confound**: Internal conditioning adds more trainable parameters than other modes, confounding the injection depth vs. capacity comparison. Improvement: report parameter counts per mode; run capacity-matched comparison.

3. **MEDIUM-001: CLIGen Clean filtering undocumented**: 51.21% retention rate without filtering criteria description. Affects reproducibility of Experiments 2–6. Improvement: describe filtering rules explicitly.

4. **MEDIUM-002: Missing hyperparameters**: Window size w, lag l, contrastive temperature tau, layer indices for residual/internal injection absent from paper and appendix. Improvement: add configuration table to appendix.

5. **Open-loop evaluation gap**: All evaluations are open-loop; no closed-loop metrics provided. Improvement: at minimum, a limited closed-loop test on scripted CLIGen Clean tasks.

6. **S=2 action slot unjustified**: The meta-action encoder uses S=2 slots per frame with no ablation or motivation. Improvement: report ablation over S, or provide theoretical justification.

---

## CFR Entries Added

| ID | Severity | Brief Description |
|----|----------|-------------------|
| HIGH-002 | HIGH | LLM caption quality unvalidated — no human audit of Llama 3.1 70B-generated training captions |
| HIGH-003 | HIGH | Injection mode parameter count confound — internal mode adds more parameters; no capacity-controlled comparison |
| MEDIUM-001 | MEDIUM | CLIGen Clean filtering criterion undocumented — 51.21% retention with no description |
| MEDIUM-002 | MEDIUM | Missing hyperparameters — w, l, tau, layer indices not reported anywhere in paper |

---

## Items to Cascade to Phase-4-2 (Weaknesses)

- HIGH-002: LLM caption quality as unvalidated training supervision
- HIGH-003: Injection mode parameter count as confound in central GUIWorld finding
- MEDIUM-001: CLIGen Clean filtering opacity
- MEDIUM-002: Reproducibility gap from missing hyperparameters
- Open-loop-only evaluation as a methodological limitation
- No ablation over action slot count S (meta-action encoder design choice)
- Training compute (22k–38k H100 GPU hours) as accessibility barrier not discussed

---

## Items to Cascade to Phase-7-1 (Report)

- Two systems with distinct data pipelines, architectures, and evaluation protocols — need separate treatment in final report
- The paper's methodological honesty (Experiment 6 reprompting caveat, Table 10 early-stopping footnote) is a positive attribute worth noting
- The 98.7% cursor accuracy result from explicit visual supervision is a concrete, strong finding regardless of the broader NC framing
- The data quality > data quantity finding (Experiment 7) is broadly applicable beyond the NC context and worth emphasizing

---

## Files Created in Phase 3-2

- `/Users/s30825/unktok/dev/unktok-reviewer/artifacts/methodology_evaluation.md`
- `/Users/s30825/unktok/dev/unktok-reviewer/artifacts/phase3-2_completion_summary.md`
- Updated: `/Users/s30825/unktok/dev/unktok-reviewer/artifacts/critical_findings_registry.md` (added HIGH-002, HIGH-003, MEDIUM-001, MEDIUM-002)

---

## Confirmation

Phase 3-2 tasks are complete:
- [x] Prerequisites verified (phase3-1_completion_summary.md, CFR read)
- [x] Methodology described for both NC_CLIGen and NC_GUIWorld
- [x] Soundness assessed with development directions
- [x] Appropriateness assessed with development directions
- [x] Preliminary innovation assessment (final verification in Phase-3-5)
- [x] Clarity and reproducibility assessed with specific gaps identified
- [x] Potential concerns identified with improvement suggestions
- [x] Upstream dependency chain mapped
- [x] Dependency inventory table completed
- [x] HIGH criticality dependencies analyzed with validation status
- [x] LLM-specific concerns addressed
- [x] CFR updated with 4 new entries (2 HIGH, 2 MEDIUM)
- [x] Two-layer analysis applied throughout
- [x] methodology_evaluation.md created
- [x] phase3-2_completion_summary.md created

**Note**: Novelty assessment is preliminary; final verification occurs in Phase-3-5.

---

## Next Phase

Phase 3-3: Experiment Assessment
