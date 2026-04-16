# Strengths Analysis: Neural Computers (arXiv:2604.06425)

## Phase-4-1 — Strengths Identification

---

## Executive Summary of Key Strengths

The paper's strongest contributions cluster around five areas:
1. A verified novel domain application (NC_CLIGen as first CLI/terminal video model — no prior work exists)
2. A creative and empirically decisive training insight (SVG cursor supervision: 8.7% to 98.7% cursor accuracy)
3. A genuine new formal abstraction (NC/CNC conceptual framework and h_t formalism, not anticipated by any of the five deeply-read competing papers)
4. Exceptional data engineering infrastructure (Dockerized reproducible pipelines, asciinema + VHS scripting)
5. A transparent experimental style that frankly discloses failures and hedges conditional claims

These strengths are meaningful and audience-relevant. Each is paired with development directions below.

---

## Strength Importance Ratings

| # | Strength | Category | Importance |
|---|----------|----------|-----------|
| 1.1 | NC_CLIGen — Verified Novel Domain | Novelty | Critical |
| 1.2 | SVG Cursor Supervision — Novel Training Insight | Novelty | Critical |
| 1.3 | NC/CNC Conceptual Framework | Novelty | Major |
| 2.1 | Data Engine Design and Infrastructure Quality | Technical | Major |
| 2.2 | Systematic Four-Mode Injection Ablation | Technical | Major (qualified) |
| 3.1 | Single-Variable Ablation Design | Experimental Rigor | Major |
| 3.2 | Decisive Large-Effect Results | Experimental Rigor | Critical |
| 3.3 | Transparent Limitation Disclosure | Experimental Rigor | Major |
| 4.1 | Problem Significance and Timeliness | Significance | Critical |
| 4.2 | Data Quality Over Quantity Finding | Significance | Major |
| 5.1 | Structural Clarity in 75-Page Document | Presentation | Major |
| 5.2 | Dense Cross-Disciplinary Citation | Presentation | Minor |
| 6.1 | Extensive Appendix Documentation | Reproducibility | Major |
| 7.1 | Two Complementary Interface-Spanning Systems | Generalizability | Major |

---

## Detailed Analysis by Category

---

### CATEGORY 1: NOVELTY AND ORIGINALITY

---

#### Strength 1.1: NC_CLIGen as a Verified Novel Domain

**Importance**: Critical

**Current State**:
NC_CLIGen (CLI/terminal video model) is a genuinely novel domain application with no prior work identified across approximately 250 candidates in the independent literature search conducted in Phase-3-5. No published paper was found that trains a video diffusion model on CLI/terminal interaction data, studies it empirically, or proposes terminal environments as a substrate for learned computation. Phase-3-5c novelty verdict: Verified Novel, High confidence.

Specific results that would not exist without this contribution: PSNR 26.89 dB under detailed caption conditioning (Table 3), character accuracy progression from 3% to 54% across 60k training steps (Table 4), arithmetic probe comparison (Table 5: NC_CLIGen 4%, Wan2.1 0%), and reprompting steerability result (Figure 6: 4% to 83%). These are the first numbers of any kind characterizing a learned video model on CLI/terminal content.

The data engine underlying NC_CLIGen is itself a contribution: approximately 824k video streams from public asciinema recordings, plus a Dockerized scripted pipeline producing approximately 128k controlled VHS traces. This two-tier data architecture — diversity/scale from CLIGen General; reproducibility/control from CLIGen Clean — has no direct precedent in the reviewed literature.

**Evidence Sources**: Phase-3-5c completion summary: Claim D status = Verified Novel, High confidence. Phase-3-5c: "No prior paper found across ~250 reviewed literature candidates addresses CLI/terminal video model simulation." GameNGen, DIAMOND, AVID, DWS, NeuralOS deep readings all confirmed no terminal/CLI work.

**Comparative Advantage**: GameNGen (ICLR 2025), DIAMOND (NeurIPS 2024), NeuralOS (ICLR 2026), AVID (ICLR 2025), and DWS (ICLR 2025) all operate in game or graphical desktop environments. None address terminal/CLI simulation. NC_CLIGen occupies a distinct, previously unoccupied niche.

**Development Direction**: This strength could be further developed by (a) expanding the CLIGen evaluation to multiple terminal emulators and font configurations, moving beyond the single standardized environment, (b) reporting the CLIGen Clean filtering criteria explicitly (currently MEDIUM-001 in CFR), and (c) conducting a human perceptual study to complement OCR-based metrics — for terminal rendering, character accuracy at 54% and pixel metrics may both understate or overstate functional quality for a human reading generated output.

---

#### Strength 1.2: SVG Cursor Supervision as a Novel Training Insight

**Importance**: Critical

**Current State**:
The discovery that explicit SVG-rendered cursor visual supervision — providing per-frame binary cursor masks and cursor-reference frames during training — raises cursor accuracy from 8.7% to 98.7% is the paper's largest single-variable empirical result (Table 9: delta = 90.0 percentage points, estimated Cohen's d > 5.0). Phase-3-5c novelty verdict: Verified Novel, High confidence (Claim E).

The insight is non-obvious: the baseline comparison (coordinate-only: 8.7%, Fourier encoding: 13.5%) demonstrates that standard conditioning approaches fail entirely on the cursor placement problem. The SVG approach represents a training-time engineering insight — injecting explicit visual structure to bypass the difficulty of learning cursor position from raw pixel coordinates — with clear practical implications for any video model applied to GUI environments.

**Evidence Sources**: Table 9, Experiment 8. Phase-3-5c: "SVG cursor supervision (novel training finding)." Results analysis Phase-3-4: Cohen's d > 5.0 estimated, effect decisively large under any plausible error bar.

**Comparative Advantage**: AVID's action conditioning (per-frame scale/shift) and DWS's per-block modulation address the injection design space but neither reports cursor-specific supervision. NeuralOS uses an RNN state for long-horizon cursor-relevant tracking, not an SVG visual supervision signal. The SVG approach is not anticipated by any of the five deeply-read papers.

**Development Direction**: This strength could be further developed by (a) testing whether the SVG supervision approach transfers to other pointing-device-intensive GUI tasks beyond cursor positioning — text selection, drag-and-drop, scrollbar interaction — (b) testing a simplified version (without full SVG templating) to isolate the key mechanism, and (c) reporting cursor accuracy under closed-loop conditions to confirm the 98.7% open-loop figure transfers to autonomous rollout.

---

#### Strength 1.3: The NC/CNC Conceptual Framework as a New Formal Abstraction

**Importance**: Major

**Current State**:
The NC abstraction (Eq. 2.1: h_t = F_theta(h_{t-1}, x_t, u_t); x_{t+1} ~ G_theta(h_t)) and the four-condition formal CNC definition (Turing complete, universally programmable, behavior-consistent, architecturally advantaged) constitute a new formal vocabulary not anticipated by the five deeply-read competing papers. Phase-3-5c confirms: "None of the five deeply-read papers adopt the NC/CNC abstraction, the 'runtime responsibilities' language, or the four-condition CNC specification."

The framework performs real analytical work: Table 13 uses it to compare four system objects (conventional computer, AI agent, world model, neural computer) at a common systems level; Table 14 gives an operational reading of each CNC requirement; Section 4.2 produces a concrete technical roadmap organized around the four gaps. The NC/CNC abstraction is not decorative — it structures the empirical agenda and shapes how findings are interpreted.

The conceptual differentiation from the NTM/DNC lineage (Graves et al. 2014, 2016) is explicit and correct: the NC concern is not differentiable external memory, but whether a learning machine can assume the role of the computer itself. This distinction opens a new research agenda.

**Evidence Sources**: Phase-3-5c: Claim A status = Partially Novel, High confidence. "Conceptual framing is new; formal specification (h_t, CNC four conditions) is new." Structural analysis: formal definition boxes and Tables 13-14 operationalize the framework throughout the paper.

**Comparative Advantage**: World model papers (GameNGen, DIAMOND) use "game engine" and "world model" framing. NeuralOS uses "OS simulation." None provide a formal definition of what a system must achieve to qualify as a neural computer in the sense of replacing a conventional computing substrate.

**Development Direction**: This strength would be substantially strengthened by (a) formally testing whether NC_CLIGen and NC_GUIWorld satisfy each of the four CNC conditions — the paper defines the conditions but never applies them to its own prototypes as a structured assessment, (b) providing a formal criterion distinguishing NC from world models at the mathematical level (the underlying q(o_n|o_<n,a_<=n) formulation is shared with GameNGen; a computational criterion for the distinction would strengthen the claim), and (c) expanding the Related Work section from its current ~1-page embedded treatment to a standalone section that rigorously situates the NC abstraction against NeuralOS, GameNGen, DIAMOND, and AVID/DWS.

---

### CATEGORY 2: TECHNICAL QUALITY

---

#### Strength 2.1: Data Engine Design and Infrastructure Quality

**Importance**: Major

**Current State**:
The data engineering for both systems is substantially beyond the minimum required for a systems paper. For NC_CLIGen, the combination of approximately 824k public asciinema recordings (CLIGen General: ~1,100 hours, diverse real workflows) with a fully Dockerized controlled scripted pipeline (CLIGen Clean: ~250k VHS scripts in reproducible containers) constitutes a two-tier data strategy: CLIGen General provides diversity and scale for broad capability learning; CLIGen Clean provides deterministic reproducibility for controlled evaluation. Dockerized scripting guarantees that terminal states are reproducible across runs — a non-trivial engineering decision that directly enables clean ablation (Experiments 2-6 all use CLIGen Clean).

For NC_GUIWorld, the recording pipeline (Xvfb/VNC/noVNC + mss + xdotool on Ubuntu 22.04/XFCE4/1024x768 at 15 FPS) is well-characterized and documented (Appendix D). Three data splits with documented action statistics (Table 7: Random Slow 1.58 actions/sec, Random Fast 4.18 actions/sec, CUA 0.10 actions/sec) provide a structured experimental corpus.

The practical payoff of this infrastructure is visible in Experiment 7: the data quality finding (110h CUA outperforms 1,400h random) is interpretable only because data collection conditions are documented and controllable.

**Evidence Sources**: Structural analysis Phase-2: Appendix B-D content. Results analysis Phase-3-4: Table 7 action statistics. Methodology evaluation Phase-3-2: "CLIGen General / CLIGen Clean separation is sound methodological practice."

**Development Direction**: This strength could be further developed by (a) publishing the full data collection pipeline code to enable extension beyond the paper's fixed app set, (b) characterizing the CLIGen General distribution more formally (the asciinema archive is biased toward developer workflows, but the distribution of command types, languages, and workflow patterns is not analyzed), and (c) describing the CLIGen Clean filtering criteria explicitly — "51.21% retained" with no description of filtering rules (MEDIUM-001 in CFR) is the most accessible documentation gap.

---

#### Strength 2.2: Systematic Four-Mode Injection Ablation

**Importance**: Major (with qualification noted below)

**Current State**:
The four-mode action injection ablation (external, contextual, residual, internal) represents a principled systematic exploration of injection depth as an architectural variable. The modes span the full design space from input-level (external: modulates VAE input), to attention-level (contextual: action tokens in joint self-attention), to block-external (residual: ControlNet-style branches), to block-internal (internal: CA_action sub-layer inside transformer blocks). Each mode is trained identically on the same data, evaluated on the same three metrics (SSIM+15, LPIPS+15, FVD+15), and produces a monotonic FVD improvement (external to internal: FVD 33.4 to 14.5, 56.6% improvement).

For video generation practitioners adapting pretrained video diffusion models to new action-conditioned domains, this characterization is directly usable as design guidance: internal conditioning achieves FVD+15 = 14.5 vs. contextual's 24.8 (41.5% improvement), which is a large enough effect to be practically significant as a design recommendation.

**Qualification**: Phase-3-5c establishes that AVID (ICLR 2025) and DWS (ICLR 2025) — both uncited — establish the same design space (per-frame scale/shift conditioning, per-block two-linear-layer modulation) for video DiTs applied to action conditioning. The injection mode ablation is original in its specific context (OS/GUI, cross-attention), but the design space is established in prior work. Once these citations are added, the ablation's contribution is better characterized as new evidence within an established design space applied to a new domain.

**Evidence Sources**: Results analysis Phase-3-4: Table 10. Methodology evaluation Phase-3-2: "systematic four-mode ablation is a principled study." Phase-3-5c: Claim C = Partially Novel, High confidence.

**Development Direction**: This strength would be substantially strengthened by (a) reporting per-mode parameter counts (HIGH-003 in CFR) to distinguish injection depth from parameter capacity, (b) completing the external baseline training run to its full compute budget (currently early-stopped at ~50%; disclosed in Table 10 footnote), (c) citing AVID and DWS and positioning the ablation within the established design space, and (d) providing 2-3 random seed repeats for Table 10 to resolve whether internal vs. residual SSIM Δ = 0.006 is a real difference or noise (CFR-007, HIGH).

---

### CATEGORY 3: EXPERIMENTAL RIGOR

---

#### Strength 3.1: Single-Variable Ablation Design

**Importance**: Major

**Current State**:
The paper's experiments are structured as clean single-variable ablations. Experiment 3 varies caption tier while holding model and data fixed. Experiment 7 varies training data source while holding conditioning mode and architecture fixed. Experiment 8 varies cursor supervision loss type while holding all other training components fixed. Experiment 9 varies injection mode while holding data, training steps, and non-action components fixed. Experiment 10 varies action encoding (raw vs. meta) while holding injection mode fixed.

This single-variable discipline enables attribution of findings to specific design choices, and is more rigorous than many system papers that report holistic system-vs-system comparisons. The paper's implicit experimental hierarchy — injection mode effect (SSIM delta ~0.050) is approximately 3x larger than encoding effect (SSIM delta ~0.016) — is derivable from Tables 10-11 and represents a quantitative priority ranking of design factors.

**Evidence Sources**: Experiment assessment Phase-3-3: "Experiments 3, 7, 8, 9, 10 each vary one factor while holding others fixed." Results analysis Phase-3-4: Tables 10-11 hierarchy derivable from reported numbers.

**Development Direction**: This strength could be further developed by (a) stating the quantitative hierarchy explicitly in the text ("injection depth is approximately 3x more impactful than encoding granularity") — the data supports this but the paper does not state it, (b) testing cross-factor interactions to determine whether injection depth and encoding type are additive or interactive, and (c) adding a missing zero-shot Wan2.1 row to Table 3 (caption ablation) to quantify the fine-tuning benefit that underlies the caption tier effect.

---

#### Strength 3.2: Decisive Large-Effect Results in Key Experiments

**Importance**: Critical

**Current State**:
Several key results are large enough to be decision-relevant independent of the statistical reporting gaps documented in CFR-009. Specifically:

- SVG cursor supervision: 98.7% vs. 8.7% cursor accuracy (Table 9), delta = 90.0 pp, estimated d > 5.0. Decisive under any plausible error bar.
- CUA data quality over random quantity: FVD 14.72 (110h CUA) vs. 48.17 (Random Fast, 400h) and 20.37 (Random Slow, 1,000h) — Table 8. CUA outperforms 12.7x more data by 69.4% on FVD.
- CLIGen fine-tuning progression: character accuracy 3% (untrained) to 54% (60k steps) — Table 4. Monotonic across seven checkpoints.
- Caption tier effect: +4.99 dB PSNR from semantic to detailed captions (Table 3), estimated d = 3.3-10.0.

These are not marginal improvements. The combination of large effects across multiple experiments provides convergent evidence for the paper's central empirical claims, even in the absence of formal statistical tests.

**Evidence Sources**: Results analysis Phase-3-4: effect size summary table. Phase-3-4 assessment: "robust to measurement uncertainty."

**Development Direction**: These decisive results would be further strengthened by (a) adding bootstrap confidence intervals to Tables 3 and 8 (the most important large-effect results), converting "likely decisive" findings to confirmed decisive ones, (b) reporting evaluation sample sizes for Tables 3 and 9 (currently unstated), and (c) adding a Wan2.1 zero-shot row to Table 3 to quantify how much fine-tuning contributes to the 26.89 dB result.

---

#### Strength 3.3: Transparent Disclosure of Limitations and Negative Results

**Importance**: Major

**Current State**:
The paper maintains consistent transparency about what its experiments do and do not demonstrate. Specific documented instances from prior phases:

- Reprompting result (83%) explicitly disclaimed: "We do not treat it as direct evidence of native arithmetic inside the NC backbone." The paper prevents its best number from being over-interpreted.
- PSNR plateau at 25k steps (Experiment 2) reported and interpreted as a negative training result, not minimized.
- External baseline early-stop in Table 10 disclosed in a footnote, not silently merged.
- Sora2's 71% arithmetic accuracy (far above NC_CLIGen's 4%) reported with three hedged hypotheses (Table 6), not downplayed.
- Section 3.2.4 explicitly states: "evaluation remains open-loop rather than closed-loop."
- Character accuracy ceiling (54%) not framed as success.
- Section 4 explicitly labeled "Position," accurately signaling vision/argument vs. evidence.

This combination of frank limitation acknowledgment is notably uncommon in ML system papers. The paper's epistemic humility about open challenges (symbolic stability, routine reuse, controlled updates, closed-loop behavior) lends its positive claims more credibility.

**Evidence Sources**: Methodology evaluation Phase-3-2: "marks of intellectual honesty." Results analysis Phase-3-4: balanced reporting section documents 5 specific instances. Structural analysis: Section 4 Position label.

**Development Direction**: This transparency could be further developed by (a) adding a formal "Limitations" section to consolidate the currently distributed limitation disclosures, (b) presenting a failure-case visualization gallery alongside the existing positive-case visualizations in Appendix E — the paper currently shows positive examples only, and a failure gallery would demonstrate that examples are not cherry-picked, and (c) converting Figure 6 (reprompting result, 4% to 83%) to a data table with sample size and CI — this is the paper's largest improvement figure and the one with the lowest current documentation standard (CFR-010).

---

### CATEGORY 4: SIGNIFICANCE AND IMPACT

---

#### Strength 4.1: Problem Significance and Timeliness

**Importance**: Critical

**Current State**:
The core question — whether a single neural network parameterization can serve as the substrate of a computer, rather than interfacing with, predicting, or controlling a separate computational process — is genuinely important and timely for April 2026. Video model capabilities have recently reached a plausible prototype threshold (Wan2.1, Sora2, Veo3.1). Computer-use agents are proliferating while still depending on separate execution environments.

The NC problem is differentiated from existing research lines: NTM/DNC addresses differentiable external memory; world models address environment prediction; AI agents address task execution using separate environments. The NC problem — collapsing the distinction between the model and the running computer — has its own success criteria, formalized in the four-condition CNC definition.

If NCs were to mature, they would represent a qualitatively different computing paradigm that merges programmability with learnability at the substrate level. Section 4's CNC roadmap provides a concrete research agenda organized around four measurable gaps.

**Evidence Sources**: Problem analysis Phase-3-1: "Novelty: High — NC abstraction distinct from NTM/DNC, world models, agents." "Impact: potentially significant." "Timeliness: Very high." Methodology evaluation Phase-3-2: "problem worth solving: Yes."

**Development Direction**: The significance could be better communicated by (a) developing a more extensive Related Work section that formally separates NC from world models, game engines, and OS simulators using the CNC four-condition definition as an organizing framework, (b) providing concrete "if-then" scenario analyses — specific applications enabled if symbolic stability is achieved — to make long-term significance tangible, and (c) quantifying the data-asymmetry motivation ("paired user I/O traces far more abundant than high-quality code"), which is currently asserted without evidence.

---

#### Strength 4.2: Data Quality Over Quantity Finding

**Importance**: Major

**Current State**:
Experiment 7 finds that 110h of goal-directed CUA data achieves FVD 14.72 while 1,400h of random exploration data achieves at best FVD 20.37 (Random Slow) and FVD 48.17 (Random Fast) — Table 8. CUA outperforms 12.7x more random data by 69.4% on FVD. This result provides actionable design guidance: prioritize curated, purposeful interactions over passive data collection for NC/interactive video model training.

The result is directionally robust to the documented action density confound (CFR-006: CUA has 0.10 actions/sec vs. Random Fast's 4.18 actions/sec, a 42x difference). The magnitude of the CUA advantage is large enough that the directional recommendation survives even if some of the benefit reflects lower action density.

**Evidence Sources**: Results analysis Phase-3-4: Table 8. Phase-3-4: "robust to measurement uncertainty." CFR-006: confound documented, directional recommendation "practically correct and likely directionally right."

**Development Direction**: This finding could be further developed by (a) adding a density-matched subsampled Random Fast condition to isolate goal-directedness versus action-sparsity (using existing data, this is a low-cost follow-up), (b) characterizing the CUA 110h dataset in terms of task diversity and coverage, and (c) testing whether the finding generalizes across conditioning modes — the experiment was conducted with contextual conditioning; whether internal conditioning shows the same data quality benefit is untested.

---

### CATEGORY 5: CLARITY AND PRESENTATION

---

#### Strength 5.1: Structural Clarity and Navigation in a 75-Page Document

**Importance**: Major

**Current State**:
For a 75-page paper, the structural organization is exceptionally well-designed. Key navigational features documented in structural analysis:

- Table of contents on page 1 covering all sections and appendices
- Numbered experiments (1-10) with color-coded icons (CLIGen and GUIWorld) for visual organization
- Formal definition boxes (NC Abstraction Teaser, CNC Abstraction, Run/Update Contract) in visually distinct isolated blocks
- Clickable thumbnail index pages (pp.12-13 for CLIGen, pp.20-21 for GUIWorld) linking to full-resolution appendix visualizations
- Subsection parallelism between NC_CLIGen (3.1) and NC_GUIWorld (3.2): both cover data pipeline, model architecture, implementation details, evaluation setup, and visualizations in the same order
- Explicit "Position" label for Section 4, accurately signaling the shift from empirical evidence to vision/argument

The Introduction is thesis-complete: it presents the formal NC definition boxes, the CNC definition box, the contribution list, and previews of all major results. This provides an effective executive summary before detailed reading.

**Evidence Sources**: Structural analysis Phase-2: "The table of contents provides excellent navigability." "Numbered experiments with color-coded icons provide clear visual organization." "Subsection parallelism makes the two systems easy to compare."

**Development Direction**: Presentation could be further strengthened by (a) adding a "Limitations" section that consolidates distributed limitation disclosures (as noted in Strength 3.3), (b) including a summary table aggregating all 10 experiments' metrics in one place, and (c) adding an explicit annotation to Figure 9 (human-machine relationship diagram) specifying which features of NC are currently demonstrated versus aspirational.

---

#### Strength 5.2: Dense Cross-Disciplinary Citation

**Importance**: Minor

**Current State**:
The approximately 87-reference list spans classical computability theory (Gödel 1931, Church 1935, Turing 1936, von Neumann 1993), foundational neural network works (Schmidhuber 1990-2018, Hochreiter & Schmidhuber 1997), world models (Ha & Schmidhuber 2018), and contemporary video generation (Wan 2025, Veo 2025, Sora 2025). The breadth connects the engineering work to the long intellectual arc of computation theory.

The explicit connections to Gödel numbering, Church-Turing thesis, and Turing completeness in Section 4.2, while going beyond what current prototypes demonstrate, give the paper intellectual depth.

**Evidence Sources**: Structural analysis Phase-2: citation distribution table showing ~10 classic computability references alongside contemporary ML references.

**Development Direction**: The citation breadth would be more credible if the missing citations (GameNGen, DIAMOND, AVID, DWS — HIGH-011 in CFR) were added, converting the related-work gap from a weakness into a demonstration of comprehensive coverage. Deepening the one-sentence treatment of NeuralOS into a proper comparative analysis section would strengthen rather than weaken the paper's positioning within the most relevant competing work.

---

### CATEGORY 6: REPRODUCIBILITY

---

#### Strength 6.1: Extensive Appendix Documentation

**Importance**: Major

**Current State**:
The 42-page appendix provides above-average documentation for a systems paper. Key reproducibility-supporting content:

- Appendix B: Full OCR evaluation protocol (B.2), GUIWorld evaluation metrics and protocol (B.3), caption field examples (B.1)
- Appendix C: CLI trajectory format examples — complete asciinema .cast file example (C.1) and VHS script example (C.2)
- Appendix D: Comprehensive GUIWorld engineering documentation — action schema (D.1), encoder and injection details with additional equations (D.2), temporal alignment and attention mask specification (D.3), cursor rendering and supervision pipeline (D.4), training signals and encoder design rationale (D.5)
- Appendix E: 30 full-resolution visualization figures (Figures 13-39) organized by system and task type

Appendix D includes 7 additional equations and detailed implementation rationale not in the main text. The breadth and specificity aid reproducibility substantially.

**Evidence Sources**: Structural analysis Phase-2: appendix table of contents (Appendices A-E), 39 total figures, equations in appendix. Methodology evaluation Phase-3-2: "appendix provides well-organized supplementary documentation."

**Development Direction**: Reproducibility support could be completed by (a) adding a configuration table to the appendix listing all action module hyperparameters — w (temporal window), l (lag), tau (contrastive temperature), layer indices for residual/internal injection, hidden dimensions — which are currently absent from both main text and appendix (MEDIUM-002 in CFR), (b) describing the CLIGen Clean filtering criteria (MEDIUM-001), and (c) providing a specific GitHub URL with license information for the data collection code.

---

### CATEGORY 7: GENERALIZABILITY

---

#### Strength 7.1: Two Complementary Systems Spanning Different Interface Paradigms

**Importance**: Major

**Current State**:
The paper presents two separate prototype systems — NC_CLIGen (text-based CLI) and NC_GUIWorld (graphical desktop GUI) — trained without shared weights but unified under the same NC abstraction. This dual-system approach provides evidence that the NC framework is not specific to one interface type.

The two systems make complementary empirical contributions: NC_CLIGen demonstrates terminal rendering is learnable, quantifies the symbolic computation bottleneck, and explores text conditioning. NC_GUIWorld demonstrates pixel-level action-response learning from recorded interactions, characterizes the injection design space, and introduces the cursor supervision finding. Together they bracket two qualitatively different computing interfaces.

This breadth exceeds adjacent prior work: GameNGen covers DOOM, DIAMOND covers CS:GO, NeuralOS covers Ubuntu XFCE. NC addresses two qualitatively different interface types with a common formal framework.

**Evidence Sources**: Structural analysis Phase-2: Section 3 dual-system organization. Results analysis Phase-3-4: 10 experiments across two systems covering complementary metrics.

**Development Direction**: The generalizability claim could be further supported by (a) demonstrating a shared result that holds across both systems — for example, testing whether scripted vs. random asciinema data shows the same quality advantage as CUA vs. random GUI data, (b) testing NC_GUIWorld on at least one additional OS visual theme or application set, and (c) presenting Table 13 (four system objects compared) as a framework that explicitly assesses where the two current prototypes fall on the NC-to-CNC spectrum.

---

## Comparative Advantages Summary

| What NC Does Better Than Related Work | Evidence Basis |
|---|---|
| First CLI/terminal video model — no prior work in this domain | Phase-3-5c: Verified Novel (Claim D) |
| SVG cursor supervision insight — not used in GameNGen, DIAMOND, AVID, NeuralOS | Phase-3-5c: Verified Novel (Claim E); Table 9: d > 5.0 |
| Four-condition formal CNC definition — no prior paper provides this | Phase-3-5c: Partially Novel (Claim A); Tables 13-14 |
| Two complementary systems (CLI + GUI) vs. single-domain prior work | Structural analysis Phase-2 |
| Explicit Section-4 "Position" label — transparent vision/evidence separation | Structural analysis Phase-2 |
| More comprehensive injection ablation depth (4 modes x 3 metrics) than GameNGen's single action-conditioning approach | Methodology evaluation Phase-3-2 vs. GameNGen deep reading |
| Frank open-challenge disclosure (symbolic stability, routine reuse, closed-loop behavior) | Results analysis Phase-3-4: balanced reporting instances |
| Documented action statistics per data split (Table 7) enabling confound analysis | Results analysis Phase-3-4 |

---

## Two-Layer Summary

### Current State

The Neural Computers paper achieves five verified strengths at submission: (1) NC_CLIGen is a first-of-its-kind contribution in a domain with no prior work — the CLI/terminal video simulation problem is unaddressed in the reviewed literature, the data infrastructure is real, and the empirical characterization is new. (2) SVG cursor supervision is a practically decisive training insight (90 pp absolute improvement) that will be directly useful to video model practitioners building GUI interfaces. (3) The NC/CNC conceptual framework is a new formal abstraction not anticipated by GameNGen, DIAMOND, AVID, DWS, or NeuralOS. (4) The data quality over quantity finding (110h CUA > 1,400h random) provides actionable design guidance for interactive video model training. (5) The paper's transparency about failures, open challenges, and conditional claims gives its positive results credibility by demonstrating that negative evidence is not being suppressed.

### Development Directions for Each Strength

| Strength | Most Impactful Development Direction |
|---|---|
| NC_CLIGen verified novel domain | Expand evaluation to multiple terminal environments; add human perceptual study; document CLIGen Clean filtering criteria |
| SVG cursor supervision | Test transfer to other GUI interaction types; report closed-loop cursor accuracy |
| NC/CNC conceptual framework | Apply CNC four conditions to evaluate own prototypes; expand Related Work to include GameNGen/DIAMOND/AVID/DWS |
| Data quality finding | Add density-matched Random Fast condition to isolate goal-directedness vs. action-sparsity |
| Transparency and balanced reporting | Add consolidated Limitations section; convert Figure 6 reprompting result to data table with sample size and CI |
| Data engine infrastructure | Publish full pipeline code with specific GitHub URL; document CLIGen Clean filtering criteria |
| Four-mode injection ablation | Report per-mode parameter counts; complete external baseline training run; cite AVID and DWS |
| Two complementary systems | Test data-quality finding across both systems for cross-domain validation |
| Dense cross-disciplinary citation | Add missing GameNGen, DIAMOND, AVID, DWS citations to convert related-work gap into strength |

---

## Overall Strengths Assessment

The paper's strongest claim to significance rests on NC_CLIGen (verified novel domain, no prior work) and SVG cursor supervision (decisive training insight, no prior work). These are the contributions most likely to survive review scrutiny because they are verified novel by independent literature search and supported by large-effect evidence that is robust to the paper's statistical reporting gaps.

The NC/CNC conceptual framework is the paper's most intellectually ambitious contribution. Its long-term impact depends on whether the community adopts it as an organizing schema — a more speculative but meaningful outcome if the roadmap it articulates generates subsequent research.

The data quality finding and transparent limitation disclosure are secondary strengths that strengthen the paper's credibility without forming its core novelty case. The structural and reproducibility strengths make the paper more usable by practitioners and more reviewable than most 75-page systems papers.

The paper's weaknesses documented in the CFR (especially HIGH-011 missing citations and HIGH-004 open-loop evaluation gap) are substantially correctable. Importantly, the strengths identified here are genuine and would survive correction of those weaknesses: NC_CLIGen's novelty does not depend on NC_GUIWorld's paradigm claims, and SVG cursor supervision's decisiveness does not depend on whether injection mode comparisons are statistically validated.

---

*Phase-4-1 Strengths Analysis complete.*
*Evidence basis: Phases 1-3-5c artifacts, including novelty_verification.md, critical_findings_registry.md, results_analysis.md, methodology_evaluation.md, experiment_assessment.md, structural_analysis.md, problem_analysis.md, and all five deep reading summaries.*
