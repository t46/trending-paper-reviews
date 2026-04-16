# Citation Coverage Analysis

## Reference Papers vs. Target Paper Citations

**Target Paper**: Neural Computers (arXiv:2604.06425)
**Reference Papers Selected**: 10
**Analysis Date**: 2026-04-15

---

## Papers in Both Lists (Cited by Target + Selected as Reference)

| Reference # | Paper | Cited in NC | Citation Depth |
|-------------|-------|-------------|----------------|
| Ref 3 | NeuralOS (arXiv:2507.08800) | Yes — Section 2.1 | ~1 sentence; inadequate for direct competitor |
| Ref 7 | Genie (Bruce et al. 2024, ICML 2024) | Yes — mentioned | Standard citation; appropriate depth |
| Ref 6 | Wan2.1 (arXiv:2503.20314) | Yes — cited as backbone | Appropriate; backbone acknowledgment |

**Analysis**: NC paper cites 3/10 selected references. Coverage is narrow (30%) and critically inadequate — the five most methodologically important comparison papers (GameNGen, DIAMOND, AVID, DWS, and OSWorld) are entirely absent from the NC paper's citations.

The single citation of NeuralOS is particularly problematic: it receives one sentence in a ~1-page related work section despite being the most direct domain competitor. No quantitative comparison is provided.

---

## Critical Papers NOT Cited by Target

The following papers were available before NC's April 7, 2026 submission date and are directly relevant to NC's core claims:

### High Priority Missing Citations

**1. GameNGen (arXiv:2408.14837, ICLR 2025, August 2024)**
- **Direct Relevance**: Establishes the two-phase paradigm (RL interaction data collection → diffusion model trained on frames+actions) that NC_GUIWorld directly instantiates. GameNGen's formal definition q(o_n|o_<n,a_<=n) is mathematically equivalent to NC's Eq. 2.1. The paper demonstrates at ICLR 2025 that this approach works for game environments; NC_GUIWorld applies it to OS/GUI environments.
- **Why "Must Cite"**: NC_GUIWorld's training pipeline is the domain application of GameNGen's paradigm. Not citing GameNGen creates the impression that NC invents this paradigm when it applies it. This is the single most important missing citation.
- **Published**: August 2024 — 20 months before NC submission
- **Impact**: ICLR 2025 accepted paper; high visibility in the community

**2. DIAMOND (arXiv:2405.12399, NeurIPS 2024 Spotlight, May 2024)**
- **Direct Relevance**: DIAMOND's CS:GO interactive game engine extension uses fixed human gameplay data (87h, no RL) → diffusion model → interactive play — identical to NC_GUIWorld's CUA data → Wan2.1 fine-tune → interactive simulation approach. DIAMOND is a NeurIPS 2024 Spotlight paper explicitly demonstrating the "human-collected data → interactive diffusion simulation" paradigm that NC_GUIWorld extends to OS/GUI.
- **Why "Must Cite"**: DIAMOND directly precedes NC_GUIWorld's paradigm in game domains. With 197 citations, it is the canonical reference for this approach. Not citing DIAMOND makes NC_GUIWorld's contribution appear more novel at the paradigm level than it is.
- **Published**: May 2024 — 23 months before NC submission
- **Impact**: NeurIPS 2024 Spotlight; 197 Semantic Scholar citations; highest-impact missing citation

**3. AVID (arXiv:2410.12822, ICLR 2025, October 2024)**
- **Direct Relevance**: AVID addresses adapting pretrained video diffusion models to action-conditioned world models using adapter-based injection — directly establishing the design space that NC_GUIWorld's four-mode injection ablation (external/internal/residual/concatenation) explores. AVID's per-frame scale/shift conditioning (adaptive normalization) is a direct methodological precedent for NC_GUIWorld's injection modes.
- **Why "Must Cite"**: NC_GUIWorld's claimed contribution of characterizing the "design space for action conditioning in video diffusion models" (Claim C in Phase-3-5c) is substantially anticipated by AVID's adapter approach. Not citing AVID misrepresents NC's contribution as more novel than it is.
- **Published**: October 2024 — 18 months before NC submission
- **Impact**: ICLR 2025; Microsoft Research authors; directly comparable method

**4. DWS / Pre-Trained Video Generative Models as World Simulators (arXiv:2502.07825, ICLR 2025, February 2025)**
- **Direct Relevance**: DWS proposes per-block lightweight action conditioning of pretrained video transformer models — architecturally equivalent to NC_GUIWorld's internal injection mode. DWS's formula (per-block scale-shift modulation) appears before NC by 14 months in a peer-reviewed ICLR 2025 paper.
- **Why "Must Cite"**: NC_GUIWorld's internal injection mode (per-block cross-attention) is the same design concept as DWS's per-block scale-shift modulation, differing only in parameterization. Not citing DWS makes NC_GUIWorld's internal injection mode appear novel when the core concept is established.
- **Published**: February 2025 — 14 months before NC submission
- **Impact**: ICLR 2025; directly overlapping method

### Medium Priority Missing Citations

**5. OSWorld (arXiv:2404.07972, NeurIPS 2024, April 2024)**
- **Direct Relevance**: OSWorld defines the real-computer-use evaluation landscape. NC_GUIWorld's training data (Claude CUA agent trajectories on Ubuntu) is generated by the same type of agent system that OSWorld benchmarks. NC should cite OSWorld to contextualize what "computer use" means and what the agent data quality covers.
- **Why "Should Cite"**: OSWorld is the canonical NeurIPS 2024 benchmark for computer use agents. NC paper's claim to be "beyond agents" requires understanding what agent-based computer use currently achieves — OSWorld quantifies this precisely. The 72.36% human vs. 12.24% AI gap in OSWorld is essential context for NC's positioning.
- **Published**: April 2024 — 24 months before NC submission
- **Impact**: NeurIPS 2024; ~300+ citations; canonical in the field

**6. ControlNet (arXiv:2302.05543, ICCV 2023)**
- **Direct Relevance**: NC_GUIWorld's "residual injection mode" is described in the paper as "ControlNet-style" residual injection. This is an uncited technical dependency.
- **Why "Should Cite"**: If the paper uses the term "ControlNet-style" or implements residual injection inspired by ControlNet, it should cite the source. This is a minor but clear citation gap identified in Phase-3-5b.
- **Published**: February 2023 — technical precursor
- **Impact**: ICCV 2023; minor citation gap

---

## Papers Cited by Target but NOT Selected as Reference

| Paper | Reason Not Selected as Reference |
|-------|----------------------------------|
| Neural Turing Machines (Graves et al. 2014) | Conceptual contrast only; too distant methodologically for comparative analysis |
| DNC (Graves et al. 2016) | Same reason as NTM; conceptual contrast |
| World Models (Ha & Schmidhuber 2018) | Foundational paper; conceptual baseline, not technical comparator |
| DreamerV3 (Hafner et al. 2023) | Well-known prior; RL world model, not GUI simulation |
| Neural Programmer-Interpreters (Reed 2015) | Intellectual ancestry; no technical comparison feasible |
| One Big Net (Schmidhuber 2018) | Intellectual ancestor; no technical comparison feasible |
| Matrix-Game (cited as contemporaneous) | Game focus; no formal arXiv paper for full comparison |
| Genie 3 (cited as contemporaneous) | No formal paper; blog post only |

**Analysis**: NC paper's citations skew heavily toward conceptual/historical context (NTM, DNC, world models lineage, Schmidhuber works) rather than direct technical comparators. The paper's related work section serves the purpose of establishing intellectual positioning rather than engaging with the technical landscape. This is appropriate for a position/vision paper but inadequate for papers making specific technical contribution claims.

---

## Overall Citation Coverage Assessment

**Coverage ratio**: 3/10 selected references cited (30%)

**Critical gap**: NC paper cites 0 of the 4 most methodologically comparable peer-reviewed papers (GameNGen, DIAMOND, AVID, DWS). All four predate NC by 14-23 months and were published at top venues (ICLR 2025 x3, NeurIPS 2024 Spotlight).

**Assessment**: Citation coverage is INADEQUATE for a paper making specific technical contribution claims about NC_GUIWorld's methodology. The conceptual contributions (NC framing, CNC four conditions) are not undermined by these gaps, but the technical contribution claims (injection mode ablation novelty, paradigm novelty of the training pipeline) are significantly weakened by the absence of these citations.

**Implication for Phase-5-2**: Comparative analysis should explicitly note which metrics and design choices from the 10 reference papers can or cannot be directly compared to NC's reported results, given that NC does not compare against these works in its own experimental section.
