# Reference Paper Search Log

## Search Strategy Summary
- **Total searches conducted**: 8 (4 WebSearch + 4 WebFetch for additional papers; Phase-3-5b deep readings leveraged for 5 pre-characterized papers)
- **Total papers examined**: ~35 (from literature_candidates.md) + ~10 (from new searches)
- **Papers selected for analysis**: 10
- **Search date**: 2026-04-15

---

## Pre-Phase Search: Leverage Phase-3-5 Work

**Source**: `artifacts/literature_candidates.md`, `artifacts/independent_literature_review.csv`, `artifacts/novelty_verification.md`
**Date**: 2026-04-15
**Papers Already Characterized**: 35 (literature_candidates.md) + 18 in CSV (at various reading levels)
**Papers with Full Deep Reading**: 5 (GameNGen, DIAMOND, AVID, DWS, NeuralOS — all at Level 2+ from Phase-3-5b)

**Papers Directly Adopted from Phase-3-5b Work**:
1. GameNGen (arXiv:2408.14837) — Level 3 reading, ICLR 2025 — selected as Reference 1
2. DIAMOND (arXiv:2405.12399) — Level 2+ reading, NeurIPS 2024 Spotlight — selected as Reference 2
3. NeuralOS (arXiv:2507.08800) — Level 3 reading, ICLR 2026 — selected as Reference 3
4. AVID (arXiv:2410.12822) — Level 2 reading, ICLR 2025 — selected as Reference 4
5. DWS (arXiv:2502.07825) — Level 2 reading, ICLR 2025 — selected as Reference 5
6. Genie (arXiv:2402.15391) — Level 0 reading, ICML 2024 — selected as Reference 7

**Notes**: Phase-3-5b already identified the five most important comparison papers through deep reading. All five are confirmed at ICLR 2025+ or NeurIPS 2024 Spotlight level, covering the core comparison dimensions. Genie was characterized in literature_candidates.md as a cited foundational work and adopted directly.

---

## Search #1: Backbone/Substrate Paper

**Query**: WebFetch of https://arxiv.org/abs/2503.20314 (Wan2.1 technical report)
**Tool**: WebFetch
**Date**: 2026-04-15
**Rationale**: NC_GUIWorld fine-tunes Wan2.1 DiT. Understanding the backbone is essential for evaluating NC's claimed contributions relative to pretrained capabilities.
**Result**: Wan2.1 confirmed: 60-page technical report; 1.3B and 14B models; 3D causal VAE + DiT architecture; open-source; March 2025.
**Papers Selected**: 1 (Wan2.1 as Reference 6)

**Notes**: Wan2.1 is cited by NC paper. Selected as reference because NC_GUIWorld's visual quality claims are only meaningful in context of what Wan2.1 can already do without action conditioning.

---

## Search #2: Computer-Use Agent Systems

**Query**: WebSearch — "Claude Computer Use AI agent desktop GUI system paper 2024"
**Tool**: WebSearch
**Date**: 2026-04-15
**Results Found**: 10 search results; primary paper: "The Dawn of GUI Agent: A Preliminary Case Study with Claude 3.5 Computer Use" (arXiv:2411.10323)
**Papers Identified**: 1 (Claude CUA study)
**Papers Selected**: 1 (selected as Reference 9)

**Rationale for Selection**: Claude CUA is NC_GUIWorld's primary training data source. Understanding the data-generating agent's capabilities is critical for evaluating NC's simulation fidelity. This paper provides the most systematic characterization of Claude CUA's behavior.

**Notes**: Several other GUI agent papers noted (UI-TARS, etc.) but not selected as they are not directly relevant to NC's training data or core comparison dimensions.

---

## Search #3: SeeAct / Alternative Paradigm Agent

**Query**: WebSearch — "SeeAct web GUI agent GPT-4V grounding 2024 arXiv"
**Tool**: WebSearch + WebFetch of arXiv:2401.01614
**Date**: 2026-04-15
**Results Found**: Multiple hits; SeeAct at ICML 2024 confirmed
**Papers Identified**: 1 (SeeAct / "GPT-4V is a Generalist Web Agent, if Grounded")
**Papers Selected**: 1 (selected as Reference 10)

**Rationale for Selection**: Represents the agent paradigm that NC explicitly contrasts itself with. ICML 2024 paper. The 51.1% task completion figure is a concrete benchmark for the alternative paradigm to NC's simulation approach. Enables "agent paradigm vs. simulation paradigm" comparison.

**Notes**: SeeAct is web-focused rather than desktop-focused, which is a limitation. However, as a top-venue ICML 2024 agent paper, it provides the clearest quantitative benchmark for the agent paradigm alternative.

---

## Search #4: OSWorld Benchmark Confirmation

**Query**: WebSearch — "OSWorld benchmark multimodal GUI agents computer tasks NeurIPS 2024"
**Tool**: WebSearch + WebFetch of arXiv:2404.07972
**Date**: 2026-04-15
**Results Found**: Confirmed NeurIPS 2024; 369 tasks; Ubuntu/Windows/macOS; 72.36% human vs. 12.24% best AI
**Papers Identified**: 1 (OSWorld)
**Papers Selected**: 1 (selected as Reference 8)

**Rationale for Selection**: Defines the real-computer-use evaluation landscape. The Anthropic CUA agent (NC_GUIWorld's data source) operates in OSWorld-type environments. Understanding OSWorld's task taxonomy and difficulty profile helps evaluate NC_GUIWorld's coverage claims. NeurIPS 2024 Datasets & Benchmarks track.

**Notes**: OSWorld is not a competing technical approach — it is a benchmark. Selected for evaluation context, not technical comparison.

---

## Search #5: Supplementary Interactive World Model Search

**Query**: WebSearch — "action-conditioned video generation world model interactive GUI desktop 2025 arXiv"
**Tool**: WebSearch
**Date**: 2026-04-15
**Results Found**: RELIC, Yan, Vid2World, Learning World Models (arXiv:2505.21996)
**Relevant Papers**: RELIC (December 2025), Vid2World (May 2025), Yan (2025)
**Papers Selected**: 0 (all postdate NC April 2026 submission or are less directly relevant than already-selected papers)

**Notes**: 
- RELIC (arXiv:2512.04040, December 2025): Interesting for long-horizon streaming video with keyboard control, but postdates NC by 8 months. Game-focused.
- Vid2World (arXiv:2505.14357, May 2025): Already identified in literature_candidates.md at Level 0 reading; postdates NC by ~1 month; causal masking approach. Excluded — postdates NC, less venue prominence than already-selected papers.
- Yan (2025): Interactive module on image-to-video; less directly relevant than AVID or DWS.
- Learning World Models (arXiv:2505.21996): May 2025; VRAG approach; too recent relative to NC.

---

## Search #6: Wan2.1 Confirmation

**Query**: WebSearch — "Wan2.1 video generation model Alibaba 2025 arXiv:2503.20314"
**Tool**: WebSearch
**Date**: 2026-04-15
**Results Found**: Confirmed open-source release, GitHub, architecture details
**Notes**: Confirms Wan2.1 as major open-source video generation model; 1.3B and 14B parameters; DiT backbone; 3D causal VAE; 8 downstream tasks. Strengthens rationale for selecting it as Reference 6.

---

## Papers Considered but Not Selected

| Paper | Reason for Exclusion |
|-------|---------------------|
| CUWM (arXiv:2602.17365) | Postdates NC paper (February 2026 vs. April 2026 NC submission — actually concurrent, not postdating); Level 0 only; less venue prominence (arXiv preprint only) |
| Vid2World (arXiv:2505.14357) | May 2025 — postdates NC by ~1 month; under review; less directly relevant than AVID and DWS which are ICLR 2025 |
| ViMo (arXiv:2504.13936) | Mobile GUI focus (not desktop); under review; less directly comparable than NeuralOS |
| iVideoGPT (arXiv:2405.15223) | RL/game focus; autoregressive not diffusion; less direct method relevance |
| LAPA (arXiv:2410.11758) | Robotics application; unsupervised latent action (vs. NC's explicit actions); less direct |
| AdaWorld (arXiv:2503.18938) | Robotics/game; latent actions; less direct than AVID/DWS |
| MineWorld (arXiv:2504.08388) | Minecraft/game; autoregressive; less direct method relevance |
| Code2World (arXiv:2602.09856) | Code-based (not pixel-based); postdates NC; arXiv preprint only |
| gWorld (arXiv:2602.01576) | Mobile focus; code generation; postdates NC |
| ControlNet (arXiv:2302.05543) | Architectural technique used in NC but not a competing work |
| UI-TARS (arXiv:2501.12326) | GUI agent (not world model); less directly relevant to NC's paradigm comparison than SeeAct |
| DreamerV3 (arXiv:2301.04104) | Already cited by NC; RL world model, not GUI simulation; well-known prior work |
| NTM/DNC (1410.5401/Nature) | Already cited by NC; conceptual contrast, not technical comparison |
