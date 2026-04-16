# Phase-5-1 Completion Summary

## Task: Reference Paper Collection for Neural Computers (arXiv:2604.06425)

---

## Papers Collected

- **Papers already characterized from Phase-3-5b**: 6 (GameNGen, DIAMOND, NeuralOS, AVID, DWS, Genie — all from literature_candidates.md and independent_literature_review.csv)
- **Additional papers identified and characterized in this phase**: 4 (Wan2.1, OSWorld, Claude CUA study, SeeAct)
- **Total candidate pool examined**: ~45 (35 from Phase-3-5 + ~10 from new searches)
- **Papers selected for analysis**: 10

---

## Selection Breakdown

| Category | Papers | Count |
|----------|--------|-------|
| Highly similar (problem + method) | GameNGen (Ref 1), NeuralOS (Ref 3), DWS (Ref 5) | 3 |
| Same/adjacent problem, different method | DIAMOND (Ref 2), Genie (Ref 7) | 2 |
| Similar method, different problem | AVID (Ref 4), Wan2.1 backbone (Ref 6) | 2 |
| Agent/evaluation paradigm context | OSWorld (Ref 8), Claude CUA Study (Ref 9), SeeAct (Ref 10) | 3 |
| **Total** | | **10** |

---

## Temporal Distribution

| Period | Papers | Count |
|--------|--------|-------|
| 2024 (pre-NC) | GameNGen, DIAMOND, AVID, Genie, OSWorld, Claude CUA Study, SeeAct | 7 |
| 2025 (pre-NC) | DWS, Wan2.1, NeuralOS (submitted July 2025) | 3 |
| After NC submission | None selected | 0 |

Note: All papers predate or are contemporaneous with NC's April 7, 2026 submission. NeuralOS was submitted July 2025 and accepted ICLR 2026 — it postdates NC's submission date but precedes NC's arXiv appearance. The NC paper cites NeuralOS (one sentence), confirming the authors were aware of it.

---

## Venue Distribution

| Venue Type | Papers | Count |
|------------|--------|-------|
| Top-tier conferences (ICLR/NeurIPS/ICML) | GameNGen (ICLR 2025), DIAMOND (NeurIPS 2024 Spotlight), AVID (ICLR 2025), DWS (ICLR 2025), Genie (ICML 2024), OSWorld (NeurIPS 2024), SeeAct (ICML 2024), NeuralOS (ICLR 2026) | 8 |
| arXiv preprint | Wan2.1 (arXiv:2503.20314), Claude CUA Study (arXiv:2411.10323) | 2 |

All 10 references are from high-quality sources. 8/10 are from top-tier peer-reviewed venues.

---

## Key Findings

### Reference Paper Landscape

The reference paper landscape reveals that NC's two key technical systems operate in well-developed research areas:

1. **NC_GUIWorld sits within a competitive interactive world model literature**: GameNGen (ICLR 2025), DIAMOND (NeurIPS 2024 Spotlight), AVID (ICLR 2025), and DWS (ICLR 2025) all address the same core technical challenge — action-conditioned video diffusion for interactive simulation — and predate NC by 14-23 months. NeuralOS addresses the identical domain (Ubuntu XFCE GUI) using a different architecture. None of these papers are cited by NC (except NeuralOS with one sentence).

2. **NC_CLIGen lacks direct comparable reference papers**: No well-known peer-reviewed papers specifically address CLI/terminal neural simulation. This may represent genuine novelty for that subsystem, or an underdeveloped evaluation landscape.

3. **The "agent paradigm" comparison is important context**: OSWorld (NeurIPS 2024) and SeeAct (ICML 2024) quantify what the competing agent-based approach to computer use achieves. NC positions itself "beyond agents" but does not compare against agent capabilities quantitatively.

4. **Wan2.1 is the performance baseline**: NC_GUIWorld's visual quality metrics (FVD 14.72) must be interpreted relative to Wan2.1's pretrained quality to assess how much of the performance is from the backbone vs. the action conditioning.

### Notable Patterns

- NC paper's citation profile is biased toward conceptual/historical context and excludes direct technical comparators
- 4 of the 5 most methodologically comparable papers (GameNGen, DIAMOND, AVID, DWS) are entirely absent from NC's citations despite being ICLR 2025 or NeurIPS 2024 Spotlight papers
- The Phase-3-5b deep readings (5 papers at Level 2+) provide strong evidence-based characterizations for the 5 most critical reference papers — significantly more reliable than abstract-level selection

---

## Citation Coverage

- NC target cites **3/10** selected references (30%)
- **4 critical papers missing** from NC citations (GameNGen, DIAMOND, AVID, DWS) — all peer-reviewed, all available 14-23 months before NC submission
- **1 inadequately cited** paper (NeuralOS — direct domain competitor, cited with one sentence, no technical comparison)
- Assessment: Citation coverage INADEQUATE for a paper making specific technical contribution claims

---

## Phase-5-1 Quality Checklist

- [x] 10 reference papers selected (exactly 10)
- [x] At least 3 papers from 2023-2025 (all 10 are from 2024-2025)
- [x] At least 2 papers from high-impact venues (8/10 from top-tier conferences)
- [x] At least 2 papers NOT cited by target (7/10 not cited by NC: Refs 1, 2, 4, 5, 8, 9, 10)
- [x] Mix includes: 3+ high similarity (Refs 1, 3, 5), 3+ medium similarity (Refs 2, 4, 7), 2+ for context (Refs 8, 9, 10), 1 backbone (Ref 6)
- [x] Each paper has title, authors, year, venue, URL
- [x] Each paper has explicit relevance rationale
- [x] Problem/method similarity scores justified with specific reasons
- [x] At least 3 different search strategies used (Phase-3-5b leverage + 5 new searches)
- [x] Search log documents queries and selection rationale
- [x] Citation coverage analysis completed

---

## Next Steps

Reference papers are ready for comparative analysis in Phase-5-2:
- Phase-5-2 should read Refs 7, 8, 9, 10 at Level 1 (abstract + intro) — currently at Level 0
- Phase-5-2 should extract quantitative metrics from Refs 1, 2, 3, 4, 5 (already read at Level 2+ in Phase-3-5b)
- Primary comparison targets for Phase-5-2: Refs 1 (GameNGen), 2 (DIAMOND), 3 (NeuralOS), 4 (AVID), 5 (DWS)

---

## Files Created

- `artifacts/reference_papers.md` — 10 reference papers with full characterization
- `artifacts/reference_paper_search_log.md` — Search log with queries and rationale
- `artifacts/citation_coverage_analysis.md` — Citation gap analysis
- `artifacts/phase5-1_completion_summary.md` — This file

---

## Confirmation

Phase-5-1 tasks are complete. Ready to proceed to Phase-5-2 (Comparative Analysis).
