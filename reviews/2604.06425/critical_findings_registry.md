# Critical Findings Registry (CFR)

## Severity Definitions
| Severity | Definition |
|----------|------------|
| CRITICAL | Affects core validity (d<0.2, core algo differs, unreported ablations) |
| HIGH | Significantly impacts quality (d<0.5, missing baselines, discrepancies) |
| MEDIUM | Notable concerns |
| LOW | Minor issues |

## Active Findings

### CRITICAL Findings

#### HIGH-004 → CRITICAL (DA-Escalated): Open-Loop-Only Evaluation Unmeasured Against NC Runtime Claim
- **Phase identified**: Phase-3-3 (as HIGH); escalated Phase-7-0 (DA)
- **Severity**: CRITICAL
- **DA Escalation Rationale**: The paper's central differentiating claim — that NC_GUIWorld instantiates "early NC primitives of a running computer" with persistent latent runtime state h_t — is the sole property distinguishing NC from GameNGen/DIAMOND/NeuralOS in the paper's framing. Every experiment uses oracle ground-truth conditioning. The runtime state property (h_t evolving through self-generated outputs) has zero experimental support. A paper claiming "NC primitives" with no closed-loop experiment is claiming a machine property it never tests. Disclosure does not reduce severity: validity impact is measured by what the claim requires, not by whether the gap is acknowledged.
- **Description**: All 10 experiments use open-loop rollout. NC's defining property — persistent latent state h_t through self-generated frame sequences — is never evaluated.
- **Impact**: The entire "running computer" / "NC primitive" framing is experimentally ungrounded. All reported metrics (PSNR, SSIM, FVD, cursor accuracy) measure oracle-conditioned I/O alignment, which is empirically equivalent to what GameNGen and DIAMOND demonstrate under the "simulation" label the paper claims to transcend.
- **Status**: UNRESOLVED

#### HIGH-011 → CRITICAL (DA-Escalated): Missing Citations Misrepresent NC_GUIWorld Paradigm Novelty
- **Phase identified**: Phase-3-5c (as HIGH); escalated Phase-7-0 (DA)
- **Severity**: CRITICAL
- **DA Escalation Rationale**: Project blog mentions GameNGen, confirming author awareness. Omission from paper body is a presentation decision, not a knowledge gap. For a paper claiming NC_GUIWorld "demonstrates a pioneering paradigm," deliberate exclusion of the most directly comparable paradigm-establishing paper (GameNGen, ICLR 2025) misrepresents the state of the art. Combined with CFR-024 (NeuralOS code derivation confirmed but undisclosed in paper body), this creates a pattern of selective attribution affecting paradigm novelty claims.
- **Description**: GameNGen (ICLR 2025), DIAMOND (NeurIPS 2024 Spotlight), AVID (ICLR 2025), and DWS (ICLR 2025) directly establish the technical design space in which NC_GUIWorld operates. All four are absent from paper citations.
- **Impact**: NC_GUIWorld's paradigm novelty claim must be repositioned from "pioneering" to "first systematic application of established paradigm to OS/GUI domain." The injection mode ablation is incremental over the established design space, not original design-space exploration.
- **Status**: UNRESOLVED

#### CFR-PATTERN-A (NEW, DA Phase-7-0): Paradigm Claim Integrity Pattern
- **Phase identified**: Phase-7-0 (Devil's Advocate synthesis)
- **Severity**: CRITICAL
- **Description**: Five findings together constitute a systematic pattern of paradigm positioning through selective disclosure: (1) GameNGen acknowledged on project blog, omitted from paper body; (2) NeuralOS receives one sentence while code pipeline is derived from NeuralOS (confirmed Issue #5); (3) NC formalism (Eq. 2.1) is mathematically equivalent to GameNGen's formal definition — not acknowledged; (4) Related Work section is 1 page with most important competitors undercited or uncited; (5) CNC four-condition definition never applied to verify existing systems fail to satisfy it.
- **Related Findings**: HIGH-001, HIGH-011, HIGH-012, CFR-024, CFR-014
- **Impact**: No individual finding reaches CRITICAL alone, but combined they show that every major comparative reference point was handled in the way that maximizes the appearance of paradigm originality. This is a systematic misrepresentation of paradigm novelty, not an editorial omission. A reviewer encountering the complete pattern would treat it as a scholarly integrity concern.
- **Status**: UNRESOLVED

### HIGH Findings

#### HIGH-001: Related Work Insufficient for Paradigm-Level Claims
- **Phase identified**: Phase 3-1 (Problem Analysis)
- **Severity**: HIGH
- **Description**: Related Work section is ~1 page embedded in Preliminaries, insufficient depth for paradigm-level claims. Distinction from NeuralOS and interactive world models is acknowledged but not deeply differentiated.
- **Impact**: Central paradigm claim ("neural system can *become* the computer itself") is weakened without thorough differentiation from prior systems such as NeuralOS and interactive world models.
- **Evidence**: Related Work ~1 page; NeuralOS/Imagine with Claude mentioned but not formally compared.
- **Status**: Open

#### HIGH-002 → MEDIUM (DA-Downgraded): LLM Caption Quality Unvalidated (CLIGen Training)
- **Phase identified**: Phase 3-2 (Methodology Evaluation)
- **Severity**: MEDIUM (downgraded from HIGH by DA Phase-7-0)
- **DA Downgrade Rationale**: CLIGen Clean (all controlled experiments, Experiments 2-6) uses scripted captions from VHS scripts, not LLM-generated captions. The LLM caption quality issue affects only CLIGen General and the caption tier ablation (Table 3). Architecture validity, injection mode findings, cursor supervision, and data quality finding are all independent of LLM caption quality. The 5 dB PSNR gap may reflect semantic informativeness, not factual accuracy.
- **Description**: All CLIGen General training captions are generated by Llama 3.1 70B from raw terminal buffers; no human validation, hallucination rate, or caption accuracy metric is reported.
- **Impact**: Training supervision quality for NC_CLIGen is an unvalidated upstream dependency. Experiment 3 (Table 3) shows a 5 dB PSNR gap between caption tiers, making caption quality a direct driver of downstream performance. Hallucinations in detailed captions could introduce systematic noise in the most informative conditioning signal.
- **Evidence**: Section 3.1.1 states Llama 3.1 70B generates three-tier captions from terminal buffers with no mention of validation. App B.1 shows caption field examples but no quality audit procedure.
- **Status**: Open

#### HIGH-003: Injection Mode Parameter Count Confound (GUIWorld)
- **Phase identified**: Phase 3-2 (Methodology Evaluation)
- **Severity**: HIGH
- **Description**: The four action injection modes (external, contextual, residual, internal) add different numbers of new trainable parameters. The internal mode adds CA_action cross-attention sub-layers inside transformer blocks — newly initialized parameters that must be trained. No per-mode parameter counts are reported.
- **Impact**: The paper's central GUIWorld architectural recommendation ("internal conditioning achieves best SSIM/FVD trade-off") cannot be cleanly attributed to injection depth vs. parameter capacity difference. The SSIM gap (internal 0.863 vs. contextual 0.813, Table 10) may partly reflect capacity.
- **Evidence**: Section 3.2.3 (p.16) claims "tune only the action encoder and learning-rate schedule," but Section 3.2.2 (p.16) describes internal mode adding new CA_action sub-layers inside blocks; these are new parameters that cannot be pre-existing "non-action components."
- **Status**: Open

### MEDIUM Findings

#### MEDIUM-001: CLIGen Clean Filtering Criterion Undocumented
- **Phase identified**: Phase 3-2 (Methodology Evaluation)
- **Severity**: MEDIUM
- **Description**: CLIGen Clean retains 51.21% (~128k of ~250k scripts) after filtering, but the filtering criteria are not described.
- **Impact**: Reproducibility of Experiments 2–6 (all conducted on CLIGen Clean) is limited; distribution of the retained subset is unknown.
- **Evidence**: Section 3.1.1 (p.7): "After filtering (51.21% retained)" with no further explanation.
- **Status**: Open

#### MEDIUM-002: Missing Hyperparameters for Reproducibility
- **Phase identified**: Phase 3-2 (Methodology Evaluation)
- **Severity**: MEDIUM
- **Description**: Several key hyperparameters are not reported: temporal window size w and lag l for contextual attention mask; temperature tau for temporal contrastive loss; exact layer indices/counts for residual and internal injection modes; hidden dimensions of added action conditioning modules.
- **Impact**: Reduces reproducibility; prevents full re-implementation from paper alone.
- **Evidence**: Appendix D.3 gives the windowing formula but not numerical values for w and l; Section 3.2.3 mentions the contrastive loss but tau is not reported; residual/internal modes described as applying to "a subset of layers" without specifying which layers.
- **Status**: Open

### LOW Findings
(None yet)

---

## CFR Entries Added in Phase 3-3

### CFR-004: Open-Loop-Only Evaluation Unmeasured Against NC Runtime Claim
- **Severity**: HIGH
- **Source Phase**: Phase-3-3
- **Finding**: All 10 experiments use open-loop rollout: ground-truth conditioning sequences are provided at each step and generated frames are never fed back as model input. This means the key NC property — persistent latent runtime state h_t maintained across self-generated frame sequences (Eq. 2.1: h_t = F_theta(h_{t-1}, x_t, u_t)) — is never evaluated. The paper claims evidence of "early NC primitives" of a running computer, but no experiment tests the model under closed-loop conditions where x_t is the model's own previous generation.
- **Evidence**: Section 3.2.4 explicitly states: "evaluation remains open-loop rather than closed-loop." All tables (2–11) are derived from open-loop rollouts against ground-truth conditioning sequences. No closed-loop result appears anywhere in the paper or appendix.
- **Impact**: PSNR, SSIM, FVD, OCR accuracy, and cursor accuracy measure I/O alignment under idealized oracle-conditioned rollout, not runtime state persistence under autoregressive self-conditioning. The gap between open-loop metrics and closed-loop behavior is acknowledged but entirely unmeasured. This weakens the "early NC primitive" claim, which depends on at least primitive runtime persistence.
- **Status**: UNRESOLVED

### CFR-005: Arithmetic Probe Sample Size Insufficient for Statistical Reliability
- **Severity**: MEDIUM
- **Source Phase**: Phase-3-3
- **Finding**: Table 5 reports arithmetic probe accuracy for four models (Wan2.1, NC_CLIGen, Veo3.1, Sora2) based on 100 randomly sampled problems from a 1,000-problem pool (single draw). NC_CLIGen achieves 4/100 (4%) and Wan2.1 achieves 0/100 (0%). The 95% Wilson confidence interval for 4/100 is approximately [1.1%, 9.9%], which overlaps with the CI for 0/100 ([0%, 3.6%]). The specific claim that NC_CLIGen outperforms Wan2.1 on arithmetic probes is not statistically supportable at n=100.
- **Evidence**: Table 5 caption: "100 problems sampled from a 1,000-problem held-out pool." No confidence intervals or multiple-sample estimates are reported. The held-out pool sampling procedure (single draw vs. multiple draws) is not described.
- **Impact**: The claim that fine-tuning on CLIGen provides any symbolic reasoning gain over the base Wan2.1 model (4% vs. 0%) is statistically indistinguishable from noise at n=100. The broader finding — that all video models except Sora2 fail on arithmetic probes — remains well-supported regardless.
- **Status**: UNRESOLVED

### CFR-006: Action Density Confound in Data Quality Experiment (Experiment 7)
- **Severity**: MEDIUM
- **Source Phase**: Phase-3-3
- **Finding**: Experiment 7 (Table 8) concludes that goal-directed CUA supervised data (110h) outperforms random exploration data (1,400h combined Random Fast + Slow) for action-response learning. However, CUA data has 0.10 actions/sec vs. Random Fast's 4.18 actions/sec (Table 7) — a 42x difference in action density. High action density introduces rapid, overlapping state changes that are intrinsically harder to model accurately, independent of whether the actions are goal-directed. The performance advantage of CUA data cannot be cleanly attributed to goal-directedness alone.
- **Evidence**: Table 7 reports Avg. actions/sec: Random Slow 1.58, Random Fast 4.18, CUA (supervised) 0.10. Table 8 reports CUA FVD 14.72 vs. Random Fast FVD 48.17. No action-density-controlled comparison is provided.
- **Impact**: The paper's design recommendation ("prioritize curated, purposeful interactions over large-scale passive data collection") is practically correct and likely directionally right, but the specific mechanism (goal-directedness vs. action sparsity) is unresolved. A subsampled Random Fast condition matching CUA density would isolate the confound.
- **Status**: UNRESOLVED

---

## CFR Entries Added in Phase 3-4

### CFR-007 → MEDIUM (DA-Downgraded): Internal vs. Residual SSIM Difference Likely Negligible
- **Severity**: MEDIUM (downgraded from HIGH by DA Phase-7-0)
- **DA Downgrade Rationale**: FVD difference (internal 14.5 vs. residual 18.8, 23% relative) is robust and points the same direction as the SSIM comparison. SSIM delta=0.006 is one metric of three. LPIPS reversal (0.003 absolute) is also within noise. The central recommendation (internal > residual) survives on FVD regardless of the SSIM noise issue. Weakens SSIM-based justification but does not undermine the recommendation.
- **Source Phase**: Phase-3-4
- **Finding**: Table 10 reports SSIM+15 of 0.863 (internal) vs. 0.857 (residual) — absolute difference of 0.006 (0.7% relative). Estimated Cohen's d ~0.06–0.15 (negligible), based on typical SSIM SDs of 0.04–0.10 in video generation evaluation. On LPIPS, residual (0.138) outperforms internal (0.141). The paper recommends internal mode as achieving the "best SSIM/FVD trade-off" — a claim that depends partly on this SSIM gap being real rather than noise.
- **Evidence**: Table 10: internal SSIM+15 = 0.863, residual SSIM+15 = 0.857, LPIPS+15 = 0.141 (internal) vs. 0.138 (residual). Section 3.2.5 (p.19): "internal achieves the highest structural consistency (SSIM 0.863)."
- **Impact**: Central GUIWorld architectural recommendation rests in part on a SSIM difference that is likely within noise. The FVD difference (14.5 vs. 18.8) is larger and more credible, but LPIPS reversal means the "best trade-off" claim is not unambiguous across all three metrics. No standard deviation or statistical test is provided.
- **Status**: UNRESOLVED

### CFR-008: Meta-Action vs. Raw-Action Encoding Differences Are Small
- **Severity**: MEDIUM
- **Source Phase**: Phase-3-4
- **Finding**: Table 11 reports meta-action vs. raw-action improvements of SSIM +1.9% (0.016 absolute), LPIPS -2.1% (0.003 absolute), FVD -12.7% (2.1 absolute). Estimated Cohen's d ~0.16–0.40 (negligible to small). The paper acknowledges "modest" gains and that qualitative failure modes "persist across both representations."
- **Evidence**: Table 11; Section 3.2.5 (p.19): "these gains are modest compared to the substantially larger improvements observed when varying the action injection scheme itself."
- **Impact**: Recommendation to prefer meta-action encoding is better justified by semantic simplicity than performance. Presentation alongside larger Table 10 effects may create an impression of greater differentiation than the effect sizes support.
- **Status**: UNRESOLVED

### CFR-009: No Statistical Reporting Across All 10 Experiments (Systemic)
- **Severity**: HIGH
- **Source Phase**: Phase-3-4
- **Finding**: No table in the paper (Tables 2–11) reports standard deviations, confidence intervals, standard errors, or significance test results. No experiment reports results from more than one random seed. This is a systemic absence. For comparisons with small absolute differences (Table 10: internal vs. residual SSIM 0.006; Table 11: meta vs. raw SSIM 0.016), statistical significance is unknowable.
- **Evidence**: Inspection of Tables 2–11 confirms absence of any variance measures. Systemic pattern across all 10 experiments.
- **Impact**: Weakens all numerical comparison claims. For large-gap results (cursor accuracy, FVD CUA vs. untrained), practical impact on conclusions is low because gaps are decision-relevant regardless of statistics. For small-gap results (internal vs. residual, meta vs. raw), architectural recommendations may not reflect real differences.
- **Status**: UNRESOLVED

### CFR-010: Reprompting Result (83%) Reported Without Data Table or Sample Size
- **Severity**: MEDIUM
- **Source Phase**: Phase-3-4
- **Finding**: Figure 6 shows NC_CLIGen rising from 4% to 83% under reprompting. No companion data table, no stated sample size, no CI, no specification of whether the same 100-problem draw from Table 5 was used. This is the paper's largest improvement figure (+79 pp) and main evidence for steerability as a conditioning lever.
- **Evidence**: Figure 6 caption: "Reprompting boosts performance to 83%." No data table provided. Table 5 reports 100 problems; Figure 6 does not state whether the same pool was used.
- **Impact**: Steerability interpretation is the key insight for avoiding RL. Without a table, sample size, and CI, the 83% figure cannot be independently assessed. The reporting standard for this result is lower than for all other 9 experiments.
- **Status**: UNRESOLVED

---

## CFR Entries Added in Phase 3-5c

### HIGH-011: Missing Citations Misrepresent NC_GUIWorld Paradigm Novelty (GameNGen, DIAMOND, AVID, DWS)
- **Severity**: HIGH
- **Source Phase**: Phase-3-5c
- **Finding**: Four papers accepted at ICLR 2025 or NeurIPS 2024 Spotlight directly establish the technical design space in which NC_GUIWorld operates — two-phase interaction data collection plus diffusion model training for action-conditioned interactive video generation. These papers are entirely absent from the NC paper's citations.
  - **GameNGen** (arXiv:2408.14837, ICLR 2025, August 2024): In Section 3, establishes the identical two-phase paradigm (RL/interaction data → diffusion model on frames+actions) applied to DOOM gameplay. GameNGen's formal definition q(o_n|o_<n,a_<=n) (Section 2) is mathematically equivalent to NC's Eq. 2.1. NC_GUIWorld is the OS/GUI domain application of the GameNGen paradigm.
  - **DIAMOND** (arXiv:2405.12399, NeurIPS 2024 Spotlight, May 2024): In its CS:GO extension (project page), demonstrates an interactive diffusion neural game engine with fixed human gameplay data (87h, no RL) at ~10 FPS — the same paradigm NC_GUIWorld proposes for OS/GUI, published ~2 years earlier.
  - **AVID** (arXiv:2410.12822, ICLR 2025, October 2024): Section 3.3 establishes adapting pretrained video diffusion models to action-conditioned world models with per-frame scale/shift conditioning — the same design problem as NC_GUIWorld's injection mode ablation.
  - **DWS** (arXiv:2502.07825, ICLR 2025, February 2025): Section 4.1 proposes per-block scale-shift action modulation for pretrained video diffusion transformers — the direct precedent for NC_GUIWorld's "internal" injection mode.
- **Evidence**:
  - GameNGen Section 3: "The entirety of the agent's actions and observations corpus T_agent during training is maintained and becomes the training dataset for the generative model in a second stage"
  - DIAMOND project page: "The diffusion model functions as an interactive neural game engine where users provide actions, and the model autoregressively generates subsequent frames"
  - AVID Section 3.3: "scale and shift parameters, gamma^tau and beta^tau, for the tau-th frame derived from action embeddings"
  - DWS Section 4.1: "a lightweight add-on module, consisting of two linear layers within each transformer block"
- **Impact**: NC_GUIWorld's paradigm claim (pioneering interactive diffusion simulation from human-collected data for computing environments) cannot be properly assessed without these citations. The injection mode ablation is presented as original design space exploration when that design space is already established at ICLR 2025. This is a significant related work integrity issue requiring correction.
- **Status**: UNRESOLVED — Requires addition of all four citations and repositioning of NC_GUIWorld's incremental contribution within the established design space.

### HIGH-012: NeuralOS Technical Advantage Over NC_GUIWorld Is Unacknowledged
- **Severity**: HIGH
- **Source Phase**: Phase-3-5c
- **Finding**: NeuralOS (arXiv:2507.08800, ICLR 2026), acknowledged as "most closely related" in one sentence in Section 2.1, demonstrably outperforms NC_GUIWorld on the critical OS simulation capability of long-horizon state persistence. NeuralOS's hierarchical RNN maintains O(1) per-timestep complexity and demonstrated 256-frame memory retention for OS-level state (e.g., remembering a folder created long before the current frame). NC_GUIWorld is only evaluated open-loop (CFR-004), with no closed-loop results and no mechanism for state persistence beyond the diffusion model's attention context window. The NC paper presents a conceptual distinction ("runtime responsibilities" vs. "simulation") without acknowledging that NeuralOS's architecture concretely solves the long-horizon state problem that NC_GUIWorld leaves as future work.
- **Evidence**:
  - NeuralOS Section 3: "the RNN maintains constant complexity per timestep, which is crucial for continuous, long-horizon OS simulation"
  - NeuralOS Appendix P: "Action-conditioned diffusion models developed for video games generally assume that the necessary state is visually encoded in recent frames, making short context windows sufficient. In operating-system settings, however, critical state may persist far beyond a short temporal window (e.g., whether a folder was created earlier)."
  - NeuralOS Appendix P: "the RNN state enables NeuralOS to recall previous interactions far in the past"
  - NC paper Section 3.2.4: "evaluation remains open-loop rather than closed-loop" (per CFR-004)
- **Impact**: The NC paper implies a conceptual superiority of NC_GUIWorld over NeuralOS (NC handles "runtime"; NeuralOS only "simulates") while omitting that NeuralOS actually provides a concrete architectural solution to the state persistence problem NC_GUIWorld acknowledges as a limitation. This creates a potentially misleading impression of comparative capability. A formal architectural comparison section and acknowledgment of NeuralOS's RNN advantage are required.
- **Status**: UNRESOLVED — Requires formal comparison with NeuralOS including explicit acknowledgment of NeuralOS's long-horizon state advantage and the current open-loop limitation of NC_GUIWorld.

---

## CFR Entries Added in Phase-4-2

### CFR-013: Positive-Only Visualization Gallery — No Failure Cases Shown
- **Severity**: MEDIUM
- **Source Phase**: Phase-4-2
- **Finding**: The 39-figure appendix (Appendix E) contains exclusively positive-case outputs. No failure case gallery exists despite the paper acknowledging specific failure modes: text smear, cursor drift, spurious color changes, and task-level failure under multi-step interactions. Visualization thumbnails on pp.20-21 (GUIWorld Samples 1-14) all show qualitatively plausible outputs. This positive-only presentation is inconsistent with standard generative model evaluation practice.
- **Evidence**: Paper pp.20-21 (PDF): all 14 GUIWorld thumbnail samples show plausible output. Section 3.2.5 (p.19): "failure modes are dominated by data quality and by where action information enters the backbone." No failure examples are shown anywhere in Appendix E or main body despite this explicit acknowledgment. Phase-3-4 qualitative analysis: "All visualization samples appear to be positive cases."
- **Impact**: Combined with the systemic absence of statistical reporting (HIGH-009), the positive-only gallery increases the risk that the qualitative impression overestimates typical performance. Reviewers familiar with generative model evaluation norms will flag this gap. Without failure case examples, readers cannot assess whether visualized examples are representative or cherry-picked.
- **Status**: UNRESOLVED

### CFR-014: NC Formalism Mathematically Indistinguishable from Interactive World Model Formalism
- **Severity**: MEDIUM
- **Source Phase**: Phase-4-2
- **Finding**: NC's defining equation (Eq. 2.1: h_t = F_theta(h_{t-1}, x_t, u_t); x_{t+1} ~ G_theta(h_t)) is mathematically equivalent to GameNGen's interactive environment definition (q(o_n|o_<n,a_<=n)) and DIAMOND's diffusion world model formulation — both formally represent the same conditional generative process over observation histories conditioned on action histories. The paper provides no mathematical-level criterion distinguishing an NC from a world model or game engine at the formalism level. The distinction is stated in natural language only ("NCs aim to make the model itself the running computer" vs. "world models learn environment dynamics"). The CNC four conditions are presented as the differentiating framework but are never applied to formally rule out GameNGen or DIAMOND from satisfying them.
- **Evidence**: Phase-3-5c Level 3 reading of GameNGen Section 2: "a simulation distribution function q(o_n|o_<n,a_<=n)" confirmed formally equivalent to NC Eq. 2.1. The paper's Section 4 CNC definition box specifies four conditions but does not formally prove that existing world models fail to satisfy them. CFR HIGH-011 documents the missing citations for GameNGen and DIAMOND.
- **Impact**: A theoretically oriented reviewer may argue that the NC/CNC framework is terminological rather than formally new — relabeling the interactive world model formalism. To defend the NC abstraction as a genuinely new machine form, the paper needs a formal argument showing that the CNC four conditions impose requirements that world models and game engines do not and cannot satisfy in their current formulations.
- **Status**: UNRESOLVED

---

## CFR Entries Added in Phase-5-2

### CFR-015: No Closed-Loop Interactive Demonstration — Direct Field Standard Gap
- **Severity**: HIGH
- **Source Phase**: Phase-5-2
- **Finding**: All 10 reference papers that propose interactive simulation systems (GameNGen, DIAMOND, NeuralOS) include at least one closed-loop interactive demonstration. GameNGen achieves 5-minute stable closed-loop autoregressive generation at 20 FPS with a human rater study (Section 4, ICLR 2025). DIAMOND demonstrates RL agent training in diffusion model imagination and CS:GO human-interactive play at ~10 FPS (NeurIPS 2024 Spotlight project page). NeuralOS demonstrates 256-frame memory in closed-loop interaction sequences (Section 7, ICLR 2026). NC_GUIWorld is the only interactive simulation system in its primary reference class that lacks any closed-loop demonstration.
- **Evidence**:
  - GameNGen Section 4: "Human raters are only slightly better than random chance at distinguishing short clips of the game from clips of the simulation, even after 5 minutes of auto-regressive generation"
  - DIAMOND project page: "The diffusion model functions as an interactive neural game engine where users provide actions, and the model autoregressively generates subsequent frames"
  - NeuralOS Section 7: Demonstrates 256-frame state persistence in closed-loop interaction sequences
  - NC paper Section 3.2.4: "evaluation remains open-loop rather than closed-loop"
- **Impact**: NC_GUIWorld's performance metrics (FVD 14.72, SSIM 0.885) measure I/O alignment under oracle conditioning but provide no evidence about autoregressive stability under self-conditioning — the core property required for a "neural computer" claiming persistent runtime state. This is a field-standard expectation that all primary technical comparators satisfy but NC_GUIWorld does not.
- **Status**: UNRESOLVED

### CFR-016: Missing Human Perceptual Study — Below Field Standard for Interactive Simulation
- **Severity**: MEDIUM
- **Source Phase**: Phase-5-2
- **Finding**: GameNGen (ICLR 2025) includes a human rater perceptual study showing that raters achieve 0.58 accuracy (near chance) at distinguishing real vs. simulated DOOM clips after 5 minutes of generation — a standard claim-independent validation for interactive simulation quality. Genie (ICML 2024) includes a human playability assessment. NC_GUIWorld includes no human evaluation despite making claims about interactive computer simulation quality. The positive-only visualization gallery (Appendix E, CFR-013) is not an equivalent substitute.
- **Evidence**: GameNGen Section 4: "Human raters are only slightly better than random chance at distinguishing short clips of the game from clips of the simulation." Genie includes human playability demonstrations. NC paper: no human rater study exists in any table, figure, or appendix section.
- **Impact**: NC_GUIWorld has no independent (non-metric) validation of whether its generated outputs are perceptually plausible as OS interactions to human observers. This is a meaningful gap for a paper claiming "early NC primitives of a running computer."
- **Status**: UNRESOLVED

### CFR-017: No Inference Speed Reported — Practical Usability Unassessable
- **Severity**: MEDIUM
- **Source Phase**: Phase-5-2
- **Finding**: All primary technical comparators report inference speed as a standard practical metric. GameNGen (ICLR 2025): 20 FPS on single TPU. DIAMOND CS:GO (NeurIPS 2024 Spotlight): ~10 FPS on RTX 3090. NeuralOS (ICLR 2026): 15 FPS generation rate. NC_GUIWorld: inference speed is never reported in the main paper, tables, appendix, or project page. The paper's original training involved 64 GPUs for ~15 days — but inference requirements are unstated.
- **Evidence**: GameNGen Section 3.3: "50ms per frame = 20 FPS." DIAMOND project page: "~10 FPS on RTX 3090." NeuralOS: 15 FPS reported. NC paper: no FPS figure appears in any table or main text section.
- **Impact**: The practical interactive usability of NC_GUIWorld is unassessable. Interactive simulation requires near-real-time inference; 15-20 FPS is the field standard. If NC_GUIWorld runs significantly slower than real-time, the interactive computer claim is practically unrealizable. This information is expected by readers and reviewers.
- **Status**: UNRESOLVED

### CFR-018: No OSWorld Task Coverage Analysis — Generalization Gap
- **Severity**: MEDIUM
- **Source Phase**: Phase-5-2
- **Finding**: OSWorld (NeurIPS 2024) is the standard benchmark for evaluating computer-use competence, covering 369 tasks across Ubuntu, Windows, and macOS. NC_GUIWorld trains and evaluates on a fixed 8-app set (Firefox, GIMP, VLC, VS Code, Calculator, Terminal, File Manager, Mahjongg) but never maps this coverage to OSWorld's task taxonomy. The NC paper motivates NC_GUIWorld as a training environment for computer-use agents, but whether NC_GUIWorld's simulation covers the OSWorld task distribution is entirely untested and unanalyzed. OSWorld is not cited by the NC paper.
- **Evidence**: OSWorld (arXiv:2404.07972): "369 computer tasks on Ubuntu/Windows/macOS; real desktop + web + multi-app workflows; 72.36% human performance vs. 12.24% best AI baseline." NC paper GUIWorld data: "Fixed app set: Firefox ESR, GIMP, VLC, VS Code, Calculator, Terminal, File Manager, Mahjongg." No comparison or task coverage mapping performed.
- **Impact**: The practical claim that NC_GUIWorld could serve as an agent training environment requires at minimum a qualitative analysis of which OSWorld task categories NC's 8-app simulation covers. Without this, the practical value for agent training is unsubstantiated.
- **Status**: UNRESOLVED

---

## CFR Entries Added in Phase-6-2

### CFR-019: Captioning Pipeline Absent — Unbridged Gap Between Data Collection and Training
- **Severity**: HIGH
- **Source Phase**: Phase-6-2
- **Finding**: The paper describes Llama 3.1 70B generating three-tier captions (semantic / regular / detailed) from raw terminal buffers as a mandatory step between CLIGen data collection and Wan2.1 fine-tuning. Experiment 3 (Table 3) shows a 5 dB PSNR difference between caption tiers, establishing caption quality as a direct performance driver. The released repository contains no LLM captioning script, no captioning configuration, no prompt template for Llama 3.1 70B, and no documentation of how to connect raw video outputs to captioned training pairs. No Python file in the repository makes any LLM API call for captioning purposes.
- **Impact**: Users cannot proceed from the released data pipeline to any training setup. The output of the CLIGen pipeline is raw MP4 files; the input to Wan2.1 training is (first_frame, caption, video) triples. The bridge between these is entirely absent. This is not merely a documentation gap; the code implementing this step does not exist in the repository.
- **Evidence**: Paper Section 3.1.1: "Llama 3.1 70B generates three-tier captions from terminal buffers." README states this is "The Data Pipeline." No `caption/` directory, no `llm_caption.py` or equivalent script exists anywhere in the repository. `grep` for "llama", "caption", "llm" across all Python files returns no results.
- **Status**: UNRESOLVED

### CFR-020: Code Attribution in GUIWorld Pipeline — NeuralOS Lineage in Code Without In-Code Attribution
- **Severity**: MEDIUM
- **Source Phase**: Phase-6-2
- **Finding**: The repository maintainer confirmed in Issue #5 (response, 2026-04-11): "We indeed build our data collection (GUIWorld part) pipeline from your original codes." The README's acknowledgments section now states: "the data engine for GUIWorld (Random) is modified directly from Neural-OS." However, no file in `engine/gui/` contains per-file attribution comments crediting NeuralOS code. Files including `action_recorder.py`, `synthetic_script.py`, `synthetic_mouse_path.py`, `loop.py`, and `computer_use_agent/tools/computer.py` have no code-level lineage documentation. The extent of code derivation from NeuralOS's August 2025 commit versus original work cannot be determined from the repository alone.
- **Impact**: This creates a scholarly integrity ambiguity. For a paper claiming independent contributions to data collection methodology (Section 3.2.1 describes GUIWorld pipeline as a contribution), the degree to which the implementation derives from NeuralOS affects how independent the contribution is. The README acknowledgment is a minimum standard; per-file attribution in derived files is the community expectation for significant code reuse. This is a lower severity than CRITICAL because MIT license compliance is met, but the question of independent technical contribution to the data engineering aspect of the paper is affected.
- **Evidence**: Issue #5 body (da03, 2026-04-11): "the released data-collection code appears to substantially overlap with our earlier data-collection pipeline." Maintainer response confirms derivation. README acknowledgments section: "GUIWorld (Random) is modified directly from Neural-OS."
- **Status**: UNRESOLVED — Per-file attribution comments should be added to files derived from NeuralOS; characterization of original vs. adapted components should be documented.

---

## CFR Entries Added in Phase-6-2b

### CFR-021 → MEDIUM (DA-Downgraded): Sora2 Comparison Configuration Undisclosed — Inconsistent Disclosure Standard
- **Severity**: MEDIUM (downgraded from HIGH by DA Phase-7-0)
- **DA Downgrade Rationale**: 71% vs. 4% gap is so large that no plausible configuration variation could reverse the directional finding. Inconsistent disclosure standard vs. Table 10 footnote is a presentation concern. Paper provides Table 6 with three hypotheses for Sora2's advantage, demonstrating awareness. Directional conclusion robust.
- **Source Phase**: Phase-6-2b
- **Finding**: The generation configuration for Sora2 in the arithmetic probe comparison (Table 5) is entirely undisclosed. The paper does not report: temperature, sampling protocol, system prompt, input format, API version/access date, number of sampled runs per problem, or whether a reference terminal frame was provided (as NC_CLIGen receives). The paper acknowledges the comparison is rough (Table 6: three hypotheses for Sora2's advantage) but applies no footnote caveat to Table 5, while the early-stopped external baseline in Table 10 receives an explicit disclosure footnote. This is an inconsistent disclosure standard within the same paper.
- **Evidence**: Table 5: "Sora2: 71%" with no configuration specification. Table 10 footnote: "baseline_2 was early-stopped at epoch 1 due to compute constraints (~50% of full training)." Methodology Evaluation Section 3 (p.17): "The generation configuration for Sora2 (temperature, sampling steps, system prompt) is not reported." The paper provides Table 6 hypotheses for Sora2's advantage but no Table 5 analog of the Table 10 footnote disclosure.
- **Impact**: The Sora2 comparison cannot be independently replicated. Readers cannot assess whether the 71% reflects model capability, prompt engineering, training data overlap with arithmetic/terminal content, or other factors. The directional finding (commercial models outperform NC_CLIGen on arithmetic probes) is robust regardless, but the magnitude (71% vs. 4%) could be configuration-dependent. The inconsistency in disclosure standards between Table 5 and Table 10 creates an appearance of selective transparency.
- **Status**: UNRESOLVED — A disclosure footnote equivalent to Table 10's should be added to Table 5, and the Sora2 evaluation protocol should be reported (prompt format, sampling configuration, API version used).

### CFR-022 → MEDIUM (DA-Downgraded): External Injection Mode Early-Stop — Outcome-Dependent Stopping Creates Incomplete Ablation
- **Severity**: MEDIUM (downgraded from HIGH by DA Phase-7-0)
- **DA Downgrade Rationale**: Explicitly disclosed in Table 10 footnote, distinguishing it from undisclosed outcome-dependent stopping. The three fully trained modes (contextual, residual, internal) are sufficient to establish the injection depth hierarchy. External mode is presented as a "rough reference baseline." Primary recommendations do not rely on the contextual vs. external comparison.
- **Source Phase**: Phase-6-2b
- **Finding**: The external injection mode in Table 10 was early-stopped at ~50% of the planned training budget "after preliminary rollouts did not warrant further compute." This stopping decision was based on intermediate performance evaluation — a form of outcome-dependent stopping. The mode is presented in a "baseline" row alongside the untrained model (baseline_1), creating a structural implication that external conditioning is categorically weaker than the three fully trained injection modes (contextual, residual, internal), when it may simply be undertrained. The injection mode ablation is therefore complete for only three of the four studied modes.
- **Evidence**: Table 10 footnote: "baseline_2 (external, early-stopped) early-stopped at epoch 1 due to compute constraints (~50% of full training)." Table 10 structure separates baseline_1 (untrained) and baseline_2 (external, early-stopped) from the three experimental conditions (contextual, residual, internal). SSIM+15 comparison: contextual (100% trained) 0.813 vs. external (~50% trained) 0.746; FVD+15 comparison: contextual 24.8 vs. external 33.4. These differences conflate injection architecture with training compute.
- **Impact**: The comparison contextual > external rests on unequal training budgets, not architectural properties alone. If external conditioning at full training budget achieves performance comparable to contextual conditioning, the proposed hierarchy (deeper injection is consistently better) would need revision. The comparison among the three fully trained modes (internal vs. residual vs. contextual) remains valid and unaffected. The paper's primary recommendation (internal conditioning achieves the best SSIM/FVD trade-off among fully trained modes) is supported, but the position of external conditioning in the hierarchy cannot be established from these data.
- **Status**: UNRESOLVED — The external injection mode should be trained to the full 64k-step budget and reported as a fourth experimental condition rather than as a "baseline." Alternatively, the table should clearly label baseline_2 as "undertrained condition" and the text should explicitly state that the contextual vs. external comparison is confounded by training compute.

---

---

## CFR Entries Added in Phase-6-3

### CFR-023 (Standardized from MAJOR): Episode Packaging Absent
- **Severity**: HIGH (standardized from non-standard "MAJOR" label)
- **Source Phase**: Phase-6-3
- **Finding**: Paper's Appendix B describes an episode packaging system as part of the data pipeline that "would be released." The repository does not implement it. The captioning pipeline is also absent (see CFR-019).
- **Impact**: Users cannot proceed from raw data collection to training. Reproducibility of Experiments 2-11 is entirely blocked.
- **Status**: UNRESOLVED

### CFR-024 (Standardized from MAJOR): GUIWorld Pipeline Derived from NeuralOS — Attribution Absent from Paper Body
- **Severity**: HIGH (standardized from non-standard "MAJOR" label; DA confirms HIGH)
- **Source Phase**: Phase-6-3
- **DA Assessment**: Confirmed code derivation (maintainer confirmed Issue #5) with no disclosure in paper body Section 3.2.1, which presents the GUIWorld data collection pipeline as a paper contribution. README acknowledgment (added post-publication) meets MIT license minimum but the paper publication record does not reflect the derivation. Combined with HIGH-011 (deliberate GameNGen omission), creates a pattern of selective attribution.
- **Finding**: GUIWorld random data collection pipeline derived from NeuralOS codebase per maintainer confirmation. Section 3.2.1 describes this pipeline as a contribution without attribution. README acknowledgment added but paper body unmodified.
- **Status**: UNRESOLVED

### CFR-025: OSWorld Task Instructions Used but Not Cited
- **Severity**: MEDIUM
- **Source Phase**: Phase-6-3
- **Finding**: OSWorld task instructions used for CUA data collection without citation in the paper.
- **Status**: UNRESOLVED

---

## CFR Entries Added in Phase-7-0 (Devil's Advocate)

### CFR-026 (NEW): Missing Zero-Shot Wan2.1 Baseline in NC_CLIGen Training Ablation
- **Severity**: HIGH
- **Source Phase**: Phase-7-0 (Devil's Advocate — previously noted as development direction in Phase-3-4 but not elevated to CFR)
- **Finding**: Tables 2-4 track NC_CLIGen training progression (3% to 54% character accuracy, PSNR across training steps). None include a zero-shot Wan2.1 baseline — the base model's performance on CLIGen data without any fine-tuning. Without this baseline, the paper cannot demonstrate that CLIGen fine-tuning produces improvement over Wan2.1's base video generation capability. The 26.89 dB PSNR result in Table 3 (detailed caption) could reflect Wan2.1's general video generation quality applied to terminal content, not learned CLI simulation.
- **Impact**: The core NC_CLIGen empirical claim — that fine-tuning on CLIGen data teaches the model to simulate CLI behavior — is structurally unsupported without a zero-shot Wan2.1 row. This was identified in Phase-3-4 as a "development direction" but never elevated to a CFR finding despite directly affecting the attribution of NC_CLIGen's performance to fine-tuning vs. pretrained model capability.
- **Evidence**: Tables 2-4 have no zero-shot Wan2.1 row. Phase-3-4 results analysis noted "missing zero-shot Wan2.1 baseline" as a development direction. Paper's Section 3.1 presents the training progression as evidence of learning without establishing a pre-fine-tuning baseline.
- **Status**: UNRESOLVED

### CFR-027 (NEW): Reprompting Comparison with Base Wan2.1 Absent
- **Severity**: MEDIUM
- **Source Phase**: Phase-7-0 (Devil's Advocate)
- **Finding**: Figure 6 shows NC_CLIGen rising from 4% to 83% under reprompting, framed as "steerability as an alternative to RL." This interpretation requires showing that NC_CLIGen with reprompting outperforms Wan2.1 with reprompting — not just that reprompting improves NC_CLIGen. If base Wan2.1 achieves comparable arithmetic accuracy under reprompting (plausible since NC_CLIGen is fine-tuned Wan2.1), the 83% result reflects Wan2.1's text-conditioned video generation capability, not a distinctive NC property from CLIGen fine-tuning.
- **Impact**: The "steerability as RL alternative" interpretation is the key conceptual insight from the reprompting experiment. Without a Wan2.1 + reprompting baseline, the insight cannot be attributed to NC_CLIGen's NC-specific properties rather than to Wan2.1's underlying conditioning capability.
- **Evidence**: Figure 6 shows NC_CLIGen 4% → 83% under reprompting. No Wan2.1 baseline with reprompting is shown in Figure 6 or Table 5. CFR-010 documents the absent data table and sample size for the same figure.
- **Status**: UNRESOLVED

---

## Resolution Log

### DA Review Phase-7-0 Escalation Log
- HIGH-004 → CRITICAL: Runtime claim has zero closed-loop experimental support
- HIGH-011 → CRITICAL: Author-aware omission of GameNGen; combined with CFR-024 creates integrity pattern
- CFR-PATTERN-A (NEW CRITICAL): Systematic paradigm positioning through selective disclosure

### DA Review Phase-7-0 Downgrade Log
- HIGH-002 → MEDIUM: CLIGen Clean controls eliminate LLM caption risk from 8/10 experiments
- HIGH-007 → MEDIUM: FVD hierarchy survives SSIM noise issue; SSIM is one metric of three
- CFR-021 → MEDIUM: 71% vs. 4% gap robust to configuration variation
- CFR-022 → MEDIUM: Explicitly disclosed in Table 10 footnote

### DA Review Phase-7-0 Standardization Log
- CFR-023: MAJOR → HIGH (non-standard severity label standardized)
- CFR-024: MAJOR → HIGH (non-standard severity label standardized; DA confirms HIGH)
