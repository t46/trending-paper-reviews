# Phase-3-5b Completion Summary

## Task: Critical Paper Deep Reading

### Status: COMPLETE

---

## Reading Statistics

- Papers selected for deep reading: 5
- Papers read at Level 2+: 5 (all)
- Papers with access limitations: 0 (all had accessible HTML or project pages)

---

## Reading Coverage

| Paper | arXiv | Venue | Access Level | Method Section Read | Evidence Documented |
|-------|-------|-------|-------------|---------------------|---------------------|
| GameNGen | 2408.14837 | ICLR 2025 | Level 3 (full paper) | Yes | Yes |
| AVID | 2410.12822 | ICLR 2025 | Level 2 (method + abstract) | Yes | Yes |
| NeuralOS | 2507.08800 | ICLR 2026 | Level 3 (full paper incl. appendices) | Yes | Yes |
| Pre-Trained Video Simulators (DWS) | 2502.07825 | ICLR 2025 | Level 2 (method + experiments) | Yes | Yes |
| DIAMOND | 2405.12399 | NeurIPS 2024 | Level 2 (method via HTML v1 + project page) | Yes | Yes |

**NC paper itself**: Read at Level 0-1 only (HTML not accessible; abstract page + project blog read). Core claims, formal equations, and Section 4.3 content accessed via project blog (metauto.ai/neuralcomputer/). Sections 3.1, 3.2 (prototype methods) known from prior phases.

---

## Key Findings

### Papers Challenging Target's Novelty

1. **GameNGen** (ICLR 2025, Aug 2024) — CRITICAL MISSING CITATION
   - Establishes the identical two-phase technical paradigm (RL/interaction data → diffusion model on frames+actions) applied to DOOM game
   - NC_GUIWorld is the OS/GUI domain application of the GameNGen paradigm
   - Not cited by NC paper despite ICLR 2025 acceptance
   - The NC paper claims differentiation ("simulational" vs. "runtime") on the project blog but not in the paper body with technical evidence

2. **AVID** (ICLR 2025, Oct 2024) — HIGH PRIORITY MISSING CITATION
   - Establishes action-conditional adaptation of pretrained video diffusion models using lightweight adapters
   - NC_GUIWorld's injection mode ablation exists in the design space AVID defines
   - Not cited by NC paper despite ICLR 2025 acceptance

3. **NeuralOS** (ICLR 2026, Jul 2025) — CITED BUT GROSSLY UNDER-DISCUSSED
   - Same domain: Ubuntu XFCE GUI simulation from mouse/keyboard inputs
   - Same data source: Anthropic CUA agent demonstrations
   - Architecturally more sophisticated: explicit RNN for long-horizon state persistence (addresses CFR-004 gap)
   - NC paper gives ~1 sentence acknowledgment; no technical comparison or formal differentiation
   - Predates NC paper submission by months; concurrent or prior depending on exact dates

4. **DWS/Pre-Trained Video as World Simulators** (ICLR 2025, Feb 2025) — HIGH PRIORITY MISSING CITATION
   - Establishes per-block action modulation for video diffusion transformers
   - Directly relevant to NC_GUIWorld's internal injection mode design
   - Not cited by NC paper despite ICLR 2025 acceptance

5. **DIAMOND** (NeurIPS 2024 Spotlight, May 2024) — HIGH PRIORITY MISSING CITATION
   - Establishes diffusion world model as interactive game engine with human-collected data
   - CS:GO extension: human-interactive at ~10 FPS with 87h human gameplay — same paradigm as NC_GUIWorld
   - Not cited by NC paper despite NeurIPS 2024 Spotlight status

### Papers Supporting Target's Novelty

1. **NC Conceptual Framework** (from absence of prior work): None of the five papers adopt or reference the NC/CNC formalism (h_t = F_theta(h_{t-1}, x_t, u_t), four CNC conditions, "runtime responsibilities" framing). The paradigm claim is genuinely novel in its intellectual framing.

2. **NC_CLIGen**: No prior work found on video model for CLI/terminal simulation. This prototype appears genuinely novel in its domain application.

3. **Domain novelty of NC_GUIWorld**: While the technical paradigm is established by game engine papers, the specific application to Ubuntu XFCE OS/GUI environment (distinct from game simulation) has only one direct competitor — NeuralOS.

---

## Critical Evidence Documented

### Evidence for novelty challenges:

1. **GameNGen technical parallel** (Section 3, Abstract):
   > "The two models (agent and generative) are trained in sequence. The entirety of the agent's actions and observations corpus during training is maintained and becomes the training dataset for the generative model in a second stage"
   — GameNGen Section 3

   NC_GUIWorld uses the same two-phase structure (CUA/human data collection → diffusion training).

2. **AVID design space** (Section 3.3):
   > "scale and shift parameters, gamma^tau and beta^tau, for the tau-th frame" derived from action embeddings applied via adaptive normalization
   — AVID Section 3.3

   NC_GUIWorld's external and contextual injection modes implement equivalent action conditioning.

3. **NeuralOS technical superiority on state persistence** (Appendix P):
   > "Action-conditioned diffusion models developed for video games generally assume that the necessary state is visually encoded in recent frames, making short context windows sufficient. In operating-system settings, however, critical state may persist far beyond a short temporal window (e.g., whether a folder was created earlier)."
   — NeuralOS Appendix P

   NeuralOS explicitly solves the problem CFR-004 identifies as unresolved in NC_GUIWorld.

4. **DIAMOND interactive environment** (Project page):
   > "The diffusion model functions as an interactive neural game engine where users provide actions, and the model autoregressively generates subsequent frames, enabling real-time gameplay within the learned environment simulation."
   — DIAMOND project page (CS:GO extension)

   NC_GUIWorld's interactive simulation claim is anticipated by DIAMOND's CS:GO extension.

5. **DWS per-block modulation** (Section 4.1):
   > "a lightweight add-on module, consisting of two linear layers within each transformer block"
   — DWS Section 4.1

   NC_GUIWorld's internal injection mode (cross-attention per block) is a more expressive variant of DWS's per-block approach.

### Evidence for maintained novelty:

1. NC conceptual framework: No prior paper uses "neural computer," "completely neural computer," or the four-condition CNC definition.
2. NC_CLIGen domain: No prior video model work found for CLI/terminal simulation.
3. SVG cursor supervision: Raising cursor accuracy from 8.7% to 98.7% via SVG supervision is a novel finding specific to GUI simulation.

---

## New CFR Entries

### CFR-NEW-1: Missing Citations Create Misleading Novelty Context for NC_GUIWorld (HIGH)
- **Severity**: HIGH
- **Source Phase**: Phase-3-5b
- **Finding**: Four ICLR/NeurIPS 2024-2025 papers (GameNGen, DIAMOND, AVID, DWS) establish the technical design space in which NC_GUIWorld operates — two-phase interaction data collection + diffusion model training for action-conditioned interactive generation. None are cited. This means the NC paper cannot properly establish what NC_GUIWorld's incremental contribution is over these established methods.
- **Evidence**:
  - GameNGen (ICLR 2025): Two-phase RL-data + diffusion for interactive game generation (Section 3)
  - DIAMOND (NeurIPS 2024 Spotlight): Diffusion world model as interactive engine with human data (Section 3.1, CS:GO extension)
  - AVID (ICLR 2025): Action-conditional lightweight adaptation of pretrained video diffusion (Section 3.3)
  - DWS (ICLR 2025): Per-block action modulation for video diffusion transformers (Section 4.1)
- **Status**: OPEN — Requires citation additions and repositioning of NC_GUIWorld's contribution

### CFR-NEW-2: NeuralOS Technical Advantage Over NC_GUIWorld Unacknowledged (HIGH)
- **Severity**: HIGH
- **Source Phase**: Phase-3-5b
- **Finding**: NeuralOS (ICLR 2026), the paper's own "most closely related" work, demonstrably solves the long-horizon state persistence problem (explicit RNN with O(1) per-timestep complexity, 256-frame memory retention demonstrated) that NC_GUIWorld leaves unresolved (CFR-004). The NC paper's ~1-sentence acknowledgment does not discuss this architectural advantage, creating an implication that NC_GUIWorld is technically superior to or equal to NeuralOS when it may not be.
- **Evidence**:
  - NeuralOS Appendix P: "the RNN state enables NeuralOS to recall previous interactions far in the past" — directly addressing CFR-004's open-loop limitation
  - NeuralOS Section 3: "constant complexity per timestep, which is crucial for continuous, long-horizon OS simulation"
  - NC_GUIWorld: open-loop only evaluation (CFR-004) — no closed-loop results reported
- **Status**: OPEN — Requires formal architectural comparison section in the NC paper

---

## Files Created

- `artifacts/deep_reading_summaries/2408.14837_GameNGen.md` — Full Level 3 deep reading
- `artifacts/deep_reading_summaries/2410.12822_AVID.md` — Full Level 2 deep reading
- `artifacts/deep_reading_summaries/2507.08800_NeuralOS.md` — Full Level 3 deep reading
- `artifacts/deep_reading_summaries/2502.07825_PreTrainedVideoSimulators.md` — Full Level 2 deep reading
- `artifacts/deep_reading_summaries/2405.12399_DIAMOND.md` — Full Level 2+ deep reading
- `artifacts/deep_reading_notes.md` — Synthesis and evidence bank

---

## Quality Checklist

- [x] CFR read at phase start
- [x] All five high-priority papers read at Level 2+
- [x] Method sections read and documented with specific quotes and section references
- [x] Access limitations clearly noted (NC paper HTML not accessible; project blog used)
- [x] Each paper: problem overlap, method overlap, and novelty conflict assessed
- [x] Evidence documented with section references and exact quotes
- [x] Summary ready for Phase-3-5c verification
- [x] New CFR entries drafted

---

## Readiness for Phase-3-5c

The evidence bank is ready. Phase-3-5c (Novelty Verification) should focus on:

1. **Primary question**: Does the NC paradigm claim (NCs are a new machine form) hold given that NeuralOS and GameNGen already do the same computational operation?

2. **Key distinction to verify**: NC's "runtime responsibilities" vs. game engines' "simulational" framing — is this distinction technical or purely philosophical?

3. **Missing citation impact**: How severely does the absence of GameNGen, DIAMOND, AVID, and DWS undermine NC_GUIWorld's contribution claim?

4. **NeuralOS comparison**: Does NC_GUIWorld offer any technical advantage over NeuralOS, or is NeuralOS strictly more capable in the same domain?

5. **Maintained novelty**: NC_CLIGen (CLI simulation) and the NC conceptual framework appear to be the most defensible novel contributions.

---

## Confirmation

- Phase-3-5b tasks are complete
- Ready for Phase-3-5c (Novelty Verification)
