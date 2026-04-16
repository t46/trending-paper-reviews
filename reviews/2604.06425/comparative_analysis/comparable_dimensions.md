# Comparable Dimensions Across Papers

## Dimension 1: Research Problem Scope

**Observation across references**:

- **Ref 1 (GameNGen)**: Narrow, specific problem — simulate one game (DOOM) in real time at high quality using a neural model
- **Ref 2 (DIAMOND)**: Medium scope — diffusion world model for RL agent training; CS:GO interactive extension as secondary contribution
- **Ref 3 (NeuralOS)**: Narrow, specific problem — simulate Ubuntu XFCE GUI from mouse/keyboard inputs using neural networks
- **Ref 4 (AVID)**: Medium-narrow — adapt pretrained video diffusion models to action-conditioned world models (black-box)
- **Ref 5 (DWS)**: Medium — architecture-agnostic framework for converting pretrained video models to world simulators
- **Ref 6 (Wan2.1)**: Very broad — general-purpose video generation foundation model (T2V, I2V, editing, personal video)
- **Ref 7 (Genie)**: Medium-broad — foundation world model trained unsupervised on internet videos for generative interactive environments
- **Ref 8 (OSWorld)**: Medium — benchmark for evaluating multimodal agents on computer tasks across real OS environments
- **Ref 9 (Claude CUA Study)**: Narrow — evaluation study of Claude 3.5 Computer Use as a GUI agent
- **Ref 10 (SeeAct)**: Medium-narrow — generalist web agent framework using multimodal LLMs with visual grounding

**Target paper (NC) position**:

The NC paper has dual scope: (1) a broad conceptual claim — "neural computers are an emerging machine form" covering CLI and GUI computing environments; (2) two narrow prototype demonstrations (NC_CLIGen for terminal, NC_GUIWorld for Ubuntu XFCE GUI). The conceptual claim is broader than most references; the prototype implementations are narrow.

**Comparison**: The combination of sweeping conceptual claims with two relatively narrow prototype systems is distinctive among references. Most references either make narrow claims with narrow implementations (GameNGen, NeuralOS) or broad claims with correspondingly large-scale experiments (Genie: 11B model, 30k hours). The NC paper's claim-to-evidence ratio — paradigm-level claims supported by two prototype systems with open-loop evaluation — is wider than typical field practice.

---

## Dimension 2: Methodological Novelty Type

**Observation across references**:

- **GameNGen**: New application domain (neural game engine) using established SD v1.4 backbone; methodological novelty in noise augmentation for autoregressive stability
- **DIAMOND**: New application of diffusion to RL world modeling; EDM formulation choice enables key stability properties
- **NeuralOS**: Novel hybrid architecture (RNN + diffusion renderer) with four-stage training curriculum; novel Gaussian cursor encoding
- **AVID**: Novel adapter design (output-space masking) with theoretical motivation (proof that PoE composition is biased)
- **DWS**: Novel framework contribution — architecture-agnostic per-block action conditioning with motion-reinforced loss
- **Wan2.1**: Large-scale model training with novel 3D causal VAE; systems-level contribution
- **Genie**: Unsupervised latent action discovery via LAM; spatiotemporal transformer scaling
- **OSWorld**: Benchmark contribution — 369 task taxonomy with evaluation infrastructure
- **Claude CUA Study**: Evaluation study — no novel architecture or training method
- **SeeAct**: Novel grounding pipeline combining visual LLM plans with multiple HTML grounding strategies

**Target paper (NC) position**:

NC's methodological novelty type is primarily: (1) new application domain (OS/GUI simulation with explicit cursor supervision); (2) systematic ablation study (four injection modes); (3) conceptual framework (NC/CNC abstraction). The NC paper does not propose a fundamentally new architecture or training algorithm.

**Comparison**: Most comparable to GameNGen and NeuralOS in novelty type — domain application of established techniques with some specific engineering innovations (cursor supervision, data pipeline). The NC paper's four-mode injection ablation is similar in spirit to DWS's architecture-agnostic analysis but less theoretically grounded. NeuralOS has a more architecturally novel contribution (RNN + diffusion renderer hybrid solving long-horizon state persistence).

---

## Dimension 3: Dataset Selection and Scale

**Observation across references**:

- **GameNGen**: Single domain (DOOM RL trajectories); no publicly available benchmark dataset comparison
- **DIAMOND**: Atari 100k benchmark (26 games); CS:GO 87h human gameplay
- **NeuralOS**: Ubuntu XFCE recordings (random + CUA agent); 120K × 30s = ~1000h+
- **AVID**: Video game data + robotics data (two domains)
- **DWS**: BAIR robot + Procgen (Coinrun, Ninja) + Atari (Breakout, Battle Zone) — 4 distinct environments
- **Wan2.1**: Billions of images and videos (internal large-scale data)
- **Genie**: 6.8M filtered clips (30k hours platformer gameplay); RT1 robotics dataset
- **OSWorld**: 369 hand-annotated tasks across Ubuntu/Windows; real desktop + web + multi-app
- **Claude CUA Study**: 20 tasks across 4 domains (web, workflow, office, games)
- **SeeAct**: Mind2Web (2000+ tasks, 137 websites); online live website evaluation

**NC paper datasets**:
- NC_CLIGen General: ~824k videos, ~1,100h (asciinema); NC_CLIGen Clean: ~128k (scripted VHS)
- NC_GUIWorld: Random Slow ~1,000h, Random Fast ~400h, CUA ~110h
- Fixed app set: Firefox, GIMP, VLC, VS Code, Calculator, Terminal, File Manager, Mahjongg

**Comparison**:

For GUIWorld, the NC paper's dataset scale (1,510h total) is comparable to or exceeds NeuralOS's data scale (120K × 30s ≈ 1,000h), though detailed comparison is difficult due to different data sources. However, the NC paper trains on a **fixed 8-app set**, meaning evaluation is limited to apps covered in training. NeuralOS demonstrates cross-app generalization (DOOM, never installed). No cross-domain generalization experiment appears in the NC paper.

For CLIGen, the 824k/128k scale is appropriate for the domain; no comparable dataset exists for CLI video simulation.

The NC paper **does not benchmark against OSWorld tasks** despite OSWorld being the primary standard for evaluating computer use competence (NeurIPS 2024). This is a significant missing evaluation dimension: NC_GUIWorld is trained on CUA agent trajectories but never evaluated against whether those trajectories cover OSWorld-style tasks or whether NC_GUIWorld's simulation generalizes to OSWorld task scenarios.

---

## Dimension 4: Baseline Coverage

**Observation across references**:

| System | Baseline Count | Baseline Types |
|--------|---------------|----------------|
| GameNGen | 4 (ablations + human rater) | Noise augmentation ablation, decoder fine-tuning ablation, human perceptual study |
| DIAMOND | 5 (Atari 100k SOTA) | IRIS, TWM, TWM-S, DreamerV3, IRIS-v2 |
| NeuralOS | 3-4 (diffusion baselines) | Video diffusion baselines (Appendix) |
| AVID | 2-3 | Yang et al. PoE, other adapter approaches |
| DWS | 3 | AVID, Yu et al., base model without DWS |
| Genie | Ablations only | 40M-11B scale ablations; FVD comparisons |
| OSWorld | 6 agents | GPT-4V, Claude, GPT-4, FLAN-T5, BLIP-2, others |
| SeeAct | 5 | FLAN-T5, BLIP-2, GPT-3.5, GPT-4, CogAgent |

**NC paper baselines**:

- NC_CLIGen: Wan2.1 (base), Veo3.1, Sora2 — 3 baselines (one is its own backbone; one is not a comparable method but a general video model)
- NC_GUIWorld: Untrained baseline, external conditioning early-stopped — 2 baselines (both weak)
- No comparison against GameNGen, DIAMOND, NeuralOS, AVID, DWS despite these being the directly comparable systems

**Critical baseline gap**:

The most glaring gap: there are **no comparisons against existing interactive diffusion world model systems** for NC_GUIWorld. The NC paper compares only against: (a) an untrained baseline and (b) an early-stopped version of one of its own ablation conditions. This means NC_GUIWorld's FVD 14.72 is reported in complete isolation from the established literature. GameNGen reports PSNR 29.4; DIAMOND demonstrates CS:GO interactive play at ~10 FPS; NeuralOS demonstrates 256-frame state retention. None of these provide cross-system FVD numbers, making head-to-head comparison difficult — but the NC paper does not even attempt to position its metrics against equivalent conditions tested by competitors.

---

## Dimension 5: Evaluation Methodology

**Observation across references**:

- **GameNGen**: PSNR, human perceptual study (real vs. simulated clips), 5-minute autoregressive stability test — includes **closed-loop** testing
- **DIAMOND**: Human normalized score (Atari 100k), mean + median across games; **closed-loop RL** training in imagination
- **NeuralOS**: Cursor accuracy (±1.6px), visual quality (FVD-equivalent), cross-app generalization (DOOM), state persistence demonstration (256-frame memory) — includes **closed-loop** testing
- **AVID**: FVD, LPIPS on video games and robotics; open-loop prediction quality
- **DWS**: FVD, PSNR, SSIM on Atari + BAIR; downstream RL performance (closed-loop RL training)
- **Genie**: FVD, delta-PSNR for controllability; human playability assessment
- **OSWorld**: Task completion rate by domain; human baseline (72.36%); multiple agent comparisons
- **SeeAct**: Whole task success rate (online + offline); element accuracy; step success rate

**NC paper's evaluation methodology**:

Open-loop only (CFR-004). All 10 experiments use ground-truth conditioning sequences; generated frames are never fed back as model input. The paper acknowledges this limitation explicitly.

**Comparison**:

The NC paper is the **only** paper among the primary technical comparison papers (GameNGen, DIAMOND, NeuralOS, AVID, DWS) that does not include any form of closed-loop evaluation. GameNGen achieves 5-minute stable autoregressive generation (closed-loop). DIAMOND trains RL agents in its world model imagination (closed-loop). NeuralOS demonstrates state persistence across 256+ frames (closed-loop). The NC paper's claim to "early NC primitives of a running computer" while lacking any closed-loop evaluation is the most significant methodological gap relative to field practice.

Additionally, the NC paper uses **no human perceptual study**, which GameNGen and Genie both include. Human evaluation would provide a claim-independent validation that is standard in interactive world model evaluation.

---

## Dimension 6: Statistical Rigor

**Observation across references**:

| System | Error Bars | Significance Tests | Runs |
|--------|------------|-------------------|------|
| GameNGen | Some ablations | Human rater CIs | N/A |
| DIAMOND | Mean ± across games | Standard | Multiple seeds |
| NeuralOS | Not fully specified | Not fully specified | Not specified |
| AVID | Not fully specified | Not fully specified | Not specified |
| DWS | FVD/PSNR with std | Not specified | Multiple |
| Genie | Scale curves | Not specified | Multiple |
| SeeAct | Task success ± | Not specified | Multiple runs |

**NC paper**:

No table (Tables 2–11) reports standard deviations, confidence intervals, or standard errors. No experiment reports results from more than one random seed (CFR-009). This is a systemic absence across all 10 experiments. The field does not have a universal standard for statistical reporting in video generation papers, but the absence in NC is notable given the small effect sizes in Tables 10–11.

---

## Dimension 7: Openness and Reproducibility

**Observation across references**:

- **GameNGen**: No code or weights released (proprietary Google system)
- **DIAMOND**: Full code released (GitHub); weights released; benchmark standard (Atari 100k)
- **NeuralOS**: No code or weights released at time of submission
- **AVID**: Code released (Microsoft Research, GitHub)
- **DWS**: Code released
- **Wan2.1**: Fully open-source (weights, code, 1.3B and 14B variants)
- **Genie**: No code or weights released (Google DeepMind proprietary)
- **OSWorld**: Full benchmark released (GitHub); evaluation infrastructure public
- **SeeAct**: Code and prompt templates released (GitHub)

**NC paper**:

Project page confirmed active. No weights or code repository linked in the arXiv paper at time of Phase-3-5b reading. NC_CLIGen and NC_GUIWorld training required 22k-38k H100 GPU hours — significant compute barrier even if code were released. The paper reports several undocumented hyperparameters (w, l, tau, layer indices) that would limit reproducibility from the paper alone (MEDIUM-002).

**Comparison**: NC paper's reproducibility is below the field norm set by DIAMOND, AVID, DWS, Wan2.1, OSWorld, and SeeAct, all of which released code/weights/benchmarks. This is a meaningful gap given the paper's claim to be establishing a new research direction that others should build on.

---

## Dimension 8: Claim-to-Evidence Ratio

**Observation across references**:

- **GameNGen**: Narrow claim (first neural game engine for DOOM) — supported by PSNR 29.4, human perceptual study, and 5-minute stable generation. Well-calibrated.
- **DIAMOND**: Technical claim (best Atari 100k for world-model-trained agents) — directly supported by benchmark numbers across 26 games. Well-calibrated.
- **NeuralOS**: Moderate claim (first neural OS GUI simulation system) — supported by multiple capability demonstrations and quantitative cursor accuracy. Reasonably calibrated.
- **AVID**: Technical claim (better adapter design for video diffusion) — supported by FVD/LPIPS on two domains. Reasonably calibrated.
- **Genie**: Broad claim (foundation world model from internet video) — supported by FVD at scale and behavioral cloning experiments. Mostly calibrated; some qualitative claims.
- **SeeAct**: Specific claim (51.1% task success with oracle grounding) — directly supported by Mind2Web results. Well-calibrated.

**NC paper claims vs. evidence**:

The NC paper makes paradigm-level claims ("neural computers are an emerging machine form," "NCs can take over the runtime responsibilities of physical computers") supported primarily by two prototype systems evaluated only in open-loop conditions on fixed app sets. The gap between claim scope and evidence scope is larger than in any other reference. The paper correctly acknowledges many limitations (open-loop, fixed apps, resolution, speed), but the conceptual framing — "a new machine form" — implies a level of generality that the evidence does not fully support.

**Most calibrated comparison**: GameNGen makes the narrowest claim with the best-matched evidence. The NC paper is at the opposite end of the calibration spectrum — the broadest claims with the most prototype-level evidence.
