# Comparative Analysis Summary

## Overview

This analysis compares the Neural Computers paper (arXiv:2604.06425, April 2026, Meta AI / KAUST) against 10 reference papers selected to span the closest technical comparators, methodological predecessors, related paradigms, and evaluative context. Five of the reference papers were read at Level 2-3 in Phase-3-5b (GameNGen, DIAMOND, NeuralOS, AVID, DWS); the remaining five (Wan2.1, Genie, OSWorld, Claude CUA Study, SeeAct) were read at Level 1-2 in Phase-5-2.

**Target Paper**: Neural Computers (arXiv:2604.06425)
**Reference Papers**: 10 papers (8 from top-tier venues: ICLR 2025, NeurIPS 2024, ICML 2024, ICLR 2026; 2 as arXiv preprints)
**Temporal Range of References**: 2024-2025 (all predate or are contemporaneous with NC's April 7, 2026 submission)

---

## Key Comparative Findings

### 1. Research Problem Positioning

**Where does the target sit in the research landscape?**

The NC paper occupies a distinctive but precarious position: it makes the broadest paradigm-level claims in its reference class ("neural computers are an emerging machine form") while its prototype implementations operate in a competitive and well-precedented technical space.

At the conceptual level, the NC/CNC formalism (Eq. 2.1: h_t = F_theta(h_{t-1}, x_t, u_t); four CNC conditions) is a genuinely new organizing framework. None of the 10 reference papers adopt this language or specify the four conditions (Turing completeness, universal programmability, behavioral consistency, machine-native semantics) as evaluation criteria for neural systems. The conceptual contribution is original.

At the technical prototype level, however, NC_GUIWorld addresses the identical problem as NeuralOS (Ref 3: same domain, same OS, same data source, same goal — Ubuntu XFCE GUI simulation from mouse/keyboard inputs using neural networks trained on Claude CUA interaction data). GameNGen (Ref 1) establishes the identical two-phase technical paradigm applied to DOOM rather than OS/GUI (18 months before NC). DIAMOND (Ref 2) demonstrates the same interactive diffusion environment paradigm for CS:GO from human-collected data (2 years before NC). NC_CLIGen addresses a genuinely novel domain (CLI/terminal video simulation) with no direct prior comparable work.

The NC paper's positioning is weakened by an incomplete related work section that cites NeuralOS in a single sentence without technical comparison, and omits GameNGen, DIAMOND, AVID, and DWS entirely — all peer-reviewed papers at ICLR 2025 or NeurIPS 2024 Spotlight that collectively establish the design space NC_GUIWorld operates within.

**Key takeaways**:
- Strength: NC conceptual framework is genuinely novel as an organizing abstraction for this class of systems
- Concern: NC_GUIWorld's technical prototype is substantially precedented by GameNGen (paradigm) and NeuralOS (domain), both uncited or under-cited
- Strength: NC_CLIGen addresses a domain with no prior comparable work
- Concern: The four CNC conditions are never formally verified to be satisfied by either NC_CLIGen or NC_GUIWorld — they are presented as goals, not achievements
- Implication: The paper's strongest intellectual contribution is the NC/CNC framework; the prototypes are best positioned as preliminary demonstrations of an ongoing paradigm, not technical novelties in themselves

---

### 2. Methodological Positioning

**How does the target's method compare?**

NC_GUIWorld's method sits at the intersection of two established research traditions: (1) the GameNGen/DIAMOND paradigm of training diffusion models on interaction traces for action-conditioned interactive simulation, and (2) the AVID/DWS paradigm of adapting pretrained video models to action-conditioned world models using lightweight injection modules. NC_GUIWorld extends the first paradigm to OS/GUI and applies a more extensive fine-tuning approach (full Wan2.1 fine-tuning with four injection modes studied) compared to the adapter-based approaches of the second tradition.

The four-mode injection ablation (external, contextual, residual, internal) is NC_GUIWorld's most technically original contribution at the methodology level. While the design space is established by AVID (per-frame scale/shift) and DWS (per-block scale-shift modulation), the systematic comparison of all four modes under identical conditions for OS/GUI interaction is new. The internal mode's cross-attention implementation is a higher-expressivity variant of DWS's two-linear-layer approach, with the trade-off of more parameters and unclear capacity confounds (CFR HIGH-003).

SVG cursor visual supervision is a genuinely novel training technique with a dramatic demonstrated effect (8.7% → 98.7% cursor accuracy, Table 9). NeuralOS independently develops Gaussian spatial cursor encoding (achieving ±1.6px accuracy), showing cursor-specific supervision is a recognized key challenge in GUI simulation — but the specific SVG-based approach is distinct.

NC_CLIGen's methodology (three-tier LLM captioning from terminal buffers; asciinema replay pipeline; scripted VHS clean dataset) is a novel data engineering contribution for a domain with no prior comparable work.

**Unique aspects of target's method**:
1. SVG cursor supervision (8.7% → 98.7% accuracy) — genuine innovation for GUI simulation
2. NC_CLIGen data pipeline (asciinema + VHS + LLM captioning) — novel domain
3. Four-mode injection ablation in OS/GUI context — extends established design space
4. Meta-action API schema encoding — semantic action abstraction for GUI interaction
5. Post-action evaluation metric windows (SSIM+15, FVD+15) — novel evaluation approach

**Comparison to reference approaches**:

NeuralOS (most architecturally sophisticated comparator) uses an RNN + diffusion renderer hybrid that explicitly solves the long-horizon state persistence problem NC_GUIWorld acknowledges but does not address. NeuralOS's O(1) per-timestep RNN complexity vs. NC_GUIWorld's quadratic attention growth is a concrete architectural advantage for the OS domain where state must persist for hundreds of frames. NC_GUIWorld's DiT fine-tuning approach may produce better single-frame visual quality due to Wan2.1's powerful pretrained visual prior, but the state persistence comparison is entirely unresolved because NC_GUIWorld is only evaluated in open-loop mode.

**Key takeaways**:
- Strength: SVG cursor supervision is a novel, well-validated training technique
- Strength: NC_CLIGen methodology is novel in its domain
- Concern: NC_GUIWorld's core architectural approach is the established GameNGen paradigm applied to OS/GUI; the specific injection mechanisms are extensions of AVID/DWS design space
- Concern: NC_GUIWorld's use of implicit attention-based state (vs. NeuralOS's explicit RNN state) is architecturally weaker for the long-horizon OS state problem
- Implication: The paper should reframe NC_GUIWorld's technical contribution as: "adapting the interactive diffusion paradigm to OS/GUI, with specific engineering innovations (cursor supervision, systematic injection ablation, meta-action encoding)" rather than implying paradigm-level technical novelty

---

### 3. Experimental Design Positioning

**How does the target's evaluation compare?**

**Dataset selection**:
- NC_GUIWorld uses Ubuntu XFCE with CUA data — aligned with field (matches NeuralOS exactly; addresses the same domain GameNGen addresses for games)
- NC_CLIGen datasets are novel with no direct comparable reference
- Critical gap: No evaluation against OSWorld task taxonomy (NeurIPS 2024 benchmark standard for computer-use evaluation)
- Critical gap: No cross-app generalization test (NeuralOS demonstrates this with DOOM on system without DOOM installed)
- Assessment: Adequate for within-domain evaluation; inadequate for generalization claims

**Baseline coverage**:
- NC_GUIWorld has only 2 baselines: untrained model and early-stopped ablation condition
- No comparison against GameNGen, DIAMOND, NeuralOS, AVID, or DWS (the five most methodologically relevant prior systems)
- NC_CLIGen has 3 baselines (own backbone + 2 commercial video models) — minimal but defensible given domain novelty
- Critical missing baseline: NeuralOS on same Ubuntu XFCE tasks — the most important missing comparison
- Assessment: Critically insufficient for NC_GUIWorld; minimal but justifiable for NC_CLIGen

**Experimental rigor**:
- No statistical reporting across all 10 experiments (CFR HIGH-009): no standard deviations, confidence intervals, or significance tests in any table
- Arithmetic probe sample size insufficient for the 4% vs. 0% claim (CFR MEDIUM-005)
- Reprompting result (83%) has no companion data table, no sample size, no CI (CFR MEDIUM-010)
- Post-action metric windows (SSIM+15, etc.) are an innovative evaluation contribution
- Assessment: Below field standard for small-difference comparisons; adequate for large-gap results (cursor accuracy, FVD improvements)

**Experimental scale**:
- 10 numbered experiments is competitive with reference papers in count
- Critical gap: All 10 experiments use open-loop rollout; no closed-loop evaluation exists
- GameNGen: 5-minute stable closed-loop generation; DIAMOND: RL training + CS:GO human play; NeuralOS: 256-frame RNN memory in closed-loop
- Assessment: Adequate in experimental count; fundamentally below field standard in evaluation mode (open-loop only when all comparators test closed-loop)

**Key takeaways**:
- Strength: Post-action metric windows (SSIM+15, FVD+15) are methodologically innovative
- Strength: 10 experiments with clear ablation isolation
- Concern: No closed-loop evaluation — the most significant gap relative to all primary technical comparators
- Concern: No comparison against NeuralOS (same domain) or any established system
- Concern: No human perceptual study (GameNGen, Genie both include this)
- Concern: Systemic absence of statistical variance measures
- Implication: The experimental design would be substantially strengthened by a single closed-loop demonstration and a side-by-side qualitative comparison with NeuralOS

---

### 4. Results and Claims Positioning

**How do target's results compare?**

**Performance improvements**:
- NC_GUIWorld: FVD improvement from untrained baseline (149.61) to CUA-trained model (14.72): 90.2% reduction — large and credible gain
- NC_GUIWorld: Cursor accuracy improvement from position-only (8.7%) to SVG supervision (98.7%): 90pp — the paper's strongest and most credible result
- NC_CLIGen: 5 dB PSNR gain from semantic to detailed captions — large, well-isolated ablation result
- Reprompting: 4% → 83% — large gain, but under-documented (CFR-010)

**Comparison to field**:
- The CUA vs. untrained FVD improvement (90.2%) is a strong within-system result but baseline (untrained Wan2.1) is extremely weak
- No gains reported relative to any established competing system
- GameNGen reports PSNR 29.4 on DOOM; NC_GUIWorld reports FVD 14.72 on Ubuntu XFCE — not directly comparable but both demonstrate domain viability
- The cursor accuracy result (98.7% with SVG vs. 8.7% without) is the paper's clearest and most field-relevant contribution — cursor precision is recognized as a core challenge by NeuralOS independently

**Claim strength assessment**:
- NC's specific quantitative claims (cursor accuracy, PSNR improvements, FVD by data source) are appropriate and reasonably well-calibrated to their evidence
- NC's paradigm-level claims ("NCs are an emerging machine form," "take over the runtime responsibilities of physical computers") are significantly broader than the prototype evidence supports
- The paper's claim to "early NC primitives" is partially supported for I/O alignment in open-loop conditions; it is entirely unsupported for runtime state persistence (no closed-loop evaluation exists)
- GameNGen and DIAMOND make narrower claims with better-matched evidence — NC's claim calibration is the weakest in its reference class

**Generalization evidence**:
- NC provides less generalization evidence than most primary comparators
- DIAMOND demonstrates across 26 Atari games; DWS demonstrates across two domains and two architectures; NeuralOS demonstrates cross-app generalization
- NC_GUIWorld evaluates only on training-overlap apps; NC_CLIGen's generalization to novel terminal content is partially suggested but not formally tested

**Key takeaways**:
- Strength: Cursor accuracy result is the paper's single strongest and most clearly novel quantitative finding
- Strength: CUA data quality finding (90.2% FVD improvement over untrained) establishes the practical value of curated interaction data
- Concern: No results demonstrated against any established comparable system — NC_GUIWorld's FVD 14.72 has no reference point other than its own baselines
- Concern: Paradigm-level claims exceed prototype-level evidence by a wider margin than in any reference paper
- Concern: Reprompting result (paper's headline practical finding) is the most under-documented result
- Implication: The paper should recalibrate its claims to match prototype-level evidence, and reserve paradigm-level claims for sections that explicitly note they describe future goals

---

## What Does This Comparative Analysis Reveal?

### Target's Strengths (Relative to References)

1. **SVG cursor visual supervision — Novel training technique**: The 8.7% → 98.7% cursor accuracy improvement through explicit SVG mask and reference frame conditioning is a genuine and practically important training insight for GUI simulation. NeuralOS independently identifies cursor precision as critical (using Gaussian spatial maps instead), but the SVG-based approach and its 90pp improvement over coordinate-only baselines is a concrete methodological contribution that the field does not yet have.
   - Evidence: Table 9 (NC paper) — SVG achieves 98.7% vs. 8.7% (position-only) and 13.5% (Fourier encoding)

2. **NC_CLIGen — Novel domain with no prior art**: Terminal/CLI video simulation from neural video models is genuinely unexplored in the reference literature. The asciinema replay pipeline, three-tier LLM captioning architecture, and VHS clean scripting infrastructure are original data engineering contributions. The 5 dB PSNR gain from caption specificity (Table 3) and the reprompting steerability finding are interesting empirical observations with no comparable prior work.
   - Evidence: No reference paper addresses CLI terminal video simulation; NC_CLIGen achieves 26.89 dB PSNR with detailed captions; reprompting raises arithmetic probe from 4% to 83%

3. **Post-action metric windows (SSIM+15, FVD+15, LPIPS+15)**: The practice of computing metrics over the 15 frames immediately following each action event (click, scroll, key) to assess action responsiveness is methodologically innovative. None of the reference papers use action-triggered metric windows. This evaluation design choice directly tests the property most relevant to interactive simulation (does the model respond correctly to actions?) rather than confounding action-response quality with ambient background quality.
   - Evidence: Tables 10-11 use action-triggered variants; reference papers use aggregate FVD/SSIM without action-specific windowing

4. **Data quality finding — curated supervision outperforms volume**: The finding that 110h CUA supervised data (FVD 14.72) outperforms 1,400h random data (FVD 48.17) by 3.3x is a practically valuable empirical result. The confound of action density is noted (CFR-006) but the directional finding about goal-directed data quality is consistent with intuition and likely generalizable. No reference paper compares curated vs. uncurated data at this scale for OS simulation.
   - Evidence: Table 8 — CUA 14.72 vs. Random Fast 48.17 vs. Random Slow 20.37 FVD; 12.7x less data, 3.3x better FVD

5. **NC/CNC conceptual framework — Novel organizing abstraction**: The four CNC conditions and the NC formalism provide a precise specification vocabulary for what properties a neural system must have to constitute a "computer." No reference paper specifies these conditions. The framework creates evaluation criteria that can organize future work, regardless of whether NC_CLIGen/NC_GUIWorld currently satisfy them.
   - Evidence: None of the 10 reference papers adopt NC/CNC formalism; GameNGen, DIAMOND, NeuralOS all use different terminological traditions ("game engine," "world model," "generative OS")

### Target's Gaps (Relative to References)

1. **No closed-loop evaluation — fundamental gap vs. all primary comparators**:
   GameNGen demonstrates 5-minute stable closed-loop generation at 20 FPS. DIAMOND demonstrates RL training in world model imagination and ~10 FPS CS:GO human-interactive play. NeuralOS demonstrates 256-frame RNN state memory across closed-loop interaction sequences. NC_GUIWorld is evaluated exclusively in open-loop (CFR-004). For a paper claiming "early NC primitives of a running computer," the complete absence of any closed-loop evaluation is the most significant single gap relative to field practice. The open-loop/closed-loop performance gap is acknowledged but entirely unmeasured.
   - Impact: Weakens the core NC runtime claim; cannot verify that NC_GUIWorld's SSIM/FVD metrics translate to stable autoregressive behavior

2. **No comparison against any established comparable system**:
   NC_GUIWorld reports FVD 14.72 against an untrained baseline and an early-stopped ablation condition — no comparison against NeuralOS (identical domain), GameNGen (identical paradigm), AVID (same design problem), or DWS (same per-block modulation approach). This is below field standard for any paper claiming technical contribution in an established research area. GameNGen, DIAMOND, AVID, and DWS all compare against at least 2-3 competing methods.
   - Impact: NC_GUIWorld's performance numbers have no reference point from which to assess whether they represent good, average, or poor performance for this type of system

3. **Missing citations misrepresent paradigm novelty (CFR HIGH-011)**:
   Four ICLR 2025 or NeurIPS 2024 Spotlight papers — GameNGen, DIAMOND, AVID, DWS — collectively establish the technical design space NC_GUIWorld operates within. Their absence from NC's citations means the paper cannot properly contextualize its incremental contributions. This is particularly problematic because: (a) GameNGen's ICLR 2025 acceptance and high citation count make it a well-known reference that reviewers will immediately identify; (b) the NC paper's injection mode ablation is presented as original design space exploration, while AVID and DWS explicitly map this design space 14-18 months earlier.
   - Impact: Potential rejection on related work grounds; damages the paper's credibility on novelty claims

4. **NeuralOS under-discussion relative to direct technical competition (CFR HIGH-012)**:
   NeuralOS (ICLR 2026) is cited in one sentence despite being the most directly comparable system — same domain, same OS, same data source, same goal. NeuralOS's RNN architecture explicitly solves the long-horizon state persistence problem that NC_GUIWorld acknowledges but does not address. The NC paper implies conceptual superiority (NC handles "runtime"; NeuralOS only "simulates") without acknowledging that NeuralOS has a concrete architectural solution to the most important challenge in OS simulation (state persistence).
   - Impact: Creates a misleading impression of comparative capability; a reviewer familiar with NeuralOS will immediately identify this gap

5. **Systemic absence of statistical reporting (CFR HIGH-009)**:
   No table in the paper (Tables 2-11) reports standard deviations, confidence intervals, or significance tests. The injection mode comparison (Table 10: internal vs. residual SSIM difference of 0.006) and the meta-action comparison (Table 11: 0.016 SSIM difference) are the NC paper's two secondary architectural recommendations — both depend on differences that are likely within statistical noise. Statistical reporting is standard in DIAMOND (results across 26 games), DWS (FVD/PSNR with variance), and SeeAct (task success rates with multiple evaluation settings).
   - Impact: Architectural recommendations in the injection mode ablation may not reflect real differences

6. **No human perceptual study**:
   GameNGen includes a human rater study achieving 0.58 accuracy (near-chance) at distinguishing real vs. simulated DOOM clips over 5 minutes — the field's standard approach to claim-independent validation of interactive simulation quality. Genie includes human playability assessment. NC_GUIWorld has no human evaluation despite claiming "early NC primitives." For a paper making claims about neural systems replacing physical computers, human perceptual validation of simulation quality is conspicuously absent.
   - Impact: No independent validation of simulation quality claims; positive-only visualization gallery (CFR MEDIUM-013) is an insufficient substitute

### Target's Unique Aspects (Different from All References)

1. **Two-system scope (CLI + GUI)**: The NC paper is the only reference that addresses both CLI/terminal simulation (NC_CLIGen) and GUI desktop simulation (NC_GUIWorld) in a single paper under a unified conceptual framework. All other references focus on a single domain (games, OS, web). Whether addressing both systems strengthens the paradigm claim ("NCs can run any computing substrate") or dilutes experimental depth for each is debatable — but the scope is unique.
   - Beneficial: Partially — demonstrates paradigm generality across computing paradigms (CLI and GUI); however, each system receives less experimental depth than a focused single-system paper would provide

2. **NC/CNC as a new research paradigm proposal**: NC explicitly aims to define a new research direction ("neural computers as an emerging machine form") rather than making a single technical contribution. This is more similar in scope to Genie (foundation world model paradigm) than to GameNGen or DIAMOND (single contribution papers). No other reference paper proposes a four-condition specification for what constitutes a neural computing substrate.
   - Beneficial: Provides a unifying framework that could organize follow-on work; however, the prototype implementations don't yet demonstrate the proposed criteria

3. **Meta-action API schema encoding**: The NC paper's meta-action v2 encoding (typed API schema with 5 action types, 2 slots per frame) is a novel approach to GUI action representation that abstracts away low-level coordinate noise into semantic categories. No reference paper uses this level of action abstraction for GUI simulation — NeuralOS uses raw coordinates, GameNGen uses discrete key presses. Whether this representation is superior or inferior to raw coordinates is only partially resolved (Table 11 shows modest gains with statistical uncertainty).
   - Beneficial: Unclear — the meta-action gains are modest and the representation design is not fully ablated; the principled API-like schema is conceptually appealing but not decisively validated

---

## Contextualized Assessment

### How Does the Target Fit in Its Research Context?

The NC paper enters the interactive world model field at a time when the core technical paradigm is established but the OS/GUI domain application is competitive. GameNGen established the foundational paradigm in August 2024; DIAMOND validated it for interactive use with human data in May 2024; NeuralOS demonstrated it for the same OS/GUI domain the NC paper targets, just months before NC's submission. The NC paper's prototypes therefore represent what is best described as competitive concurrent work (for NC_GUIWorld) and genuine first work (for NC_CLIGen).

The NC paper's most valuable contribution is not the prototype implementations themselves but the intellectual reframing: by introducing the NC/CNC framework, the paper proposes a specification vocabulary that distinguishes "computing" from "simulating" in a way that creates a meaningful research agenda beyond what GameNGen and NeuralOS articulate. Whether this distinction is fundamentally new or terminological (CFR MEDIUM-014) is a debatable theoretical question, but the framework's practical utility as an organizing concept for future research is real.

The prototypes, however, do not yet demonstrate the distinguishing NC properties. NC_GUIWorld's open-loop evaluation does not show persistent runtime state (h_t across self-generated sequences). NC_CLIGen's reprompting result shows task completion through conditioned generation, not native NC computation. The paper correctly acknowledges these gaps, but the framing as "early NC primitives" alongside paradigm-level claims creates an impression of capability that the evidence does not fully support.

Where the paper falls short relative to its reference class is primarily in two areas: (1) inadequate contextualization of its technical work within established prior art (missing citations, one-sentence NeuralOS comparison), and (2) absence of closed-loop evaluation that would directly address its core claims. Both are correctable without redesigning the experiments — the first requires a more thorough related work section; the second requires a single closed-loop demonstration sequence.

The NC paper's strongest contributions — the NC/CNC framework, SVG cursor supervision, NC_CLIGen as a new domain, the data quality finding, and the post-action evaluation methodology — are genuine additions to the field. Its weaknesses are primarily presentational and evaluative, not fundamental to the research direction.

### What Would Strengthen the Target Paper?

**Priority 1 - Critical Improvements (based on reference standards)**:

1. **Add all four missing citations with substantive discussion**: GameNGen, DIAMOND, AVID, DWS must be cited with explicit positioning of how NC_GUIWorld's injection mode ablation extends (rather than duplicates) their design space. The related work section needs to be substantially expanded from its current ~1 page. A taxonomy of existing interactive diffusion world models (GameNGen/DIAMOND paradigm) and action conditioning approaches (AVID/DWS) would provide the proper context for NC_GUIWorld's contribution (CFR HIGH-011).

2. **Expand NeuralOS comparison to a full comparison section**: NeuralOS deserves its own comparison subsection (not one sentence) covering: (a) architectural differences (RNN+renderer vs. DiT fine-tuning); (b) the state persistence tradeoff (NeuralOS's explicit RNN advantage vs. NC_GUIWorld's DiT quality advantage); (c) performance comparison on the shared Ubuntu XFCE domain; (d) honest acknowledgment that NeuralOS's RNN solves the long-horizon state problem NC_GUIWorld has not yet addressed (CFR HIGH-012).

3. **Include at least one closed-loop evaluation**: A 60-second autoregressive rollout (NC_GUIWorld's own generated frames fed back as input) would directly address the core NC runtime claim. Even a qualitative stability demonstration would be more informative than the current open-loop-only evaluation. This is the single most important missing experiment relative to field standards (CFR HIGH-004).

**Priority 2 - Important Improvements**:

4. **Add human perceptual study**: A human rater study on real vs. simulated Ubuntu XFCE clips (analogous to GameNGen's study) would provide claim-independent evidence for NC_GUIWorld's simulation quality. Even a small-scale study (20 raters, 50 clips) would significantly strengthen the interactive simulation claim.

5. **Report inference speed**: NC_GUIWorld's frames-per-second during inference is never reported. GameNGen (20 FPS), DIAMOND (~10 FPS), and NeuralOS (15 FPS) all report this; it is a standard measure of practical utility for interactive systems.

6. **Add data table for reprompting result**: The 4% → 83% result needs a proper data table with sample size, draw randomness description, and confidence interval. This is currently the paper's worst-documented quantitative result (CFR MEDIUM-010).

7. **Add parameter count table for injection modes**: A table showing trainable parameters per injection mode would resolve the capacity confound (CFR HIGH-003) and strengthen the injection mode ablation from suggestive to architecturally conclusive.

**Priority 3 - Nice-to-Have Improvements**:

8. **Add cross-app generalization test**: Test NC_GUIWorld on at least one app not in the training set. NeuralOS's DOOM demonstration is the reference example. This would provide evidence for the generalization claim embedded in the NC paradigm.

9. **Add OSWorld task coverage analysis**: Map NC_GUIWorld's 8-app evaluation set to OSWorld's task taxonomy to establish which computer-use capability categories NC_GUIWorld covers and which remain gaps.

10. **Add per-app performance breakdown**: Per-app FVD/SSIM/LPIPS would reveal whether performance is uniform or concentrated in easier apps.

---

## Comparative Context for Phase-5 Report

This comparative analysis provides context for the comprehensive evaluation report (Phase-6-1):

**For Novelty Assessment**:
The NC/CNC framework is genuinely novel; NC_CLIGen is a novel domain application; NC_GUIWorld's technical paradigm is precedented by GameNGen and NeuralOS, with specific innovations (SVG cursor supervision, four-mode ablation in OS/GUI context) that are incrementally novel. The missing citations significantly undermine the novelty presentation without affecting the underlying contributions.

**For Experimental Rigor Assessment**:
The open-loop-only evaluation is the most significant methodological gap relative to field practice. All primary technical comparators (GameNGen, DIAMOND, NeuralOS) demonstrate closed-loop operation. The systemic absence of statistical reporting is below field standard for small-difference comparisons.

**For Impact Assessment**:
The NC/CNC framework could have high long-term impact if it establishes a productive vocabulary for the emerging field of neural computing substrates. The practical contributions (SVG cursor supervision, NC_CLIGen pipeline, data quality finding) are immediately applicable by researchers in the interactive world model space.

**For Weakness Identification**:
The four most significant weaknesses revealed by comparison: (1) missing citations misrepresenting paradigm novelty; (2) no closed-loop evaluation; (3) no comparison against NeuralOS (most critical missing comparison); (4) paradigm-level claims exceeding prototype-level evidence.

**For Improvement Recommendations**:
Priority recommendations derived from field standards: (1) expanded related work with GameNGen, DIAMOND, AVID, DWS citations; (2) NeuralOS formal comparison section; (3) closed-loop demonstration; (4) human perceptual study. These four additions would bring the paper to the standard set by its best reference comparators.
