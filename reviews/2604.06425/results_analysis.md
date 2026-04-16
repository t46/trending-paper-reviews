# Results Analysis: Neural Computers (arXiv:2604.06425)

## Phase 3-4 — Results Analysis

---

## 1. Complete Results Extraction

### NC_CLIGen Results

**Table 2 — VAE Reconstruction Quality (Experiment 1)**
- Average PSNR: 40.77 dB
- Average SSIM: 0.989
- Context: Wan2.1 VAE applied to CLIGen (General) frames; no NC fine-tuning. Prerequisite validation for backbone viability.
- No breakdown by font size, content type, or clip. Single aggregate statistic.

**Table 3 — Caption Styles vs. TI2V Fidelity (Experiment 3)**

| Prompt Style | PSNR (dB) | SSIM | Avg. Words |
|---|---|---|---|
| Semantic | 21.90 | 0.813 | 55 |
| Regular | 23.63 | 0.843 | 52 |
| Detailed | 26.89 | 0.867 | 76 |

- Absolute difference (Semantic to Detailed): 4.99 dB PSNR, 0.054 SSIM
- Relative improvement in PSNR: +22.8% over semantic baseline
- No standard deviations, no confidence intervals, sample size unspecified.

**Table 4 — OCR Accuracy vs. Training Steps (Experiment 4)**

| Steps (k) | Char. acc. | Exact line |
|---|---|---|
| 0 | 0.03 | 0.01 |
| 10 | 0.18 (+0.15) | 0.05 (+0.04) |
| 20 | 0.33 (+0.30) | 0.12 (+0.11) |
| 30 | 0.41 (+0.38) | 0.18 (+0.17) |
| 40 | 0.52 (+0.49) | 0.26 (+0.25) |
| 50 | 0.52 (+0.49) | 0.27 (+0.26) |
| 60 | 0.54 (+0.51) | 0.31 (+0.30) |

- Final character accuracy: 0.54 (54%), exact-line: 0.31 (31%)
- Plateau begins around 40-50k steps
- No standard deviations across evaluation runs.

**Table 5 — Arithmetic Probe Accuracy (Experiment 5)**

| Model | Accuracy |
|---|---|
| Wan2.1 | 0% |
| NC_CLIGen | 4% |
| Veo3.1 | 2% |
| Sora2 | 71% |

- Sample: 100 problems from 1,000-problem pool, single draw
- NC_CLIGen improvement over Wan2.1: +4 percentage points absolute

**Figure 6 — Reprompting Effect (Experiment 6)**
- NC_CLIGen native: 4%
- NC_CLIGen reprompted: 83% (+79 pp)
- Sora2 (reference): 71%
- Result is from a bar chart only; Table 6 presents hypotheses, not additional data. No sample size or CI stated.

### NC_GUIWorld Results

**Table 7 — Cursor/Action Statistics (Experiment 7 context)**

| Split | Avg. cursor speed (px/frame) | Actions/sec |
|---|---|---|
| Random Slow | 1.51 | 1.58 |
| Random Fast | 195.15 | 4.18 |
| CUA (supervised) | 3.79 | 0.10 |

**Table 8 — Overall Performance Across Data Sources (Experiment 7)**

| Split | FVD_all | SSIM_all | LPIPS_all |
|---|---|---|---|
| Untrained baseline | 149.61 | 0.496 | 0.605 |
| Random Fast (train) | 48.17 | 0.695 | 0.483 |
| Random Slow (train) | 20.37 | 0.830 | 0.237 |
| Claude CUA (train) | 14.72 | 0.885 | 0.144 |

- CUA vs. untrained: FVD 149.61 to 14.72 (-90.2%), SSIM 0.496 to 0.885 (+78.4%)
- CUA vs. Random Fast: FVD 48.17 to 14.72 (-69.4%), SSIM 0.695 to 0.885 (+27.3%)
- CUA data is 110h; Random Fast + Random Slow combined ~1,400h (12.7x more data)

**Table 9 — Cursor Conditioning Losses vs. Accuracy (Experiment 8)**

| Loss variant | Cursor accuracy |
|---|---|
| Position (x,y) only | 8.7% |
| Position (x,y) + Fourier | 13.5% |
| Position (x,y) + SVG mask/ref | 98.7% |

- SVG vs. position-only: +90.0 percentage point absolute improvement
- SVG vs. Fourier: +85.2 pp
- This is the paper's largest single-variable result by absolute magnitude.

**Table 10 — Action-Driven Metrics Across Injection Schemes, 15 frames post-action (Experiment 9)**

| Mode | SSIM+15 (up) | LPIPS+15 (down) | FVD+15 (down) |
|---|---|---|---|
| baseline_1 (untrained) | 0.326 | 0.649 | 184.3 |
| baseline_2 (external, early-stopped) | 0.746 | 0.251 | 33.4 |
| contextual | 0.813 | 0.190 | 24.8 |
| residual | 0.857 | 0.138 | 18.8 |
| internal | 0.863 | 0.141 | 14.5 |

Note: baseline_2 (external) was early-stopped at ~50% planned training budget.

- internal vs. contextual: SSIM 0.813 to 0.863 (+6.2%), FVD 24.8 to 14.5 (-41.5%)
- internal vs. residual: SSIM 0.857 to 0.863 (+0.7%), FVD 18.8 to 14.5 (-22.9%)
- residual achieves lowest LPIPS (0.138) vs. internal (0.141); a reversal on one of three metrics.

**Table 11 — Raw-Action vs. Meta-Action Encoding (Experiment 10)**

| Mode | Encoding | SSIM+15 (up) | LPIPS+15 (down) | FVD+15 (down) |
|---|---|---|---|---|
| internal | raw-action (event-stream) | 0.847 | 0.144 | 16.6 |
| internal | meta-action (API-like) | 0.863 | 0.141 | 14.5 |

- Meta vs. raw: SSIM +1.9%, LPIPS -2.1%, FVD -12.7%
- Authors describe these gains as "modest" (Section 3.2.5, p.19).

---

## 2. Effect Size Summary Table (MANDATORY)

Because no standard deviations are reported for any table in the paper, Cohen's d cannot be computed directly. Estimation is applied using field norms; all estimates are marked as such.

**SD estimation methodology**: For SSIM metrics, SD is typically 0.04-0.10 in video generation evaluation. For PSNR, SD is typically +/-0.5-1.5 dB. For FVD, SD often 5-20% of value. For percentage metrics (cursor accuracy), binomial SE used. All Cohen's d values are estimates.

| Metric | Proposed (best) | Best Comparable Baseline | Delta Abs | Delta Rel% | Cohen's d (est.) | Interpretation | CFR Entry |
|---|---|---|---|---|---|---|---|
| PSNR: Detailed vs. Semantic captions (Table 3) | 26.89 dB | 21.90 dB | 4.99 dB | +22.8% | d ~3.3-10.0 (est., SD +/-0.5-1.5 dB) | Large | N/A |
| SSIM: Detailed vs. Semantic (Table 3) | 0.867 | 0.813 | 0.054 | +6.6% | d ~0.5-1.4 (est., SD ~0.04-0.10) | Medium-Large | N/A |
| Char. acc.: NC_CLIGen 60k vs. 0k (Table 4) | 0.54 | 0.03 | 0.51 | +1700% | d > 2.0 (est.) | Large | N/A |
| Arithmetic probe: NC_CLIGen vs. Wan2.1 (Table 5) | 4% | 0% | +4 pp | N/A | d ~0.4 (est., binomial SE ~2%) | Small | CFR-005 (existing) |
| Cursor accuracy: SVG vs. position-only (Table 9) | 98.7% | 8.7% | +90.0 pp | +1034% | d > 5.0 (est.) | Large | N/A |
| FVD: CUA vs. Untrained (Table 8) | 14.72 | 149.61 | -134.89 | -90.2% | d > 3.0 (est.) | Large | N/A |
| FVD: CUA vs. Random Fast (Table 8) | 14.72 | 48.17 | -33.45 | -69.4% | d ~2.0-4.0 (est.) | Large | N/A |
| SSIM+15: internal vs. contextual (Table 10) | 0.863 | 0.813 | +0.050 | +6.2% | d ~0.5-1.3 (est.) | Medium | N/A |
| FVD+15: internal vs. contextual (Table 10) | 14.5 | 24.8 | -10.3 | -41.5% | d ~1.0-2.5 (est.) | Large | N/A |
| SSIM+15: internal vs. residual (Table 10) | 0.863 | 0.857 | +0.006 | +0.7% | d ~0.06-0.15 (est.) | Negligible | CFR-007 (NEW) |
| FVD+15: meta vs. raw-action (Table 11) | 14.5 | 16.6 | -2.1 | -12.7% | d ~0.2-0.5 (est.) | Small-Medium | CFR-008 (NEW) |
| SSIM+15: meta vs. raw-action (Table 11) | 0.863 | 0.847 | +0.016 | +1.9% | d ~0.16-0.40 (est.) | Negligible-Small | CFR-008 (NEW) |

**SD absent note (systemic)**: The paper reports no standard deviations, confidence intervals, or repeated-run statistics anywhere in Tables 2-11. All effect size interpretations are conditional on estimated SDs and may shift if actual SDs are large. See CFR-009.

---

## 3. Do Results Support the Claims?

### Claim 1: "NCs realize early interface primitives, especially I/O alignment and short-horizon control"

**Current State**: Partially supported with appropriate scope qualification.
- I/O alignment evidence: Table 3 shows 26.89 dB PSNR (detailed captions), Table 4 shows 54% character accuracy at 60k steps, Table 9 shows 98.7% cursor accuracy under SVG supervision.
- Short-horizon control evidence: Table 10 shows FVD+15 = 14.5 for internal conditioning vs. 184.3 untrained.
- Qualification: "short-horizon control" implies closed-loop reactivity, which is never measured. The open-loop FVD/SSIM numbers measure rendering fidelity given oracle conditioning, not controllability under self-generated inputs.

**Development Direction**: State more precisely as "open-loop I/O alignment and short-horizon rendering fidelity under oracle conditioning." A minimal closed-loop test (3-5 autoregressive steps on 50 scripted tasks) would allow replacing the hedge with direct evidence.

### Claim 2: "Data quality outperforms data quantity for NC training"

**Current State**: Results support the directional claim, but the mechanism is not cleanly isolated.
- CUA 110h achieves FVD 14.72 vs. Random Fast 400h FVD 48.17 and Random Slow 1,000h FVD 20.37 (Table 8). CUA outperforms 12.7x more random data.
- Unresolved confound: CUA action density (0.10 actions/sec) vs. Random Fast (4.18 actions/sec) is a 42x difference (Table 7, CFR-006).

**Development Direction**: Subsample Random Fast to match CUA's 0.10 actions/sec density to isolate the confound. Report FVD for density-matched Random Fast.

### Claim 3: "Cursor accuracy reaches 98.7% with explicit SVG visual supervision"

**Current State**: Directly and unambiguously supported by Table 9. The 8.7% to 98.7% gap is large enough to be decisive under any plausible error bar (estimated d > 5.0). Caveat: measured under open-loop oracle conditioning.

**Development Direction**: Add closed-loop cursor accuracy evaluation to confirm precision transfers to autonomous rollout.

### Claim 4: "Internal action injection achieves best SSIM/FVD trade-off"

**Current State**: Supported at the system level, but the internal vs. residual margin is likely negligible for SSIM (Δ = 0.006, d ~0.06-0.15). On LPIPS, residual (0.138) outperforms internal (0.141). The "best trade-off" claim selects the two metrics where internal wins. The external baseline early-stop (~50% compute, Table 10 footnote) additionally confounds the depth-of-injection finding.

**Development Direction**: Complete the external baseline training run. Report per-mode parameter counts. Report per-metric SDs for Tables 10-11 to determine whether the internal vs. residual differences exceed noise.

### Claim 5: "Symbolic computation remains the main bottleneck"

**Current State**: Strongly supported. NC_CLIGen 4%, Wan2.1 0%, Veo3.1 2% all show near-zero arithmetic accuracy (Table 5). The Sora2 71% outlier is correctly hedged with three alternative hypotheses (Table 6).

**Development Direction**: Add a random-generation baseline (what accuracy does random symbol generation achieve given correct output format?) to establish the chance floor.

### Claim 6: "Reprompting achieves 83% accuracy; this is steerability not native reasoning"

**Current State**: The 4% to 83% improvement (Figure 6) supports the steerability interpretation, and the paper explicitly disclaimed this as rendering rather than native computation. Intellectual honesty is notable. However, the 83% result is reported as a bar chart without a data table, sample size, or CI.

**Development Direction**: Convert Figure 6 result to a data table with sample size, CI, and exact evaluation protocol equivalent to Table 5.

### Claim 7: "Meta-action encoding is preferred over raw-action"

**Current State**: Weakly supported quantitatively. Improvements are small (SSIM Δ = 0.016, d ~0.16-0.40). The paper itself acknowledges "modest" gains and qualitative failure mode persistence across both encodings. The preference is justified by semantic simplicity, not performance.

**Development Direction**: Frame the recommendation explicitly as a simplicity choice rather than a performance claim. The paper's own text does this in Section 3.2.5; the results summary should match.

---

## 4. Performance Analysis

### Absolute Performance

**CLIGen:**
- PSNR 26.89 dB (detailed captions): adequate for perceptual terminal rendering; below typical high-fidelity targets (>30 dB for natural images) but terminal content with flat backgrounds is not directly comparable to natural image benchmarks.
- Character accuracy 0.54 / exact-line accuracy 0.31 at 60k steps: moderate functional metrics. For a "running computer," near-100% character accuracy would be required; 54% means roughly half of rendered characters are incorrectly read from generated frames.
- Arithmetic accuracy 4% (native): pre-functional for any compute task.

**GUIWorld:**
- FVD 14.72 (CUA training): strong for video generation on desktop interaction data. Natural video generation literature considers FVD below 20 high quality, though cross-domain comparison is not straightforward.
- Cursor accuracy 98.7% (SVG supervision): very high for a generative model under oracle conditions.
- SSIM+15 = 0.863 (internal conditioning): structurally high SSIM for post-action rendering fidelity.

### Where the Method Works Best

1. Cursor positioning under SVG supervision (Experiment 8): 98.7% cursor accuracy is the clearest evidence of learnable GUI primitives. Large effect size, clean experimental design.
2. Caption-driven text rendering (Experiment 3): 26.89 dB PSNR with detailed captions vs. 21.90 dB with semantic demonstrates literal description is an effective conditioning mechanism.
3. Data quality benefit (Experiment 7): CUA-trained model achieves lowest FVD despite smallest dataset size, demonstrating NC training responds well to dense action-response supervision.
4. Training OCR accuracy progression (Experiment 4): Monotonic improvement from 3% to 54% over 60k steps demonstrates text rendering is genuinely learned, not a random baseline artifact.

### Where the Method Shows Limitations

1. Symbolic computation (Experiment 5): 4% native arithmetic accuracy is near-zero. The NC abstraction as a video model shows no meaningful arithmetic capability without conditioning.
2. SSIM plateau (Experiment 2): Plateau at ~25k steps and slight degradation with prolonged training suggest the diffusion objective is not well-matched to continued NC primitive learning.
3. Character accuracy ceiling: At 54%, NC_CLIGen generates partially legible text. For functional NC use, this is a significant gap.
4. Internal vs. residual injection distinction (Experiment 9): SSIM difference of 0.006 is likely negligible; the architectural recommendation rests primarily on FVD.
5. Action encoding (Experiment 10): Meta-action improvement is modest; qualitative failure modes persist regardless of encoding choice.

### Trade-offs

- SSIM vs. FVD trade-off in Table 10: Internal mode optimizes SSIM and FVD but not LPIPS. Residual mode achieves marginally lower LPIPS. No single mode dominates all three metrics.
- Data quality vs. quantity trade-off (Table 8): CUA 110h outperforms Random Slow 1,000h, but CUA data requires Claude API calls for collection. The paper recommends quality without addressing collection cost or scalability.
- Caption specificity vs. availability: Detailed captions (best PSNR) require ~76-word descriptions generated by Llama 3.1 70B; the paper does not address pipeline cost at scale.

---

## 5. Validity Assessment

### Internal Validity

**Strengths:**
- Single-variable ablation design: Experiments 3, 7, 8, 9, 10 each vary one factor while holding others fixed.
- Within-system consistency: Results are internally consistent; the injection mode hierarchy (internal > residual > contextual > external) is monotonic on two of three metrics.
- Baseline correctness: Untrained Wan2.1 is used as a zero-shot floor in Table 5, Table 8, and Table 10.

**Threats to internal validity:**
1. External baseline early-stop (Table 10): Early-stopped at ~50% planned training budget; the footprint on SSIM/FVD values is unknown.
2. Parameter count confound (HIGH-003): Internal mode adds new CA_action sub-layers with newly initialized weights; unreported parameter count differences may partially explain performance differences.
3. Arithmetic probe single draw (CFR-005): Single 100-sample draw; different draws would produce different accuracy estimates.
4. No multiple random seeds: No experiment reports results from more than one training seed.

### External Validity

1. Single OS environment: All GUIWorld data from Ubuntu 22.04 / XFCE4 / 1024x768 / Arc-Dark theme. No generalization to other OS, theme, resolution, or app set is tested.
2. Single CLI environment: All CLIGen Clean evaluation uses standardized font/palette/resolution. Generalization to different terminal emulators or color schemes is untested.
3. Closed-loop gap (CFR-004): The most important external validity concern. All results measured under oracle conditioning; how metrics predict autonomous rollout behavior is unknown.

### Robustness

- Large-gap results (cursor accuracy 8.7% to 98.7%, FVD 149.61 to 14.72) are robust to measurement uncertainty; they represent effect sizes that would survive substantial noise.
- Small-gap results (internal vs. residual SSIM 0.006, meta vs. raw SSIM 0.016) are not robust without statistics and may not replicate.
- No ablation is repeated with a different seed; run-to-run variance is uncharacterized throughout.

---

## 6. Statistical Rigor Assessment

**Summary**: Statistical rigor across all 10 experiments is uniformly low. No table reports error bars, standard deviations, confidence intervals, or significance tests. This is a systemic absence (CFR-009).

**Specific statistical concerns:**

1. Tables 3, 8, 9, 10, 11 (all main quantitative results): Single-point measurements with no uncertainty estimates. Table 3 does not even state evaluation sample size.
2. Table 4 (OCR accuracy): Delta notation implies comparison to baseline but no evaluation-draw variance. 5-frame-pair sampling per video introduces unquantified variance.
3. Table 5 (arithmetic probes): 100 samples, single draw. 95% Wilson CI for 4/100 is [1.1%, 9.9%]. NC_CLIGen (4%) vs. Wan2.1 (0%) and Veo3.1 (2%) are statistically indistinguishable (CFR-005).
4. Figure 6 (reprompting): 83% accuracy in a bar chart with no table, no sample size, no CI. Highest-magnitude improvement in the paper is least verifiable (CFR-010).
5. Table 10 (injection modes): Internal vs. residual SSIM difference of 0.006 is unreliable without variance measures (CFR-007).
6. No multiple seeds: No experiment repeats training with a different random seed.
7. No significance tests: No t-test, bootstrap test, or permutation test is applied anywhere.

---

## 7. Cherry-Picking, Selective Reporting, and Over-Claiming Analysis

### Evidence of Balanced Reporting

- Early-stopped external baseline disclosed in Table 10 footnote (not hidden).
- Experiment 6 explicitly disclaimed as steerability not native reasoning.
- SSIM plateau (Experiment 2) reported despite being a negative training result.
- Sora2 71% reported even though it substantially outperforms NC_CLIGen.
- Character accuracy ceiling (54%) not framed as complete success.

### Concerns

1. Reprompting reported as Figure without data table (CFR-010): The largest single improvement figure (+79 pp) has the lowest reporting standard of any result in the paper.
2. External baseline early-stop interpretation: Stopping at ~50% compute "after preliminary rollouts did not warrant further compute" introduces a judgment call that may have been influenced by knowledge of other conditions' results.
3. Metric selection for main recommendation (Table 10): "Best SSIM/FVD trade-off" selects the two metrics where internal wins while omitting that residual wins on LPIPS.
4. Missing Wan2.1 zero-shot baseline in Table 3: The fine-tuning benefit on PSNR cannot be assessed without a Wan2.1 zero-shot row in the caption ablation.
5. No failed experiments reported: The ablation sequence shows clean positive results. Whether any injection mode combinations or alternative hyperparameters were tried and discarded is unknown.

---

## 8. Ablation Study Analysis

**Ablations conducted (good coverage):**
- Caption tier (3 levels): clean 1-variable ablation (Table 3)
- Training step count: 0k-460k progression (Figure 5, Table 4)
- Training data source: 4 splits x 3 metrics (Table 8)
- Cursor supervision type: 3 variants (Table 9)
- Action injection mode: 4 modes x 3 metrics (Table 10)
- Action encoding type: 2 encoders x 3 metrics (Table 11)

**Ablation coverage gaps:**
1. No action slot count (S) ablation: meta-action encoder uses S=2 with no justification or ablation.
2. No temporal window (w) and lag (l) ablation for contextual attention mask.
3. No ablation combining injection modes.
4. No caption ablation on CLIGen General (only CLIGen Clean tested).
5. No contrastive loss weight (lambda) ablation.

**Hierarchy clarification needed**: The injection mode effect (contextual to internal: SSIM +6.2%) is roughly 3x the encoding effect (raw to meta: SSIM +1.9%), establishing that injection depth matters more than encoding granularity. This hierarchy is implicit in the tables but not explicitly quantified in the text.

---

## 9. Qualitative Analysis

**Strengths**: Extensive visualization support (pages 12-13 for CLIGen, page 20 for GUIWorld). GUIWorld side-by-side comparisons show coherent cursor behavior in positive samples. CLIGen visualizations demonstrate text rendering improvement before/after training.

**Limitations**:
- All visualization samples appear to be positive cases. No failure case gallery is presented despite acknowledged failure modes (text smear, cursor drift, spurious color changes).
- Reprompting comparison (Experiment 6, Figure 6) shows a bar chart but no visual example of reprompted vs. non-reprompted generation.
- Arithmetic probe failure cases described in text but not shown visually.
- Figure 5(c) y-axis ticks too small to read precise PSNR/SSIM values at each checkpoint.

---

## 10. Results Presentation Assessment

**Strengths:**
- Color-coding by system (CLIGen vs. GUIWorld) consistently applied throughout.
- Named takeaways per experiment (6 for CLIGen, 4 for GUIWorld) provide accessible summaries.
- Post-action metrics (SSIM+15, FVD+15) explicitly justified and consistently applied.
- Table 10 footnote on external baseline early-stop appropriately disclosed.

**Weaknesses:**
- Figure 6 reprompting result in bar chart without companion data table.
- Table 3 does not state evaluation sample size.
- Table 9 does not state how cursor accuracy was measured (frame count, number of clips).
- No summary table aggregating all 10 experiments' metrics in one place.
- Figure 5(c) training curve y-axis ticks too small for precise reading.

---

## 11. New CFR Entries Added in Phase 3-4

### CFR-007: Internal vs. Residual SSIM Difference Likely Negligible
- **Severity**: HIGH
- **Finding**: Table 10 reports SSIM+15 of 0.863 (internal) vs. 0.857 (residual) -- absolute difference of 0.006 (0.7% relative). Estimated Cohen's d ~0.06-0.15 (negligible). On LPIPS, residual (0.138) outperforms internal (0.141). The paper recommends internal mode as achieving the "best SSIM/FVD trade-off" -- a claim that depends partly on this SSIM gap being real.
- **Evidence**: Table 10; Section 3.2.5 (p.19): "internal achieves the highest structural consistency (SSIM 0.863)."
- **Impact**: Central GUIWorld architectural recommendation rests in part on a SSIM difference that is likely within noise. The FVD difference (14.5 vs. 18.8) is larger and more credible, but LPIPS reversal means the "best trade-off" claim is not unambiguous across metrics.
- **Status**: UNRESOLVED

### CFR-008: Meta-Action vs. Raw-Action Encoding Differences Are Small
- **Severity**: MEDIUM
- **Finding**: Table 11 reports meta-action vs. raw-action improvements of SSIM +1.9% (0.016 absolute), LPIPS -2.1% (0.003 absolute), FVD -12.7% (2.1 absolute). Estimated Cohen's d ~0.16-0.40 (negligible to small). Paper acknowledges "modest" gains and persistent qualitative failure modes across both encodings.
- **Evidence**: Table 11; Section 3.2.5 (p.19): "these gains are modest compared to the substantially larger improvements observed when varying the action injection scheme itself."
- **Impact**: Recommendation to prefer meta-action encoding is better justified by semantic simplicity than performance. Presentation alongside larger Table 10 effects may create an impression of greater differentiation than exists.
- **Status**: UNRESOLVED

### CFR-009: No Statistical Reporting Across All 10 Experiments (Systemic)
- **Severity**: HIGH
- **Finding**: No table in the paper (Tables 2-11) reports standard deviations, confidence intervals, standard errors, or significance test results. No experiment reports results from more than one random seed. For comparisons with small absolute differences (Table 10: internal vs. residual SSIM 0.006; Table 11: meta vs. raw SSIM 0.016), statistical significance is unknowable.
- **Evidence**: Inspection of Tables 2-11 confirms absence of any variance measures. Pattern is systemic, not isolated.
- **Impact**: Weakens all numerical comparison claims. For large-gap results (cursor accuracy, FVD), practical impact is low. For small-gap results, architectural recommendations may not reflect real differences.
- **Status**: UNRESOLVED

### CFR-010: Reprompting Result (83%) Reported Without Data Table or Sample Size
- **Severity**: MEDIUM
- **Finding**: Figure 6 shows NC_CLIGen rising from 4% to 83% under reprompting. No companion data table, no stated sample size, no CI, no specification of whether the same 100-problem draw from Table 5 was used. This is the paper's largest improvement figure (+79 pp) and main evidence for steerability as a conditioning lever.
- **Evidence**: Figure 6 caption: "Reprompting boosts performance to 83%." No data table provided.
- **Impact**: Steerability interpretation is key insight for avoiding RL. Without a table, sample size, and CI, the 83% figure cannot be independently verified. Reporting standard is lower than for all other 9 experiments.
- **Status**: UNRESOLVED

---

## 12. CFR Entry Summary After Phase 3-4

| ID | Severity | Brief Description |
|---|---|---|
| HIGH-001 | HIGH | Related Work insufficient for paradigm-level claims |
| HIGH-002 | HIGH | LLM caption quality unvalidated |
| HIGH-003 | HIGH | Injection mode parameter count confound |
| CFR-004 | HIGH | Open-loop-only evaluation unmeasured against NC runtime claim |
| CFR-007 | HIGH | Internal vs. residual SSIM Δ=0.006 likely negligible |
| CFR-009 | HIGH | Systemic absence of statistical reporting (Tables 2-11) |
| MEDIUM-001 | MEDIUM | CLIGen clean filtering criterion undocumented |
| MEDIUM-002 | MEDIUM | Missing hyperparameters for reproducibility |
| CFR-005 | MEDIUM | Arithmetic probe sample size insufficient (n=100, single draw) |
| CFR-006 | MEDIUM | Action density confound in Experiment 7 |
| CFR-008 | MEDIUM | Meta vs. raw-action encoding differences are small |
| CFR-010 | MEDIUM | Reprompting 83% result reported without data table or sample size |

Total: 6 HIGH, 4 MEDIUM (+ 2 prior MEDIUM from Phase 3-2 not renumbered) = 12 total CFR entries

---

## 13. Two-Layer Summary

### Current State

**Decisive results (large effects, robust to statistical uncertainty):**
- SVG cursor supervision: 98.7% vs. 8.7% cursor accuracy (Table 9, Δ=90 pp, d > 5.0 est.)
- CUA data quality over random exploration: FVD 14.72 vs. 48.17 (Random Fast) and 20.37 (Random Slow) with 12.7x less data (Table 8)
- CLIGen fine-tuning enables coherent terminal rendering: 3% to 54% character accuracy progression (Table 4)
- Detailed captions improve PSNR by ~5 dB over semantic (Table 3, Δ = 4.99 dB)
- Symbolic computation bottleneck: near-zero native arithmetic across all video models (Table 5)

**Supported but not decisively demonstrated (small-gap or uncontrolled results):**
- Internal conditioning better than residual (SSIM Δ=0.006, likely within noise; FVD Δ=4.3 more credible)
- Meta-action encoding outperforms raw-action (SSIM Δ=0.016, negligible by estimated effect size)
- NC_CLIGen shows more arithmetic capability than Wan2.1 (4% vs. 0%, statistically indistinguishable at n=100)
- Reprompting achieves 83% (result in a bar chart without sample size or CI)

**Not demonstrated by the paper's experiments:**
- Closed-loop NC behavior (latent state persistence under self-generated inputs)
- Generalization beyond Ubuntu 22.04 XFCE4 / standardized CLIGen environment
- Whether NC-specific fine-tuning improves over zero-shot Wan2.1 on visual quality (Table 3 lacks Wan2.1 zero-shot row)
- Multi-step sequential GUI task execution

### Development Directions

**To strengthen decisive results:**
- Add bootstrap CIs to Table 3 (caption ablation) and Table 8 (data quality); these are the paper's most important positive results
- Report evaluation sample sizes for Tables 3 and 9 (currently unstated)
- Add a Wan2.1 zero-shot row to Table 3 to quantify the fine-tuning benefit

**To strengthen supported-but-not-decisive results:**
- Report 2-3 random seed repeats for Tables 10-11; this would resolve the internal vs. residual SSIM ambiguity
- Convert Figure 6 (reprompting) to a data table with sample size, CI, and evaluation protocol
- Complete the external baseline training run for Table 10
- Report per-mode parameter counts for all four injection modes (CFR-007 / HIGH-003)

**To address missing results:**
- Minimal closed-loop evaluation: 50-100 scripted CLIGen Clean tasks at 3-5 autoregressive steps; characterize error accumulation
- Cross-environment generalization: evaluate NC_GUIWorld on a second visual theme as a minimal robustness check
- Add failure case gallery alongside existing positive visualizations
- Random-generation chance baseline for arithmetic probe to establish chance floor

---

*Phase 3-4 Results Analysis complete.*
