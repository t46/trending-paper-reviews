# Critical Review: Neural Computers (arXiv:2604.06425)
# Phase 7-2 — Peer-Review-Style Critical Assessment

**Reviewer Perspective**: Senior researcher in video generation, interactive AI systems, and computer systems with familiarity with GameNGen, DIAMOND, NeuralOS, and the computer-use agent literature.

---

## Executive Summary

"Neural Computers" is an ambitious paper that proposes a new conceptual framework (the NC/CNC abstraction) for thinking about neural networks as computing substrates rather than agents, and presents two prototype systems: NC_CLIGen (CLI/terminal video simulation) and NC_GUIWorld (desktop GUI simulation). The paper is uneven across its components. The NC_CLIGen domain and the SVG cursor supervision training insight are genuinely novel and decisively validated contributions. The NC/CNC conceptual framework is a meaningful organizational contribution despite being a formal restatement of established formalisms. NC_GUIWorld, however, operates in a design space established by at least four uncited papers (GameNGen, DIAMOND, AVID, DWS), and the paper's central "runtime" framing is not supported by any closed-loop experiment.

Three findings rise to CRITICAL severity. First, the paper's defining claim — that the prototypes instantiate "early NC primitives of a running computer" with "persistent latent runtime state h_t" — is experimentally ungrounded: all 10 experiments use oracle-conditioned open-loop rollout, and the runtime state property is never tested. Second, the project blog confirms the authors are aware of GameNGen (ICLR 2025), the most directly comparable paradigm-establishing paper, yet GameNGen is absent from the paper body. Third, five individually significant attribution and citation gaps collectively form a systematic pattern of presenting NC as a paradigm originator rather than a domain extender with important conceptual contributions.

These CRITICAL concerns require substantial revision. The paper's genuine strengths are meaningful enough to justify publication after revision — the NC_CLIGen novelty, the SVG cursor finding, and the NC/CNC organizing framework are real contributions to a timely research direction. However, the paper in its current form makes paradigm-level claims that overstate what the experiments demonstrate and what the prior-work landscape supports.

**Final CFR Status: CRITICAL: 3, HIGH: 10, MEDIUM: 12, LOW: 0**

---

## Critical Questions About Research Excellence

### About the Contribution and Novelty

1. The paper claims NC_GUIWorld "demonstrates a pioneering paradigm for interactive OS simulation." Given that GameNGen (ICLR 2025) establishes the identical two-phase paradigm (RL/interaction data -> diffusion model fine-tuning for action-conditioned frame generation) for game simulation, and DIAMOND (NeurIPS 2024 Spotlight) demonstrates interactive diffusion simulation from fixed human gameplay data at ~10 FPS — how does the paradigm novelty claim survive without citation and engagement with these works? The project blog mentions GameNGen directly, establishing author awareness. What is the principled distinction between NC_GUIWorld and the GameNGen paradigm applied to OS/GUI?

2. The NC formalism (Eq. 2.1: h_t = F_theta(h_{t-1}, x_t, u_t); x_{t+1} ~ G_theta(h_t)) is mathematically equivalent to GameNGen's formal interactive environment definition (q(o_n|o_<n,a_<=n)) and DIAMOND's diffusion world model formulation. If the formalism is shared, what is the formal distinguishing criterion between an NC and a world model at the mathematical level? The four CNC conditions are stated but never formally applied to verify that GameNGen and DIAMOND fail them. Can a paper that does not attempt this verification credibly claim a new machine-form abstraction?

3. The GUIWorld data collection pipeline is confirmed (maintainer-confirmed, GitHub Issue #5) to derive from NeuralOS's codebase. Section 3.2.1 presents this pipeline as a paper contribution without attribution in the paper body. How does this affect the independence of the data engineering contribution claim? What fraction of the GUIWorld pipeline is original versus adapted?

4. For NC_CLIGen: Tables 2-4 track training progression from 3% to 54% character accuracy but include no zero-shot Wan2.1 baseline. Without knowing Wan2.1's performance on CLIGen data before fine-tuning, how can the paper claim that fine-tuning teaches the model CLI simulation rather than demonstrating Wan2.1's pre-existing video generation quality applied to terminal content?

5. The reprompting result (Figure 6: 4% to 83% arithmetic accuracy) is the paper's headline practical finding. Without a Wan2.1 + reprompting baseline, how can this be attributed to NC_CLIGen's fine-tuning rather than to Wan2.1's text-conditioned generation capability? NC_CLIGen is fine-tuned Wan2.1; its backbone's conditioning ability is the most parsimonious explanation for the reprompting gain.

### About the Methodology

6. Section 3.2.3 states "we tune only the action encoder and learning-rate schedule," but Section 3.2.2 describes the internal mode adding CA_action cross-attention sub-layers inside transformer blocks — newly initialized parameters that cannot be "pre-existing non-action components." No per-mode parameter count is reported. How can the injection depth hierarchy (internal > residual > contextual) be interpreted as testing injection architecture rather than parameter capacity?

7. The external injection mode was early-stopped at approximately 50% of the planned training budget "after preliminary rollouts did not warrant further compute." Presenting an undertrained external mode alongside three fully trained modes as an architectural ablation introduces a confound between architecture and training completeness. If external conditioning at a full training budget achieved performance comparable to contextual conditioning, the injection hierarchy claim would need revision. Why was the complete four-mode ablation not run?

8. The paper never applies the CNC four-condition specification to NC_CLIGen or NC_GUIWorld. If neither prototype satisfies the CNC conditions (which seems likely given the open-loop-only evaluation), are they NC primitives in any formally specified sense, or is the CNC framework merely aspirational for this paper?

### About the Experiments

9. The paper's central conceptual claim is not that NC_GUIWorld generates accurate video frames. The claim is that it instantiates "early NC primitives of a running computer" with "persistent latent runtime state h_t" maintained through self-generated outputs. Every experiment in the paper uses oracle ground-truth conditioning. The runtime state property — h_t evolving through the model's own generated outputs — is never exercised in any experiment. How does the paper support "NC primitive" claims with exclusively open-loop measurements?

10. NC_GUIWorld is the only interactive simulation system in its primary technical reference class (GameNGen, DIAMOND, NeuralOS) that includes no closed-loop demonstration. GameNGen demonstrates 5-minute stable autoregressive generation at 20 FPS with human rater study. DIAMOND demonstrates RL agent training in world model imagination and CS:GO interactive play at ~10 FPS. NeuralOS demonstrates 256-frame RNN state persistence in closed-loop sequences. What is the rationale for omitting closed-loop evaluation given that every directly comparable paper includes it?

11. Tables 10-11 (the injection mode ablation and meta-action encoding comparison) present architectural recommendations based on effect sizes that are estimated to be negligible to small (SSIM delta 0.006 and 0.016; estimated Cohen's d 0.06-0.40) with no variance reporting across any of the 10 experiments. How can architectural recommendations stand without any statistical validation? For comparisons this small, are the differences real or within experimental noise?

12. NC_GUIWorld's evaluation covers exactly the same 8 apps used for training. No out-of-distribution app is tested. NeuralOS demonstrates cross-app generalization; DIAMOND demonstrates across 26 Atari games. What evidence does the paper provide that NC_GUIWorld generalizes beyond its training distribution?

### About the Results and Claims

13. The "data quality over quantity" finding (Experiment 7) is presented as a generalizable design principle. However, CUA data has 0.10 actions/sec versus Random Fast's 4.18 actions/sec — a 42x action density difference. The FVD advantage could reflect sparse vs. dense action sequences rather than goal-directedness. The principle is stated as: "prioritize curated, purposeful interactions over large-scale passive data collection." But if action density is the mechanism, the principle should be: "prefer sparse interaction data." How does the paper rule out the action density confound?

14. NC_GUIWorld's absolute performance (FVD 14.72) has no reference point against any established comparable system. NeuralOS, GameNGen, DIAMOND all report their own metrics on different tasks, so direct comparison is difficult. But the paper does not attempt to benchmark its output quality against these systems even qualitatively. How does the reader assess whether FVD 14.72 represents good performance for OS simulation?

15. The paper claims conceptual superiority of NC over NeuralOS ("NC handles runtime responsibilities; NeuralOS simulates"). Yet NeuralOS's hierarchical RNN maintains O(1) per-timestep complexity and demonstrated 256-frame memory retention for OS-level state — concretely solving the long-horizon state persistence problem that NC_GUIWorld acknowledges as a future challenge. Does framing NC as conceptually superior while omitting that NeuralOS architecturally outperforms it on the defining property of persistent runtime state constitute an accurate comparative assessment?

### About Reproducibility

16. The captioning pipeline (Llama 3.1 70B generating three-tier captions from terminal buffers) is described as a mandatory step between CLIGen data collection and training, and Experiment 3 establishes it as a direct performance driver (5 dB PSNR across caption tiers). The repository contains no captioning script, no prompt template, and no documentation of this step. How can any NC_CLIGen training experiment be reproduced from the released code?

17. The episode packaging system is described in Appendix B and noted as "would be released" — but is absent from the repository. Combined with the missing captioning pipeline, users cannot proceed from raw data collection to any training experiment. Is the code release meaningful given these gaps?

---

## Concerns Affecting Research Excellence

### Contribution and Novelty Concerns

**Concern N-1 (CRITICAL — CFR HIGH-011, escalated Phase-7-0)**: NC_GUIWorld's paradigm novelty is substantially overstated. GameNGen (ICLR 2025), DIAMOND (NeurIPS 2024 Spotlight), AVID (ICLR 2025), and DWS (ICLR 2025) collectively establish the design space in which NC_GUIWorld operates: two-phase interaction data collection plus diffusion model training for action-conditioned frame generation, with per-frame and per-block action conditioning explored. All four are absent from the paper's citations. The author's separate blog post mentions GameNGen, confirming awareness. The injection mode ablation is presented as original design-space exploration when that design space is already published at ICLR 2025 (AVID, DWS). NC_GUIWorld's contribution is better characterized as the first systematic application of the established paradigm to the OS/GUI domain — a meaningful but qualitatively different claim from paradigm origination.

**Concern N-2 (CRITICAL — CFR-PATTERN-A, Phase-7-0)**: Five individually significant findings combine into a systematic pattern of paradigm positioning through selective attribution: (1) author-aware GameNGen omission from paper body; (2) NeuralOS receives one sentence while the GUIWorld data pipeline is confirmed to derive from NeuralOS's codebase; (3) NC formalism mathematically equivalent to GameNGen's formal definition without acknowledgment; (4) Related Work is approximately one page with most important competitors undercited or uncited; (5) CNC four conditions never applied to verify that existing systems fail them. The pattern creates a coherent presentation of NC as paradigm originator rather than domain extender with conceptual contributions. This is a scholarly integrity concern beyond individual editorial oversights.

**Concern N-3 (HIGH — CFR-026)**: NC_CLIGen's empirical claim — that fine-tuning on CLIGen data teaches the model to simulate CLI behavior — lacks the zero-shot Wan2.1 control required to attribute performance to fine-tuning rather than to Wan2.1's pretrained capabilities. Tables 2-4's training progression (3% to 54% character accuracy) documents improvement during fine-tuning but does not establish that the starting point (3%) was below Wan2.1's inherent CLIGen performance.

**Concern N-4 (HIGH — CFR HIGH-012)**: NeuralOS is described as "most closely related" in a single sentence while NC_GUIWorld is framed as conceptually superior. NeuralOS's hierarchical RNN demonstrably addresses the long-horizon state persistence challenge that is central to NC's "runtime" claim. The paper omits that NeuralOS concretely solves a problem NC_GUIWorld treats as future work, while the NC paper's code pipeline derives from NeuralOS's implementation.

**Concern N-5 (MEDIUM — CFR-014)**: The NC/CNC framework's claim to provide a new formal machine-form abstraction is weakened by the mathematical equivalence of Eq. 2.1 to GameNGen's and DIAMOND's formalisms, and by the absence of a formal proof that existing systems fail the four CNC conditions. The contribution is real as conceptual vocabulary but requires stronger formal differentiation.

### Technical Validity Concerns

**Concern T-1 (HIGH — CFR HIGH-003)**: The injection mode ablation's central finding is confounded by unequal parameter counts across modes. The internal mode adds CA_action sub-layers inside transformer blocks that must be randomly initialized and trained — new parameters inconsistent with the paper's claim that "only the action encoder and learning-rate schedule" are tuned. Without per-mode parameter counts, the architectural hierarchy (internal > residual > contextual on FVD) conflates injection depth with parameter capacity.

**Concern T-2 (MEDIUM — Pattern B from Phase-7-0)**: The injection mode ablation is simultaneously affected by four weaknesses: unequal parameter counts (HIGH-003), noise-level SSIM difference (CFR-007 MEDIUM), absent statistical validation (HIGH-009), and an underfitted anchor condition (external early-stopped at 50% budget, CFR-022 MEDIUM). The FVD-based hierarchy is the only credible finding from Table 10. The full four-mode recommendation should be treated as preliminary and directional, not definitive.

**Concern T-3 (MEDIUM — CFR-006)**: The data quality over quantity finding (Experiment 7) conflates goal-directedness with action density (42x difference in actions/sec between CUA and Random Fast). The practical recommendation is directionally robust, but the stated mechanism (goal-directedness) is unverified.

### Evidence and Rigor Concerns

**Concern E-1 (CRITICAL — CFR HIGH-004, escalated Phase-7-0)**: The paper's defining claim — "early NC primitives of a running computer" with "persistent latent runtime state h_t" — has zero experimental support. All 10 experiments use oracle-conditioned open-loop rollout. The NC-defining property (h_t evolving through self-generated outputs) is never measured. The paper's metrics (PSNR, SSIM, FVD, cursor accuracy) measure oracle-conditioned I/O alignment — empirically equivalent to what GameNGen and DIAMOND demonstrate under the label "simulation" that the NC framing claims to transcend. Disclosure of this limitation in Section 3.2.4 does not reduce severity: validity is measured by what the claim requires, not by what is acknowledged.

**Concern E-2 (HIGH — CFR HIGH-009)**: Systemic absence of statistical reporting across all 10 experiments. No table reports standard deviations, confidence intervals, or significance tests. No experiment uses more than one random seed. For small-effect results (Tables 10-11: SSIM deltas 0.006 and 0.016, estimated Cohen's d 0.06-0.40), the architectural recommendations cannot be confirmed as reflecting real performance differences rather than noise.

**Concern E-3 (HIGH — CFR-015, CFR-016)**: NC_GUIWorld is the only interactive simulation system in its primary reference class without any closed-loop demonstration or human perceptual evaluation. GameNGen, DIAMOND, and NeuralOS all provide closed-loop demonstrations; GameNGen includes a human rater study. This is a field-standard expectation the paper does not meet.

**Concern E-4 (HIGH — CFR-026, CFR-027)**: Two structurally required control conditions are absent: (a) zero-shot Wan2.1 on CLIGen data, required to attribute NC_CLIGen's performance to fine-tuning; (b) Wan2.1 with reprompting, required to attribute the 83% reprompting result to NC_CLIGen's NC-specific properties rather than to Wan2.1's text-conditioned generation.

**Concern E-5 (MEDIUM — CFR-005, CFR-010)**: The arithmetic probe result (4% NC_CLIGen vs. 0% Wan2.1, n=100) is statistically indistinguishable at the reported sample size — the Wilson CIs overlap. The reprompting result (83%, Figure 6) lacks a data table, stated sample size, and confidence interval — a lower documentation standard than all other nine experiments, applied to the paper's largest improvement figure.

### Completeness Concerns

**Concern C-1 (HIGH — CFR HIGH-001)**: The Related Work section is approximately one page embedded in Preliminaries — insufficient depth for a paper making paradigm-level claims. GameNGen, DIAMOND, AVID, and DWS are entirely absent. NeuralOS receives one sentence despite being the most architecturally comparable system operating in the same domain. OSWorld (NeurIPS 2024), the field-standard benchmark for computer-use evaluation, is not cited despite NC_GUIWorld's motivation as a computer-use training environment.

**Concern C-2 (HIGH — CFR-019, CFR-023)**: Two critical pipeline components are absent from the released repository: the captioning pipeline (Llama 3.1 70B generating three-tier captions from terminal buffers) and the episode packaging system. Together these prevent reproduction of any NC_CLIGen training experiment. The code release is incomplete for the paper's primary empirical contributions.

**Concern C-3 (HIGH — CFR-024)**: The NeuralOS code derivation for the GUIWorld pipeline is disclosed only in the repository README (added post-publication), not in the paper body where Section 3.2.1 presents the pipeline as a paper contribution. For a paper with ongoing paradigm originality claims, this gap compounds the attribution concerns.

**Concern C-4 (MEDIUM — CFR-017, CFR-018)**: Two practically important measurements are absent: NC_GUIWorld inference speed (all primary comparators report FPS; the paper never does), and an OSWorld task coverage analysis mapping NC_GUIWorld's 8-app scope to the field's standard 369-task benchmark. Without inference speed, practical interactive usability is unassessable. Without OSWorld coverage, the claim that NC_GUIWorld could serve as an agent training environment is unsubstantiated.

**Concern C-5 (MEDIUM — CFR MEDIUM-001, MEDIUM-002)**: The CLIGen Clean filtering criterion (retaining 51.21% of scripts) is undocumented, limiting reproducibility of Experiments 2-6. Temporal window parameters w and l for the contextual attention mask are given as formulas but not as numerical values.

### Presentation Concerns

**Concern P-1 (MEDIUM — CFR-013)**: The 39-figure appendix (Appendix E) contains exclusively positive-case outputs. No failure case gallery exists despite the paper explicitly acknowledging specific failure modes: text smear, cursor drift, spurious color changes, and task-level failure under multi-step interactions. The positive-only gallery, combined with the absence of statistical reporting, increases the risk that visual impressions overestimate typical performance. This is inconsistent with generative model evaluation norms.

**Concern P-2 (MEDIUM)**: Small-effect comparisons (Tables 10-11) are presented with the same visual format and narrative confidence as large-effect comparisons (Tables 8-9), creating an impression of parity in evidential strength that the effect sizes do not support. The paper acknowledges these gains are "modest" but does not clearly differentiate between the two evidential levels in its summary claims.

---

## Gaps Relative to Field Standards (from Phase-5-2 Comparative Analysis)

### Closed-Loop Evaluation Gap

This is the most significant field-standard gap. Phase-5-2 establishes that every interactive simulation paper in the primary reference class includes a closed-loop demonstration:
- GameNGen (ICLR 2025): 5-minute stable autoregressive generation at 20 FPS with human rater study (rater accuracy 0.58, near chance)
- DIAMOND (NeurIPS 2024 Spotlight): RL agent training in world model imagination; CS:GO human-interactive play at ~10 FPS
- NeuralOS (ICLR 2026): 256-frame RNN state memory in closed-loop interaction sequences

NC_GUIWorld is the only paper in this class with zero closed-loop evaluation. For a paper claiming "early NC primitives of a running computer," this gap is not a minor omission — it is the absence of the measurement most directly relevant to the central claim.

### External Comparator Gap

NC_GUIWorld reports 2 baselines: untrained Wan2.1 and an early-stopped external conditioning condition. No comparison is made against any established system (GameNGen, DIAMOND, NeuralOS, AVID, DWS). Phase-5-2 confirms: at least 4 of the 10 reference papers report performance against prior published systems. The paper's FVD 14.72 result has no interpretable reference point beyond its own training ablations.

### Statistical Reporting Gap

Phase-5-2 finds that 6 of the 10 reference papers report confidence intervals or multiple-seed results for key comparisons. NC reports none across any of its 10 experiments. This is a systemic gap below the current field standard for quantitative ML papers.

### Inference Speed Gap

GameNGen reports 20 FPS (single TPU), DIAMOND ~10 FPS (RTX 3090), NeuralOS 15 FPS. NC_GUIWorld never reports inference speed. Given that the paper's training required 64 GPUs for approximately 15 days, inference requirements are a legitimate practical concern the paper does not address.

### Human Evaluation Gap

GameNGen and Genie include human perceptual evaluations as standard practice for interactive simulation quality assessment. NC_GUIWorld includes no human evaluation. This is below the field standard for papers making "early NC primitive of a running computer" claims.

### Zero-Shot Baseline Gap

NC_CLIGen's Tables 2-4 lack a zero-shot Wan2.1 row — the minimum pre-fine-tuning baseline expected in any fine-tuning study. Without it, the training progression cannot be interpreted as demonstrating learning rather than measuring Wan2.1's inherent quality on terminal content.

---

## Novelty and Positioning Assessment (from Phase-3-5c)

Phase-3-5c verified novelty across approximately 250 literature candidates, with five papers read at Level 2-3 (GameNGen, DIAMOND, NeuralOS, AVID, DWS).

### Verified Novel Components (High Confidence)

- **NC_CLIGen domain**: No prior work on CLI/terminal video simulation identified across all candidates. Domain novelty is confirmed.
- **SVG cursor supervision**: Not anticipated by any of the five deeply-read papers. NeuralOS independently develops Gaussian spatial cursor encoding (confirming cursor precision as a recognized challenge), validating that the SVG approach is distinct and novel.

### Partially Novel Components (High Confidence)

- **NC/CNC conceptual framework**: New formal vocabulary and four-condition specification without direct precedent in competing papers. However, the h_t formalism is mathematically shared with GameNGen's formal definition. The distinction rests on natural language claims about "runtime responsibility" that are not formally proved.
- **NC_GUIWorld injection mode ablation**: The OS/GUI domain application with cross-attention internal conditioning is new; the design space was established by AVID (per-frame scale/shift) and DWS (per-block two-linear-layer modulation), both uncited. The contribution is "new domain application within established design space."

### Challenged Components (High Confidence)

- **NC_GUIWorld paradigm claim**: The core technical paradigm (interaction data -> diffusion model -> action-conditioned frame generation) is established by GameNGen (August 2024, ICLR 2025). The interactive implementation from fixed human data is demonstrated by DIAMOND (May 2024, NeurIPS 2024 Spotlight). Both papers predate NC_GUIWorld and are omitted from its citations despite the author's documented blog awareness of GameNGen. NC_GUIWorld's contribution relative to these precedents is domain extension and systematic ablation, not paradigm origination.

### Missing Critical Citations

The following papers are absent from NC's citations and are directly relevant:
- GameNGen (arXiv:2408.14837, ICLR 2025) — identical paradigm for games; author-aware omission
- DIAMOND (arXiv:2405.12399, NeurIPS 2024 Spotlight) — interactive diffusion from fixed human data
- AVID (arXiv:2410.12822, ICLR 2025) — per-frame action conditioning design space
- DWS (arXiv:2502.07825, ICLR 2025) — per-block modulation for video DiTs
- OSWorld (arXiv:2404.07972, NeurIPS 2024) — field-standard computer-use benchmark
- OSWorld task instructions — used without citation

---

## Devil's Advocate Findings (from Phase-7-0)

### Escalated to CRITICAL

**HIGH-004 -> CRITICAL**: The "running computer" / "NC primitive" framing is the paper's central differentiator from GameNGen, DIAMOND, and NeuralOS. Every experiment measures open-loop oracle-conditioned performance. The runtime state property that makes NC an NC (persistent state through self-generated inputs) has no experimental support. All 10 experiments are empirically equivalent to what GameNGen and DIAMOND demonstrate under "simulation." Disclosure of the limitation in Section 3.2.4 does not reduce severity.

**HIGH-011 -> CRITICAL**: Author awareness of GameNGen is confirmed via project blog. Paper body does not cite it. For a paper claiming NC_GUIWorld "demonstrates a pioneering paradigm," deliberate exclusion of the most directly comparable paradigm-establishing paper is a presentation choice affecting paradigm novelty assessment, not an editorial oversight.

**CFR-PATTERN-A (NEW CRITICAL)**: Five findings together — GameNGen awareness but omission, NeuralOS code derivation without paper-body attribution, mathematical equivalence of NC Eq. 2.1 to GameNGen's formalism without acknowledgment, 1-page related work, CNC conditions never applied to existing systems — constitute systematic paradigm positioning through selective disclosure. No individual finding is CRITICAL alone; combined they describe deliberate positioning, not isolated omissions.

### Downgraded from HIGH to MEDIUM

**HIGH-002 -> MEDIUM (LLM caption quality)**: CLIGen Clean (all controlled experiments, Experiments 2-6) uses scripted captions, not LLM-generated ones. LLM caption quality affects only CLIGen General and the caption tier ablation. The 5 dB PSNR gap may reflect semantic informativeness rather than factual accuracy.

**HIGH-007 -> MEDIUM (internal vs. residual SSIM)**: The FVD hierarchy (internal 14.5 < residual 18.8) is robust and points in the same direction as SSIM despite the noise-level SSIM difference. The "best trade-off" recommendation survives on FVD.

**CFR-021 -> MEDIUM (Sora2 configuration)**: The 71% vs. 4% gap is too large to be reversed by configuration variation. This is a presentation concern, not a validity issue.

**CFR-022 -> MEDIUM (external early-stopping)**: Explicitly disclosed; three fully trained modes are sufficient for the injection hierarchy finding.

### Newly Identified (Phase-7-0)

**CFR-026 (HIGH)**: Missing zero-shot Wan2.1 baseline in Tables 2-4 — structurally required to attribute NC_CLIGen's learned performance to fine-tuning rather than to Wan2.1's base capabilities.

**CFR-027 (MEDIUM)**: Missing Wan2.1 + reprompting baseline in Figure 6 — required to attribute the 83% reprompting result to NC_CLIGen's properties rather than Wan2.1's text-conditioned generation.

### Defense of the Paper (Phase-7-0)

The Phase-7-0 Devil's Advocate review also identified areas where prior phases were too harsh:

- Transparency about limitations (Section 3.2.4, Table 10 footnote, reprompting disclaimer) lends credibility to positive findings
- NC_CLIGen domain novelty survives all scrutiny and is the paper's strongest claim
- SVG cursor supervision is decisively confirmed (d > 5.0) and would be publishable independently
- Data quality finding is directionally robust even if the mechanism is unresolved
- Two complementary systems (CLI + GUI) under one framework exceeds the individual scope of GameNGen, DIAMOND, or NeuralOS

---

## Fundamental Limitations

### 1. Open-Loop-Only Evaluation Undermines Central Claim

The most fundamental limitation is the gap between what is measured and what is claimed. The paper claims "early NC primitives of a running computer" with "persistent latent runtime state." What is measured is oracle-conditioned I/O alignment — precisely what world models and game engines like GameNGen already demonstrate. The paper is transparent about this limitation (Section 3.2.4), which is commendable, but the framing of the results as NC evidence is not commensurate with the measurements.

Whether this limitation is inherent to the current prototype stage or to the approach is unclear. For a prototype paper, it is reasonable to present first-generation results without full CNC satisfaction. What is not reasonable is framing first-generation open-loop results as evidence of runtime primitives when the runtime property has never been tested.

### 2. Paradigm Boundary Unverifiable Without CNC Application

The NC/CNC framework's distinction between "computing" and "simulating" is stated in natural language and supported by a four-condition specification that is never formally applied to verify that NC_CLIGen or NC_GUIWorld satisfy them (or that GameNGen and DIAMOND do not). Without this application, the CNC four conditions function as a roadmap for future work rather than a formal specification distinguishing NC from world models. This is intellectually honest if framed correctly, but the paper's current framing implies the prototypes are already NC primitives rather than systems working toward CNC compliance.

### 3. Dual-System Breadth vs. Experimental Depth Tradeoff

Addressing both CLI and GUI simulation under one framework is a genuine contribution to paradigm generality. However, this breadth comes at the cost of experimental depth for each individual system. NC_CLIGen covers only one terminal emulator and font; NC_GUIWorld covers only the 8 training apps with no out-of-distribution test. DIAMOND demonstrates across 26 Atari games; NeuralOS demonstrates cross-app generalization. The breadth claim (two systems) and the depth of evidence per system are in tension.

### 4. State Persistence Architecture

NC_GUIWorld's attention-based state handling has quadratic complexity growth with context window length. NeuralOS's hierarchical RNN maintains O(1) per-timestep complexity and demonstrates 256-frame memory retention. For the long-horizon state persistence that defines a "running computer," NC_GUIWorld's current architecture faces a fundamental scalability challenge that NeuralOS's architecture addresses concretely. The paper identifies this as future work but does not characterize it as a fundamental limitation of the current design choice.

### 5. NC_CLIGen Practical Motivation Underspecified

The paper opens NC_CLIGen as a demonstration of neural computer primitives for the CLI paradigm. Whether terminal video simulation serves any practical use case — as an agent training environment, a novel form of computation, or otherwise — is not established. The reprompting result (83% arithmetic accuracy) is intriguing but is not connected to any concrete downstream application. The paper would be strengthened by articulating when and why NC_CLIGen would be preferable to a conventional terminal emulator or agent-based approach.

---

## Arguments FOR Publication (Strengths of the Paper)

### 1. Genuinely Novel Domain and Training Insight

NC_CLIGen occupies an unambiguously novel domain. Phase-3-5c found no prior work on CLI/terminal video simulation across approximately 250 candidates. The SVG cursor supervision insight (8.7% to 98.7% cursor accuracy, estimated Cohen's d > 5.0) is the paper's most decisively validated finding — a practical training engineering contribution with clear applicability to any video model applied to GUI environments. NeuralOS independently developing a different cursor supervision approach (Gaussian spatial encoding) confirms that cursor precision is a recognized challenge and validates the SVG approach as an independently discovered, distinct solution.

### 2. Timely and Important Research Direction

The NC framework addresses a genuinely important and timely question: whether neural networks can constitute computing substrates rather than interfacing with or simulating them. Phase-3-1: "Impact: potentially significant. Timeliness: Very high." The convergence of powerful video generation models, large-scale computer-use data, and frontier AI capabilities makes this question newly empirically tractable in 2025-2026. The paper correctly identifies that no prior work formalizes this specific problem at the conceptual level the CNC specification attempts.

### 3. Organizing Conceptual Framework

The NC/CNC four-condition specification provides new organizing vocabulary (Turing completeness, universal programmability, behavioral consistency, architectural advantage) that no reference paper anticipates. The framework performs useful analytical work: Table 13 compares four system types at a common level; Table 14 gives operational readings of each CNC requirement; Section 4's roadmap structures concrete research milestones. Whether the CNC conditions are formally distinguishable from interactive world model requirements is a legitimate concern, but the vocabulary itself structures the field usefully.

### 4. Large and Directionally Robust Empirical Findings

The paper's core empirical findings — SVG cursor supervision, data quality over quantity, caption tier effect, CLIGen training progression — all show large, decision-relevant effects that are robust to the statistical reporting gap. The data quality finding (110h CUA achieving FVD 14.72 vs. 1,400h random achieving FVD 48.17) provides actionable design guidance for future NC data collection regardless of whether the mechanism is goal-directedness or action density. These findings are meaningful contributions even if the statistical reporting should be improved.

### 5. Transparent Limitation Disclosure

The paper maintains consistent epistemic humility: the reprompting result is explicitly disclaimed as non-evidence of native arithmetic; Table 10's early-stop is disclosed in a footnote; Section 3.2.4 explicitly acknowledges open-loop-only evaluation; Section 4 is labeled "Position." This transparency lends the paper's positive findings additional credibility, as negative evidence is not suppressed.

### 6. Dual-System Scope

Having both NC_CLIGen (text-based) and NC_GUIWorld (graphical) under one framework, with 10 quantitative ablation experiments across two qualitatively different computing paradigms, provides more scope evidence for the NC research agenda than any single prior paper. The breadth demonstrates that the NC approach is not domain-specific to games (as GameNGen) or to graphical interfaces alone (as NeuralOS).

---

## Arguments AGAINST Publication in Current Form (Critical Concerns)

### 1. CRITICAL: "Runtime" Claim Has Zero Experimental Support

The paper's central conceptual claim — that the systems instantiate "early NC primitives of a running computer" with "persistent latent runtime state h_t" — is not supported by any experiment. The NC-defining property (h_t evolving through self-generated outputs, Eq. 2.1) is never tested. All reported metrics measure oracle-conditioned I/O alignment. This is empirically equivalent to what GameNGen calls "simulation." The paper's framing implies an experimental demonstration that its actual experiments do not provide. Without at least a minimal closed-loop evaluation, the distinction between "NC primitive" and "simulation" is purely verbal, not empirical.

### 2. CRITICAL: Author-Aware Citation Omission Misrepresents Paradigm State of the Art

The most directly comparable paradigm-establishing paper (GameNGen, ICLR 2025) is absent from the paper body despite the authors separately acknowledging it on their project blog. Three additional papers (DIAMOND, AVID, DWS) collectively establish the design space in which NC_GUIWorld operates. Their absence converts NC_GUIWorld's contribution from "domain extension of an established paradigm" to "pioneering paradigm origination" — a fundamentally different and factually unsupported claim category. A reviewer encountering a paper that claims to pioneer a paradigm while excluding the most directly comparable paradigm-establishing paper from its citations — with documented author awareness — will treat this as a presentation integrity issue.

### 3. CRITICAL: Systematic Attribution Pattern Across Five Findings

The five-finding pattern (GameNGen awareness but omission, NeuralOS one-sentence treatment despite code derivation, mathematical equivalence of NC Eq. 2.1 to GameNGen's formalism unacknowledged, 1-page related work, CNC conditions never applied to existing systems) is not an accumulation of editorial oversights. Each element contributes to a coherent presentation of NC as paradigm originator. Combined, they constitute a systematic misrepresentation of the paper's position in the prior-work landscape that a thorough reviewer would identify and flag as a scholarly integrity concern.

### 4. HIGH: No External Comparator for NC_GUIWorld

NC_GUIWorld's 2 baselines (untrained Wan2.1 and an undertrained external mode) are insufficient for a paper making technical contribution claims in a domain where multiple published systems exist. No comparison against NeuralOS (same domain, same OS, same data source), GameNGen, DIAMOND, AVID, or DWS is provided. The FVD 14.72 result has no interpretable reference point. A reviewer familiar with interactive simulation papers expects at least one comparison against a published system.

### 5. HIGH: Statistical Reporting Absent Across All Experiments

No variance measures appear in any of the paper's 10 experiment tables. For small-effect architectural recommendations (Tables 10-11), this absence means the recommendations cannot be confirmed as reflecting real performance differences. Architectural recommendations based on estimated Cohen's d of 0.06-0.40 without variance reporting are directional suggestions, not validated findings.

### 6. HIGH: Two Critical Pipeline Components Missing from Repository

The captioning pipeline and episode packaging system are absent from the repository, blocking reproduction of all NC_CLIGen training experiments. For a paper claiming contributions to data engineering methodology, an incomplete code release is a significant concern. The 42-page appendix documents what was built; the repository should implement it.

---

## Constructive Recommendations

### Critical Priority — Must Address Before Publication

**CR-1: Add Minimal Closed-Loop Evaluation**

Design a minimal Experiment 11: Closed-Loop Error Accumulation. On CLIGen Clean, run 100 scripted tasks for 5 autoregressive steps, feeding generated frames back as conditioning input rather than oracle frames. Report character accuracy degradation as a frame-by-frame curve. This single experiment would constitute the first evidence characterizing NC behavior under self-generated input — the property that distinguishes NC from simulation in the paper's own framing. Even a degradation curve showing rapid quality loss would be informative and honest; it does not need to show stability to be valuable. The 5-step horizon is achievable with existing infrastructure.

**CR-2: Add GameNGen, DIAMOND, AVID, DWS with Substantive Comparison**

Expand the Related Work section from approximately 1 page to a full standalone section (3-4 pages). For each of the four missing papers:
- State the technical paradigm they establish
- Identify specifically what NC_GUIWorld adopts, extends, or differs from
- Frame NC_GUIWorld's contribution as: "the first systematic application of the interactive video diffusion paradigm to the OS/GUI domain, with a systematic injection mode ablation extending the design space of AVID and DWS to the OS/GUI setting"

Additionally, acknowledge explicitly that NC's Eq. 2.1 formalism is mathematically equivalent to GameNGen's and DIAMOND's formal definitions, and explain the conceptual distinction in natural language with reference to the CNC four conditions.

**CR-3: Disclose NeuralOS Code Attribution in Paper Body**

Add a paragraph in Section 3.2.1 stating: "The GUIWorld data collection pipeline builds on and extends the NeuralOS [citation] data collection infrastructure, as acknowledged in the repository README." Per-file attribution comments should be added to files derived from NeuralOS's codebase. This brings the paper body into alignment with the README acknowledgment already added post-publication.

**CR-4: Add Zero-Shot Wan2.1 Baseline to Tables 2-4**

Add a single "Wan2.1 (zero-shot)" row to Tables 2-4 reporting the base model's CLIGen character accuracy and PSNR without any CLIGen fine-tuning. This converts a training progression observation into a fine-tuning attribution claim — the minimum required to demonstrate that CLIGen fine-tuning teaches the model CLI simulation.

**CR-5: Apply CNC Four Conditions to Both Prototypes and to GameNGen/DIAMOND**

Add a Table 12 (or equivalent) applying the four CNC conditions to NC_CLIGen, NC_GUIWorld, GameNGen, and DIAMOND. This formal application would (a) demonstrate that the CNC conditions perform real analytical work; (b) formally differentiate NC from world models at the specification level; (c) honestly characterize which CNC conditions the current prototypes satisfy and which remain as future work. If neither prototype satisfies the CNC conditions, the paper should say so explicitly and reframe the "NC primitive" claim as demonstrating progress toward specific CNC conditions rather than instantiating NC primitives.

### High Priority — Should Address

**HR-1: Report Per-Mode Parameter Counts and Add Capacity-Controlled Baseline**

Report trainable parameter counts for all four injection modes in a table accompanying Table 10. If the internal mode has substantially more parameters than the contextual mode, add a capacity-controlled contextual baseline — contextual conditioning with a randomly initialized parameter budget matched to internal mode's additional CA_action count. This isolates injection depth from parameter capacity.

**HR-2: Add Statistical Variance for Tables 10 and 11**

Run 2-3 random seeds for Tables 10 and 11. Report bootstrap 95% confidence intervals. For large-effect results (Tables 8, 9), bootstrap CIs from evaluation data would be sufficient without additional runs. This addresses the most consequential dimension of the systemic statistical gap: the small-effect architectural recommendations that currently cannot be distinguished from noise.

**HR-3: Add Wan2.1 + Reprompting Baseline to Figure 6**

Add a Wan2.1 (without CLIGen fine-tuning) + reprompting curve to Figure 6. If NC_CLIGen's 83% under reprompting substantially exceeds Wan2.1's reprompting performance, the NC-specific value of fine-tuning is demonstrated. If Wan2.1 achieves comparable reprompting performance, the result should be reframed as a capability of Wan2.1 enhanced by CLIGen fine-tuning, with appropriate implications for the "steerability as RL alternative" interpretation.

**HR-4: Release Captioning Pipeline and Episode Packaging System**

Implement and release the Llama 3.1 70B captioning pipeline including prompt templates, captioning configuration, and data format bridge between raw video outputs and training pairs. Implement and release the episode packaging system. These components are necessary to make the code release meaningful for reproduction of the paper's primary empirical claims.

**HR-5: Add Formal NeuralOS Comparison Section**

Add a Section 2.2 or equivalent: "Comparison with NeuralOS." Cover: (a) architectural comparison (RNN+renderer vs. DiT fine-tuning); (b) state persistence tradeoff — NeuralOS's O(1) RNN advantage vs. NC_GUIWorld's DiT visual quality advantage; (c) explicit acknowledgment that NeuralOS's hierarchical RNN architecture concretely addresses the long-horizon state persistence problem that NC_GUIWorld identifies as future work. Acknowledge that the code pipeline for GUIWorld data collection derives from NeuralOS.

**HR-6: Report NC_GUIWorld Inference Speed**

Add an inference speed measurement (frames per second on reference hardware) to the paper's experimental tables. Context: GameNGen 20 FPS, DIAMOND ~10 FPS, NeuralOS 15 FPS. Given NC_GUIWorld's training on 64 GPUs for ~15 days, inference requirements are a legitimate practical concern that readers and reviewers will need to assess practical feasibility claims.

**HR-7: Complete External Injection Mode Training**

Train the external injection mode to the full 64k-step budget and report as a fourth experimental condition rather than as a "baseline." This completes the four-mode ablation design the paper proposes and allows a clean architectural comparison unconfounded by training compute differences.

**HR-8: Document CLIGen Clean Filtering Criterion**

Describe the filtering criterion that retains 51.21% of CLIGen scripts as CLIGen Clean. This affects reproducibility of Experiments 2-6 and characterizes the distribution of the controlled evaluation set.

### Medium Priority — Would Strengthen

**MR-1: Add Failure Case Visualization Gallery**

Add a Section to Appendix E showing representative failure cases for both systems, consistent with the failure modes acknowledged in Section 3.2.5 (text smear, cursor drift, spurious color changes, multi-step interaction failures). A mixed success/failure gallery would demonstrate that the positive examples in Appendix E are representative rather than cherry-picked.

**MR-2: Add OSWorld Task Coverage Analysis**

Map NC_GUIWorld's 8-app evaluation scope to OSWorld's 369-task taxonomy and characterize coverage. Even a qualitative coverage table would substantially strengthen the claim that NC_GUIWorld could serve as a computer-use agent training environment.

**MR-3: Expand Arithmetic Probe Result Documentation**

Convert Figure 6 to a data table reporting: sample size, number of reprompting iterations, confidence intervals, and the Wan2.1 + reprompting comparison baseline (addressed in HR-3). The reprompting result is the paper's most practically significant finding; its documentation should meet the same standard as the nine numbered experiments.

**MR-4: Add Consolidated Limitations Section**

Consolidate the distributed limitation disclosures (Section 3.2.4, Table 10 footnote, reprompting disclaimer) into a single "Limitations" section. This improves discoverability for reviewers and readers who rely on the limitations section for calibration, and consolidates the paper's already-commendable transparency in one place.

**MR-5: Articulate NC_CLIGen Practical Motivation**

Add a brief discussion of when and why NC_CLIGen simulation would be preferable to a conventional terminal emulator or agent-based approach. The paper does not currently establish a clear practical motivation for terminal video simulation as a computing paradigm element versus as a demonstration of fine-tuning capability.

---

## What Would Most Enhance Research Excellence and Impact

### Top Recommendation: Reframe NC_GUIWorld's Contribution Accurately

The paper would be stronger — not weaker — if it reframed NC_GUIWorld as "the first systematic OS/GUI application of the interactive video diffusion paradigm, with a systematic injection mode ablation extending AVID and DWS to the OS/GUI domain." This framing: (a) is accurate and verifiable; (b) does not diminish the genuine contribution (novel domain application, systematic ablation, SVG cursor training); (c) eliminates the paradigm integrity concerns that are the paper's most damaging issues; (d) positions the NC/CNC framework as the paper's main conceptual contribution — which is where its strongest novelty lies. The NC/CNC framework is more compelling as a specification vocabulary for an emerging field than as a paradigm origin claim that the evidence does not support.

### Second Recommendation: Provide Any Closed-Loop Evidence

Adding even a single minimal closed-loop experiment (5 autoregressive steps, error accumulation measurement) would transform the paper's status from "claims NC runtime properties with zero closed-loop evidence" to "demonstrates NC runtime behavior with preliminary closed-loop characterization." The paper's framing of NC as distinct from simulation rests entirely on the runtime property; without any closed-loop measurement, this distinction is purely verbal. A 5-step degradation curve is achievable and would constitute genuine NC-specific evidence.

### Third Recommendation: Complete the Citation Set

Adding GameNGen, DIAMOND, AVID, DWS, and NeuralOS (with substantive comparison) would transform the paper from one that misrepresents the state of the art to one that makes a clearly valuable domain-extension contribution within an accurately characterized prior-work landscape. This is simultaneously the lowest-effort and highest-impact change available, as it requires writing rather than experimentation.

### Fourth Recommendation: Validate Architectural Recommendations Statistically

Running 2-3 seeds for Tables 10-11 would provide the minimum statistical grounding for the injection mode hierarchy and meta-action encoding recommendations — the paper's two secondary technical findings. Without this, these recommendations cannot be validated as reflecting real performance differences rather than noise.

### Fifth Recommendation: Release Complete Pipeline

Releasing the captioning pipeline and episode packaging system would make the code release meaningful for reproduction and for practitioners who want to build on NC_CLIGen's infrastructure — converting what is currently a partial release into a usable toolkit.

---

## Section-by-Section Feedback on Key Sections

### Section 2 (Related Work / Preliminaries)

**Current state**: Approximately one page embedded in the Preliminaries section. GameNGen, DIAMOND, AVID, DWS are entirely absent. NeuralOS receives one sentence. The NC formalism (Eq. 2.1) is not compared to the mathematically equivalent GameNGen formulation. OSWorld is not cited.

**What needs to change**: This section requires substantial expansion to a standalone Related Work section (3-4 pages). The section should characterize the interactive video diffusion paradigm established by GameNGen and DIAMOND, describe AVID and DWS's contributions to the injection mode design space, compare NC's formalism to existing world model formalisms, and explicitly acknowledge the NeuralOS code lineage. The section should be the authoritative evidence for how NC differs from prior work, not an abbreviated disclaimer.

### Section 3.1 (NC_CLIGen)

**Current state**: Technically sound, clearly written, with good experimental design (CLIGen General/Clean separation). The primary gap is the absence of a zero-shot Wan2.1 baseline in Tables 2-4, which prevents attribution of performance to fine-tuning. The reprompting result (Figure 6) is significantly underdocumented relative to all other experiments.

**What needs to change**: Add zero-shot Wan2.1 row to Tables 2-4. Convert Figure 6 to a data table with sample size, CIs, and the Wan2.1 + reprompting comparison. Describe the CLIGen Clean filtering criterion. Add per-step parameter count for the number of additional tokens generated.

### Section 3.2 (NC_GUIWorld)

**Current state**: The technical implementation is sound; the SVG cursor finding is decisive. The injection mode ablation is the primary technical contribution but is confounded by unequal parameter counts, absent statistical validation, and an undertrained external mode anchor. Section 3.2.3 contains an internal contradiction about which parameters are tuned.

**What needs to change**: Report per-mode parameter counts and add a capacity-controlled baseline. Complete the external mode training. Report inference speed. Add a formal NeuralOS comparison with explicit acknowledgment of NeuralOS's state persistence advantage. Correct the Section 3.2.3 contradiction about tuned parameters. Add statistical variance for Tables 10-11.

### Section 3.2.4 (Limitations)

**Current state**: The paper discloses the open-loop limitation directly, which is commendable. The disclosure is appropriate in tone and content.

**What needs to change**: The disclosure reduces the deception risk but does not reduce the validity concern — the runtime claim requires closed-loop evidence regardless of whether the gap is disclosed. The section should be expanded into a standalone Limitations section and should acknowledge: the parameter count confound in the injection ablation, the absent zero-shot baseline, and the NeuralOS architectural advantage. The open-loop disclosure should explicitly state that without closed-loop evaluation, the distinction between "NC primitive" and "simulation" is not empirically established.

### Section 4 (Position: Toward CNC)

**Current state**: Clearly labeled as "Position" — appropriate epistemic signaling. The four CNC conditions are well-specified. The roadmap connects concretely to research gaps.

**What needs to change**: Apply the CNC conditions formally to NC_CLIGen and NC_GUIWorld to determine which conditions they currently satisfy, partially satisfy, or do not satisfy. This formal application would strengthen Section 4 by grounding the roadmap in the current systems' known gaps. Apply the conditions to GameNGen and DIAMOND to formally demonstrate differentiation.

### Appendix E (Visualization Gallery)

**Current state**: 39 figures of exclusively positive outputs across both systems.

**What needs to change**: Add representative failure cases for text smear, cursor drift, spurious color changes, and multi-step failures as acknowledged in Section 3.2.5. A mixed gallery is standard practice and expected by reviewers evaluating generative model papers.

---

## Two-Layer Analysis: Current State and Development Directions

### Layer 1 — Current State

The paper in its current form makes three categories of claims:

1. **Well-supported claims** (NC_CLIGen domain novelty, SVG cursor supervision, data quality over quantity, caption tier effect, CLIGen training progression): These are credible, decisively validated, and constitute genuine contributions to the field. They would be publishable as a focused paper on NC_CLIGen and cursor supervision methodology.

2. **Directional but statistically unvalidated claims** (injection mode hierarchy beyond FVD, meta-action encoding advantage, data quality mechanism as goal-directedness): These point in a plausible direction but lack statistical grounding. They provide research guidance rather than validated findings.

3. **Claims that outrun the evidence** ("early NC primitives of a running computer," "pioneering paradigm for interactive OS simulation," NC_GUIWorld as runtime rather than simulation): These claims require either substantially more evidence (closed-loop evaluation, formal CNC application) or accurate reframing to match what the experiments actually demonstrate.

### Layer 2 — Development Directions

For the paper to reach a state where its claims match its evidence, the following changes are essential:

- **Reframe NC_GUIWorld's contribution**: Domain extension of established paradigm, not paradigm origination. Cite GameNGen, DIAMOND, AVID, DWS with substantive comparison.
- **Provide closed-loop evidence**: At minimum, a 5-step autoregressive experiment establishing NC's behavior under self-generated conditioning.
- **Disclose NeuralOS code derivation in paper body**: Align paper body with repository README.
- **Add zero-shot baseline**: Allow attribution of NC_CLIGen's performance to fine-tuning.
- **Provide statistical validation**: For architectural recommendations that rest on small effect sizes.
- **Complete pipeline release**: Make code release functionally meaningful.

With these changes, the paper would represent a strong contribution to a nascent but important research direction — grounded in what its experiments actually demonstrate, positioned accurately within the prior-work landscape, and providing the empirical infrastructure for others to build on.
