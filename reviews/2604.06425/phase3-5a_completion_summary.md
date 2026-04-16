# Phase-3-5a Completion Summary

## Task: Literature Discovery

### Status: COMPLETE

---

## Authors' Claims Extracted

- **Main contributions**: 6 claims identified (NC abstraction, paradigm differentiation, NTM/DNC distinction, NC_CLIGen system, NC_GUIWorld system, CNC roadmap)
- **Gaps claimed**: 5 gaps identified (no prior neural-as-computer work; NTM/DNC is about external memory; world models keep runtime outside; agents use external environments; NeuralOS/Imagine with Claude underexplored)
- **Related work coverage**: 17 papers/works cited in Section 2.1 (~1 page of Related Work)

---

## Search Results

- **Total papers examined**: approximately 250
- **High relevance candidates**: 8
- **Medium relevance candidates**: 17
- **Low relevance candidates**: 7
- **Search sessions conducted**: 40

---

## Search Coverage

**Search strategies used**:
- Problem-based search (NC concept, NeuralOS, learned OS)
- Method-based search (video diffusion world models, GUI/CLI simulation, action conditioning)
- Citation-based search (backward: foundational papers; forward: what cites Graves/Ha-Schmidhuber)
- Author-based search (Zhuge/KAUST, Graves, Hafner lineage)
- Venue-based search (ICLR 2025, NeurIPS 2024, ICML 2025 proceedings)

**Time period covered**: 2014–2026 (primary focus: 2023–2026)

**Venues covered**: ICLR 2025, NeurIPS 2024, ICML 2025, ICCV 2023, Nature 2025, NeurIPS 2021, ICML 2024

---

## Key Findings

### Critical Observation: GUI World Model Space is Dense
The GUI/desktop world model space saw rapid growth in 2025–2026 with at least 6 relevant systems (ViMo, CUWM, Code2World, gWorld, NeuralOS, NC_GUIWorld). This is the primary gap in the NC paper's Related Work section.

### Critical Observation: NC Paradigm Space is Sparse
Searches for "neural computer as runtime" found effectively zero prior work beyond the NC paper itself and NeuralOS. The conceptual claim of the paper is genuinely differentiated from all found literature. The question is whether the technical implementation (video model for screen prediction) is as differentiated as the conceptual claim.

### Critical Observation: Game World Model Literature is Relevant and Uncited
GameNGen, DIAMOND, Oasis, MineWorld, Matrix-Game (1/2) all do action-conditioned video prediction for interactive environments. GameNGen and DIAMOND predate the NC paper and are not cited despite being directly relevant.

### Critical Observation: Imagine with Claude is Not a Video System
"Imagine with Claude" is a live-code-generation product (Claude writes code that renders as interactive UI), not a video generation system. The NC paper's acknowledgment of it as "closely related" may not be accurate — it is more analogous to a code-generating agent than a video-based NC prototype.

---

## Papers NOT Cited by Target Paper (Potential Missing Citations)

**Pre-submission papers that are not cited (most important)**:

| Paper | arXiv | Year | Severity of Omission |
|-------|-------|------|---------------------|
| GameNGen | 2408.14837 | Aug 2024 | HIGH — directly relevant diffusion game engine |
| DIAMOND | 2405.12399 | May 2024 | HIGH — NeurIPS 2024 Spotlight diffusion world model |
| AVID | 2410.12822 | Oct 2024 | HIGH — ICLR 2025 video diffusion action conditioning |
| Pre-Trained Video as World Simulators | 2502.07825 | Feb 2025 | HIGH — ICLR 2025 same problem |
| LAPA | 2410.11758 | Oct 2024 | MEDIUM — ICLR 2025 latent action from videos |
| ViMo | 2504.13936 | Apr 2025 | MEDIUM — visual GUI world model |
| AdaWorld | 2503.18938 | Mar 2025 | MEDIUM — ICML 2025 latent action world model |
| ControlNet | 2302.05543 | Feb 2023 | MEDIUM — used but not cited (residual injection mode) |

**Post-submission papers (cannot be missing citations)**:
- CUWM (arXiv:2602.17365, Feb 2026)
- Code2World (arXiv:2602.09856, Feb 2026)
- gWorld (arXiv:2602.01576, Feb 2026)
- MineWorld (arXiv:2504.08388, Apr 2025 — borderline; may be concurrent)
- NeuralOS (arXiv:2507.08800, Jul 2025 — clearly postdates)

---

## Papers Recommended for Deep Reading in Phase-3-5b

### Priority 1 — CRITICAL

1. **NeuralOS (arXiv:2507.08800)** — Most closely related acknowledged system; needs formal differentiation analysis
   - Read for: Architecture comparison (RNN+diffusion vs. DiT fine-tuning), conceptual framing, whether it fits the NC abstraction

2. **GameNGen (arXiv:2408.14837)** — Diffusion game engine; not cited; direct technical analog
   - Read for: Whether "neural game engine" claim overlaps with "neural computer" claim; action conditioning approach comparison

3. **AVID (arXiv:2410.12822)** — Not cited; ICLR 2025; same problem of adapting video diffusion for action conditioning
   - Read for: Whether the adapter method overlaps with NC_GUIWorld's injection modes; methodological differentiation

### Priority 2 — HIGH

4. **Pre-Trained Video as World Simulators (arXiv:2502.07825)** — ICLR 2025; lightweight universal action module
   - Read for: DWS module design comparison with NC_GUIWorld injection modes

5. **DIAMOND (arXiv:2405.12399)** — NeurIPS 2024 Spotlight; diffusion world model + interactive game engine
   - Read for: Whether the RL-in-imagination framing vs. NC-as-computer framing is a meaningful distinction

6. **Vid2World (arXiv:2505.14357)** — Concurrent/postdates; most methodologically parallel approach
   - Read for: Causal masking approach comparison with NC_GUIWorld internal injection

### Priority 3 — MEDIUM

7. **ViMo (arXiv:2504.13936)** — GUI world model for mobile agents; visual approach
   - Read for: Whether symbolic text representation (STR) vs. pixel-level prediction is a meaningful distinction

8. **Computer-Using World Model (arXiv:2602.17365)** — Contemporary desktop GUI world model
   - Read for: Whether the two-stage factorization (text+visual) vs. NC's end-to-end pixel approach represents a substantive difference

9. **Genie 1 (arXiv:2402.15391)** — Cited; read for foundational understanding
   - Read for: Latent action model approach; unsupervised action inference vs. NC's explicit action conditioning

10. **LAPA (arXiv:2410.11758)** — Latent action pretraining
    - Read for: How unsupervised latent action extraction compares to NC's explicit action collection and conditioning philosophy

---

## Files Created

- `artifacts/novelty_claims_extraction.md` — Authors' claims with quotes, locations, and gap analysis
- `artifacts/literature_candidates.md` — 35 candidate papers with full metadata and relevance assessment
- `artifacts/literature_search_log.md` — 40 search sessions documented
- `artifacts/phase3-5a_completion_summary.md` — This file

---

## Quality Checklist

- [x] Authors' novelty claims clearly extracted with quotes and locations
- [x] 35 candidate papers identified (exceeds 20–30 target)
- [x] Multiple search strategies used (problem, method, citation, author, venue)
- [x] All searches documented in search log (40 sessions)
- [x] Candidates categorized by relevance (High/Medium/Low)
- [x] Papers NOT cited by authors flagged (8 pre-submission; 5 post-submission)
- [x] Recommendations for Phase-3-5b deep reading provided (10 papers with rationale)
- [x] NO technical claims made about paper methods (only abstract-level descriptions)

---

## Confirmation

- Phase-3-5a tasks are complete
- Ready for Phase-3-5b (Deep Reading)

### Next Step

Phase-3-5b should deeply read the following papers in priority order:
1. NeuralOS (arXiv:2507.08800) — CRITICAL
2. GameNGen (arXiv:2408.14837) — CRITICAL
3. AVID (arXiv:2410.12822) — CRITICAL
4. Pre-Trained Video as World Simulators (arXiv:2502.07825) — HIGH
5. DIAMOND (arXiv:2405.12399) — HIGH
6. Vid2World (arXiv:2505.14357) — HIGH
7. ViMo (arXiv:2504.13936) — MEDIUM
8. Computer-Using World Model (arXiv:2602.17365) — MEDIUM
9. Genie 1 (arXiv:2402.15391) — MEDIUM
10. LAPA (arXiv:2410.11758) — MEDIUM
