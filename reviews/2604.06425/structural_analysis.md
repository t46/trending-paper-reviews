# Structural Analysis: Neural Computers (arXiv:2604.06425)

## 1. Section Hierarchy and Organization

### Table of Contents (as printed in paper, p.1)

| Section | Title | Page Range |
|---------|-------|------------|
| 1 | Introduction | 2 |
| 2 | Preliminaries | 3–4 |
| 3 | Implementation of Neural Computers | 4–21 |
| 4 | Position: Toward Completely Neural Computers | 22–28 |
| 5 | Conclusion | 28 |
| — | Acknowledgements | 28 |
| — | References | 29–33 |
| Appendix | Appendix (A–E) | 34–75 |

---

## 2. Detailed Section Summary

### Abstract (p.1)
The abstract introduces Neural Computers (NCs) as "an emerging machine form that unifies computation, memory, and I/O in a learned runtime state." It distinguishes NCs from conventional computers (which execute explicit programs), AI agents (which act over external environments), and world models (which learn environment dynamics). The long-term goal is the Completely Neural Computer (CNC). Concretely, the paper instantiates NCs as video models that roll out screen frames from instructions, pixels, and user actions in CLI and GUI settings. The abstract lists three empirical findings (I/O alignment and short-horizon control achievable; routine reuse, controlled updates, and symbolic stability remain open) and concludes by outlining a CNC roadmap.

---

### Section 1: Introduction (p.2)
**Key points:**
- Introduces the Neural Computer (NC) concept: a neural system parameterized by theta that models an interactive computer interface through a single latent runtime state h_t
- Distinguishes NC from Neural Turing Machine / Differentiable Neural Computer lineage (Graves et al.): the concern is not differentiable external memory but whether a learning machine can assume the role of a running computer
- Motivates instantiation as video models (pragmatic prototype substrate)
- Introduces two concrete NC instantiations: NC_CLIGen (CLI/terminal interface) and NC_GUIWorld (desktop GUI interaction)
- Presents a formal "NC abstraction (Teaser)" box: (F, G) parameterized by theta, modeling interface through latent runtime state h_t
- Presents a "CNC abstraction" box: defines CNC as (i) Turing complete, (ii) universally programmable, (iii) behavior-consistent, (iv) architecturally advantaged
- Lists four contributions explicitly in bullet form
- Points to Section 4 for CNC roadmap

**Structural note:** Introduction is unusually dense and thesis-complete — it includes the formal NC definition box, the CNC definition box, the contribution list, and previews of all major results. This serves as an effective executive summary.

---

### Section 2: Preliminaries (p.3–4)
**Key points:**
- Defines "conventional digital computers" as von Neumann-style stored-program machines
- Presents the formal NC model: h_t = F_theta(h_{t-1}, x_t, u_t), x_{t+1} ~ G_theta(h_t) — Equation 2.1
- Explains notation: h_t is latent runtime state (NC persistent memory), F_theta is state-update computation, G_theta is decoder, (x_t, u_t, G_theta) define the I/O pathway
- Notes connection to world-model terminology (x_t as observations, u_t as conditioning/conditioning stream)
- Subsection 2.1 (Related Work, pp.3–4): surveys neuromorphic designs, fast weight programmers, Neural Turing Machines, Differentiable Neural Computers, Neural Programmer-Interpreters, world models, latent video models, Genie 3, Veo 3, Sora 2, NeuralOS, Imagine with Claude; positions paper relative to all these

**Structural note:** Related Work is embedded within Preliminaries as Subsection 2.1 rather than as a standalone section, which is unconventional but works well for a position-style paper. It is brief (~1 page) but covers the key neighboring lines of work.

---

### Section 3: Implementation of Neural Computers (pp.4–21)
This is the largest section (approximately 18 pages of main text, plus 11 pages of visualization thumbnails). It covers two NC instantiations.

#### 3.1 The CLI Video Generators (NC_CLIGen) (pp.5–11, +thumbnails pp.12–13)

**Subsections:**
- 3.1.1 Data pipeline
- 3.1.2 Model architecture
- 3.1.3 Implementation details
- 3.1.4 Evaluations (Experiments 1–6)
- 3.1.5 Visualizations

**Data:**
- CLIGen (General): 823,989 video streams (~1,100 hours) from public asciinema .cast trajectories; resampled at 15 FPS; LLM-generated captions at three granularity levels (semantic, regular, detailed)
- CLIGen (Clean): ~250k scripted VHS scripts in Dockerized environments; two subsets (~78k regular traces + ~50k Python math validation traces)

**Model architecture:**
- Built on Wan2.1 image-to-video model
- VAE encoder for first frame, CLIP image encoder for visual features, T5 text encoder for captions
- Conditioning features concatenated with diffusion noise, projected through zero-initialized linear layer, processed by DiT stack
- Decoupled cross-attention for joint caption and first-frame context

**Experiments (6 total):**
1. VAE reconstruction quality at different font sizes (PSNR/SSIM); shows 13px font adequate
2. Performance plateau and degradation with prolonged training (PSNR/SSIM curves)
3. Literal captions drive rendering accuracy (semantic: 21.90 dB vs. detailed: 26.89 dB PSNR)
4. Character-level text generation accuracy via OCR (Tesseract); char acc 0.54, exact-line 0.31 at 60k steps
5. Symbolic computation probe: arithmetic accuracy (NC_CLIGen: 4%, Wan2.1: 0%, Veo3.1: 2%, Sora2: 71%)
6. Reprompting boosts arithmetic performance from 4% to 83% without RL

#### 3.2 The GUI World Models (NC_GUIWorld) (pp.14–21, +thumbnails pp.20–21)

**Subsections:**
- 3.2.1 Data pipeline
- 3.2.2 Model architecture
- 3.2.3 Implementation details
- 3.2.4 Evaluation setup
- 3.2.5 Visualizations

**Data:**
- Three interaction splits: Random Slow (~1,000 hours), Random Fast (~400 hours), CUA supervised (~110 hours from Claude CUA)
- Ubuntu 22.04, XFCE4, 1024x768 at 15 FPS; apps include Firefox, GIMP, VLC, VS Code, Calculator, Terminal, file manager, Mahjongg
- Two action encoder variants: raw-action (v1, 182-d multi-hot) and meta-action (v2, API-like schema)

**Model architecture:**
- Built on Wan2.1, adding explicit action conditioning modules
- Four injection modes studied: external, contextual, residual, internal (Figure 7)
- External: action modulates VAE input before transformer
- Contextual: action tokens concatenated with visual tokens, processed via structured temporal attention mask (Figure 12)
- Residual: ControlNet-style block-external residual branches
- Internal: additional cross-attention sub-layer inside transformer blocks (best SSIM/FVD trade-off)

**Experiments (4 total, numbered 7–10):**
7. Data quality dominates: 110h Claude CUA outperforms 1,400h random exploration (FVD: 14.72 vs 48.17)
8. Precise cursor control requires explicit visual supervision (SVG mask/ref raises cursor accuracy from 13.5% to 98.7%)
9. Action injection depth matters: internal conditioning achieves SSIM 0.863, FVD 14.5 (best)
10. Meta-action encoding modestly outperforms raw-action encoding; difference is small relative to injection mode

---

### Section 4: Position: Toward Completely Neural Computers (pp.22–28)
This is the conceptual/position section, approximately 7 pages.

**Subsections:**
- 4.1 From Neural Computers to Completely Neural Computers (pp.22–23)
  - Current status of NCs
  - Fundamental differences between NCs and conventional computers
  - Definition of Completely Neural Computers (formal, 4 conditions)
  - Table 13: Four system objects compared at systems level (conventional computer, AI agent, world model, neural computer)
  - Table 14: Operational reading of the four CNC requirements

- 4.2 A Roadmap Towards CNC (pp.24–25)
  - Turing completeness (formal discussion, references to Siegelmann & Sontag 1992, Pérez et al. 2021)
  - Universal programmability
  - Behavior consistency (run/update contract box)
  - Architectural semantics / programming-language semantics

- 4.3 Relations to Other System Objects (pp.25–26)
  - Conventional computers
  - World models
  - AI agents
  - Figure 9: How the human-machine relation changes (conceptual diagram)

- 4.4 Additional Thoughts (pp.27–28)
  - ONE (Schmidhuber 2018) as systems-level realization
  - Video models as pragmatic prototype substrate
  - A hypothesis: machine-native neural architectures
  - Neural network generation via NC interaction
  - Unified hardware requirements and data representation

**Structural note:** Section 4 is a position/vision section that does not present new experiments. It provides the theoretical and conceptual framing that justifies the broader CNC vision. It is the paper's most argumentative section and draws heavily on classical computer science (Gödel, Church, Turing, von Neumann) and learning theory.

---

### Section 5: Conclusion (p.28)
One paragraph. Summarizes: NCs have begun to exhibit early runtime primitives (I/O alignment, short-horizon control); stable reuse, symbolic reliability, and runtime governance remain unresolved. Identifies the "more immediate gap" as moving from prototype behavior to usable runtime behavior. Closes with a conditional statement: if gaps close, NCs will "look less like isolated demonstrations and more like a plausible candidate machine form for next-generation computers."

---

### Acknowledgements (p.28)
Brief acknowledgement of Yasheng Sun (GUI data collection), Deyao Zhu and Firas Laakom (manuscript feedback), and KAUST funding sources (King Abdullah University of Science and Technology Center of Excellence for Generative AI, award 5940; SDAIA-KAUST Center of Excellence in Data Science and AI).

---

### References (pp.29–33)
Approximately 85–90 references spanning classic computability theory (Gödel 1931, Church 1935, Turing 1936, von Neumann 1993), foundational neural network works (Ivakhnenko 1965–1971, Schmidhuber 1990–2018, Hochreiter & Schmidhuber 1997), world models (Ha & Schmidhuber 2018, Hafner et al. 2019), video generation (Wan 2025, Google Veo 2025, OpenAI Sora 2025, Bruce et al. 2024), agents (Sager et al. 2025, OpenAI 2023, Zhuge et al. 2024a/b), and related neural computation (Graves et al. 2014, 2016, Reed & De Freitas 2015).

---

### Appendix (pp.34–75)

| Appendix | Title | Pages |
|----------|-------|-------|
| A | Explorations: Alternative Data Sources and Online Interaction | 34–36 |
| A.1 | Web video extraction | 34–36 |
| A.2 | Online environment interaction | 35–36 |
| B | Datasets: Collection and Evaluation Protocols | 37–39 |
| B.1 | Caption fields and metadata (CLIGen General) | 37 |
| B.2 | OCR evaluation protocol (CLIGen Clean) | 37–38 |
| B.3 | Evaluation metrics and protocol (GUIWorld) | 38–39 |
| C | CLIGen: CLI Trajectory Formats | 40–42 |
| C.1 | Asciinema (.cast) example | 40–41 |
| C.2 | VHS script example | 40–42 |
| D | GUIWorld: Action Representation, Temporal Alignment, and Conditioning | 43–47 |
| D.1 | Action schema | 43 |
| D.2 | Conditioning: encoders and injection | 43–44 |
| D.3 | Temporal alignment and attention | 44 |
| D.4 | Cursor rendering and supervision | 45 |
| D.5 | Training signals and encoder design | 45–47 |
| E | Additional Visualizations | 48–75 |
| E.1 | CLIGen Visualizations (Figures 13–25) | 48–61 |
| E.2 | GUIWorld Visualizations (Figures 26–39) | 62–75 |

The appendix is extensive (42 pages) and primarily consists of:
- Detailed data pipeline documentation (Appendix B, C)
- Technical details on GUIWorld action representation, temporal alignment, and cursor supervision (Appendix D, which contains additional equations)
- Full-resolution visualization pages (Appendix E, Figures 13–39), which constitute the majority of appendix content

---

## 3. Catalog of Figures, Tables, and Equations

### Figures

| Figure | Caption (summary) | Section |
|--------|-------------------|---------|
| 1 | Neural computers across interfaces: NC rolls out future interface frames for NC_CLIGen (CLI) and NC_GUIWorld (desktop) | p.3 (Sec 2) |
| 2 | Data types used to learn NC behaviors: CLIGen (General), CLIGen (Clean), GUIWorld datasets | p.5 (Sec 3.1) |
| 3 | NC_CLIGen architecture: terminal frames as observations x_t; Wan2.1-based latent state z_t | p.7 (Sec 3.1.2) |
| 4 | Wan2.1 VAE reconstructions on CLIGen (General) at different font sizes (6px dense vs 13px regular) | p.8 (Sec 3.1.4, Exp 1) |
| 5 | (a–b) Qualitative generations before/after CLIGen training; (c) CLIGen (Clean) PSNR/SSIM plateau at 25k steps | p.9 (Sec 3.1.4, Exp 2) |
| 6 | Reprompting boosts arithmetic performance from 4% to 83% | p.10 (Sec 3.1.4, Exp 6) |
| 7 | Four modes for injecting GUI actions into diffusion transformer (external, contextual, residual, internal) | p.15 (Sec 3.2.2) |
| 8 | Cursor references in GUIWorld: original desktop frames, binary cursor masks, cursor-only reference frames | p.17 (Sec 3.2.4, Exp 8) |
| 9 | Changing human-machine relations across conventional computers, agent era, and neural computers (conceptual diagram) | p.26 (Sec 4.3) |
| 10 | Common issues in web-scale screen video crawling | p.34 (App A) |
| 11 | Agentic online interaction pipeline (early exploration) | p.35 (App A.2) |
| 12 | Contextual attention mask for GUIWorld | p.47 (App D.3) |
| 13–15 | CLIGen (General) visualization samples A, B, C | pp.49–51 (App E.1) |
| 16–19 | CLIGen (Clean) REPL visualization samples A, B, C, D | pp.52–55 (App E.1) |
| 20–22 | CLIGen (Clean) math comparison samples A, B, C | pp.56–58 (App E.1) |
| 23–25 | CLIGen (Clean) math reprompting samples A, B, C | pp.59–61 (App E.1) |
| 26–39 | GUIWorld visualization samples 1–14 | pp.62–75 (App E.2) |

**Total figures in main text:** 9 (Figures 1–9)
**Total figures in appendix:** 30 (Figures 10–39)
**Total figures overall:** 39

Additionally, there are two non-numbered "thumbnail grid" pages in the main text (pp.12–13 for CLIGen and pp.20–21 for GUIWorld) that serve as clickable index pages pointing to full-resolution appendix pages.

### Tables

| Table | Caption (summary) | Section |
|-------|-------------------|---------|
| 1 | Data samples for CLIGen (General) and CLIGen (Clean) | p.6 (Sec 3.1) |
| 2 | Reconstruction quality (Average PSNR: 40.77, Average SSIM: 0.989) | p.8 (Sec 3.1.4, Exp 1) |
| 3 | Caption styles versus TI2V fidelity (Semantic/Regular/Detailed PSNR) | p.9 (Sec 3.1.4, Exp 3) |
| 4 | OCR accuracy versus training steps (char acc + exact line acc) | p.9 (Sec 3.1.4, Exp 4) |
| 5 | Arithmetic probe accuracy: Wan2.1/NC_CLIGen/Veo3.1/Sora2 | p.10 (Sec 3.1.4, Exp 5) |
| 6 | Hypotheses for Sora2's advantage (3 factors with implications) | p.10 (Sec 3.1.4, Exp 6) |
| 7 | Cursor/action statistics across data splits (Random Slow, Random Fast, CUA supervised) | p.14 (Sec 3.2.1) |
| 8 | Overall performance across data sources (FVD, SSIM, LPIPS) | p.17 (Sec 3.2.4, Exp 7) |
| 9 | Cursor conditioning losses versus accuracy (position only, +Fourier, +SVG mask/ref) | p.17 (Sec 3.2.4, Exp 8) |
| 10 | Action-driven metrics across injection schemes (SSIM+15, LPIPS+15, FVD+15) | p.18 (Sec 3.2.4, Exp 9) |
| 11 | Raw-action vs. API-like action encoding under same injection mode | p.18 (Sec 3.2.4, Exp 10) |
| 12 | Encoding examples for raw-action and meta-action encoders | p.19 (Sec 3.2.2) |
| 13 | Four system objects compared at common systems level | p.23 (Sec 4.1) |
| 14 | Operational reading of the four CNC requirements | p.23 (Sec 4.2) |
| 15 | Caption tiers and metadata for CLIGen (General) clip 7****_0001 | p.38 (App B.1) |
| 16 | Meta-action schema for GUIWorld (per action slot) | p.43 (App D.1) |
| 17 | Raw-action versus meta-action encoders in GUIWorld (detailed comparison) | p.46 (App D.2) |

**Total tables: 17**

### Equations

| Equation | Content | Section |
|----------|---------|---------|
| 2.1 | Core NC update-and-render loop: h_t = F_theta(h_{t-1}, x_t, u_t); x_{t+1} ~ G_theta(h_t) | p.4 (Sec 2) |
| (unlabeled, p.15) | External conditioning: z'_{1:T} = z_{1:T} + Delta z_{1:T}(u_{1:T}) | p.15 (Sec 3.2.2) |
| (unlabeled, p.16) | Internal block computation: h' = FFN(h + CA_text(SA(h), c) + CA_action(h, a)) | p.16 (Sec 3.2.2) |
| (unlabeled, p.38) | char_acc = max(0, 1 - d(s,t)/max(|s|,1)) (Levenshtein-based character accuracy) | p.38 (App B.2) |
| (unlabeled, p.38) | exact_line_acc = (1/N_g) sum_{i=1}^{N_g} 1[i<=N_p and p_i=g_i] | p.38 (App B.2) |
| (unlabeled, p.43) | Residual update: h_tilde^{(l)} = h^{(l)} + Delta h^{(l)}(a, mouse) | p.43 (App D.2) |
| (unlabeled, p.44) | Internal block: h' = FFN(h + CA_text(SA(h), c) + CA_action(h, a)) | p.44 (App D.2) |
| (unlabeled, p.44) | Temporal window: W_{t,k} = r_tilde_{a_t - (p-1+l)+k}; a_t^act = (1/p) sum W_{t,k} | p.44 (App D.3) |
| (unlabeled, p.45) | Normalized cursor coordinate mapping: x_t = (s*x_screen,t + p_x) / (w_dst - 1) | p.45 (App D.4) |

**Total named/numbered equations: 1 (Eq. 2.1)**
**Total unlabeled equations: ~8 additional**
**Formal definitions/boxes: 3 (NC Abstraction Teaser, CNC Abstraction, Run/Update Contract)**

---

## 4. Structural Assessment

### Organizational Pattern

The paper follows a hybrid organizational pattern: **system description + position paper**. The first half (Sections 1–3) is a standard systems/empirical paper presenting two concrete implementations with experimental ablations. The second half (Section 4) is an explicit position section that argues for a new computing paradigm. This dual structure is explicitly flagged in the table of contents (Section 4 is titled "Position: Toward Completely Neural Computers").

This dual-mode structure is unusual in ML papers but has precedent in systems/vision papers that combine implementation with vision statements (e.g., DALL-E, GPT-4 technical report style).

### Logical Flow

The paper's narrative logic is clear and linear:

1. Abstract and Introduction establish the thesis (NCs as a new machine form) and preview all findings
2. Preliminaries give the formal model and situate related work
3. Section 3 provides empirical grounding for current NC capabilities and limitations through two prototype systems
4. Section 4 uses the empirical findings as a launching pad for the position argument: what constitutes a CNC, and what remains to be solved
5. Conclusion synthesizes findings and restates the gap

The transition from Section 3 (empirical) to Section 4 (position) is well-marked and intentional.

### Proportionality Analysis

| Component | Pages (approx.) | % of main text (1–33) |
|-----------|----------------|----------------------|
| Introduction + Preliminaries + Related Work | 3 | ~9% |
| CLI Implementation + Experiments | 10 | ~30% |
| GUI Implementation + Experiments | 8 | ~24% |
| Position + CNC Roadmap | 7 | ~21% |
| Conclusion + Acknowledgements | 1 | ~3% |
| References | 5 | ~15% |

The position section (Section 4) is comparatively large for a systems paper, reflecting the dual nature of the contribution. CLI experiments are given slightly more attention than GUI experiments.

### Section Balance Assessment

- Introduction: appropriately detailed and self-contained; the inclusion of formal definition boxes early is a strength
- Preliminaries: lean and functional; related work is compressed but identifies key prior work
- Section 3: well-structured into parallel subsections for CLIGen and GUIWorld, making the two systems easy to compare; ten experiments are clearly numbered and color-coded by system
- Section 4: the position section is ambitious and broad; it draws on a large range of sources (from Gödel to LLMs) and makes claims that go well beyond the empirical results, which is appropriate for a position section but introduces interpretive risks
- Conclusion: brief but sufficient; could benefit from being slightly longer to synthesize the position section's claims
- Appendix: very substantial (42 pages) and well-organized, providing reproducibility support; the large volume of visualization pages is appropriate for a video/visual system paper

### Structural Strengths

1. The table of contents on page 1 provides excellent navigability for a 75-page paper
2. The explicit labeling of Section 4 as a "Position" section is transparent and useful for the reader
3. Numbered experiments (Experiments 1–10) with color-coded icons (CLIGen vs. GUIWorld) provide clear visual organization across the implementations section
4. Formal definition boxes (NC Abstraction, CNC Abstraction, Run/Update Contract) are visually distinct and efficiently communicate key formal content
5. The clickable thumbnail index pages (pp.12–13, 20–21) provide navigation hooks linking to full-resolution visualization pages in the appendix — a sophisticated structural feature
6. The appendix is well-organized with lettered sections (A–E), each covering a distinct purpose (explorations, datasets, data formats, action representation, visualizations)
7. Subsection parallelism between 3.1 and 3.2 (data pipeline, model architecture, implementation details, evaluation setup, visualizations) makes the two systems easy to compare

### Structural Weaknesses

1. Related Work is embedded inside Preliminaries (Section 2.1) rather than given a standalone section. While it works in context, this makes the related work harder to locate and limits the space for comparison. Given the novel claims in Section 4, a fuller related work discussion would strengthen the paper's positioning
2. Section 4 (Position) is long and heterogeneous, combining formal computability analysis (Section 4.2) with speculative additional thoughts (Section 4.4). The section could benefit from clearer internal demarcation between established claims and hypotheses — though Section 4.4 does note its speculative nature
3. There is no standalone "Discussion" section. Discussion is distributed across subsections (within each experiment and within Section 4). This diffuse structure means there is no single place where the key limitations are consolidated
4. The Conclusion is brief (one paragraph) relative to the ambitious scope of the paper; it does not address the position claims in Section 4 in depth
5. Some experiments share tables that span different experiments (Tables 5 and 6 both concern Experiment 5/6), which slightly complicates reading
6. The paper has 39 figures, of which 30 are in the appendix. Many are full-page visualization samples. This is appropriate for a video system paper but creates a large document that may be unwieldy for reviewers

---

## 5. Paper Type Classification

### Primary Type: System

**Justification:**
- The paper's core contribution is the design, implementation, and evaluation of two concrete neural computer prototype systems (NC_CLIGen and NC_GUIWorld)
- The emphasis throughout Section 3 is on engineering decisions: data pipeline design, model architecture (Wan2.1 as backbone, VAE, DiT, CLIP, T5), training recipes, action conditioning schemes, and practical takeaways
- The evaluation metrics (PSNR, SSIM, LPIPS, FVD, OCR accuracy, cursor control accuracy) are system-level performance metrics, not algorithmic novelty metrics
- Scalability and data quality considerations are prominently featured (15,000+ H100 GPU hours; 23k GPU-hours per full GUIWorld pass; 1,400+ hours of interaction data)
- Appendix D provides extensive engineering documentation on action representation, temporal alignment, and cursor supervision — the hallmark of a systems paper

### Secondary Type: Analysis / Position

**Justification:**
- Section 4 is explicitly titled "Position: Toward Completely Neural Computers" and constitutes approximately 21% of the main text (7 pages)
- The paper engages in conceptual analysis: defining Turing completeness, universal programmability, and behavior consistency for NCs; distinguishing NCs from world models and AI agents; and characterizing what engineering evidence for CNC progress should look like (Tables 13 and 14)
- Section 4 contains no new experiments; it is argumentative and comparative analysis of existing concepts and systems

### Summary

**Primary Type**: System
**Secondary Type**: Analysis/Position

---

## 6. Theoretical Content Flag

**HAS_THEORETICAL_CONTENT: No**

**Justification:**
- The paper contains one formal model definition (Equation 2.1: the NC update-and-render loop) and three formal definition boxes (NC abstraction, CNC abstraction, Run/Update contract). These are definitional, not analytical.
- Section 4.2 discusses Turing completeness, universal programmability, and behavior consistency in conceptual/operational terms, referencing theoretical results from prior work (Siegelmann & Sontag 1992; Pérez et al. 2021; Graves et al. 2014, 2016). However, it does not prove new theorems, derive new lemmas, or provide formal proofs or proof sketches of its own.
- The paper makes no formal complexity claims, convergence proofs, generalization bounds, or sample complexity analyses.
- There are no theorems, lemmas, propositions, or corollaries in the paper.
- The mathematical content in the paper is limited to:
  - Equation 2.1 (NC model definition)
  - Action conditioning equations (architectural descriptions)
  - Metric definitions (OCR accuracy formulas in Appendix B.2)
  - Coordinate normalization formulas (Appendix D.4)
  - Temporal windowing equations (Appendix D.3)

All mathematical content is definitional or descriptive rather than analytical.

**Conclusion**: Phase-3-2b (Theory Analysis) should NOT be executed for this paper.

---

## 7. References Summary

**Estimated total references: approximately 87**

**Citation distribution by topic:**
- Video generation / world models: ~15 references (Ha & Schmidhuber, Hafner, Bruce/Genie, Wan, Veo, Sora, Matrix-Game-2, Wiedemer)
- Neural computation / NTM / DNC: ~10 references (Graves 2014/2016, Reed & De Freitas, Schmidhuber 1992/1993a/1993b/1990/2015/2018, Katz, Davis, Mead)
- Classic computability / CS theory: ~10 references (Gödel, Church, Turing, von Neumann, Siegelmann & Sontag, Pérez, Wilkes, Hartmanis & Simon, Anagnostopoulos)
- Language models / foundation models: ~12 references (Brown, Radford, Bommasani, Vaswani, Wei, Ouyang, Jurafsky & Martin, Reynolds & McDonell)
- AI agents / computer use: ~8 references (Anthropic, OpenAI, Hong, Sager, Zhuge 2024a/2024b, 2026a/b)
- Learning / neural network fundamentals: ~10 references (Ivakhnenko, Hinton, Bishop, Bengio, Poggio, Fukushima, Hochreiter)
- Systems / hardware / OS: ~5 references (Tanenbaum & Austin, Silberschatz, Gregg, Sz, Vasilache)
- Miscellaneous (robotics, RL, data generation): ~17 references

**Most frequently cited authors/works:**
- Schmidhuber (multiple papers across multiple decades: 1990, 1992, 1993a/b, 2015, 2018)
- Zhuge (multiple papers as lead author or co-author)
- Graves et al. (2014, 2016 — NTM and DNC)
- Ha & Schmidhuber (2018 — world models)

**Citation style:** Author-year (Harvard style), consistent throughout
