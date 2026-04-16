# Comprehensive Research Quality Evaluation Report
# Neural Computers (arXiv:2604.06425)
# Phase 7-1 — Synthesis Across All Evaluation Phases

---

## Executive Summary

**Paper**: "Neural Computers"
**Authors**: Affiliated with Meta AI and KAUST
**Venue**: Preprint (arXiv:2604.06425, April 7, 2026)
**Length**: 75 pages (28 pages main text, 42-page appendix)
**Code**: Repository available (GitHub)

### Contribution Summary

The paper introduces "Neural Computers" (NCs) — a conceptual framework proposing that large neural networks can serve as the computational substrate of a computer rather than as agents operating over separate execution environments. The paper introduces a formal NC abstraction (the h_t state machine formalism, Eq. 2.1) and a four-condition "Canonical NC" (CNC) specification for what a system must achieve to constitute a neural computer. Two prototype implementations are presented: NC_CLIGen (a video diffusion model trained on CLI/terminal interaction data) and NC_GUIWorld (a video diffusion model fine-tuned for desktop GUI simulation on Ubuntu XFCE using action-conditioned frame generation). The paper reports 10 controlled ablation experiments across both systems.

### Research Quality Overview

The paper's research quality is uneven across its components. The NC/CNC conceptual framework and NC_CLIGen prototype are genuine contributions to a nascent research area with no prior work specifically addressing CLI/terminal video simulation. The SVG cursor supervision training insight is the paper's strongest and most decisively validated empirical finding. However, the NC_GUIWorld prototype operates in a design space substantially established by uncited prior work (GameNGen, DIAMOND, AVID, DWS), and the paper's central claim — that the prototypes instantiate "early NC primitives of a running computer" — is not supported by any closed-loop experiment. Three findings in the Critical Findings Registry (CFR) rise to CRITICAL severity: the absence of closed-loop evaluation for a "runtime" claim, a pattern of selective attribution and citation omission that misrepresents paradigm originality, and the confirmed author-awareness of the most directly comparable prior paper (GameNGen) whose deliberate exclusion from the paper body misrepresents the state of the art.

### Key Strengths

1. NC_CLIGen is a genuinely novel domain application: no prior work on CLI/terminal video simulation was identified across approximately 250 literature candidates (Phase-3-5c verification, Verified Novel, High confidence).
2. SVG cursor supervision achieves a decisive 90-percentage-point improvement (8.7% to 98.7% cursor accuracy, estimated Cohen's d > 5.0 — robust to any plausible error bar).
3. The NC/CNC conceptual framework and four-condition specification introduce new formal vocabulary not anticipated by any of the five deeply-read competing papers (Phase-3-5c, Claim A: Partially Novel).
4. The data quality over quantity finding (110h CUA data, FVD 14.72, outperforms 1,400h random data, FVD 48.17) provides actionable design guidance with a large, directionally credible effect.
5. Transparent limitation disclosure: the paper openly acknowledges its open-loop-only evaluation, reprompting result caveats, and prototype-stage claims throughout.
6. Extensive appendix documentation (42 pages) and released code repository support reproducibility within the pipeline components that are implemented.

### Key Areas for Improvement

1. **CRITICAL**: Add the four missing citations (GameNGen, DIAMOND, AVID, DWS) and reframe NC_GUIWorld's contribution as a domain extension of an established paradigm rather than a pioneering paradigm origination.
2. **CRITICAL**: Provide at least one closed-loop evaluation sequence to give any experimental support to the "runtime" and "NC primitive" claims.
3. **CRITICAL**: Disclose the NeuralOS code derivation in the paper body (Section 3.2.1), not only in the repository README.
4. Add statistical variance reporting (standard deviations or confidence intervals) for Tables 10 and 11, where architectural recommendations rest on small effect sizes that are likely within noise.
5. Include a formal comparison section with NeuralOS, acknowledging NeuralOS's architectural advantage for long-horizon state persistence.

---

## Paper Overview

### Research Problem and Motivation

The paper asks whether a single neural network, trained on human computer-use data, can take over the "runtime responsibilities" of a physical computer — executing user instructions, maintaining persistent system state, and rendering responsive interfaces — without a separate programmed operating system or application layer. The motivating claim is that the convergence of powerful video generation models, large-scale computer-use data, and frontier AI capabilities has brought this question within empirical reach for the first time. The NC problem is formalized as distinct from (a) differentiable memory (NTM/DNC) which adds external memory to neural networks, (b) AI agents which control external execution environments, and (c) world models which learn to predict environment state without claiming to replace the environment itself.

### Proposed Approach

The paper proposes two prototype NC implementations using the Wan2.1 video diffusion model as backbone:

**NC_CLIGen**: A fine-tuned video model trained on approximately 824k CLI/terminal video streams (CLIGen General, from public asciinema recordings) and approximately 128k Dockerized scripted terminal sessions (CLIGen Clean). Input conditioning uses three caption tiers (semantic, regular, detailed) generated by Llama 3.1 70B from terminal buffer content. The system is evaluated on character rendering accuracy, PSNR, and arithmetic probe completion.

**NC_GUIWorld**: A fine-tuned video model for desktop GUI simulation. Training data spans three types: Random Slow (1,000h random mouse/keyboard events at 1.58 actions/sec), Random Fast (400h at 4.18 actions/sec), and CUA supervised (110h of goal-directed Anthropic CUA agent data at 0.10 actions/sec). The architecture study ablates four action injection modes (external, contextual, residual, internal) and two action encoding schemes (raw coordinates vs. meta-action API schema). A key training contribution is SVG cursor visual supervision, which provides per-frame binary cursor masks and cursor-reference frames.

### Main Experimental Findings

The paper reports 10 numbered experiments (Tables 2–11):
- NC_CLIGen character accuracy improves from 3% (untrained) to 54% (60k training steps), with the caption tier ablation showing a 5 dB PSNR gap between semantic and detailed conditioning.
- Reprompting (iterative re-conditioning) raises arithmetic probe accuracy from 4% to 83%, interpreted as evidence of steerability without RL.
- SVG cursor supervision raises cursor accuracy from 8.7% (position-only) to 98.7% (Table 9) — the paper's largest and most decisive single finding.
- CUA-supervised data (110h) achieves FVD 14.72 vs. Random Fast (400h) FVD 48.17 — 12.7x less data achieving 3.3x better FVD (Table 8).
- Internal action injection mode achieves best FVD 14.5 vs. contextual 24.8 vs. residual 18.8 (Table 10).
- Meta-action encoding provides modest improvement over raw encoding (SSIM +1.9%, FVD -12.7%) (Table 11).

### Key Contributions Claimed

1. The NC/CNC conceptual framework as a new machine-form abstraction
2. NC_CLIGen as the first CLI/terminal video neural computer prototype
3. NC_GUIWorld as a pioneering OS/GUI neural computer prototype
4. SVG cursor visual supervision as a novel training technique
5. Four-mode injection ablation as a design space characterization for action conditioning in video DiTs
6. Data quality over quantity as a training principle

---

## Research Quality Evaluation

---

### Research Problem Quality

#### Problem Formulation

The NC problem is clearly and precisely formulated: can a neural network replace the executing substrate of a computer rather than interface with or simulate one? The formal definition in Eq. 2.1 (h_t = F_theta(h_{t-1}, x_t, u_t); x_{t+1} ~ G_theta(h_t)) provides a mathematical specification, and the four CNC conditions (Turing completeness, universal programmability, behavioral consistency, architectural advantage) define evaluable milestones. The distinction from NTM/DNC, AI agents, and world models is stated clearly in the introduction, though the mathematical differentiation from world model formalisms is incomplete (the formal overlap with GameNGen's q(o_n|o_<n,a_<=n) is unacknowledged, as documented in CFR-014).

The problem boundaries are appropriately bounded for a paper in this domain. The paper explicitly marks Section 4 as "Position" — honest signaling that the roadmap content is argument rather than evidence. This structural honesty about the paper's scope helps the reader calibrate expectations.

**Evidence**: Phase-3-1 problem analysis: "Novelty: High — NC abstraction distinct from NTM/DNC, world models, agents." Phase-3-2 methodology evaluation: "problem worth solving: Yes."

#### Significance and Motivation

The research problem is timely and significant. Video model capabilities have recently crossed a plausible prototype threshold (Wan2.1, Sora2, Veo3.1 released in 2025-2026). Computer-use agent proliferation is creating large-scale paired user I/O trace datasets. The NC research agenda — if it matures — would represent a qualitatively different computing paradigm merging programmability with learnability at the substrate level. Phase-3-1 assessment: "Impact: potentially significant. Timeliness: Very high."

The paper's significance claim is strong and appropriately hedged. Section 4's CNC roadmap provides a concrete research agenda organized around four measurable gaps (symbolic stability, routine reuse, controlled updates, machine-native semantics).

#### Gap Identification

The NC framework correctly identifies an unoccupied conceptual niche between world models, agents, and NTM/DNC systems. However, the gap analysis in the Related Work section is approximately one page embedded in Section 2 (Preliminaries) — insufficient for a paradigm-level claim. Phase-3-1 identified the gap analysis as sound at the conceptual level but weak in terms of prior art coverage. The absence of GameNGen, DIAMOND, AVID, and DWS (all directly adjacent prior work) from the gap analysis means that NC_GUIWorld's technical gap claim ("first interactive diffusion system for OS/GUI") overstates the gap, as these papers establish the paradigm months to years earlier.

**Assessment**: Research problem quality is **Good** for the conceptual NC/CNC formulation and the NC_CLIGen domain gap identification. It is **Adequate** for NC_GUIWorld's gap analysis, which overstates novelty due to incomplete prior art coverage. The underlying problem importance is high and not in dispute.

---

### Methodological Quality

#### Technical Soundness

Both NC_CLIGen and NC_GUIWorld are technically sound implementations. The use of Wan2.1 as a fine-tuning backbone is appropriate given its strong visual generation priors. The three-tier caption architecture for NC_CLIGen is a sensible design for exploring the information-fidelity tradeoff in conditioning. The CLIGen General/CLIGen Clean separation (diversity vs. controlled reproducibility) is a sound experimental design choice noted in Phase-3-2.

For NC_GUIWorld, the four action injection modes span a principled range from input-level to block-internal conditioning. The post-action metric windows (SSIM+15, FVD+15, LPIPS+15) — computing metrics over the 15 frames immediately following each action event — are a technically motivated and methodologically innovative evaluation approach that none of the 10 reference papers use (Phase-5-2).

One technical soundness concern: Section 3.2.3 states "we tune only the action encoder and learning-rate schedule" with backbone fixed, but Section 3.2.2 describes the internal mode adding CA_action sub-layers inside transformer blocks — newly initialized parameters that cannot be "pre-existing non-action components." No per-mode parameter counts are reported. This creates an unresolved confound between injection depth and parameter capacity in the central NC_GUIWorld architectural finding (CFR HIGH-003).

#### Novelty and Innovation

**NC_CLIGen**: Novelty is strong. Phase-3-5c verified no prior work exists on CLI/terminal video simulation across approximately 250 literature candidates. The asciinema replay pipeline, three-tier LLM captioning, and VHS clean scripting constitute a novel data engineering contribution in an unexplored domain.

**SVG cursor supervision**: Novelty is strong. The specific SVG-based approach (per-frame binary cursor masks + cursor-reference frames providing explicit visual structure) is not anticipated by any of the five deeply-read competing papers (Phase-3-5c, Claim E: Verified Novel). NeuralOS independently develops Gaussian spatial cursor encoding, confirming cursor-specific supervision as a recognized challenge but validating that the SVG approach is distinct.

**NC_GUIWorld injection mode ablation**: Novelty is moderate. Phase-3-5c establishes that AVID (ICLR 2025) and DWS (ICLR 2025) — both uncited — directly establish the same design space (per-frame scale/shift conditioning and per-block two-linear-layer modulation for pretrained video DiTs). The NC_GUIWorld injection mode ablation extends this design space to OS/GUI with a cross-attention implementation; it does not originate the design space. The contribution is better characterized as "new evidence within an established design space applied to a new domain" rather than original design space exploration (Phase-3-5c, Claim C: Partially Novel).

**NC/CNC framework**: Novelty is moderate. The four-condition CNC specification and h_t formalism introduce new formal vocabulary not anticipated by competing papers, but the underlying mathematical operation is shared with GameNGen's formalism (CFR MEDIUM-014). The conceptual contribution is real but rests on a formal distinction the paper does not prove rigorously.

**Comparative context** (Phase-5-2): SVG cursor supervision and NC_CLIGen methodology are unique in the reference class. NC_GUIWorld's technical paradigm is established by GameNGen/DIAMOND; the injection ablation extends AVID/DWS. The NC/CNC conceptual framework is the most distinctive contribution at the research agenda level.

#### Appropriateness

The choice to fine-tune Wan2.1 is appropriate for both systems. The CLIGen General/CLIGen Clean two-tier data strategy directly enables clean ablation by separating diversity from reproducibility — a sound methodological choice. The single-variable ablation design (one experimental factor varied per table) is appropriate and disciplined: Phase-3-3 and Phase-4-1 confirm that Experiments 3, 7, 8, 9, and 10 each vary one factor while holding others fixed.

#### Clarity and Completeness

The methodology is clearly described for the major design decisions. Significant gaps exist for: (a) CLIGen Clean filtering criterion — "51.21% retained after filtering" with no description of filtering rules (CFR MEDIUM-001); (b) temporal window size w and lag l for contextual attention mask — formula given in Appendix D.3 but no numerical values (CFR MEDIUM-002); (c) no per-mode parameter count table for the four injection modes (CFR HIGH-003). The captioning pipeline for CLIGen (Llama 3.1 70B from terminal buffers to three-tier captions) is described in the paper but not implemented in the repository (CFR-019 HIGH).

**Assessment**: Methodological quality is **Good** for NC_CLIGen and SVG cursor supervision. It is **Adequate** for NC_GUIWorld, where the central injection mode ablation is confounded by unequal parameter counts and the claimed design space originality is substantially undermined by uncited prior work at ICLR 2025. The post-action evaluation metric window is a genuine methodological innovation.

---

### Experimental Design Quality

#### Dataset Selection

NC_CLIGen datasets are novel and appropriate. The combination of approximately 824k asciinema recordings (CLIGen General) with approximately 128k Dockerized VHS scripted sessions (CLIGen Clean) is well-suited to the research questions. No field standard benchmark exists for CLI/terminal video simulation; the paper's choice to establish its own evaluation suite is appropriate given domain novelty.

NC_GUIWorld's training data is appropriate (Ubuntu 22.04/XFCE4/1024x768 matching NeuralOS's setup) but critically lacks coverage evaluation. The paper never maps the 8-app evaluation set (Firefox, GIMP, VLC, VS Code, Calculator, Terminal, File Manager, Mahjongg) to OSWorld (NeurIPS 2024 benchmark, 369 tasks across Ubuntu/Windows/macOS), which is the field-standard benchmark for computer-use evaluation. OSWorld is not cited (CFR-018 MEDIUM, CFR-025 MEDIUM for OSWorld task instructions used without citation). No cross-app generalization test exists, whereas NeuralOS demonstrates cross-app generalization.

#### Baseline Comparisons

**NC_CLIGen**: The three baselines (Wan2.1 base, Veo3.1, Sora2) are minimal but defensible given domain novelty. However, the critical missing baseline is zero-shot Wan2.1 on CLIGen data without fine-tuning — without this, the paper cannot demonstrate that CLIGen fine-tuning actually produces improvement over Wan2.1's base video generation capability (CFR-026 HIGH, identified in Phase-7-0). Tables 2-4 track training progression but have no zero-shot baseline row.

**NC_GUIWorld**: The baseline coverage is critically insufficient by field standards. The only baselines are an untrained Wan2.1 model (extremely weak) and an early-stopped external conditioning condition (undertrained at approximately 50% of compute). No comparison is made against NeuralOS (same domain, same OS, same data source), GameNGen (paradigm predecessor), DIAMOND, AVID, or DWS. Phase-5-2 comparative analysis confirms: "NC_GUIWorld has only 2 baselines: untrained model and early-stopped ablation condition. No comparison against GameNGen, DIAMOND, NeuralOS, AVID, or DWS."

#### Evaluation Metrics

The evaluation metrics are appropriate: PSNR and character accuracy for NC_CLIGen (appropriate for terminal rendering quality); SSIM, LPIPS, and FVD for NC_GUIWorld (standard video generation metrics). The post-action metric windows (computing metrics over the 15 frames following each action event) are a novel and well-motivated evaluation contribution — direct assessment of action responsiveness rather than overall video quality.

Absent metrics include: inference speed (FPS), which all primary comparators report (GameNGen: 20 FPS; DIAMOND: ~10 FPS; NeuralOS: 15 FPS) and which NC_GUIWorld never reports (CFR-017 MEDIUM); human perceptual evaluation, which GameNGen and Genie include (CFR-016 MEDIUM); and OSWorld task success rates for any evaluation of practical computer-use simulation coverage.

#### Experimental Rigor

The single-variable ablation design is a genuine strength: each of Experiments 3, 7, 8, 9, and 10 varies exactly one experimental factor. However, the statistical rigor is uniformly low across all 10 experiments. No table (Tables 2–11) reports standard deviations, confidence intervals, standard errors, or significance test results. No experiment reports results from more than one random seed (CFR HIGH-009 — systemic absence of variance reporting). This systemic gap means:
- Large-effect results (cursor accuracy delta 90pp, FVD CUA vs. untrained delta 90.2%) are robust to this gap — their effects are decision-relevant regardless.
- Small-effect results (internal vs. residual SSIM delta 0.006, estimated Cohen's d ~0.06–0.15; meta vs. raw SSIM delta 0.016) may not reflect real differences, and the architectural recommendations based on them are uncertain.

The closed-loop evaluation gap is the most significant experimental design gap relative to field standards. All primary technical comparators (GameNGen, DIAMOND, NeuralOS) include at least one closed-loop demonstration. NC_GUIWorld is the only interactive simulation system in its primary reference class without any closed-loop evaluation (CFR-015 HIGH, Phase-5-2).

**Assessment**: Experimental design quality is **Adequate** overall. The ablation discipline and post-action evaluation window are genuine strengths. The absence of zero-shot baselines (NC_CLIGen), the near-absence of external comparators (NC_GUIWorld), the systemic lack of statistical reporting, and the absence of any closed-loop evaluation are significant weaknesses that collectively place NC_GUIWorld's experimental evidence below field standards for interactive simulation papers.

---

### Results Quality

#### Evidence Strength

Several key results are decisively large and credible regardless of the statistical reporting gap:

- SVG cursor supervision: 98.7% vs. 8.7% cursor accuracy (delta = 90.0 pp, estimated Cohen's d > 5.0). Decisive under any plausible error bar. This is the paper's most credible and most clearly novel empirical finding.
- CUA data quality over random quantity: FVD 14.72 (110h CUA) vs. FVD 48.17 (Random Fast, 400h). CUA outperforms 12.7x more data by 69.4% on FVD. Directionally robust (though mechanism unresolved, CFR-006).
- CLIGen training progression: character accuracy 3% (untrained) to 54% (60k steps). Monotonic across seven checkpoints.
- Caption tier effect: +4.99 dB PSNR from semantic to detailed captions (estimated Cohen's d = 3.3–10.0).

Two results are insufficiently documented to assess their strength:
- Reprompting result: 4% to 83% arithmetic probe accuracy (Figure 6). This is the paper's headline practical finding (+79 pp) but is reported without data table, sample size, or confidence interval (CFR MEDIUM-010). Whether the same 100-problem draw from Table 5 was used is unstated.
- Internal vs. residual SSIM: delta 0.006 (estimated d ~0.06–0.15, negligible). The LPIPS reversal (residual 0.138 outperforms internal 0.141) contradicts the "best trade-off" claim on one of three metrics without statistical validation (CFR MEDIUM, downgraded in Phase-7-0 because FVD hierarchy survives).

#### Statistical Validity

Statistical validity is uniformly poor across all 10 experiments. The systemic absence of variance measures (CFR HIGH-009) means that architectural recommendations based on small effect sizes (Tables 10-11) cannot be confirmed as statistically meaningful. The arithmetic probe comparison (4% vs. 0%, n=100) is statistically indistinguishable at the reported sample size — Wilson CI for 4/100 ([1.1%, 9.9%]) overlaps with CI for 0/100 ([0%, 3.6%]) (CFR MEDIUM-005). The reprompting result (Figure 6) has no stated sample size.

#### Generalization

The paper provides limited generalization evidence. NC_CLIGen is evaluated only within the training environment (single terminal emulator, single font). NC_GUIWorld is evaluated on the same 8 apps used for training, with no out-of-distribution test. NeuralOS demonstrates cross-app generalization; DIAMOND demonstrates across 26 Atari games; NC_GUIWorld provides no equivalent evidence.

The "data quality over quantity" finding (Experiment 7) is reported under contextual conditioning only. Whether the finding generalizes across injection modes is untested. The paper presents this as a general design principle without cross-validation.

#### Comparison with Field

Phase-5-2 comparative analysis finds that NC_GUIWorld's absolute performance numbers (FVD 14.72) have no reference point other than its own baselines. No comparison against any established competing system is reported. GameNGen (PSNR 29.4 on DOOM) and DIAMOND (~10 FPS interactive play) provide performance context for the paradigm, but direct comparability is limited by domain differences. The paper's most important performance comparison — NC_GUIWorld vs. NeuralOS on shared Ubuntu XFCE tasks — does not exist.

**Assessment**: Results quality is **Good** for the decisive large-effect results (cursor supervision, data quality, caption tier, training progression). Results quality is **Poor** for the small-effect architectural recommendations (Tables 10-11), which lack statistical grounding. The reprompting result quality is **Adequate** in directional terms but **Poor** in documentation. Overall results quality is **Adequate**, significantly constrained by systemic statistical reporting gaps and absence of external comparators.

---

### Presentation Quality

#### Writing Clarity

The writing is clear and well-organized for a 75-page paper. The dual-system scope (NC_CLIGen and NC_GUIWorld) is handled without major organizational confusion. Phase-2 structural analysis: 28-page main text with logical section flow; Section 4 appropriately labeled "Position" to signal argument vs. evidence content; limitation disclosures distributed throughout rather than consolidated. The paper's epistemic tone is notably modest and transparent for an ML systems paper — specific instances include the reprompting result disclaimer ("we do not treat it as direct evidence of native arithmetic"), the Table 10 early-stop footnote, and the Section 3.2.4 open-loop disclosure.

#### Completeness

The 42-page appendix provides substantial documentation: Appendix B covers data engineering; Appendix D covers hyperparameter details; Appendix E provides 39 figures of output visualizations. Key completeness gaps include: CLIGen Clean filtering criterion undocumented (CFR MEDIUM-001); temporal window parameters w and l not numerically specified (CFR MEDIUM-002); per-mode injection parameter counts absent (CFR HIGH-003); no failure case visualizations in Appendix E (CFR MEDIUM-013, positive-only gallery).

#### Visual Communication

The paper's figures effectively communicate training progression (Tables 2-4 as training curves) and experimental conditions (Tables 7-11). The 14 NC_GUIWorld thumbnail samples on pp.20-21 provide visual evidence of generation quality. However, all visualized samples appear to be positive cases — no failure examples are shown despite the paper acknowledging specific failure modes (text smear, cursor drift, spurious color changes) in Section 3.2.5. A failure-case gallery would demonstrate that positive examples are not cherry-picked (Phase-4-2 assessment; CFR MEDIUM-013).

**Assessment**: Presentation quality is **Good**. The paper is clearly written and well-organized for its scope and length. The positive-only visualization gallery and several documentation gaps (filtering criteria, window parameters) are meaningful but not fundamental presentational failures.

---

### Reproducibility Quality

The paper is classified as Type A (Definitely Requires Code) under Phase-4-3 repository detection. A code repository is available (GitHub). Phase-6 analysis identified two critical reproducibility gaps:

**CFR-019 HIGH — Captioning pipeline absent**: The paper describes Llama 3.1 70B generating three-tier captions from raw terminal buffers as a mandatory step between CLIGen data collection and Wan2.1 fine-tuning. Experiment 3 (Table 3) establishes that caption quality drives a 5 dB PSNR difference — making the captioning pipeline a direct performance determinant. The released repository contains no LLM captioning script, no captioning configuration, no prompt template, and no documentation for connecting raw video outputs to captioned training pairs. Users cannot proceed from the CLIGen data pipeline to any training setup.

**CFR-023 HIGH — Episode packaging absent**: Appendix B describes an episode packaging system that "would be released." The repository does not implement it. Combined with CFR-019, users cannot reproduce any of Experiments 2-11 from the released code.

**CFR-024 HIGH — NeuralOS code attribution absent from paper body**: The repository maintainer confirmed in Issue #5 that the GUIWorld data collection pipeline derives from the NeuralOS codebase. The README's acknowledgments section was updated to note this. However, the paper body (Section 3.2.1, which presents the GUIWorld data collection pipeline as a paper contribution) does not acknowledge the NeuralOS derivation. Per-file attribution comments in derived files are also absent.

**CFR-PATTERN-A CRITICAL (partially applies)**: The NeuralOS code attribution gap, combined with the GameNGen citation omission and the mathematical equivalence of NC's formalism to GameNGen's (unacknowledged in paper), forms part of the CRITICAL pattern of selective attribution identified in Phase-7-0.

The extensive 42-page appendix provides hyperparameter documentation for many components. However, the two absent pipeline components (captioning, episode packaging) block the critical path from data to training for all NC_CLIGen experiments. For NC_GUIWorld, the data collection pipeline is partially available but with incomplete per-file attribution.

**Assessment**: Reproducibility is **Partially Reproducible**. The released repository implements the data collection scaffolding and provides documented configs for key hyperparameters, constituting a meaningful reproducibility effort. However, the absence of the captioning pipeline and episode packaging system prevents full reproduction of any NC_CLIGen training experiment from the released code alone.

---

## Key Strengths

### 1. NC_CLIGen — Verified Novel Domain (Critical Importance)

NC_CLIGen is the paper's most clearly novel contribution. Phase-3-5c independent literature review, covering approximately 250 candidates with five directly competing papers read at Level 2-3, found no prior work on CLI/terminal video simulation. The five deeply-read competing papers (GameNGen, DIAMOND, NeuralOS, AVID, DWS) all operate in game or graphical desktop environments; none address terminal/CLI simulation. This is a verified novel domain application.

The data engineering infrastructure is itself a contribution: approximately 824k asciinema recordings (CLIGen General) plus approximately 128k Dockerized VHS scripted sessions (CLIGen Clean) constitute a two-tier data strategy without direct precedent in the reviewed literature.

**Comparative context** (Phase-5-2): All reference papers operate in distinct domains. NC_CLIGen occupies a unique niche.

### 2. SVG Cursor Supervision — Decisive Training Insight (Critical Importance)

The discovery that SVG-rendered cursor visual supervision raises cursor accuracy from 8.7% to 98.7% (Table 9, delta = 90.0 pp, estimated Cohen's d > 5.0) is the paper's strongest, most clearly novel, and most decisively validated empirical finding. Phase-3-5c novelty verdict: Verified Novel, High confidence. The baseline comparisons (coordinate-only: 8.7%, Fourier encoding: 13.5%) demonstrate that standard conditioning approaches fail entirely on the cursor placement problem. The SVG approach provides a training-time engineering insight with clear practical implications for any video model applied to GUI environments.

NeuralOS independently develops Gaussian spatial cursor encoding — confirming cursor precision as a recognized critical challenge and validating that the SVG approach is technically distinct.

### 3. NC/CNC Conceptual Framework — New Organizing Abstraction (Major Importance)

The four-condition CNC specification (Turing completeness, universal programmability, behavioral consistency, architectural advantage) and the h_t state machine formalism constitute a new formal vocabulary not anticipated by the five deeply-read competing papers (Phase-3-5c, Claim A: Partially Novel). The framework performs real analytical work: Table 13 compares four system types at a common systems level; Table 14 gives operational readings of each CNC requirement; Section 4 structures a concrete research roadmap around the four gaps. No reference paper proposes a specification vocabulary for what distinguishes "computing" from "simulating" in this technical tradition.

**Caveat** (from Phase-7-0 and Phase-3-5c): The NC formalism (Eq. 2.1) is mathematically equivalent to GameNGen's formal definition (q(o_n|o_<n,a_<=n)), and this equivalence is not acknowledged in the paper. The four CNC conditions are stated but never formally applied to verify that NC_CLIGen or NC_GUIWorld satisfy them, nor applied to demonstrate that GameNGen and DIAMOND fail them.

### 4. Data Quality Over Quantity Finding (Major Importance)

Experiment 7 establishes that 110h of CUA goal-directed data (FVD 14.72) outperforms 1,400h of random exploration data (FVD 48.17 for Random Fast, 20.37 for Random Slow) — 12.7x less data achieving 3.3x better FVD (Table 8). This is a directionally robust finding with practical design guidance value. The action density confound (CUA: 0.10 actions/sec vs. Random Fast: 4.18 actions/sec, a 42x difference — CFR-006) means the specific mechanism (goal-directedness vs. action sparsity) is unresolved, but the practical recommendation to prioritize curated interaction data survives the confound.

No reference paper compares curated vs. uncurated data at this scale for OS simulation.

### 5. Transparent Limitation Disclosure (Major Importance)

The paper maintains consistent transparency about its limitations in ways that are notable for an ML systems paper. Documented instances (Phase-4-1): the reprompting result explicitly disclaimed as non-evidence of native arithmetic; the Table 10 early-stop footnote clearly labeled; Section 3.2.4 explicitly acknowledging open-loop-only evaluation; Sora2's 71% arithmetic accuracy reported with three hedged hypotheses rather than downplayed; character accuracy ceiling (54%) not framed as success. Section 4's "Position" label accurately signals vision/argument content. This epistemic humility lends the paper's positive claims additional credibility.

### 6. Dual-System Breadth (Major Importance)

Addressing both CLI/terminal simulation (NC_CLIGen) and desktop GUI simulation (NC_GUIWorld) under a unified NC/CNC framework is unique in the reference class (Phase-5-2). All reference papers focus on a single domain. The dual-system scope provides some evidence for paradigm generality across computing paradigms, though it comes at the cost of experimental depth for each individual system.

### 7. Extensive Reproducibility Documentation (Major Importance)

The 42-page appendix provides substantial documentation of data pipelines (Appendix B), evaluation procedures (Appendix C), and training hyperparameters (Appendix D). The released repository implements the data collection scaffolding with Dockerized containers for CLIGen Clean. While critical pipeline gaps exist (CFR-019, CFR-023), the documentation effort substantially exceeds the minimum for a paper in this field.

---

## Areas for Improvement

### 1. Missing Citations That Misrepresent Paradigm Novelty (CRITICAL — CFR HIGH-011, escalated to CRITICAL in Phase-7-0)

Four papers accepted at ICLR 2025 or NeurIPS 2024 Spotlight directly establish the technical design space in which NC_GUIWorld operates:

- **GameNGen** (arXiv:2408.14837, ICLR 2025): Establishes the identical two-phase paradigm (interaction data → diffusion model fine-tuning for action-conditioned frame generation) for game simulation (DOOM). The project blog separately mentions GameNGen, confirming author awareness. The paper body does not cite it. GameNGen's formal definition q(o_n|o_<n,a_<=n) is mathematically equivalent to NC's Eq. 2.1.
- **DIAMOND** (arXiv:2405.12399, NeurIPS 2024 Spotlight): Demonstrates interactive diffusion simulation from fixed human gameplay data (87h) at ~10 FPS — the same paradigm NC_GUIWorld proposes for OS/GUI.
- **AVID** (arXiv:2410.12822, ICLR 2025): Establishes per-frame scale/shift action conditioning for pretrained video diffusion models — the direct precedent for NC_GUIWorld's injection mode design space.
- **DWS** (arXiv:2502.07825, ICLR 2025): Proposes per-block two-linear-layer scale-shift modulation for pretrained video DiTs — the direct precedent for NC_GUIWorld's internal injection mode.

The author's awareness of GameNGen (documented on project blog) makes the paper-body omission a deliberate presentation choice rather than a knowledge gap. This is the basis for CRITICAL escalation in Phase-7-0. NC_GUIWorld's paradigm novelty claim must be repositioned from "pioneering" to "first systematic application of the interactive diffusion paradigm to the OS/GUI domain with a systematic injection mode ablation."

**Concrete improvement**: Add all four citations with characterization of overlap and distinction. Expand Section 2.1 into a standalone Related Work section. Reframe NC_GUIWorld's contribution statement.

### 2. No Closed-Loop Evaluation for "Runtime" Claim (CRITICAL — HIGH-004, escalated in Phase-7-0)

All 10 experiments use open-loop evaluation: ground-truth conditioning sequences are provided at each step; generated frames are never fed back as model input. The defining NC property — persistent latent runtime state h_t maintained across self-generated frame sequences — is never tested. The paper claims evidence of "early NC primitives of a running computer," but all reported metrics (PSNR, SSIM, FVD, OCR accuracy, cursor accuracy) measure oracle-conditioned I/O alignment, which is empirically equivalent to what GameNGen and DIAMOND demonstrate under the "simulation" label the NC paper claims to transcend.

Disclosure of this limitation in Section 3.2.4 does not reduce severity: the finding is classified by what the claim requires, not by whether the gap is acknowledged.

**Comparative context** (CFR-015 HIGH, Phase-5-2): GameNGen demonstrates 5-minute stable closed-loop autoregressive generation at 20 FPS. DIAMOND demonstrates RL agent training in world model imagination and CS:GO human-interactive play. NeuralOS demonstrates 256-frame RNN state memory in closed-loop interaction sequences. NC_GUIWorld is the only interactive simulation system in its primary reference class without any closed-loop demonstration.

**Concrete improvement**: Add a minimal Experiment 11 "Closed-Loop Error Accumulation" on CLIGen Clean: 100 scripted tasks, 5 autoregressive steps feeding generated frames back as conditioning, reporting character accuracy degradation as a frame-by-frame curve. Even a single 5-step degradation curve would constitute the first evidence characterizing NC runtime behavior under self-generated input.

### 3. Systematic Paradigm Attribution Pattern (CRITICAL — CFR-PATTERN-A, Phase-7-0)

Five individually HIGH/MEDIUM findings combine into a CRITICAL pattern of systematic selective disclosure in service of paradigm positioning:

1. Project blog mentions GameNGen; paper body does not cite it.
2. NeuralOS receives one sentence in a paper whose GUIWorld data pipeline derives from NeuralOS's codebase (maintainer confirmed in Issue #5).
3. NC formalism (Eq. 2.1) is mathematically equivalent to GameNGen's formal definition — this equivalence is not acknowledged.
4. Related Work section is approximately one page; the most important competitors are either undercited or uncited.
5. CNC four-condition definition is never applied to verify that existing systems (GameNGen, DIAMOND) fail to satisfy it.

The pattern creates a coherent presentation of NC as a paradigm originator rather than a domain extender/conceptual reframer. No individual finding reaches CRITICAL alone; combined, they constitute a systematic misrepresentation of paradigm originality.

**Concrete improvement**: Address each element: (a) add GameNGen and DIAMOND to paper body with substantive comparison; (b) add NeuralOS code attribution to Section 3.2.1; (c) acknowledge the mathematical equivalence of Eq. 2.1 and GameNGen's formalism explicitly; (d) expand Related Work from ~1 page to a full section; (e) apply the CNC four-condition checklist to GameNGen and DIAMOND to formally differentiate NC.

### 4. NeuralOS Receives Insufficient Comparison Despite Architectural Superiority on Key Dimension (HIGH — CFR HIGH-012)

NeuralOS (ICLR 2026), described as "most closely related" in one sentence, demonstrably provides a concrete architectural solution to the long-horizon state persistence problem that NC_GUIWorld acknowledges but cannot address. NeuralOS's hierarchical RNN maintains O(1) per-timestep complexity and demonstrated 256-frame memory retention for OS-level state. NC_GUIWorld's attention-based state handling has quadratic complexity growth and no demonstrated closed-loop persistence. The NC paper implies conceptual superiority (NC handles "runtime"; NeuralOS only "simulates") while omitting that NeuralOS architecturally outperforms NC_GUIWorld on the defining property of a running computer.

**Concrete improvement**: Add a Section 2.2 "Comparison with NeuralOS" covering: architectural differences (RNN+renderer vs. DiT fine-tuning); the state persistence tradeoff (NeuralOS's explicit RNN advantage vs. NC_GUIWorld's DiT quality advantage); honest acknowledgment of NeuralOS's long-horizon state advantage.

### 5. Systemic Absence of Statistical Reporting (HIGH — CFR HIGH-009)

No table in the paper (Tables 2–11) reports standard deviations, confidence intervals, standard errors, or significance tests. No experiment reports results from more than one random seed. For small-effect comparisons:
- Internal vs. residual SSIM: delta 0.006, estimated Cohen's d ~0.06–0.15 (negligible). LPIPS reversal contradicts "best trade-off" on one metric.
- Meta vs. raw SSIM: delta 0.016, estimated Cohen's d ~0.16–0.40 (negligible to small).

These two comparisons support the paper's two secondary architectural recommendations — both are statistically uncertain without variance measures.

**Concrete improvement**: Run 2–3 random seeds for Tables 10 and 11. Report bootstrap 95% confidence intervals for Tables 3 and 8 (computable from existing evaluation data). At minimum, report evaluation sample sizes for Tables 3 and 9.

### 6. Missing Zero-Shot Baseline for NC_CLIGen (HIGH — CFR-026)

Tables 2-4 track NC_CLIGen training progression across checkpoints but include no zero-shot Wan2.1 baseline — the base model's performance on CLIGen data without any fine-tuning. Without this baseline, the paper cannot demonstrate that CLIGen fine-tuning produces improvement over Wan2.1's inherent video generation capability. The 26.89 dB PSNR result could reflect Wan2.1's general quality applied to terminal content rather than learned CLI simulation.

**Concrete improvement**: Add a zero-shot Wan2.1 row to Tables 2-4. This single control condition converts a training progression observation into a fine-tuning attribution claim.

### 7. Critical Pipeline Components Missing from Repository (HIGH — CFR-019, CFR-023)

The captioning pipeline (Llama 3.1 70B generating three-tier captions from terminal buffers) and the episode packaging system are both described in the paper as integral components but are absent from the repository. These are not documentation gaps — the code implementing these steps does not exist in the repository. Experiment 3 establishes that caption quality drives a 5 dB PSNR difference, making the captioning pipeline a direct performance determinant. Without both components, users cannot proceed from raw data collection to training for any NC_CLIGen experiment.

**Concrete improvement**: Implement and release the captioning pipeline (including Llama 3.1 70B prompt templates, captioning configuration, and the data format bridge between raw video outputs and training triples) and the episode packaging system.

### 8. Injection Mode Ablation Confounded by Unequal Parameter Counts (HIGH — CFR HIGH-003)

The internal injection mode adds CA_action sub-layers inside transformer blocks — newly initialized parameters. Section 3.2.3 claims "only the action encoder and learning-rate schedule" are tuned, which is inconsistent with the internal mode's additional parameters. No per-mode parameter count table is reported. The SSIM advantage of internal over residual (delta 0.006) may partly reflect parameter capacity rather than injection depth.

**Concrete improvement**: Report per-mode trainable parameter counts. Add a capacity-controlled baseline: train contextual mode with randomly initialized parameters matched to internal mode's additional CA_action parameter count.

---

## Overall Research Assessment

### Contribution and Novelty

**Novelty verdict (MODERATE overall, differentiated by component)**:

Phase-3-5c novelty verification, based on Level 2-3 readings of five directly competing papers and a broader search across approximately 250 literature candidates, establishes the following component-level verdicts:

- **NC_CLIGen domain**: Verified Novel, High confidence. No prior work on CLI/terminal video simulation identified.
- **SVG cursor supervision**: Verified Novel, High confidence. Not anticipated by any of the five deeply-read competing papers.
- **NC/CNC conceptual framework**: Partially Novel, High confidence. Conceptual framing is new; underlying mathematical operation is shared with GameNGen.
- **NC_GUIWorld injection mode ablation**: Partially Novel, High confidence. Design space established by AVID and DWS; the specific OS/GUI application with cross-attention internal conditioning is novel.
- **NC_GUIWorld paradigm claim**: Challenged. The core technical paradigm (interaction data → diffusion model → action-conditioned frame generation) is established by GameNGen (August 2024, ICLR 2025) and demonstrated for interactive use by DIAMOND (May 2024, NeurIPS 2024 Spotlight) — both uncited.

The NC paper's strongest intellectual contribution is the NC/CNC conceptual reframing, which provides a specification vocabulary for distinguishing "computing" from "simulating" that no reference paper provides. NC_CLIGen and SVG cursor supervision are the paper's strongest empirical contributions. NC_GUIWorld's value lies in systematic empirical characterization (injection ablation, data quality comparison) within an established paradigm applied to a new domain.

**Comparative context** (Phase-5-2): NC's conceptual framework is unique in its reference class. NC_CLIGen is unique. NC_GUIWorld's paradigm placement requires accurate repositioning against GameNGen and DIAMOND as precedents.

### Problem Importance and Significance

The underlying research problem — whether neural networks can constitute computing substrates rather than acting as agents over separate substrates — is genuinely important and timely for April 2026. The convergence of powerful video generation models, large-scale computer-use data, and frontier AI capabilities creates conditions where empirical exploration of this question is newly feasible. Phase-3-1 assessment: "Impact: potentially significant. Timeliness: Very high."

The NC research agenda, if it matures, would represent a qualitatively different computing paradigm. The four-condition CNC specification provides measurable milestones for this agenda. The paper correctly identifies that no existing research line (NTM/DNC, agents, world models) has formalized this specific problem.

Problem importance is not affected by the prototype evaluation gaps — the importance of the question is independent of whether the current prototypes satisfy the CNC conditions.

### Technical Quality and Rigor

Technical quality is good for NC_CLIGen and SVG cursor supervision, where the implementations are sound, the experimental designs are clean, and the effects are large and decisively validated. Technical quality is adequate for NC_GUIWorld, where the parameter count confound in the injection mode ablation (CFR HIGH-003) and the absence of external comparators limit the strength of technical conclusions. The data engineering infrastructure for both systems is beyond the minimum required for a systems paper.

The injection mode ablation compound weakness identified in Phase-7-0 (Pattern B: HIGH-003 parameter confound + CFR-007 SSIM noise + HIGH-009 no statistics + CFR-022 external early-stopped) means that the NC_GUIWorld injection mode findings should be treated as preliminary and directional rather than definitive. The FVD-based hierarchy (internal 14.5 < residual 18.8 < contextual 24.8) is the most credible finding from Table 10; the SSIM-based secondary claims are not reliably established.

### Experimental Evidence and Rigor

Experimental evidence is strong for the decisive large-effect results (cursor supervision, data quality, caption tier, training progression) that form the empirical core of the paper's contribution. These results are robust to the statistical reporting gap because effect sizes are sufficiently large to be decision-relevant under any plausible error bar assumption.

Experimental evidence is weak for the secondary architectural recommendations (injection mode hierarchy beyond FVD, meta-action encoding advantage) where effect sizes are estimated to be negligible to small and no variance measures are reported.

The most significant experimental gap is the complete absence of closed-loop evaluation for a paper claiming "early NC primitives of a running computer" (CFR HIGH-004 → CRITICAL). The second most significant gap is the absence of any external comparator for NC_GUIWorld — the field-standard expectation for papers making technical contribution claims in an established research area.

**Comparative context** (Phase-5-2): NC_GUIWorld is the only interactive simulation system in its primary reference class (GameNGen, DIAMOND, NeuralOS) without any closed-loop evaluation and without any comparison against established systems.

### Clarity and Presentation

The paper is clearly written and well-organized for a 75-page document covering two prototype systems under a unified conceptual framework. The structural design (Section 4 labeled "Position," distributed limitation disclosures, Table 13-14 formal comparisons) is effective. The 42-page appendix is dense with practical information. The principal presentational shortcomings are: positive-only visualization gallery (CFR MEDIUM-013), absent failure-case examples, and underdocumented small-effect comparisons presented with the same visual format as large-effect comparisons.

### Impact and Generalizability

The NC/CNC framework has genuine long-term impact potential as an organizing concept for a nascent research direction. Whether the framework matures into an experimental program depends on the foundational infrastructure questions (closed-loop stability, state persistence, scaling) that the paper's roadmap identifies but does not yet address.

The SVG cursor supervision finding has immediate generalizability to any video model applied to GUI environments — it addresses a recognized core challenge and provides a practical training recipe. The data quality over quantity finding provides actionable guidance for future NC data collection, though with the caveat that the mechanism is unresolved (goal-directedness vs. action density).

The NC_CLIGen system's practical impact depends on whether terminal video simulation serves a useful agent training use case — a question the paper identifies but does not address.

Generalizability of NC_GUIWorld's performance is limited by the 8-app evaluation scope, the open-loop-only evaluation, and the absence of cross-app generalization tests. The paper's paradigm-level claims generalize beyond the evidence the prototypes currently provide.

**Comparative context** (Phase-5-2): DIAMOND demonstrates across 26 Atari games; DWS demonstrates across two domains and two architectures; NeuralOS demonstrates cross-app generalization. NC_GUIWorld provides less generalization evidence than most primary comparators.

### Reproducibility and Openness

The paper provides more documentation than is typical for a systems paper at this scale, with a 42-page appendix and a released code repository. However, two critical pipeline components (captioning, episode packaging) are absent from the repository, blocking reproduction of all NC_CLIGen training experiments. The NeuralOS code derivation for the GUIWorld pipeline is confirmed but disclosed only in the repository README (added post-publication), not in the paper body where Section 3.2.1 presents the pipeline as a paper contribution.

**Assessment**: Reproducibility is partially reproducible. The documentation effort is genuine and meaningful; the missing pipeline components are the primary barrier to full reproducibility. For a Type A implementation-based paper (definitively requires code), the captioning and episode packaging gaps are significant.

---

## Overall Research Assessment Summary

**Overall Evaluation**

The Neural Computers paper makes a genuine and timely intellectual contribution through its NC/CNC conceptual framework, its verified-novel NC_CLIGen domain application, and its SVG cursor supervision training insight. These contributions are real, well-motivated, and occupy a distinct position in the research landscape. The paper's transparency about limitations and its disciplined single-variable ablation design are methodological strengths that lend credibility to its positive findings.

However, the paper's paradigm-level claims — that NC_GUIWorld demonstrates "early NC primitives of a running computer" and constitutes a "pioneering paradigm" — are not supported by the prototype evidence and are complicated by three CRITICAL findings from the post-Devil's-Advocate CFR.

**Context within Field**

The NC paper enters the interactive world model field at a transition point: the GameNGen/DIAMOND paradigm is established; NeuralOS has demonstrated the same OS/GUI domain; and the NC paper's NC_GUIWorld prototype arrives as competitive concurrent work rather than paradigm origination. The NC/CNC framework is the paper's most distinctive contribution relative to this context — it proposes a specification vocabulary and research agenda that GameNGen, DIAMOND, and NeuralOS do not provide. NC_CLIGen is genuinely novel. The paper's most valuable long-term contribution is likely the framework and NC_CLIGen rather than the NC_GUIWorld prototype, which is best understood as preliminary empirical characterization within an established paradigm applied to a new domain.

**Key Contributions and Value**

1. The NC/CNC conceptual framework introduces a formal specification for what distinguishes a neural computer from a world model, game engine, or OS simulator — a new research agenda vocabulary with organizational value for follow-on work.
2. NC_CLIGen is the first empirical study of a video diffusion model trained on CLI/terminal interaction data, establishing baseline performance numbers for a new research area.
3. SVG cursor visual supervision is a concretely useful training insight for GUI video models that solves a recognized problem (cursor precision) with a decisive demonstrated effect.
4. The data quality over quantity finding provides actionable guidance for NC data collection.
5. The post-action evaluation metric window (SSIM+15, FVD+15) is a methodologically innovative evaluation contribution.

**Critical Concerns**

**CRITICAL 1 — Runtime claim lacks closed-loop experimental support** (HIGH-004, escalated CRITICAL): The paper's central differentiating claim — that NC_GUIWorld instantiates "early NC primitives of a running computer" — requires the NC property (persistent latent runtime state h_t evolving through self-generated outputs). Every experiment uses oracle ground-truth conditioning. The runtime state property has zero experimental support. All reported metrics measure oracle-conditioned I/O alignment — empirically equivalent to what GameNGen and DIAMOND demonstrate under the "simulation" label NC claims to transcend. A paper claiming NC "primitives" with no closed-loop experiment is claiming a machine property it never tests.

**CRITICAL 2 — Author-aware citation omission misrepresents paradigm novelty** (HIGH-011, escalated CRITICAL): The project blog confirms author awareness of GameNGen. The paper body does not cite it. GameNGen (ICLR 2025) establishes the identical two-phase paradigm NC_GUIWorld instantiates for OS/GUI. Three additional papers (DIAMOND, AVID, DWS) collectively establish the injection mode design space. Their absence from the paper means the injection mode ablation is presented as original design space exploration when the design space is charted by multiple peer-reviewed papers at ICLR 2025 and NeurIPS 2024. The author-aware omission converts a citation gap into a misrepresentation of the state of the art.

**CRITICAL 3 — Systematic paradigm attribution pattern** (CFR-PATTERN-A, new CRITICAL): Five individually HIGH/MEDIUM findings combine into a pattern in which every major comparative reference point (GameNGen citation, NeuralOS code derivation, mathematical equivalence of NC and GameNGen formalisms, related work depth, CNC condition verification) was handled in the way that maximizes the appearance of paradigm originality. The pattern is systematic rather than coincidental.

These three CRITICAL concerns require substantive revision to the paper. The first requires a new experiment. The second requires expanding the related work section with four additions and reframing the NC_GUIWorld contribution statement. The third requires addressing the attribution and formal differentiation gaps across the paper.

---

## Critical Questions for Consideration

1. **Closed-loop behavior**: Under autoregressive self-conditioning (each generated frame fed back as the next input), how quickly does NC_GUIWorld's performance degrade? The open-loop metrics (FVD 14.72, SSIM 0.885) measure oracle-conditioned performance; the closed-loop degradation profile is entirely unknown.

2. **NC_GUIWorld vs. NeuralOS**: On a shared Ubuntu XFCE task set (creating a folder, navigating to a URL, opening a file), how does NC_GUIWorld's visual generation quality and state persistence compare to NeuralOS's? The paper claims conceptual superiority but provides no performance comparison against the most directly comparable system.

3. **Fine-tuning attribution for NC_CLIGen**: What does Wan2.1 produce on CLIGen data without any fine-tuning (zero-shot)? Tables 2-4 show training progression but never establish the fine-tuning gain relative to the pretrained model's base capability.

4. **CNC condition verification**: Do NC_CLIGen and NC_GUIWorld satisfy any of the four CNC conditions (Turing completeness, universal programmability, behavioral consistency, architectural advantage)? The paper defines the conditions as goals but never applies them to assess the current prototypes.

5. **Reprompting attribution**: Under reprompting, what does base Wan2.1 achieve on arithmetic probes? If Wan2.1 without NC_CLIGen fine-tuning achieves comparable accuracy under reprompting, the 83% result reflects Wan2.1's underlying conditioning capability rather than any NC-specific property from CLIGen training (CFR-027).

6. **Parameter count confound in injection ablation**: How many trainable parameters does each injection mode (external, contextual, residual, internal) add? Does a capacity-controlled contextual mode (with parameters matched to internal mode) achieve performance comparable to the internal mode?

7. **CLIGen filtering criterion**: What rules determine the 51.21% of VHS scripts retained in CLIGen Clean? Without knowing the filtering criterion, the representativeness of Experiments 2-6 (all using CLIGen Clean) cannot be assessed.

---

## Constructive Feedback and Recommendations

### Priority 1 — Critical for Research Validity

**1.1 Add all four missing citations and reframe NC_GUIWorld's contribution**

Add GameNGen (arXiv:2408.14837), DIAMOND (arXiv:2405.12399), AVID (arXiv:2410.12822), and DWS (arXiv:2502.07825) to the paper body with substantive comparison. The contribution statement should be revised from "NC_GUIWorld demonstrates a pioneering paradigm for interactive OS simulation" to "NC_GUIWorld extends the interactive diffusion paradigm (established by GameNGen and DIAMOND for games) to the OS/GUI domain, with a systematic four-mode injection ablation that extends the design space characterized by AVID and DWS." Expand the Related Work from approximately one page to a full standalone section organized around: (a) interactive diffusion simulation paradigm (GameNGen, DIAMOND), (b) action injection design for video DiTs (AVID, DWS), (c) OS/GUI neural simulation (NeuralOS). This addresses CFR HIGH-011 (CRITICAL) and the attribution component of CFR-PATTERN-A (CRITICAL).

**1.2 Add a minimal closed-loop evaluation sequence**

Design and report Experiment 11: an autoregressive rollout test in CLIGen Clean where 100 scripted tasks are executed with 5 steps of self-conditioning (generated frames fed back as input), measuring character accuracy or OCR accuracy as a function of autoregressive depth. Report a frame-by-frame accuracy curve relative to the open-loop oracle baseline. Even a qualitative stability demonstration would constitute the first evidence characterizing NC runtime behavior under self-generated input. This addresses CFR HIGH-004 (CRITICAL) and directly tests the "NC primitive" claim.

**1.3 Disclose NeuralOS code derivation in the paper body**

Add an attribution statement to Section 3.2.1: "The GUIWorld random data collection pipeline builds on and modifies code from NeuralOS [citation]." Add per-file attribution comments in derived files within `engine/gui/`. This addresses the attribution component of CFR-PATTERN-A (CRITICAL) and CFR-024 (HIGH). Note: the README acknowledgment is a minimum standard; per-file attribution and paper-body disclosure are required for scholarly integrity.

**1.4 Report the zero-shot Wan2.1 baseline for NC_CLIGen**

Add a zero-shot Wan2.1 row to Tables 2-4 showing base model performance on CLIGen data without any fine-tuning. This establishes what the NC_CLIGen fine-tuning actually achieves relative to the pretrained model's inherent capability, converting a training progression observation into a fine-tuning attribution claim. This addresses CFR-026 (HIGH).

### Priority 2 — Important Experimental Improvements

**2.1 Add statistical variance reporting for Tables 10 and 11**

Run 2-3 random training seeds for the injection mode ablation (Table 10) and action encoding ablation (Table 11). Report mean ± SD. If repeated runs are computationally prohibitive for full training, report bootstrap 95% confidence intervals across evaluation clips (computable from existing model outputs). This addresses CFR HIGH-009 and would resolve whether the internal vs. residual SSIM recommendation (delta 0.006) is real or noise.

**2.2 Add per-mode parameter count table for injection ablation**

Report the number of trainable parameters added by each injection mode (external, contextual, residual, internal), broken down by module type. Add a capacity-controlled contextual baseline (parameters matched to internal mode's CA_action sub-layers) to determine whether the internal mode's FVD advantage reflects injection depth or parameter capacity. This addresses CFR HIGH-003.

**2.3 Expand the NeuralOS comparison to a dedicated section**

Add a 1-2 page Section 2.2 "Comparison with NeuralOS" covering: (a) architectural differences (RNN+renderer vs. DiT fine-tuning); (b) the state persistence tradeoff (NeuralOS's O(1) RNN complexity and 256-frame memory vs. NC_GUIWorld's quadratic attention growth and open-loop-only evaluation); (c) performance comparison on the shared Ubuntu XFCE domain if feasible; (d) an honest acknowledgment that NeuralOS's RNN architecture currently provides a concrete solution to the long-horizon state problem NC_GUIWorld has not yet addressed. This addresses CFR HIGH-012.

**2.4 Complete the external injection mode training run**

Train the external conditioning mode to the full 64k-step budget and add it as a fourth experimental condition in Table 10 (removing it from the "baseline" section or clearly marking all baselines). The current contextual vs. external comparison conflates injection architecture with training compute. Completing the run would either strengthen the injection depth conclusion (if external FVD remains well above contextual at full budget) or reveal a need for revised interpretation. This addresses CFR MEDIUM-022.

**2.5 Provide a data table for the reprompting result**

Convert Figure 6 from a bar chart to a data table with: sample size, draw randomness description (same 100-problem draw as Table 5 or new draw), Wilson confidence intervals for both the 4% and 83% values, and a reprompting protocol description. This is the paper's largest improvement figure (+79 pp) and currently the most under-documented quantitative result. This addresses CFR MEDIUM-010. Additionally, include a Wan2.1 baseline under reprompting to assess whether the 83% result is NC_CLIGen-specific or reflects Wan2.1's underlying conditioning capability (CFR-027).

**2.6 Release the captioning and episode packaging pipeline**

Implement and release the Llama 3.1 70B captioning pipeline, including: captioning script, prompt templates, configuration file specifying three caption tier definitions, and a data processing script bridging raw video outputs to (first_frame, caption, video) training triples. Release the episode packaging system described in Appendix B. Without these components, users cannot reproduce any NC_CLIGen training experiment from the released code. This addresses CFR-019 (HIGH) and CFR-023 (HIGH).

### Priority 3 — Presentation and Completeness Improvements

**3.1 Add a failure-case visualization gallery**

Add a Section E.2 "Failure Cases" to Appendix E showing representative examples of the acknowledged failure modes: text smear, cursor drift, spurious color changes, and task-level failure under multi-step interactions. A failure gallery would demonstrate that the existing positive-case examples are not cherry-picked and would enable readers to calibrate expected performance for specific use cases. This addresses CFR MEDIUM-013.

**3.2 Report CLIGen Clean filtering criterion**

Describe the filtering rules that resulted in 51.21% (~128k of ~250k scripts) being retained in CLIGen Clean. This is the dataset used for all controlled ablation experiments (Experiments 2-6) and its distribution is currently uncharacterized. This addresses CFR MEDIUM-001.

**3.3 Report inference speed**

Report NC_GUIWorld's frames-per-second during inference on standard hardware (e.g., A100 GPU). GameNGen (20 FPS), DIAMOND (~10 FPS), and NeuralOS (15 FPS) all report this; it is the standard measure of practical usability for interactive simulation systems. For a paper claiming "early NC primitives of a running computer," near-real-time inference is a prerequisite for any practical deployment. This addresses CFR MEDIUM-017.

**3.4 Formally apply the CNC conditions to NC_CLIGen and NC_GUIWorld**

Add a table (analogous to existing Table 13) that applies each of the four CNC conditions to the current prototypes and assesses whether they are satisfied, partially satisfied, or not yet demonstrated. This honest self-assessment would strengthen the paper by demonstrating that the authors understand the gap between current prototypes and the full NC vision. The paper defines the conditions but never applies them — a notable omission for a paper framed around a new evaluation framework.

**3.5 Consolidate and formalize the limitations discussion**

Add a standalone "Limitations" section consolidating the currently distributed limitation disclosures. Cover: open-loop-only evaluation; CLIGen character accuracy ceiling (54%); action density confound in the data quality finding; single-environment evaluation scope; symbolic stability gap; inference speed for interactive use. The distributed disclosures are a strength; a consolidated section makes them more easily findable by readers assessing validity.

### Opportunities for Extension

1. **Closed-loop stability scaling study**: Test how autoregressive performance degrades as a function of steps and model scale (Wan2.1 size vs. a smaller DiT backbone). A scaling law for NC autoregressive stability would be a foundational result for the field.

2. **SVG cursor supervision transfer**: Test whether the SVG supervision approach (binary mask + reference frame) generalizes to other pointing-device-intensive GUI tasks (text selection, drag-and-drop, scroll) and to other GUI simulation systems (including NeuralOS). A positive transfer result would establish SVG cursor supervision as a general contribution rather than a NC_GUIWorld-specific technique.

3. **NC_CLIGen practical application**: Demonstrate a concrete agent training use case for NC_CLIGen — for example, training a reinforcement learning agent within the NC_CLIGen simulation and measuring task completion on a real terminal. This would address the currently unaddressed question of whether terminal video simulation serves any practical agent training use case.

4. **Formal CNC condition verification**: Develop a structured benchmark for each of the four CNC conditions that could be applied to NC_CLIGen, NC_GUIWorld, NeuralOS, and GameNGen to formally map where each system stands on the NC research agenda. This would operationalize the NC/CNC framework as an evaluable specification rather than a conceptual proposal.

5. **Data quality mechanism experiment**: Subsample Random Fast data to match CUA's 0.10 actions/sec density and compare with the original CUA condition. This single control condition would determine whether the data quality advantage reflects goal-directedness or action sparsity — a key mechanistic question for the paper's design guidance claim.

---

*This report synthesizes evidence from Phases 1 through 7-0, including Phase-3-5 independent literature review (approximately 250 candidates, five papers read at Level 2-3), Phase-5-2 comparative analysis (10 reference papers), Phase-6 repository analysis, and Phase-7-0 Devil's Advocate review. All assessments are grounded in evidence from prior phases. CFR statistics at synthesis: 3 CRITICAL, 10 HIGH, 15 MEDIUM, 0 LOW findings.*
