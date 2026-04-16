# Improvement Roadmap: Neural Computers (arXiv:2604.06425)
# Phase 8-1 — Prioritized Improvement Recommendations

---

## Executive Summary

**Total Issues Consolidated**: 28 distinct issues (3 CRITICAL, 10 HIGH, 15 MEDIUM)

**Priority Breakdown**:
- Critical (Must Address): 5 improvement actions addressing 3 CRITICAL CFR findings
- High Impact (Should Address): 9 improvement actions addressing 10 HIGH CFR findings
- Recommended (Could Address): 9 improvement actions addressing remaining HIGH and MEDIUM findings
- Optional Enhancements: 5 items addressing LOW-impact polish issues

**Top 5 Most Impactful Improvements (in order)**:
1. Add minimal closed-loop experiment — the only action that can validate the paper's central NC-primitive claim
2. Add GameNGen, DIAMOND, AVID, DWS citations and reframe paradigm contribution — resolves the paper's most serious scholarly integrity concern
3. Add NeuralOS paper-body attribution and formal comparison — closes the attribution pattern; adds substantive technical comparison
4. Add zero-shot Wan2.1 baseline to NC_CLIGen tables — converts uninterpretable training curves into evidence of fine-tuning benefit
5. Add statistical variance reporting for Tables 10-11 — elevates directional architectural recommendations to validated findings

**Estimated Overall Revision Effort**:
- Minimum viable revision (Tier 1 + Tier 2): 4–8 weeks of focused work
- Comprehensive revision (all tiers): 3–4 months including new training runs

---

## Two-Layer Analysis: Overall Paper State

**Current State (Layer 1)**: The paper makes three categories of claims supported by three different evidential levels. Well-supported claims (NC_CLIGen domain novelty, SVG cursor supervision, data quality over quantity, caption tier effect) rest on large effects with clear experimental design. Directional but statistically unvalidated claims (injection mode hierarchy, meta-action encoding advantage) provide useful guidance but cannot be confirmed as real differences without variance reporting. Claims that outrun the evidence (NC-primitive framing, pioneering paradigm origination) rely on experimental measurements that do not test the claimed properties or on a paradigm positioning that omits the directly comparable prior work.

**Development Directions (Layer 2)**: The paper can be substantially strengthened with revisions that fall into two categories: (a) writing-only changes (citation additions, reframing, attribution disclosure, documentation) that require no new experiments and address the paradigm positioning and attribution concerns; (b) targeted new experiments (minimal closed-loop evaluation, zero-shot baseline, multi-seed runs) that validate the paper's most important quantitative claims. The genuine strengths — NC_CLIGen novelty, SVG cursor supervision, data quality finding — are durable and would survive even the most rigorous revision intact.

---

## Improvement Roadmap Overview

```
TIER 1 — CRITICAL (Do First, prerequisite for submission integrity)
  ├── R1: Add closed-loop experiment (new experiment required)
  ├── R2: Add GameNGen/DIAMOND/AVID/DWS citations + reframe (writing-only)
  ├── R3: Disclose NeuralOS code attribution in paper body (writing-only)
  ├── R4: Add zero-shot Wan2.1 baseline to Tables 2-4 (new evaluation run)
  └── R5: Apply CNC four conditions to NC prototypes and existing systems (writing + analysis)

TIER 2 — HIGH IMPACT (Address before final submission)
  ├── R6: Report per-mode parameter counts; add capacity-controlled baseline
  ├── R7: Run 2-3 seeds for Tables 10-11; add bootstrap CIs for Tables 3 and 8
  ├── R8: Add Wan2.1 + reprompting baseline to Figure 6
  ├── R9: Release captioning pipeline and episode packaging system
  ├── R10: Add formal NeuralOS comparison subsection
  ├── R11: Report NC_GUIWorld inference speed (FPS)
  └── R12: Expand Related Work to standalone section

TIER 3 — RECOMMENDED (Strengthen before camera-ready)
  ├── R13: Complete external injection mode training to full budget
  ├── R14: Add action density-controlled condition to Table 8
  ├── R15: Add failure case visualization gallery to Appendix E
  ├── R16: Add OSWorld task coverage analysis
  ├── R17: Convert Figure 6 to data table with sample size and CIs
  ├── R18: Evaluate arithmetic probe on full 1,000-problem pool
  └── R19: Document CLIGen Clean filtering criterion

TIER 4 — OPTIONAL ENHANCEMENTS
  ├── R20: Add S-slot ablation for meta-action encoder
  ├── R21: Add hyperparameter table to Appendix D
  ├── R22: Add performance gap analysis paragraph for NC_CLIGen 54% ceiling
  ├── R23: Evaluate NC_GUIWorld zero-shot on one additional visual theme
  └── R24: Add consolidated Limitations section
```

**Dependency Map**:
- R1 (closed-loop experiment) can be done independently
- R2 and R3 are writing-only and independent; R3 should be done before final submission and alongside R2 for coherence
- R4 (zero-shot Wan2.1 baseline) requires one model evaluation run; independent of all other new experiments
- R5 (CNC conditions application) is writing-only and best done after R2 is drafted, so the formal analysis is contextualized against the complete prior-work landscape
- R6 (parameter counts) is writing-only for the reporting part; the capacity-controlled baseline is a new training run that can proceed in parallel with R7
- R7 (multi-seed runs) is the highest-compute item in Tier 2; can be started immediately in parallel with all writing-only tasks
- R8 (Wan2.1 + reprompting baseline) is a single evaluation run; independent
- R9 (repository release) is code engineering; independent
- R10 (NeuralOS comparison) should be done after R3 and after reviewing NeuralOS in full
- R13 (complete external mode training) is a continuation of an existing training run; highest feasibility in Tier 3
- R14 (density-controlled condition) reuses existing Random Fast data; no new collection needed
- R17 and R18 are writing and evaluation tasks using existing data; easy to do together

---

## Tier 1: Critical Improvements (Must Address)

---

### R1: Add Minimal Closed-Loop Evaluation

**Category**: Experimental Design / Evidence
**CFR Source**: HIGH-004 → CRITICAL (escalated Phase-7-0)
**Effort Required**: New experiment (moderate compute)
**Effort Estimate**: 1–2 weeks of experiment time; 1 day of writing

**Problem Statement**:
The paper's defining claim is that NC_GUIWorld and NC_CLIGen instantiate "early NC primitives of a running computer" with "persistent latent runtime state h_t." Equation 2.1 defines this as h_t evolving through the model's own generated outputs. Every one of the paper's 10 experiments instead provides oracle ground-truth conditioning at each step. The NC-defining runtime property — self-referential state evolution — is never tested. The paper's Section 3.2.4 explicitly acknowledges this as a limitation, but disclosure does not reduce the evidential gap: a claim requires measurement proportionate to what it asserts, not acknowledgment of the gap between claim and measurement.

All 10 experiments are empirically equivalent to what GameNGen and DIAMOND demonstrate under the "simulation" label the NC framing claims to transcend. The paper's choice to frame the results as "NC primitive" evidence rather than "simulation" evidence is a framing claim, not an empirical one.

**Why It Matters**:
Every directly comparable paper in the primary reference class (GameNGen, DIAMOND, NeuralOS) provides closed-loop demonstration as standard practice. Reviewers familiar with these papers will immediately identify the absence. More importantly, without any closed-loop measurement, the paper cannot empirically distinguish between "NC primitive" and "world model" at any operational level. The paper's title, abstract, and central claim all depend on this distinction.

**Recommended Improvement**:
Add a minimal Experiment 11 "Closed-Loop Error Accumulation" using the best-performing NC_CLIGen configuration (internal conditioning, CLIGen Clean, semantic captions). Design: 100 scripted CLI tasks; 5–10 autoregressive steps feeding the model's generated frames back as conditioning input for the next step rather than ground-truth frames. Measure character accuracy at each step (steps 1–5 or 1–10). Report a frame-by-frame accuracy degradation curve against the oracle-conditioned baseline.

This minimal experiment does not require new data collection, new model training, or new infrastructure — it requires changing the evaluation loop to substitute generated frames for oracle frames. The result — whether character accuracy degrades gracefully or collapses rapidly — is scientifically informative in either direction. A graceful degradation curve (e.g., 54% → 48% → 43% over 5 steps) would constitute the paper's first empirical evidence for partial NC primitive behavior. A rapid collapse (54% → 10% → near-zero) would accurately characterize the current prototype's limitations while establishing the measurement framework for future work.

Even 5 autoregressive steps with a reported accuracy curve would be the first evidence anywhere in the paper that the NC runtime property has been exercised at all.

**Expected Outcome**:
The paper's central claim moves from ungrounded assertion to at least partially empirically characterized. The "early NC primitive" framing becomes defensible as a characterization of a system that maintains some accuracy under self-conditioned rollout, even if performance degrades. The result also provides a concrete research target (increasing autoregressive step count while maintaining accuracy above threshold) that strengthens Section 4's roadmap.

**Dependencies**: None — can be started immediately.

---

### R2: Add Citations and Reframe NC_GUIWorld Paradigm Contribution

**Category**: Contribution and Novelty / Citation
**CFR Source**: HIGH-011 → CRITICAL (escalated Phase-7-0); CFR-PATTERN-A (CRITICAL)
**Effort Required**: Writing-only
**Effort Estimate**: 2–3 days of writing; requires careful positioning language

**Problem Statement**:
Four papers peer-reviewed at ICLR 2025 and NeurIPS 2024 Spotlight directly establish the technical design space in which NC_GUIWorld operates, and are entirely absent from the paper's citations:
- GameNGen (arXiv:2408.14837, ICLR 2025, August 2024): establishes the two-phase interaction-data to diffusion-model paradigm; author awareness confirmed via project blog
- DIAMOND (arXiv:2405.12399, NeurIPS 2024 Spotlight, May 2024): demonstrates the identical paradigm from fixed human gameplay data at ~10 FPS
- AVID (arXiv:2410.12822, ICLR 2025, October 2024): establishes per-frame scale/shift action conditioning for pretrained video diffusion models — the same design problem as NC_GUIWorld's injection mode ablation
- DWS (arXiv:2502.07825, ICLR 2025, February 2025): establishes per-block two-linear-layer scale-shift modulation for video DiTs — the direct design precedent for the internal injection mode

The project blog separately acknowledges GameNGen, establishing that the omission is a presentation decision rather than a knowledge gap. A reviewer who encounters a paradigm-origination claim and then recognizes that the paradigm-establishing paper is absent — with documented author awareness — will treat this as a scholarly integrity concern that supersedes the paper's technical merits.

**Why It Matters**:
This is the most damaging issue in the paper from a reception standpoint. The paper currently claims NC_GUIWorld "demonstrates a pioneering paradigm for interactive OS simulation." With GameNGen and DIAMOND in the citation set, the correct characterization is "first systematic application of the established GameNGen/DIAMOND paradigm to OS/GUI computing environments." These are qualitatively different contribution claims. The second claim is honest and meaningful; the first is not supportable given the prior-work landscape.

The injection mode ablation (presented in the paper as original design-space exploration) is incremental exploration within a design space established by AVID and DWS, without this context. Adding the citations transforms the narrative from "we created this design space" to "we systematically explored this design space for a new domain" — an accurate and still valuable contribution.

**Recommended Improvement**:
(a) Add GameNGen, DIAMOND, AVID, and DWS as citations with substantive characterization in the Related Work section. For each paper, one to three sentences identifying: what paradigm it establishes, how it overlaps with NC_GUIWorld, and what NC_GUIWorld contributes that goes beyond the prior paper.

(b) Revise the NC_GUIWorld contribution statement to: "NC_GUIWorld is the first systematic application of the action-conditioned diffusion simulation paradigm (GameNGen, DIAMOND) to desktop GUI computing environments, with a comprehensive four-mode action injection ablation extending the design space established by AVID and DWS."

(c) Reframe Section 2.1 into an expanded Related Work section (see R12) with three clear subsections: action-conditioned video simulation (GameNGen, DIAMOND), action injection design for video DiTs (AVID, DWS), and OS/GUI neural simulation (NeuralOS).

(d) In the introduction, remove or qualify "pioneering paradigm" language applied to NC_GUIWorld's technical design. The NC/CNC conceptual framework can retain its originality claim — that is genuinely new.

**Expected Outcome**:
The paper accurately represents its position in the prior-work landscape. NC_GUIWorld's contribution is repositioned to a claim that is well-supported by the evidence: domain extension, systematic ablation, and data engineering in an established paradigm space. The citation set is complete. A reviewer familiar with GameNGen and DIAMOND will find the paper's claims defensible rather than misleading.

**Dependencies**: Inform R3, R5, and R10.

---

### R3: Disclose NeuralOS Code Attribution in Paper Body

**Category**: Contribution and Novelty / Attribution
**CFR Source**: CFR-024 (HIGH); CFR-PATTERN-A (CRITICAL)
**Effort Required**: Writing-only
**Effort Estimate**: Half a day

**Problem Statement**:
The GUIWorld data collection pipeline is presented in Section 3.2.1 as a paper contribution. Repository Issue #5 (confirmed post-publication by a maintainer) establishes that the pipeline derives from NeuralOS's codebase. This derivation is disclosed in the repository README but not in the paper body. For a paper that makes paradigm-level contribution claims, and where the five-finding attribution pattern has already been identified as a CRITICAL concern, locating this disclosure only in the repository while the paper body presents the pipeline as original work creates a discrepancy that a researcher reading only the paper cannot resolve.

**Why It Matters**:
This is the easiest single item to address and one of the most impactful for the paper's scholarly credibility. It does not require any new experiments, new analysis, or restructuring of the paper's narrative. A one-to-two sentence attribution statement in Section 3.2.1 fully resolves CFR-024 and eliminates one of the five components of CFR-PATTERN-A. Attribution of prior code in the paper body is standard academic practice in any system-building paper.

**Recommended Improvement**:
Add to Section 3.2.1, in the paragraph describing the GUIWorld data collection pipeline: "Our pipeline builds on the GUI interaction recording infrastructure from NeuralOS [cite]; we adapted [component names] for our OS/GUI data collection workflow and [what was added or changed]." Update the repository's derived files to include per-file attribution comments consistent with NeuralOS's license terms.

This change is fully additive — it does not require removing any existing claim, only contextualizing the claim with accurate attribution.

**Expected Outcome**:
Section 3.2.1 accurately represents which parts of the pipeline are original to NC and which derive from prior work. CFR-024 is resolved. One component of CFR-PATTERN-A is eliminated, weakening the systematic attribution pattern concern.

**Dependencies**: R2 should be completed in parallel for coherence of the attribution narrative.

---

### R4: Add Zero-Shot Wan2.1 Baseline to NC_CLIGen Tables

**Category**: Experimental Design / Evidence
**CFR Source**: CFR-026 (HIGH, added Phase-7-0)
**Effort Required**: New evaluation run (low compute)
**Effort Estimate**: 1–2 days of compute and writing

**Problem Statement**:
Tables 2-4 document NC_CLIGen's training progression from 3% to 54% character accuracy. The starting-point 3% character accuracy is the fine-tuning epoch-1 measurement, not Wan2.1's zero-shot performance on CLIGen data. Without knowing Wan2.1's inherent performance on terminal video content before any fine-tuning, the training progression tables cannot establish whether fine-tuning teaches the model CLI simulation versus demonstrating Wan2.1's pretrained visual generation quality applied to terminal content.

This is the structurally required control condition for any fine-tuning study: the pretrained model evaluated on the target domain before any task-specific training. Its absence is not a minor gap — it means the paper's most important tables cannot support the attribution they are presented to support.

**Why It Matters**:
The zero-shot baseline is the minimum standard for a fine-tuning study. Without it, a reviewer will ask: "How do we know the improvement from 3% to 54% reflects fine-tuning rather than Wan2.1's pre-existing capabilities?" The correct answer — running Wan2.1 zero-shot on CLIGen evaluation data — takes one model evaluation run. If Wan2.1 scores near 0% zero-shot, the fine-tuning benefit is decisively established. If Wan2.1 scores near 3%, the training curve represents learning rather than measurement noise. Either result is informative.

**Recommended Improvement**:
Evaluate Wan2.1 (no fine-tuning) on the CLIGen Clean evaluation set using the same evaluation protocol as Tables 2-4 (PSNR, SSIM, FVD, character accuracy, exact-line accuracy). Add a "Wan2.1 (zero-shot)" row to Tables 2-4. This single row — requiring one evaluation pass with no training — resolves the attribution gap for all five metrics across all three tables.

Additionally, add a "Wan2.1 (zero-shot)" row to Table 5 (arithmetic probe) if not already present, to enable the fine-tuning benefit comparison for NC_CLIGen's reasoning capability claim.

**Expected Outcome**:
Tables 2-4 become interpretable as fine-tuning benefit evidence rather than training progression logs. The paper's claim that "fine-tuning on CLIGen data teaches the model CLI simulation" becomes empirically supported. CFR-026 is resolved.

**Dependencies**: None — single evaluation run. Can start immediately.

---

### R5: Apply CNC Four Conditions to NC Prototypes and Existing Systems

**Category**: Contribution and Novelty / Methodology
**CFR Source**: CFR-014 (MEDIUM); CFR-PATTERN-A (CRITICAL component)
**Effort Required**: Writing and analysis
**Effort Estimate**: 1–2 days of writing

**Problem Statement**:
The CNC four conditions (Turing completeness, universal programmability, behavioral consistency, architectural advantage) are the paper's formal specification distinguishing NC from world models and game engines. However, the paper never applies these conditions to verify that: (a) NC_CLIGen and NC_GUIWorld satisfy or approach the conditions, and (b) GameNGen and DIAMOND do not satisfy them. Without this application, the CNC conditions function as aspirational goals rather than a formal specification that places NC in a distinct machine-form category. The NC formalism (Eq. 2.1) is also mathematically equivalent to GameNGen's formal definition, which is unacknowledged.

**Why It Matters**:
A formally-oriented reviewer will ask: "What is the formal distinguishing criterion between an NC and a world model?" The current answer is natural language rather than formal application of the stated four conditions. This is a tractable writing problem. The application of the four conditions to existing systems — even informally, in tabular form — would demonstrate that the conditions impose substantive requirements, and that existing systems fail at least some of them, while NC prototypes partially satisfy others. Table 13 in the paper already takes a step in this direction; it needs to be made explicit.

**Recommended Improvement**:
Add a Section 2.3 or Table 2b "Formal CNC Condition Analysis" that applies each of the four CNC conditions to: NC_CLIGen (current state), NC_GUIWorld (current state), GameNGen, DIAMOND, and NeuralOS. For each (system, condition) pair, provide a brief justification: Satisfied / Partially Satisfied / Not Satisfied, with evidence. Acknowledge that Eq. 2.1 is mathematically equivalent to interactive world model definitions and that the distinction is at the four-condition level. Show specifically which conditions GameNGen and DIAMOND fail (likely: Turing completeness, machine-native semantics) and which NC_CLIGen and NC_GUIWorld approach or partially satisfy.

**Expected Outcome**:
The CNC framework's formal contribution is established by demonstration rather than assertion. The distinction between NC and world models is operationalized. CFR-014 is resolved. One component of CFR-PATTERN-A (CNC conditions never applied to verify existing systems fail) is eliminated.

**Dependencies**: Best done after R2 is drafted, so the analysis is contextualized against the complete prior-work landscape.

---

## Tier 2: High-Impact Improvements (Should Address)

---

### R6: Report Per-Mode Parameter Counts and Add Capacity-Controlled Baseline

**Category**: Methodology / Experimental Design
**CFR Source**: HIGH-003
**Effort Required**: Writing (parameter count reporting) + new training run (capacity baseline)
**Effort Estimate**: 1 day for reporting; 2-4 weeks for capacity-controlled training run

**Current State**: The injection mode ablation's central recommendation (internal > residual > contextual on FVD) is confounded by unequal trainable parameter counts. The internal mode adds CA_action cross-attention sub-layers — newly initialized parameters — while the paper claims only the action encoder and learning-rate schedule are tuned. No per-mode parameter count is reported.

**Development Direction**:
(a) Immediately report per-mode parameter counts in Table 10's caption or in a new Appendix column. This is a writing-only change that partially resolves the confound by allowing readers to assess its magnitude. If the additional parameters are small (e.g., less than 1% of backbone), the capacity confound is minor. If they are large, the confound is serious.

(b) Add a capacity-controlled contextual baseline: train the contextual mode with randomly initialized parameters matching the parameter count of internal mode's CA_action sub-layers. If this capacity-matched contextual mode still underperforms internal, injection depth explains the difference. This controls for the confound directly.

**Expected Outcome**: The injection mode ablation's architectural conclusions are elevated from "confounded recommendation" to "validated architectural finding."

---

### R7: Run Multiple Seeds for Tables 10-11; Add Bootstrap CIs for Tables 3 and 8

**Category**: Statistical Rigor
**CFR Source**: HIGH-009
**Effort Required**: New training runs (Tables 10-11); bootstrap computation from existing data (Tables 3 and 8)
**Effort Estimate**: 3-6 weeks for 2-3 seed runs of Tables 10-11; 1 day for bootstrap CIs

**Current State**: No variance measures appear in any of the 10 experiment tables. For Tables 10-11 specifically, where effect sizes are estimated at Cohen's d of 0.06-0.40 (negligible to small), the architectural recommendations cannot be confirmed as real differences versus experimental noise. The internal vs. residual SSIM delta of 0.006 (d approximately 0.06-0.15) is almost certainly within noise at a single seed.

**Development Direction**:
(a) Run 2-3 random seeds for Tables 10 and 11 and report mean ± SD for all metrics. This is the most important statistical addition and directly determines whether the internal vs. residual SSIM distinction is real. FVD results (d > 0.5) will likely survive; SSIM results may show overlap.
(b) Report bootstrap 95% CIs across evaluation clips for Tables 3 and 8 — computable from existing data without new training.
(c) At minimum, report evaluation sample sizes (number of evaluation clips) for all tables currently lacking them, enabling readers to compute approximate standard errors.

**Expected Outcome**: The architectural hierarchy claims become statistically grounded. If multi-seed runs confirm the FVD hierarchy while showing SSIM differences within noise, the paper can accurately state "internal conditioning achieves best FVD trade-off across seeds" while noting the SSIM advantage is not statistically reliable.

---

### R8: Add Wan2.1 + Reprompting Baseline to Figure 6

**Category**: Experimental Design / Evidence
**CFR Source**: CFR-027 (MEDIUM)
**Effort Required**: New evaluation run (low compute)
**Effort Estimate**: 1-2 days

**Current State**: Figure 6 reports NC_CLIGen + reprompting achieving 83% arithmetic accuracy — the paper's largest improvement finding. Since NC_CLIGen is a fine-tuned variant of Wan2.1, and reprompting leverages text-conditioned generation ability, the 83% result could reflect Wan2.1's base reprompting capability applied to terminal content rather than an NC-specific property.

**Development Direction**:
Add a Wan2.1 (zero-shot) + reprompting condition to Figure 6. Evaluate base Wan2.1 on the same arithmetic probe with the same reprompting protocol. If Wan2.1 + reprompting substantially underperforms NC_CLIGen + reprompting, the fine-tuning benefit for reprompting-assisted performance is established. If they perform comparably, the 83% result is attributable to Wan2.1's base capabilities, and the paper's interpretation should be revised accordingly.

**Expected Outcome**: The paper's headline reprompting result is accurately attributed — either to NC_CLIGen-specific learning or to Wan2.1's base conditioning capacity. CFR-027 is resolved.

---

### R9: Release Captioning Pipeline and Episode Packaging System

**Category**: Reproducibility
**CFR Source**: CFR-019 (HIGH), CFR-023 (HIGH)
**Effort Required**: Code engineering
**Effort Estimate**: 1-2 weeks of software development and documentation

**Current State**: Two critical pipeline components are absent from the repository: (a) the Llama 3.1 70B captioning pipeline (mandatory between CLIGen data collection and training; direct driver of 5 dB PSNR improvement in Table 3); (b) the episode packaging system (described in Appendix B as "would be released" but currently absent). Together, these gaps prevent reproduction of any NC_CLIGen training experiment from raw data.

**Development Direction**:
Release the captioning pipeline (prompt templates, API call structure, tier formatting) and episode packaging system (frame extraction, action alignment, file format) as part of the main repository. If the Llama 3.1 70B API calls use non-public resources, provide the prompt templates and processing code with instructions for substituting an available LLM. The code does not need to be optimized — it needs to enable replication of the main training experiments.

**Expected Outcome**: The code release becomes functional for NC_CLIGen reproduction. CFR-019 and CFR-023 are resolved. The paper's reproducibility claim is substantiated.

---

### R10: Add Formal NeuralOS Comparison Subsection

**Category**: Contribution and Novelty / Presentation
**CFR Source**: HIGH-012; CFR-PATTERN-A (component)
**Effort Required**: Writing
**Effort Estimate**: 2-3 days

**Current State**: NeuralOS is described as "most closely related" in one sentence while NC_GUIWorld is framed as conceptually superior on the "runtime vs. simulation" distinction. However, NeuralOS's hierarchical RNN architecture demonstrably addresses the long-horizon state persistence challenge that NC_GUIWorld acknowledges as a limitation. NeuralOS demonstrates 256-frame OS state persistence in closed-loop interaction — the precise property NC_GUIWorld lacks. The paper omits that NeuralOS outperforms NC_GUIWorld on the defining property of the "running computer" concept.

**Development Direction**:
Add a Section 2.2 "Comparison with NeuralOS" (approximately half to one page) that: (a) acknowledges NeuralOS's RNN advantage for long-horizon state persistence with specific reference to its 256-frame results; (b) positions NC_GUIWorld as a proof-of-concept prototype using a more accessible pretrained backbone (Wan2.1) rather than claiming current superiority; (c) identifies what NC_GUIWorld offers that NeuralOS does not (DiT visual quality, CLIGen domain, four-mode injection analysis); (d) explicitly frames the "runtime vs. simulation" distinction as an architectural target for future work rather than a current empirical achievement.

**Expected Outcome**: The comparison with NeuralOS is accurate and honest. The paper's positioning acknowledges NeuralOS's architectural strength while clearly identifying NC's complementary contributions. One component of CFR-PATTERN-A is addressed.

---

### R11: Report NC_GUIWorld Inference Speed

**Category**: Completeness / Practical Evaluation
**CFR Source**: CFR-017 (MEDIUM)
**Effort Required**: New measurement (trivial compute)
**Effort Estimate**: Half a day

**Current State**: NC_GUIWorld never reports inference speed. All primary comparators in the reference class report FPS: GameNGen 20 FPS (single TPU), DIAMOND approximately 10 FPS (RTX 3090), NeuralOS 15 FPS. Without inference speed, the practical interactive usability of NC_GUIWorld cannot be assessed by readers.

**Development Direction**:
Measure and report NC_GUIWorld inference speed (FPS) on a specific GPU configuration with batch size 1. Report hardware specifications, resolution, and any optimizations applied. Comparison to the reference class speeds contextualizes whether NC_GUIWorld is practically interactive or requires further optimization. If inference is slow (e.g., less than 1 FPS), this is important information for the practical motivation section and roadmap.

**Expected Outcome**: Readers can assess NC_GUIWorld's practical deployment feasibility. The paper meets field standard for reporting inference speed. CFR-017 is resolved.

---

### R12: Expand Related Work to Standalone Section

**Category**: Presentation / Completeness
**CFR Source**: HIGH-001
**Effort Required**: Writing
**Effort Estimate**: 2-3 days (most of the content is already drafted for R2)

**Current State**: The Related Work section is approximately one page embedded within Section 2.1 (Preliminaries). For a paper making paradigm-level claims, this is insufficient depth to establish the paper's contribution against the field. The expansion required for R2 (adding GameNGen, DIAMOND, AVID, DWS) naturally transforms this into a standalone Related Work section.

**Development Direction**:
Separate the current Related Work content from Preliminaries into a dedicated Section 2 "Related Work" with three subsections: (a) Action-Conditioned Video Simulation (GameNGen, DIAMOND, Genie), (b) Action Injection Design for Video DiTs (AVID, DWS), (c) OS/GUI Neural Simulation (NeuralOS). Each subsection should end with a clear statement of how NC differs from or extends the cited work. This change can be done as a direct extension of R2 with minimal additional effort.

**Expected Outcome**: The Related Work section matches the depth expected for a paradigm-level paper. HIGH-001 is resolved.

---

## Tier 3: Recommended Improvements (Could Address)

---

### R13: Complete External Injection Mode Training

**Category**: Experimental Design
**CFR Source**: CFR-022 (MEDIUM)
**Effort Required**: Continue existing training run
**Effort Estimate**: 1-2 weeks compute (approximately 50% additional training budget)

**Current State**: The external injection mode was early-stopped at approximately 50% of planned budget after "preliminary rollouts did not warrant further compute." This creates an unequal comparison: three fully trained modes versus one partially trained anchor condition. External mode is the ablation's anchor separating pre-backbone injection from in-backbone modes.

**Development Direction**:
Complete the external mode training to the full planned budget. Update Table 10 with the full-budget external result. Either outcome is informative: if external FVD at full budget remains substantially above contextual, the injection depth conclusion is strengthened; if it approaches contextual, the hierarchy interpretation needs revision.

---

### R14: Add Action Density-Controlled Condition to Table 8

**Category**: Experimental Design / Mechanism
**CFR Source**: CFR-006 (MEDIUM)
**Effort Required**: Data resampling and evaluation (low compute; no new collection)
**Effort Estimate**: 3-5 days

**Current State**: Experiment 7 concludes that goal-directed CUA data (110h, 0.10 actions/sec) outperforms random data (1,400h, 4.18 actions/sec). However, the 42x action density difference confounds goal-directedness with interaction sparsity. The stated principle ("prioritize curated, purposeful interactions") may actually reflect "prefer sparse interactions."

**Development Direction**:
Subsample Random Fast data to match CUA's 0.10 actions/sec using existing collected data. Train or evaluate a model on this density-matched Random Fast subset. Add as a row to Table 8. The existing data is already collected; this requires only resampling and a model evaluation pass. The result either confirms the goal-directedness interpretation (density-matched random still underperforms CUA) or identifies action density as the operative mechanism (density-matched approaches CUA performance).

---

### R15: Add Failure Case Visualization Gallery

**Category**: Presentation / Evidence
**CFR Source**: CFR-013 (MEDIUM)
**Effort Required**: Curation and writing
**Effort Estimate**: 1 day

**Current State**: The 39-figure appendix (Appendix E) contains exclusively positive-case outputs. No failure case gallery exists despite the paper explicitly acknowledging specific failure modes: text smear, cursor drift, spurious color changes, task-level failure under multi-step interactions. Positive-only galleries, combined with absent statistical reporting, increase the risk that visual impressions overestimate typical performance.

**Development Direction**:
Add a small failure case gallery (5-8 figures) to Appendix E alongside the existing positive cases. Each failure example should be paired with the paper's verbal description of the failure mode (text smear, cursor drift, etc.) to show that representative failure cases match the acknowledged limitations. This is standard practice in generative model evaluation and adds credibility to the positive cases by demonstrating that the paper is not cherry-picking.

---

### R16: Add OSWorld Task Coverage Analysis

**Category**: Completeness / Practical Scope
**CFR Source**: CFR-018 (MEDIUM)
**Effort Required**: Analysis and writing
**Effort Estimate**: 1-2 days

**Current State**: NC_GUIWorld's evaluation covers 8 apps. OSWorld (NeurIPS 2024) defines the field-standard benchmark for computer-use evaluation with 369 tasks across 12 app domains. The paper's motivation includes NC_GUIWorld as a potential training environment for computer-use agents, but the coverage of NC_GUIWorld's 8 apps against OSWorld's task taxonomy is not analyzed.

**Development Direction**:
Add a table mapping NC_GUIWorld's 8 training/evaluation apps to OSWorld's 12 app categories and 369 tasks. Report what percentage of OSWorld's task space is currently covered and what would need to be extended. This analysis substantiates or qualifies the claim that NC_GUIWorld could serve as an agent training environment, and provides a concrete scope target for future work.

---

### R17: Convert Figure 6 to Data Table with Sample Size and CIs

**Category**: Statistical Rigor / Presentation
**CFR Source**: CFR-010 (MEDIUM)
**Effort Required**: Writing and evaluation bookkeeping
**Effort Estimate**: Half a day

**Current State**: Figure 6 shows the 83% reprompting result as a bar chart with no accompanying data table, no stated sample size, and no confidence interval. This is the paper's largest improvement finding reported with the lowest documentation standard of any result in the paper.

**Development Direction**:
Replace or supplement Figure 6 with a data table reporting: Model, Condition, Sample Size (n), Accuracy (%), 95% Wilson CI. State whether the same 100-problem draw from Table 5 was used. If a different draw, report both draws' NC_CLIGen native results to assess cross-draw variability. The 83% figure may survive unchanged — the goal is to provide the documentation standard expected for the paper's headline result.

---

### R18: Evaluate Arithmetic Probe on Full 1,000-Problem Pool

**Category**: Statistical Rigor
**CFR Source**: CFR-005 (MEDIUM)
**Effort Required**: New evaluation run (trivial compute)
**Effort Estimate**: Half a day

**Current State**: Table 5 reports arithmetic probe accuracy from 100 problems sampled from a 1,000-problem pool. NC_CLIGen: 4/100 (4%), Wan2.1: 0/100 (0%). The Wilson 95% CI for 4/100 is approximately [1.1%, 9.9%], which overlaps with the CI for 0/100 ([0%, 3.6%]). The 4% vs. 0% comparison is statistically indistinguishable.

**Development Direction**:
Evaluate all four models on the full 1,000-problem held-out pool. At 1,000 problems, a 4% vs. 0% difference becomes statistically assessable with reasonable power. The broader conclusion (symbolic reasoning bottleneck for all video models) is robust regardless; the evaluation on the full pool primarily affects the fine-tuning benefit claim for NC_CLIGen.

---

### R19: Document CLIGen Clean Filtering Criterion

**Category**: Reproducibility
**CFR Source**: MEDIUM-001
**Effort Required**: Writing
**Effort Estimate**: Half a day

**Current State**: Section 3.1.1 states "After filtering (51.21% retained)" without describing the filtering criteria. This affects reproducibility of all Experiments 2-6 (conducted on CLIGen Clean).

**Development Direction**:
Add a paragraph to Section 3.1.1 or Appendix B.1 describing the filtering criteria: what conditions cause a script to be excluded (e.g., empty output, error conditions, non-ASCII characters, minimum length threshold). Report the distribution of filtered categories to characterize what was excluded. This requires no new experiments — only documentation of the existing pipeline.

---

## Tier 4: Optional Enhancements

---

### R20: Add S-Slot Ablation for Meta-Action Encoder

**Category**: Methodology
**CFR Reference**: (Phase-3-2 finding)
**Effort**: New training runs; 2-3 weeks

The meta-action encoder uses S=2 action slots per frame without ablation or motivation. Add S=1, 2, 4 ablation to Table 11 or Appendix D. If flat, report as evidence of robustness. If performance varies, update the design recommendation.

---

### R21: Add Complete Hyperparameter Table to Appendix D

**Category**: Reproducibility
**CFR Source**: MEDIUM-002
**Effort**: Half a day of writing; no experiments

Add a hyperparameter table to Appendix D reporting: w (temporal window frames), l (lag frames), tau (contrastive temperature), layer indices for residual and internal injection, hidden dimensions of action conditioning modules. Enables full reproducibility from the paper alone.

---

### R22: Add Performance Gap Analysis for NC_CLIGen 54% Ceiling

**Category**: Presentation / Completeness
**CFR Reference**: (Phase-3-4 finding)
**Effort**: Half a day of writing

Add one paragraph to Section 3.1 explicitly stating the functional NC threshold (near-100% character accuracy), quantifying the current gap (54% achieved), and interpreting the training plateau (40-50k steps) as either a training or architectural limitation. Strengthens Section 4's roadmap specificity.

---

### R23: Zero-Shot Generalization Evaluation for NC_GUIWorld

**Category**: Generalization / External Validity
**CFR Reference**: (Phase-4-2 finding)
**Effort**: One evaluation run; no retraining

Evaluate NC_GUIWorld on one additional Ubuntu visual theme (e.g., GNOME Adwaita) zero-shot without retraining. Tests whether the model generalizes beyond its training visual environment. This requires only running the existing model on out-of-distribution inputs.

---

### R24: Add Consolidated Limitations Section

**Category**: Presentation
**CFR Reference**: (Phase-7-2 finding)
**Effort**: 1 day of writing

Consolidate limitations currently scattered across Section 3.2.4, Table 10 footnote, and other locations into a dedicated Limitations section. Include: open-loop-only evaluation, 54% character accuracy ceiling, single-environment evaluation for both systems, quadratic state complexity, action density confound, and LLM caption quality concern. This makes the paper's epistemic transparency more visible and credible.

---

## Cross-Cutting Themes

### Theme 1: The Attribution and Citation Pattern

Five of the paper's most serious issues (R2, R3, R5, R10, and a component of R12) all stem from a common pattern: the paper's related work and attribution choices consistently favor paradigm-origination framing over paradigm-extension framing. Addressing R2 and R3 together resolves the core of this pattern, and R5 and R10 complete it. These four writing-only recommendations collectively transform the paper's positioning from one that a reviewer will identify as problematic to one that accurately represents a genuine and meaningful contribution.

### Theme 2: Claims vs. Evidence Calibration

Three issues (R1, R4, R8) address the same structural problem: the paper's claims are systematically larger than what its experiments demonstrate. The runtime primitive claim (R1) runs ahead of any closed-loop measurement. The fine-tuning benefit claim (R4) runs ahead of a zero-shot baseline. The reprompting attribution claim (R8) runs ahead of a base Wan2.1 reprompting baseline. All three are small targeted experiments that require little compute but are individually necessary for the claims they are meant to support.

### Theme 3: Statistical Reporting Deficit

The systemic absence of variance reporting (R7) affects the interpretability of the entire experimental section. The good news is that the paper's large-effect findings (cursor supervision, data quality, caption tier) are robust and will not change. The statistical additions primarily affect the small-effect findings (Tables 10-11), where they may narrow the architectural hierarchy claims but will not overturn the overall directional finding.

### Theme 4: Reproducibility Infrastructure

Three issues (R9, R19, R21) together address the gap between the paper's code release and functional reproducibility. The most important of these is R9 (captioning pipeline and episode packaging), which is the difference between a code repository that users can run and one they cannot. R19 and R21 add documentation that further supports reproducibility without requiring any new code.

---

## Minimum Viable Revision Path

For a revision addressing the most critical issues with minimum effort, the following sequence addresses all three CRITICAL findings and the most important HIGH findings:

**Week 1-2 (Writing-Only, Parallel)**:
- R2: Add citations and reframe paradigm contribution (3 days)
- R3: Disclose NeuralOS code attribution in paper body (0.5 days)
- R10: Add formal NeuralOS comparison subsection (2-3 days)
- R12: Expand Related Work to standalone section (builds on R2 work; 1 additional day)
- R5: Apply CNC conditions to NC prototypes and existing systems (2 days)
- R11: Report NC_GUIWorld inference speed (0.5 days)
- R17: Convert Figure 6 to data table (0.5 days)
- R19: Document CLIGen Clean filtering criterion (0.5 days)
- R21: Add hyperparameter table to Appendix D (0.5 days)

**Week 2-3 (New Experiments, Parallel with Week 1 writing)**:
- R1: Closed-loop error accumulation experiment, NC_CLIGen (5-10 autoregressive steps, no new training)
- R4: Zero-shot Wan2.1 baseline evaluation on CLIGen Clean (no new training)
- R8: Wan2.1 + reprompting baseline evaluation (no new training)
- R18: Arithmetic probe on full 1,000-problem pool (no new training)

**Week 3-4 (Code and Statistics)**:
- R9: Release captioning pipeline and episode packaging system
- R7 (partial): Bootstrap 95% CIs for Tables 3 and 8 from existing data

**Total Minimum Viable Revision**: Approximately 4-5 weeks, requires no new model training. Addresses all 3 CRITICAL CFR findings and 7 of the 10 HIGH findings.

---

## Comprehensive Revision Path

For a revision that addresses all Tier 1, 2, and 3 improvements:

**Phase A (Weeks 1-3): Writing and evaluation (no new training)**:
All Tier 1 writing tasks (R2, R3, R5), all evaluation-only new experiments (R4, R8, R11, R18), Tier 2 writing tasks (R10, R12), documentation tasks (R9, R19, R21), and Tier 3 writing tasks (R13 not yet started, R15, R16, R17, R22, R24).

**Phase B (Weeks 3-8): New training runs (in parallel with Phase A)**:
- R7: 2-3 random seeds for Tables 10-11 (4-6 weeks compute)
- R6: Capacity-controlled contextual baseline for Table 10 (2-4 weeks compute)
- R13: Complete external injection mode training (1-2 weeks compute, continuation of existing run)
- R1: Full closed-loop evaluation with more steps (builds on MVR experiment; 1 additional week if extending)

**Phase C (Weeks 8-12): Synthesis and optional enhancements**:
- R14: Action density-controlled condition (requires existing data; 1 week)
- R20: S-slot ablation for meta-action encoder (requires new training; 2-3 weeks)
- R23: Zero-shot generalization evaluation (no new training; 1 day)

**Total Comprehensive Revision**: Approximately 3-4 months including new training runs. Addresses all issues across all priority tiers.

---

## Quick Wins Summary (High Impact, Low Effort)

The following improvements have the highest impact-to-effort ratio and should be prioritized regardless of which revision path is chosen:

| Recommendation | Impact | Effort | Rationale |
|---------------|--------|--------|-----------|
| R2: Add missing citations + reframe | Critical | 3 days writing | Resolves CRITICAL finding; writing-only |
| R3: NeuralOS code attribution | Critical | 0.5 days | Resolves HIGH CFR-024; half a day |
| R4: Zero-shot Wan2.1 baseline | Critical | 1-2 days | Resolves HIGH CFR-026; single eval run |
| R11: Report inference speed | High | 0.5 days | Resolves MEDIUM CFR-017; measurement only |
| R17: Figure 6 data table | Medium | 0.5 days | Resolves MEDIUM CFR-010; documentation |
| R19: CLIGen Clean filter docs | Medium | 0.5 days | Resolves MEDIUM-001; documentation |
| R8: Wan2.1 reprompting baseline | High | 1-2 days | Resolves MEDIUM CFR-027; single eval run |
| R15: Add failure case gallery | Medium | 1 day | Resolves MEDIUM CFR-013; curation |

---

*Phase 8-1 Improvement Roadmap — Neural Computers (arXiv:2604.06425)*
*Based on Phase 4-2 (Weaknesses), Phase 5-2 (Comparative Analysis), Phase 7-1 (Comprehensive Evaluation), Phase 7-2 (Critical Review)*
*CFR Final State: CRITICAL: 3, HIGH: 10, MEDIUM: 15*
