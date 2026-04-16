# Weaknesses Analysis: Neural Computers (arXiv:2604.06425)

## Phase-4-2 — Weaknesses Identification

---

## Executive Summary of Key Weaknesses

The five most consequential weaknesses of the Neural Computers paper are:

1. **Open-loop-only evaluation fundamentally misaligns with the NC "runtime" claim** (CFR HIGH-004): The paper's central claim — that NCs instantiate a "running computer" with a persistent latent runtime state h_t — is never tested under the conditions it describes. Every experiment uses oracle ground-truth conditioning; the self-referential property of the runtime state is never exercised.

2. **Four critical related-work citations absent, misrepresenting NC_GUIWorld's paradigm novelty** (CFR HIGH-011): GameNGen (ICLR 2025), DIAMOND (NeurIPS 2024 Spotlight), AVID (ICLR 2025), and DWS (ICLR 2025) directly establish the technical design space in which NC_GUIWorld operates. Their absence means the injection mode ablation is presented as original design-space exploration when the space is already charted by multiple peer-reviewed papers.

3. **Systemic absence of statistical reporting across all 10 experiments** (CFR HIGH-009): No table in the paper reports error bars, standard deviations, confidence intervals, or significance tests. The central architectural recommendation (internal over residual conditioning) rests on an SSIM difference of 0.006 (d ~0.06–0.15, estimated negligible).

4. **NeuralOS — the most directly competing system — receives one sentence despite being architecturally superior on the paper's own key dimension** (CFR HIGH-012): NeuralOS demonstrates 256+ frame long-horizon OS state persistence via RNN, directly addressing the open-loop limitation NC_GUIWorld acknowledges but cannot solve.

5. **LLM-generated caption quality unvalidated for the most critical conditioning tier** (CFR HIGH-002): The 5 dB PSNR gap between caption tiers (Table 3) makes LLM caption quality a direct driver of the most important NC_CLIGen performance metric, yet no hallucination rate, accuracy metric, or human validation study is reported.

---

## Detailed Weaknesses by Category

---

### CATEGORY 1: RELATED WORK AND NOVELTY FRAMING

---

#### Weakness 1.1: Missing Citations That Directly Establish NC_GUIWorld's Design Space

**CFR Entry**: HIGH-011
**Severity**: HIGH

**Current State (Layer 1)**:
The NC paper's Related Work section is approximately one page embedded within the Preliminaries section (Section 2.1). Four papers accepted at ICLR 2025 or NeurIPS 2024 Spotlight that directly precede NC_GUIWorld's technical contribution are entirely absent:

- **GameNGen** (arXiv:2408.14837, ICLR 2025, August 2024): Establishes the two-phase interaction-data-to-diffusion-model paradigm in Section 3. Its formal framework q(o_n | o_<n, a_<=n) is mathematically equivalent to NC's Eq. 2.1. The project blog acknowledges GameNGen; the paper body does not cite it.
- **DIAMOND** (arXiv:2405.12399, NeurIPS 2024 Spotlight, May 2024): Demonstrates interactive diffusion simulation from fixed human gameplay data (87h, no RL) at ~10 FPS — the same paradigm NC_GUIWorld instantiates for OS/GUI, published approximately 18 months earlier.
- **AVID** (arXiv:2410.12822, ICLR 2025, October 2024): Establishes per-frame scale/shift action conditioning for pretrained video diffusion models — the same design problem as NC_GUIWorld's injection mode ablation.
- **DWS** (arXiv:2502.07825, ICLR 2025, February 2025): Proposes per-block two-linear-layer scale-shift modulation for pretrained video diffusion transformers — the direct precedent for NC_GUIWorld's internal injection mode.

**Evidence**: Phase-3-5c Level 2+ readings of all four papers. Introduction (pp.2-3) cites Genie 3 (Bruce et al., 2024) in the action-controllable video model lineage but not GameNGen or DIAMOND. Section 2.1 names NeuralOS and "Imagine with Claude" but not these four papers. Project blog separately mentions GameNGen (confirming author awareness), making the paper-body omission a presentation choice.

**Impact**: NC_GUIWorld's paradigm novelty claim cannot be properly assessed without these four prior papers. The injection mode ablation (presented as original design-space exploration in Experiment 9) is incremental over the established design space without this context.

**Fixability**: Easy — requires adding four citations, repositioning the contribution statement, and expanding Related Work.

**Development Direction**: Add all four citations with characterization of overlap and distinction. Reframe the NC_GUIWorld contribution as "first systematic four-mode injection ablation in OS/GUI action-conditioned video simulation, extending the GameNGen/DIAMOND paradigm to desktop computing environments." Expand Section 2.1 into a standalone Related Work section organized around: (a) action-conditioned video generation paradigm (GameNGen, DIAMOND), (b) action injection design for video DiTs (AVID, DWS), (c) OS/GUI neural simulation (NeuralOS).

---

#### Weakness 1.2: NeuralOS Treated in One Sentence Despite Architectural Superiority on the Paper's Key Dimension

**CFR Entry**: HIGH-012
**Severity**: HIGH

**Current State (Layer 1)**:
NeuralOS (arXiv:2507.08800, ICLR 2026) is described as "most closely related" in one sentence in Section 2.1. The paper distinguishes NC from NeuralOS by claiming NC maintains "runtime responsibilities" while NeuralOS only "simulates" the OS. However, NeuralOS's hierarchical RNN architecture provides O(1) per-timestep memory complexity and demonstrated 256+ frame long-horizon state persistence — the precise architectural capability NC_GUIWorld acknowledges it lacks (Section 3.2.4: "evaluation remains open-loop rather than closed-loop"). NeuralOS Appendix P explicitly argues that diffusion-only OS simulation without RNN fails for OS state persistence tasks.

**Evidence**: CFR HIGH-012 (Phase-3-5c). NeuralOS Level 3 reading: "the RNN maintains constant complexity per timestep, which is crucial for continuous, long-horizon OS simulation." "Action-conditioned diffusion models developed for video games generally assume that the necessary state is visually encoded in recent frames... In operating-system settings, however, critical state may persist far beyond a short temporal window" (NeuralOS Appendix P). NC paper Section 3.2.4 (confirmed in PDF): "evaluation remains open-loop rather than closed-loop."

**Impact**: The NC paper's positioning implies NC_GUIWorld is conceptually superior to NeuralOS ("runtime" vs. "simulation") while omitting that NeuralOS architecturally outperforms NC_GUIWorld on long-horizon state persistence — the defining property of a running computer.

**Fixability**: Moderate — requires a 1-2 page formal comparison subsection.

**Development Direction**: Add a Section 2.2 "Comparison with NeuralOS" that (a) acknowledges NeuralOS's RNN advantage for long-horizon state persistence with specific reference to its 256-frame results, (b) positions NC_GUIWorld as a proof-of-concept prototype using a more accessible pretrained backbone rather than a claim of superiority, and (c) explicitly frames the "runtime vs. simulation" distinction as an aspirational architectural target rather than a current empirical advantage.

---

#### Weakness 1.3: Underdeveloped Mathematical Differentiation of NC from World Models

**CFR Entry**: CFR-014 (NEW, added this phase)
**Severity**: MEDIUM

**Current State (Layer 1)**:
NC's Eq. 2.1 (h_t = F_theta(h_{t-1}, x_t, u_t); x_{t+1} ~ G_theta(h_t)) and GameNGen's formal definition q(o_n | o_<n, a_<=n) are mathematically equivalent — both express a conditional generative process over observation histories conditioned on action histories. The paper provides no mathematical-level criterion distinguishing NC from a world model or game engine at the formalism level. The distinction is made in natural language only.

**Evidence**: Phase-3-5c: "GameNGen's formal definition is formally equivalent to NC's Eq. 2.1." The CNC four-condition definition (Section 2, confirmed in Introduction) provides the intended differentiator but is not formally applied to rule out GameNGen or DIAMOND from satisfying those conditions.

**Impact**: A theoretically oriented reviewer may argue the NC/CNC framework is terminological rather than formally new. The paper needs a formal argument that CNC conditions impose requirements that world models do not satisfy.

**Fixability**: Moderate — requires a formal analysis section.

**Development Direction**: Add a Section 2.3 "Formal Differentiation from World Models" that (a) states explicitly that Eq. 2.1 is mathematically equivalent to interactive world model definitions, (b) argues that the CNC four conditions are additional requirements on top of Eq. 2.1, and (c) applies the four-condition checklist to GameNGen and DIAMOND to show they do not satisfy conditions (i)-(iv), formally differentiating NC from existing world models.

---

### CATEGORY 2: EXPERIMENTAL DESIGN WEAKNESSES

---

#### Weakness 2.1: Open-Loop Evaluation Cannot Validate the "Runtime" Claim

**CFR Entry**: HIGH-004
**Severity**: HIGH

**Current State (Layer 1)**:
All 10 experiments use open-loop evaluation: ground-truth conditioning sequences are provided at each step and generated frames are never fed back as model input. The defining property of a "runtime" — that the model's own outputs become the next inputs, creating a self-referential execution loop — is never tested. PSNR, SSIM, FVD, OCR accuracy, and cursor accuracy all measure I/O alignment under idealized oracle-conditioned rollout.

**Evidence**: Section 3.2.4 evaluation setup (confirmed in PDF p.16): "Our ablations target three capabilities: global fidelity, post-action responsiveness, and cursor-control precision." Section 3 opening (p.4): "In the present prototypes, these prompts and actions are logged conditioning streams, so evaluation remains open-loop rather than closed-loop interaction with a live environment." No table in the paper reports closed-loop results. CFR HIGH-004.

**Impact**: The gap between open-loop metrics and closed-loop behavior is acknowledged but entirely unmeasured. The 90.2% FVD improvement and 98.7% cursor accuracy measure oracle performance. Under closed-loop conditions, rendering errors in generated frames become corrupted inputs for the next step, causing error accumulation that open-loop evaluation cannot detect.

**Fixability**: Moderate — a minimal closed-loop evaluation requires new experiment runs but not new data.

**Development Direction**: Add a minimal Experiment 11 "Closed-Loop Error Accumulation" in CLIGen Clean: 100 scripted tasks, 5 autoregressive steps feeding generated frames back as conditioning, measuring character accuracy degradation relative to the oracle-conditioned baseline. Report a frame-by-frame accuracy curve. Even a single 5-step degradation curve would be the first evidence characterizing how quickly NC runtime performance degrades under self-generated input — a crucial data point for the runtime claim.

---

#### Weakness 2.2: Injection Mode Ablation Confounded by Unequal Trainable Parameter Counts

**CFR Entry**: HIGH-003
**Severity**: HIGH

**Current State (Layer 1)**:
Section 3.2.3 states "we tune only the action encoder and learning-rate schedule" with backbone and "all non-action components fixed." However, the internal mode adds CA_action sub-layers inside each selected transformer block — newly initialized parameters that cannot be pre-existing non-action components. No per-mode parameter count is reported. The internal mode's advantage (SSIM+15 = 0.863 vs. contextual 0.813) may partly reflect increased model capacity rather than injection depth architecture.

**Evidence**: Section 3.2.2 (p.15-16, confirmed in PDF): "each selected block augments the standard attention stack with an additional action cross-attention sub-layer" (internal mode). Section 3.2.3: "keeping the backbone and all non-action components fixed." These two statements are inconsistent — the CA_action sub-layers are not pre-existing components. Table 10: internal SSIM+15 = 0.863 vs. contextual 0.813 (+6.2%). CFR HIGH-003.

**Impact**: The central GUIWorld architectural recommendation cannot be cleanly attributed to injection depth vs. parameter capacity without per-mode parameter counts. The FVD improvement (contextual 24.8 to internal 14.5, -41.5%) is a more robust effect, but even it could partially reflect capacity.

**Fixability**: Moderate — reporting parameter counts is easy; a capacity-controlled comparison requires additional training.

**Development Direction**: (a) Immediately report per-mode parameter counts for all four injection modes, broken down by module type. This alone allows readers to assess the confound magnitude. (b) Add a capacity-controlled baseline: train contextual mode with randomly initialized parameters matched to internal mode's additional CA_action sub-layers. If contextual + matched parameters underperforms internal, the injection depth interpretation is strengthened.

---

#### Weakness 2.3: External Baseline Early-Stopped, Compromising the Ablation Anchor

**Severity**: MEDIUM-HIGH

**Current State (Layer 1)**:
Table 10's baseline_2 (external conditioning) was early-stopped at approximately 50% of the planned training budget after "preliminary rollouts did not warrant further compute." This judgment-based early stopping introduces a confound into the mode comparison. External mode is the ablation's anchor point separating pre-backbone injection from the three in-backbone modes.

**Evidence**: Table 10 footnote (confirmed in PDF p.18): "baseline_2 (external) was early-stopped at ~50% of the planned training budget after preliminary rollouts did not warrant further compute. Included only as a rough reference." External FVD+15 = 33.4 vs. contextual 24.8.

**Impact**: The decision to stop external mode early after internal knowledge of other modes' results introduces potential bias. External mode at full compute might achieve lower FVD, compressing the contextual-to-internal improvement span that supports the "injection depth matters" conclusion.

**Fixability**: Easy — complete the external mode training run.

**Development Direction**: Complete the external baseline training run and update Table 10. If external FVD at full budget remains substantially above contextual (>27), the injection depth conclusion is strengthened. If it approaches contextual, a revised interpretation is warranted. Either outcome is informative.

---

#### Weakness 2.4: Action Density Confound in Data Quality Experiment

**CFR Entry**: MEDIUM-006 (as CFR-006)
**Severity**: MEDIUM

**Current State (Layer 1)**:
Experiment 7 concludes that 110h of goal-directed CUA data outperforms 1,400h of random exploration data. However, CUA data has 0.10 actions/sec vs. Random Fast's 4.18 actions/sec — a 42x difference in action density. High action density creates rapid overlapping state changes harder to model independently of goal-directedness. No density-matched comparison is provided.

**Evidence**: Table 7 (confirmed p.14 of PDF): CUA 0.10 actions/sec, Random Fast 4.18 actions/sec. Table 8: CUA FVD 14.72 vs. Random Fast FVD 48.17. Section 3.2.1 (p.14): the paper itself acknowledges "high-frequency cursor jitter and irregular, non-goal-directed action bursts make consistent control difficult" but does not isolate the density factor. CFR-006.

**Impact**: The practical recommendation — prioritize curated, purposeful interactions over large-scale passive data collection — is potentially confounded with prioritize sparse interactions over dense interactions. These are different guidance principles with different practical implications.

**Fixability**: Easy — subsample Random Fast to match CUA's 0.10 actions/sec density using existing data, no new collection needed.

**Development Direction**: Add a subsampled Random Fast condition to Table 8. If subsampled Random Fast still underperforms CUA, the goal-directedness interpretation is supported. If it approaches CUA's FVD, the density explanation dominates. This single control condition converts a directional observation into a mechanistic conclusion.

---

#### Weakness 2.5: Arithmetic Probe Sample Size Too Small for Stated Comparison

**CFR Entry**: MEDIUM-005 (as CFR-005)
**Severity**: MEDIUM

**Current State (Layer 1)**:
Table 5 reports arithmetic probe accuracy based on 100 randomly sampled problems from a 1,000-problem pool (single draw). NC_CLIGen: 4/100 (4%), Wan2.1: 0/100 (0%). The 95% Wilson CI for 4/100 is approximately [1.1%, 9.9%], which overlaps substantially with the CI for 0/100 ([0%, 3.6%]). The stated comparison — NC_CLIGen fine-tuning improves over Wan2.1 on arithmetic — is not statistically supportable at n=100.

**Evidence**: Table 5 caption: "100 problems sampled from a 1,000-problem held-out pool." No CIs reported. Phase-3-3: "the 100-problem single-draw sample size makes the 4% vs. 0% comparison not reliably distinguishable." CFR-005.

**Impact**: The claim that fine-tuning on CLIGen provides symbolic reasoning gain over Wan2.1 rests on a 4 pp difference that is statistically indistinguishable from noise. The broader finding (all video models near-zero on arithmetic) remains well-supported regardless.

**Fixability**: Easy — evaluate on the full 1,000-problem pool or report Wilson CIs for the 100-sample result.

**Development Direction**: (a) Report Wilson CIs in Table 5 for all four models. (b) Evaluate all four models on the full 1,000-problem held-out pool. The broader conclusion (symbolic reasoning bottleneck) is robust; the CIs primarily affect the fine-tuning benefit claim.

---

### CATEGORY 3: STATISTICAL REPORTING

---

#### Weakness 3.1: Systemic Absence of Variance Reporting Across All 10 Experiments

**CFR Entry**: HIGH-009
**Severity**: HIGH

**Current State (Layer 1)**:
No table in the paper (Tables 2-11) reports standard deviations, confidence intervals, standard errors, or significance test p-values. No experiment reports results from more than one random training seed. This is a systemic absence. The central architectural recommendations depend on comparisons with estimated Cohen's d of 0.06-0.40 (negligible to small by convention).

Specific effect sizes (from Phase-3-4 estimation):
- Internal vs. residual SSIM: Δ=0.006, d ~0.06-0.15 (negligible)
- Meta vs. raw-action SSIM: Δ=0.016, d ~0.16-0.40 (negligible to small)
- LPIPS reversal: residual (0.138) outperforms internal (0.141) — contradicts "best trade-off" claim on one of three metrics

**Evidence**: Inspection of Tables 2-11 (confirmed in paper PDF pp.7-19) confirms no variance measure appears in any table. CFR HIGH-009. Phase-3-4 statistical rigor assessment: "Statistical rigor across all 10 experiments is uniformly low." Effect size table in Phase-3-4 documents all estimated Cohen's d values.

**Impact**: The two most important architectural recommendations — (a) use internal over residual conditioning, (b) prefer meta-action over raw-action encoding — both depend on differences that cannot be shown to exceed noise without variance reporting. Large-effect results (cursor accuracy delta = 90 pp, FVD CUA vs. untrained delta = 90.2%) are robust regardless of missing statistics.

**Fixability**: Moderate — requires 2-3 repeat training runs for key experiments; partial fix (bootstrap CIs on evaluation sets) is feasible without new training.

**Development Direction**: (a) Run 2-3 random seeds for Tables 10 and 11 and report mean ± SD. This is the most important fix and would determine whether the internal vs. residual SSIM distinction is real. (b) Report bootstrap 95% CIs across evaluation clips for Tables 3 and 8 — computable from existing data. (c) At minimum, report evaluation sample sizes for Tables 3 and 9 (currently unstated) to allow readers to compute approximate standard errors.

---

#### Weakness 3.2: Reprompting Result Reported as Bar Chart Without Data Table, Sample Size, or CI

**CFR Entry**: MEDIUM-010 (as CFR-010)
**Severity**: MEDIUM

**Current State (Layer 1)**:
Figure 6 shows NC_CLIGen rising from 4% to 83% under reprompting (+79 percentage points) — the largest single improvement figure in the paper. This result is reported as a bar chart only: no companion data table, no stated sample size, no CI, and no specification of whether the same 100-problem draw from Table 5 was used. The reprompting result is the main evidence for steerability as a conditioning lever and the "reprompting as alternative to RL" interpretation.

**Evidence**: Figure 6 (confirmed in paper — bar chart). No data table accompanies Figure 6. Table 6 presents hypotheses about Sora2's performance differential, not additional reprompting data. CFR-010.

**Impact**: The 83% figure cannot be independently assessed or reproduced without knowing sample size, evaluation pool, and CI. The highest-magnitude improvement in the paper has the lowest documentation standard of any result.

**Fixability**: Easy — add a data table to replace or supplement Figure 6.

**Development Direction**: Add Table 6b "Reprompting Results" with: Model, Condition, Sample Size, Accuracy (%), 95% CI. Report whether the same 100-problem draw from Table 5 was used or a different draw. If a different draw, report both draws' NC_CLIGen native results to assess cross-draw variability.

---

### CATEGORY 4: METHODOLOGICAL GAPS

---

#### Weakness 4.1: LLM Caption Quality Unvalidated for NC_CLIGen Training

**CFR Entry**: HIGH-002
**Severity**: HIGH

**Current State (Layer 1)**:
All NC_CLIGen General training captions are generated by Llama 3.1 70B from raw terminal buffers. No human validation study, hallucination rate measurement, or caption accuracy metric is reported. The 5 dB PSNR gap between caption tiers (Table 3: semantic 21.90 dB vs. detailed 26.89 dB) makes LLM caption quality a direct driver of NC_CLIGen's primary performance metric.

**Evidence**: Section 3.1.1 (p.5 of PDF): "Underlying buffers and logs are used to generate aligned textual descriptions with Llama 3.1 70B (Dubey et al., 2024) in three tiers." Appendix B.1 shows caption field examples but describes no quality audit procedure. Table 3: 4.99 dB PSNR gap attributable directly to caption tier. CFR HIGH-002.

**Impact**: If detailed captions systematically hallucinate terminal content, the 26.89 dB PSNR result may reflect learning to match hallucinated descriptions rather than accurate terminal state. This is a plausible risk given Llama 3.1 70B is asked to describe fine-grained ANSI/VT100 terminal output it may not be optimized for.

**Fixability**: Moderate — 100-200 sample human validation study provides sufficient evidence.

**Development Direction**: (a) Conduct a human caption validation study on 100-200 randomly sampled (buffer, detailed-caption) pairs evaluating factual accuracy, hallucination rate, and completeness. (b) Add a CLIGen Clean scripted-caption row to Table 3 — CLIGen Clean uses scripted captions derived directly from VHS scripts (not LLM-generated), providing an implicit upper bound on caption accuracy and allowing estimation of LLM hallucination impact.

---

#### Weakness 4.2: Action Slot Count S=2 Unjustified in Meta-Action Encoder

**Severity**: MEDIUM

**Current State (Layer 1)**:
The meta-action encoder uses S=2 action slots per frame (5 action types, 2 slots per frame). This design choice is not motivated or ablated. The slot count directly controls how many simultaneous or sequential actions the encoder can represent in a single diffusion step.

**Evidence**: Methodology evaluation Phase-3-2: "S=2 action slots per frame in the meta-action encoder: no ablation over S is provided; the choice is not motivated." Appendix D provides encoder design rationale but no ablation over S.

**Impact**: If S=2 is suboptimal, the meta-action encoder's 1.9% SSIM improvement over raw-action encoding (Table 11) may understate achievable gain. The choice is currently unreproducible because its optimality is unknown.

**Fixability**: Easy — add an ablation over S (S=1, 2, 4) to Table 11 or Appendix.

**Development Direction**: Report Table 11 results for S=1, 2, and 4. If performance is flat across S values, report this as evidence that S=2 is a robust choice. If performance varies, identify the optimal S and update the design recommendation.

---

#### Weakness 4.3: Temporal Window and Contrastive Loss Hyperparameters Not Reported

**CFR Entry**: MEDIUM-002
**Severity**: MEDIUM

**Current State (Layer 1)**:
Several key hyperparameters are not reported: (a) temporal window size w and lag l for the causal temporal attention mask (formula given in Appendix D.3 but not numerical values), (b) temperature tau for the temporal contrastive loss, (c) exact layer indices selected for residual and internal injection modes (described only as "a subset of layers").

**Evidence**: Appendix D.3: windowing formula provided but w and l left symbolic. Phase-3-2 methodology evaluation: "Appendix D.3 gives the windowing formula but not numerical values for w and l." CFR MEDIUM-002.

**Impact**: A practitioner attempting to reproduce contextual conditioning results cannot determine the attention window size, which governs how many past action tokens each frame attends to — a key distinguishing feature of contextual mode.

**Fixability**: Easy — add a hyperparameter table to the appendix.

**Development Direction**: Add a "Hyperparameter Table" to Appendix D listing: w (temporal window frames), l (lag frames), tau (contrastive temperature), layer indices for residual and internal injection, hidden dimensions of added action conditioning modules. Requires no new experiments.

---

### CATEGORY 5: GENERALIZATION AND SCOPE LIMITATIONS

---

#### Weakness 5.1: Single-Environment Evaluation for Both Systems

**Severity**: MEDIUM

**Current State (Layer 1)**:
NC_CLIGen is evaluated exclusively on the standardized CLIGen Clean environment (one font, one color palette, one terminal emulator). NC_GUIWorld is evaluated exclusively on Ubuntu 22.04 / XFCE4 / 1024x768 / Arc-Dark theme. No generalization across OS versions, visual themes, screen resolutions, or application sets is tested.

**Evidence**: Section 3.2.1 (p.14 of PDF): "All GUI data is collected inside an Ubuntu 22.04 container running XFCE4 (Arc-Dark theme, Papirus icons) on a fixed 1024x768 virtual display at 15 FPS." Phase-3-4 external validity: "Single OS environment: All GUIWorld data from Ubuntu 22.04 / XFCE4 / 1024x768 / Arc-Dark theme."

**Impact**: The reported SSIM+15 = 0.863 and FVD+15 = 14.5 reflect performance on a single, fixed visual environment. For the CNC roadmap's "universally programmable" condition, cross-environment generalization is a prerequisite; current evaluation cannot assess this.

**Fixability**: Low cost — evaluate on one additional Ubuntu theme using the existing model without retraining.

**Development Direction**: (a) Evaluate NC_GUIWorld on one additional visual theme (e.g., Ubuntu GNOME Adwaita) zero-shot — tests generalization without retraining. (b) Evaluate NC_CLIGen on one additional terminal palette zero-shot. (c) Include cross-OS evaluation as a concrete next step in the CNC roadmap discussion.

---

#### Weakness 5.2: Character Accuracy Ceiling at 54% Not Contextualized for Functional NC Use

**Severity**: MEDIUM

**Current State (Layer 1)**:
NC_CLIGen achieves 54% character accuracy and 31% exact-line accuracy at 60k training steps. The paper reports this as a training progression but does not explicitly state the functional NC threshold (near-100% character accuracy) or quantify the gap. The plateau at 40-50k steps suggests the current architecture-data combination may not close this gap without architectural changes.

**Evidence**: Table 4 (p.7 confirmed): character accuracy 0.54, exact-line 0.31 at 60k steps, plateau beginning ~40-50k. Phase-3-4 performance analysis: "For a 'running computer,' near-100% character accuracy would be required; 54% means roughly half of rendered characters are incorrectly read."

**Impact**: Without explicit contextualization, readers may interpret the training progression as evidence of converging performance. The plateau at 40-50k steps is a negative result that warrants explicit architectural interpretation.

**Fixability**: Easy — add one paragraph.

**Development Direction**: Add a "Performance Gap Analysis" paragraph in Section 3.1 that: (a) states the functional NC threshold (near-100% character accuracy), (b) quantifies the current gap (54% achieved, ~46 pp remaining), and (c) discusses whether the plateau indicates a training limitation (solvable with more data) or an architectural limitation (requiring new architecture). The paper's Section 4 roadmap would be strengthened by this explicit gap analysis.

---

### CATEGORY 6: PRESENTATION AND REPRODUCIBILITY GAPS

---

#### Weakness 6.1: Positive-Only Visualization Gallery — No Failure Cases Shown

**CFR Entry**: CFR-013 (NEW, added this phase)
**Severity**: MEDIUM

**Current State (Layer 1)**:
The 39-figure appendix (Appendix E) contains exclusively positive-case outputs. No failure case gallery exists despite the paper acknowledging specific failure modes in Section 3.2.5 (p.19): "failure modes are dominated by data quality and by where action information enters the backbone." GUIWorld visualization thumbnails pp.20-21 (14 samples) all show qualitatively plausible outputs.

**Evidence**: Paper pp.20-21 (confirmed in PDF): GUIWorld visualization thumbnails all show plausible output. Section 3.2.5 (p.19): failure modes explicitly acknowledged but no failure example shown. Phase-3-4 qualitative analysis: "All visualization samples appear to be positive cases."

**Impact**: Without failure case visualization, readers cannot assess the qualitative distribution of errors or verify that selected examples are representative. Combined with absent statistical reporting (HIGH-009), positive-only galleries increase the risk that qualitative impression overestimates typical performance.

**Fixability**: Easy — add 3-5 failure case examples alongside existing positive cases.

**Development Direction**: Add a "Failure Cases" subsection to Appendix E with 5-10 negative examples for each system: NC_CLIGen failures showing text smear and incorrect character rendering; NC_GUIWorld failures showing cursor drift and spurious color changes. Label each failure case with the identified failure mode.

---

#### Weakness 6.2: No Summary Table Aggregating All 10 Experiments' Key Metrics

**Severity**: MEDIUM

**Current State (Layer 1)**:
The 10 experiments are spread across Tables 2-11 and Figure 6 with no single summary table. A reader comparing the relative magnitude of different design choices (injection mode vs. data quality vs. caption tier vs. encoding) must manually extract and normalize numbers across different metric variants.

**Evidence**: Structural analysis Phase-2: 10 numbered experiments with separate tables. Phase-3-4: "No summary table aggregating all 10 experiments' metrics in one place." Tables 8 and 10 use different FVD/SSIM metric variants (FVD_all/SSIM_all vs. FVD+15/SSIM+15), making cross-table comparison non-trivial.

**Impact**: Practitioners seeking actionable design guidance must manually synthesize findings across 9 tables plus Figure 6. The paper's implicit hierarchy (injection depth effect ~3x larger than encoding effect) is derivable from Tables 10-11 but not stated.

**Fixability**: Easy — add one summary table.

**Development Direction**: Add Table 1 "Summary of Design Choices and Key Results" in the Introduction or after Section 3's final subsection, with columns: Experiment, Design Choice Varied, Key Metric, Best Value, Second-Best Value, Improvement (%). Explicitly state the hierarchy: "injection depth (SSIM +6.2%) is approximately 3x more impactful than encoding granularity (SSIM +1.9%)."

---

#### Weakness 6.3: CLIGen Clean Filtering Criterion Undocumented

**CFR Entry**: MEDIUM-001
**Severity**: MEDIUM

**Current State (Layer 1)**:
CLIGen Clean retains 51.21% (~128k of ~250k scripts) after filtering, but filtering criteria are not described anywhere in the paper or appendix. Experiments 2-6 (all NC_CLIGen quantitative results) use CLIGen Clean.

**Evidence**: Section 3.1.1 (p.5 of PDF): "After filtering (51.21% retained)" with no further explanation. Appendix C does not describe filtering rules. CFR MEDIUM-001.

**Impact**: Without knowing what the 48.79% discarded scripts contain, the CLIGen Clean distribution cannot be characterized. If filtering systematically removes difficult scripts, OCR accuracy and PSNR results may overstate performance on the full CLIGen distribution.

**Fixability**: Easy — describe filtering criteria in one paragraph.

**Development Direction**: Add a "Filtering Criteria" subsection to Appendix C listing: specific discard conditions, distribution of discard reasons, and summary statistics for retained vs. discarded scripts.

---

### CATEGORY 7: CONCEPTUAL FRAMEWORK VALIDATION

---

#### Weakness 7.1: CNC Four Conditions Not Applied to Evaluate Current Prototypes

**Severity**: MEDIUM

**Current State (Layer 1)**:
The paper defines a Completely Neural Computer (CNC) as requiring four conditions — Turing complete, universally programmable, behavior-consistent, architecturally advantaged — in the Introduction. However, the paper never applies this checklist to NC_CLIGen or NC_GUIWorld. Table 13 provides a conceptual comparison of four system types but does not situate the current prototypes on this matrix.

**Evidence**: Introduction (p.2, confirmed in PDF): CNC definition box with four conditions. Phase-3-5c: "paper defines the CNC conditions but never applies them to its own prototypes as a structured assessment." Table 14 gives operational readings of CNC requirements but does not assess whether current prototypes satisfy them.

**Impact**: The CNC four-condition definition reads as an aspirational vision statement rather than an analytical tool. A reader naturally expects the paper to assess which conditions NC_CLIGen and NC_GUIWorld satisfy, partially satisfy, and do not yet satisfy.

**Fixability**: Easy — add one table applying the CNC checklist to current prototypes.

**Development Direction**: Add Table 14b "CNC Condition Assessment for Current Prototypes" with rows for each of the four CNC conditions and columns for NC_CLIGen, NC_GUIWorld, and a brief evidence/gap note. This would give the CNC framework analytical weight and make Section 4 (the roadmap) more directly actionable.

---

## Weakness Prioritization by Impact on Paper's Validity

| Priority | CFR ID | Weakness | Severity | Impact on Core Claims | Fixability |
|---|---|---|---|---|---|
| 1 | HIGH-004 | Open-loop evaluation vs. runtime claim | HIGH | Directly undermines "NC primitive" claim | Moderate |
| 2 | HIGH-011 | Missing 4 critical citations | HIGH | Misrepresents NC_GUIWorld novelty | Easy |
| 3 | HIGH-009 | Systemic absent statistical reporting | HIGH | Weakens all close-comparison results | Moderate |
| 4 | HIGH-012 | NeuralOS under-discussed | HIGH | Misleading comparative positioning | Moderate |
| 5 | HIGH-002 | LLM caption quality unvalidated | HIGH | Main NC_CLIGen metric at risk | Moderate |
| 6 | HIGH-003 | Injection mode parameter count confound | HIGH | Weakens injection depth interpretation | Moderate |
| 7 | HIGH-007 | Internal vs. residual SSIM likely within noise | HIGH | Weakens central architectural recommendation | Moderate |
| 8 | HIGH-001 | Related Work 1 page; insufficient | HIGH | Weakens paradigm novelty positioning | Easy |
| 9 | 2.3 | External baseline early-stopped | MEDIUM-HIGH | Weakens injection ablation anchor | Easy |
| 10 | MEDIUM-001 | CLIGen filtering undocumented | MEDIUM | Limits reproducibility | Easy |
| 11 | MEDIUM-002 | Missing hyperparameters | MEDIUM | Limits reproducibility | Easy |
| 12 | MEDIUM-006 | Action density confound | MEDIUM | Weakens data quality mechanism claim | Easy |
| 13 | MEDIUM-005 | Arithmetic probe n=100 | MEDIUM | 4% vs. 0% statistically indistinguishable | Easy |
| 14 | MEDIUM-010 | Reprompting 83% without data table | MEDIUM | Largest result inadequately documented | Easy |
| 15 | CFR-013 | Positive-only visualization gallery | MEDIUM | Raises cherry-picking concern | Easy |
| 16 | CFR-014 | NC formalism indistinguishable from world models | MEDIUM | Weakens framework novelty claim | Moderate |
| 17 | MEDIUM-008 | Meta vs. raw-action differences small | MEDIUM | Weakens encoding recommendation | None needed |
| 18 | 7.1 | CNC checklist not applied to prototypes | MEDIUM | Weakens framework utility | Easy |
| 19 | 5.1 | Single-environment evaluation | MEDIUM | Limits external validity | Moderate |
| 20 | 4.2 | S=2 action slots unjustified | MEDIUM | Minor design/reproducibility gap | Easy |

---

## CFR Entries Added in Phase-4-2

| ID | Severity | Description |
|---|---|---|
| CFR-013 | MEDIUM | Positive-only visualization gallery — no failure cases shown despite acknowledged failure modes |
| CFR-014 | MEDIUM | NC Eq. 2.1 formalism mathematically indistinguishable from world model formalisms without formal proof that CNC conditions constitute genuine differentiators |

---

## Two-Layer Summary

### Current State — What Is Lacking (with Evidence)

**Critical gaps affecting core claims**:
1. The defining property of a "runtime" — self-referential state evolution under self-generated inputs — is never tested. All 10 experiments use oracle conditioning. The paper's most important claim has zero direct experimental support. (HIGH-004; Section 3 admission in PDF)
2. Four ICLR/NeurIPS 2024-2025 peer-reviewed papers establishing NC_GUIWorld's technical design space are uncited. The paradigm claimed as pioneering is established work. (HIGH-011; Phase-3-5c Level 2+ readings)
3. Variance is unreported for every numerical comparison. The central architectural recommendation rests on SSIM Δ=0.006 with d ~0.06-0.15, indistinguishable from noise without error bars. (HIGH-009; Tables 10-11)
4. NeuralOS outperforms NC_GUIWorld on the very capability (long-horizon state persistence) that defines a "running computer" and receives one sentence of acknowledgment. (HIGH-012; NeuralOS Level 3 reading)
5. Training supervision quality for NC_CLIGen's most informative conditioning tier is generated by an LLM with no validation. (HIGH-002; Section 3.1.1)

**High-priority experimental design gaps**:
6. Injection mode ablation confounded by unequal parameter counts across modes. (HIGH-003; pp.15-16 inconsistency)
7. External baseline early-stopped at ~50% compute, compromising the ablation anchor. (Table 10 footnote)
8. Data quality experiment's main conclusion cannot be separated from 42x action density difference. (MEDIUM-006; Table 7)
9. Largest single improvement (reprompting: 4% to 83%) reported as bar chart without table, sample size, or CI. (MEDIUM-010; Figure 6)
10. Arithmetic probe n=100 single draw makes NC_CLIGen vs. Wan2.1 (4% vs. 0%) statistically indistinguishable. (MEDIUM-005; Table 5)

**Framework and presentation gaps**:
11. CNC four-condition definition not applied to evaluate whether current prototypes satisfy any conditions. (Tables 13-14)
12. NC Eq. 2.1 formalism not formally differentiated from interactive world model formalisms. (CFR-014)
13. Visualization gallery contains exclusively positive cases despite acknowledged failure modes. (CFR-013; p.19 admission)
14. CLIGen Clean filtering criteria (48.79% discarded without explanation) limit reproducibility of Experiments 2-6. (MEDIUM-001)
15. Seven key hyperparameters not reported. (MEDIUM-002; Appendix D.3)

### Development Directions — How Each Weakness Can Be Improved

| Weakness | Most Impactful Development Direction | Effort Required |
|---|---|---|
| Open-loop-only evaluation | Add minimal Experiment 11: 100 scripted tasks, 5 autoregressive steps, measure character accuracy degradation | Moderate (new experiment) |
| Missing 4 citations | Add GameNGen, DIAMOND, AVID, DWS; expand Related Work to standalone section | Easy (writing) |
| No variance reporting | 2-3 random seeds for Tables 10-11; bootstrap CIs for Tables 3 and 8 | Moderate (2-3 training runs) |
| NeuralOS under-discussed | Add Section 2.2 formally comparing architectures; acknowledge RNN advantage | Easy (writing) |
| LLM caption quality unvalidated | 100-200 sample human validation study; add scripted vs. LLM comparison row to Table 3 | Moderate (validation study) |
| Injection mode parameter confound | Report per-mode parameter counts; add capacity-controlled contextual baseline | Easy to Moderate |
| External baseline early-stop | Complete external mode training run at full budget | Easy (training run) |
| Action density confound | Subsample Random Fast at 0.10 actions/sec; add to Table 8 | Easy (existing data) |
| Reprompting documentation gap | Replace Figure 6 with data table including sample size and CI | Easy |
| Arithmetic probe sample size | Evaluate on full 1,000-problem pool; report Wilson CIs | Easy |
| CNC conditions not applied | Add Table 14b assessing current prototypes against 4 CNC conditions | Easy (writing) |
| Formal indistinguishability | Add formal argument that CNC conditions differentiate NC from GameNGen/DIAMOND | Moderate (theoretical) |
| Positive-only visualizations | Add 5-10 failure case examples to Appendix E with labeled failure modes | Easy |
| CLIGen filtering undocumented | Add filtering criteria paragraph to Appendix C | Easy |
| Missing hyperparameters | Add hyperparameter table to Appendix D | Easy |

---

## Overall Weaknesses Assessment

The Neural Computers paper has a coherent set of correctable weaknesses rather than a single invalidating flaw. The verified strengths (NC_CLIGen novelty, SVG cursor supervision, NC/CNC conceptual framework) are robust to all identified weaknesses. The weaknesses cluster into three groups requiring different responses:

**Group A — Correctable with additional experiments** (HIGH-004, HIGH-003, MEDIUM-006, MEDIUM-005, MEDIUM-010): The open-loop evaluation gap is the most important weakness and requires a new experiment (minimal closed-loop evaluation). The injection mode confound and action density confound require reuse of existing data with small additional analysis.

**Group B — Correctable with writing and citation work** (HIGH-011, HIGH-012, HIGH-001, CFR-014, CFR-013): The missing citations and NeuralOS under-discussion are presentation choices requiring no new experiments. Expanding Related Work from ~1 page to a standalone section, adding four missing citations, and formally acknowledging NeuralOS's architectural advantage would address these weaknesses entirely through writing.

**Group C — Correctable with additional documentation** (HIGH-002, HIGH-009 partially, MEDIUM-001, MEDIUM-002): The LLM caption validation, hyperparameter reporting, and filtering criteria gaps require modest additional work that does not require new training runs.

The weaknesses in Group B are the most anomalous given the paper's otherwise careful documentation style. A paper that devotes a 42-page appendix to implementation detail but fails to cite four directly relevant ICLR/NeurIPS 2024-2025 papers creates a significant inconsistency that reviewers will flag. Addressing Group B weaknesses would involve primarily writing effort and would substantially improve the paper's competitive positioning without invalidating any of its genuine contributions.

---

*Phase-4-2 Weaknesses Analysis complete.*
*Evidence basis: All Phase 1-3-5c artifacts, novelty_verification.md, critical_findings_registry.md (12 prior entries), results_analysis.md, methodology_evaluation.md, experiment_assessment.md, structural_analysis.md, problem_analysis.md, and five deep reading summaries. Paper PDF pp.1-5 and pp.14-21 confirmed directly.*
