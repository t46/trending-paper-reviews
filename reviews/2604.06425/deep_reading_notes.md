# Deep Reading Notes — Phase-3-5b
# Neural Computers (arXiv:2604.06425) Novelty Assessment

## Overview

This document synthesizes deep readings of 5 critical papers and their relevance to the Neural Computers (NC) paper's novelty claims. Individual paper summaries are in `artifacts/deep_reading_summaries/`.

---

## Papers Read

| Paper | arXiv | Venue | Access | Reading Level | NC Cited? |
|-------|-------|-------|--------|---------------|-----------|
| GameNGen | 2408.14837 | ICLR 2025 | Full HTML (v1) | Level 3 | No |
| AVID | 2410.12822 | ICLR 2025 | Full HTML (v1) | Level 2 | No |
| NeuralOS | 2507.08800 | ICLR 2026 | Full HTML (v1+v2) | Level 3 | Yes (thin) |
| Pre-Trained Video Simulators (DWS) | 2502.07825 | ICLR 2025 | Full HTML | Level 2 | No |
| DIAMOND | 2405.12399 | NeurIPS 2024 Spotlight | Full HTML (v1) + project page | Level 2+ | No |

---

## Paper 1: GameNGen (arXiv:2408.14837)

### Core Contribution
"The first game engine powered entirely by a neural model that also enables real-time interaction with a complex environment over long trajectories at high quality." (Abstract)

### Technical Approach
Two-phase training: (1) RL agent (PPO) plays DOOM, all trajectories recorded; (2) Fine-tuned Stable Diffusion v1.4 trained on (frames, actions) to predict next frame.

Action conditioning: Learned embedding per action type; replaces text cross-attention. Observations: encoded via autoencoder, concatenated channel-wise to noised latents.

Noise augmentation: Context frames randomly noised during training to prevent autoregressive drift.

Running at 20 FPS on a single TPU. Context: 64 past frames + 64 past actions.

### Explicit Similarities to NC Paper
- Identical two-phase paradigm: interaction data collection → diffusion model training
- Both generate next visual frame conditioned on (past frames, past actions)
- Both use fine-tuned pretrained diffusion model
- Both claim to replace conventional computation (game engine / OS) with a neural model
- Both use RL/human interaction traces as training data
- GameNGen's formal definition q(o_n|o_<n,a_<=n) is equivalent to NC's Eq. 2.1

### Explicit Differences from NC Paper
- Domain: DOOM (game) vs. Ubuntu XFCE (OS/GUI)
- Data collection: RL agent vs. human+CUA recorded sessions
- Architecture: SD v1.4 U-Net vs. Wan2.1 DiT
- Action injection: Cross-attention replacement (single mode) vs. four injection mode ablation
- Scale: NC_GUIWorld uses larger base model (Wan2.1) and more data (1,510h vs. RL trajectories)
- NC paper adds philosophical "runtime" framing absent in GameNGen

### Does It Undermine or Support NC Novelty?
**Partially undermines** technical prototype novelty. GameNGen establishes the NC_GUIWorld technical paradigm 18 months earlier. The NC paper's philosophical "neural computer vs. neural game engine" differentiation is offered on the project blog but not established in the paper body with technical evidence. The NC paper's failure to cite GameNGen is a significant omission.

**Supports** the conceptual paradigm claim: GameNGen is explicitly framed as a game engine/simulator, not as a "running computer" taking on "runtime responsibilities." The NC paper's distinction between "simulational" and "runtime" functions is philosophically coherent, even if not technically differentiated at the implementation level.

---

## Paper 2: AVID (arXiv:2410.12822)

### Core Contribution
"Adapts pretrained video diffusion models to action-conditioned world models, without access to pretrained model parameters" using a learned spatial mask to combine pretrained and adapter outputs. (Abstract)

### Technical Approach
Lightweight 3D UNet adapter taking concatenated input: (noisy video, pretrained model's noise prediction, repeated initial frame). Outputs a spatial mask m and noise prediction. Final output: epsilon_pre ⊙ m + epsilon_adapt ⊙ (1-m). Per-frame scale/shift conditioning from action embeddings via adaptive normalization.

Only adapter parameters trained; pretrained model completely frozen.

### Explicit Similarities to NC Paper
- Same technical problem: adapt a pretrained video diffusion model for action-conditioned generation
- Per-frame action conditioning using scale/shift parameters (adaptive normalization)
- Both study the design space of injecting actions into pretrained video models
- Both train a lightweight module on domain-specific action-labeled data

### Explicit Differences from NC Paper
- AVID requires NO access to model weights (black-box adaptation); NC_GUIWorld has full weight access
- AVID modifies outputs (output-space masking); NC_GUIWorld modifies internal representations
- AVID applies to game/robotics; NC_GUIWorld applies to OS/GUI
- AVID is a pure adaptation method; NC_GUIWorld frames itself as instantiating a new machine form

### Does It Undermine or Support NC Novelty?
**Partially undermines** NC_GUIWorld's methodological novelty claim. AVID demonstrates action-conditional adaptation of pretrained video diffusion models (ICLR 2025, October 2024) — the same design space that NC_GUIWorld's injection mode ablation explores, 18 months earlier. NC_GUIWorld extends this to OS/GUI with full weight access, but the technical contribution is incremental.

The omission of AVID from the NC paper's related work is a significant gap. The injection mode ablation is presented without contextualizing it in the established literature.

---

## Paper 3: NeuralOS (arXiv:2507.08800)

### Core Contribution
"Simulates an operating system's graphical interface entirely using deep neural networks" without manually programmed code. Demonstrates application simulation from fabricated training data. (Section 1)

### Technical Approach
Two-component architecture: (1) Hierarchical two-level LSTM (constant O(1) complexity per timestep) for long-horizon OS state persistence; (2) UNet-based diffusion renderer (263M parameters) generating latent frames from RNN context.

Training data: 2K Claude-3.5-Sonnet CUA agent demonstrations + 120K random explorations (12TB latent data). Four sequential training stages including scheduled sampling and curriculum learning.

Explicit cursor spatial encoding via Gaussian spatial maps (critical for ±1.6 pixel cursor accuracy).

### Explicit Similarities to NC Paper
- Same exact domain: Ubuntu XFCE GUI simulation from mouse/keyboard inputs
- Same data source: Anthropic CUA agent demonstrations
- Same general goal: make a neural model simulate an OS without programmed code
- Both train on recorded user-interaction traces
- Both generate visual screen frames as primary output
- Both acknowledge lack of OS-level completeness as a limitation

### Explicit Differences from NC Paper
- Architecture: RNN+diffusion renderer (NeuralOS) vs. DiT fine-tuning (NC_GUIWorld)
- State mechanism: Explicit RNN (O(1) constant per timestep, long-horizon memory) vs. implicit transformer attention
- NeuralOS demonstrates closed-loop operation; NC_GUIWorld only tested open-loop (CFR-004)
- Scale: NeuralOS used 17K H200 + 6K H100 GPU hours; NC_GUIWorld's training scale not specified
- NeuralOS (ICLR 2026) was published after the NC paper submission date but before it — borderline concurrent

### Does It Undermine or Support NC Novelty?
**Directly conflicts** with the NC_GUIWorld prototype claim's uniqueness. Both systems do the same thing (simulate Ubuntu XFCE GUI from user inputs). The NC paper's "most closely related" label is accurate but the lack of formal comparison is problematic.

The NC paper's philosophical "NC runtime" framing provides a layer of differentiation, but at the implementation level NC_GUIWorld is technically less sophisticated than NeuralOS (open-loop only; no explicit state persistence; lower training scale).

**Supports NC's conceptual claim**: NeuralOS frames its contribution as a "generative interface" or "neural OS," which is similar to the NC framing but not identical. NeuralOS does not adopt the NC formalism h_t = F_theta(h_{t-1}, x_t, u_t).

**Critical gap**: NeuralOS's RNN architecture explicitly solves the long-horizon state persistence problem (OS state from 256+ frames ago) that NC_GUIWorld leaves unresolved (CFR-004). This is a direct technical advantage of NeuralOS over NC_GUIWorld that the NC paper does not acknowledge.

---

## Paper 4: Pre-Trained Video Generative Models as World Simulators / DWS (arXiv:2502.07825)

### Core Contribution
"DWS: a unified, architecture-agnostic approach for efficiently converting pre-trained video generative models into world simulators" using two linear layers per transformer block for scale-shift action modulation. (Section 4)

### Technical Approach
Add two linear layers per transformer block: x^i = x^i + FFN(LayerNorm(x^i) × (1+alpha^i) + beta^i). Action embeddings (discrete via text encoder; continuous via linear layer) produce per-frame scale/shift parameters. Motion-reinforced loss weights dynamic pixels more heavily. Works for both diffusion and autoregressive models.

### Explicit Similarities to NC Paper
- Converts pretrained video model into action-conditioned simulator — same technical operation as NC_GUIWorld
- Per-block action modulation (two linear layers) — conceptually parallel to NC_GUIWorld's internal injection mode (cross-attention per block)
- Both study per-block injection vs. other approaches
- Both use per-frame action conditioning

### Explicit Differences from NC Paper
- DWS keeps pretrained weights frozen; NC_GUIWorld fine-tunes
- DWS uses two linear layers (scale-shift); NC_GUIWorld uses cross-attention (more expressive)
- DWS domain: games/robotics; NC_GUIWorld: OS/GUI
- DWS is architecture-agnostic (diffusion + autoregressive); NC_GUIWorld only tests DiT
- DWS introduces motion-reinforced loss; NC_GUIWorld does not adopt this

### Does It Undermine or Support NC Novelty?
**Partially undermines** NC_GUIWorld's injection mode contribution. The per-block modulation design space is explored by DWS in February 2025. NC_GUIWorld's four-mode ablation extends this space but does not cite DWS.

---

## Paper 5: DIAMOND (arXiv:2405.12399)

### Core Contribution
"DIAMOND: a reinforcement learning agent trained in a diffusion world model" achieving mean human normalized score 1.46 on Atari 100k. Extended to CS:GO as an interactive human-playable game engine. (Abstract)

### Technical Approach
U-Net 2D diffusion model with EDM formulation. Action conditioning via adaptive group normalization (AdaGN) in residual blocks. Past observations concatenated channel-wise. 3 denoising steps per frame for stability. CS:GO extension: 87h human gameplay, ~10 FPS, human-interactive.

### Explicit Similarities to NC Paper
- Diffusion model conditioned on past frames + actions → next frame prediction
- Used as interactive environment (CS:GO): user provides actions, model generates frames
- Fixed human gameplay data (not RL) sufficient for interactive environment — same as NC_GUIWorld
- Action conditioning via in-residual-block normalization — same design space as NC_GUIWorld internal mode

### Explicit Differences from NC Paper
- Domain: Game (DOOM/CS:GO) vs. OS/GUI
- Architecture: U-Net 2D vs. DiT 3D video
- DIAMOND demonstrates closed-loop interactive play; NC_GUIWorld is open-loop only (CFR-004)
- DIAMOND trains from scratch; NC_GUIWorld fine-tunes pretrained model
- NC paper adds "runtime" philosophical framing; DIAMOND is framed as a world model for RL

### Does It Undermine or Support NC Novelty?
**Partially undermines** NC_GUIWorld's interactive simulation claim. DIAMOND (NeurIPS 2024 Spotlight, May 2024) establishes interactive diffusion-based environment simulation with human-collected data. The CS:GO extension shows the same approach NC_GUIWorld uses for OS/GUI, but for games, 2 years earlier.

---

## Synthesis: Novelty Assessment

### NC Paper's Paradigm Claim ("Neural Computers are a new machine form")

**Status**: Largely intact. No prior work adopts the NC formalism (h_t = F_theta(h_{t-1}, x_t, u_t)) or uses the language of "runtime responsibilities" shifting into the neural model. The project blog's differentiation from game engines as "simulational" vs. NC "runtime" is a coherent philosophical distinction.

**Evidence supporting this claim**:
- None of the five papers explicitly adopt or reference the "NC" abstraction
- NeuralOS, GameNGen, DIAMOND all frame their contributions as "game engines," "world models," or "generative interfaces" — different intellectual framing
- The CNC four-condition formal definition (Turing complete, universally programmable, behavior-consistent, machine-native semantics) is genuinely novel as a specification for neural systems

**Weakness**: The conceptual differentiation is offered primarily in the blog post (not formally in the paper body) and the paper's own Related Work (~1 page) does not adequately engage with the literature.

### NC Paper's Prototype Claims (NC_CLIGen and NC_GUIWorld)

**Status**: Technical novelty weakened by uncited prior work.

**NC_CLIGen** (CLI terminal video model):
- No direct prior work found on neural CLI/terminal simulation as a video model
- This prototype appears more novel in its specific domain application

**NC_GUIWorld** (Ubuntu XFCE GUI simulation):
- GameNGen (ICLR 2025): same technical paradigm (interaction data → diffusion model), game domain
- AVID (ICLR 2025): same adaptation problem, black-box version
- DWS (ICLR 2025): same per-block modulation design space
- DIAMOND (NeurIPS 2024): same interactive diffusion environment concept, game domain
- NeuralOS (ICLR 2026): same domain (Ubuntu XFCE), same data source (CUA), direct precedent

NC_GUIWorld's technical novelty reduces to: (1) applying the established game engine paradigm to OS/GUI; (2) the four-mode injection ablation. Neither is as novel as presented without these citations.

### Most Critical Novelty Challenges

1. **GameNGen omission** (CRITICAL): The NC_GUIWorld prototype is the OS/GUI application of the GameNGen paradigm. Not citing GameNGen misrepresents the technical precedent.

2. **NeuralOS under-discussion** (CRITICAL): The NC paper acknowledges NeuralOS as "most closely related" in one sentence but provides no architectural comparison. NeuralOS outperforms NC_GUIWorld in state persistence (explicit RNN handles long-horizon state; NC_GUIWorld uses open-loop only).

3. **AVID/DWS omission** (HIGH): NC_GUIWorld's injection mode ablation exists in a design space already explored by AVID (output-space masking) and DWS (per-block scale-shift modulation). These papers should be cited to contextualize NC_GUIWorld's contribution.

4. **DIAMOND omission** (HIGH): DIAMOND establishes interactive diffusion environment with human gameplay data (NeurIPS 2024 Spotlight) — directly relevant to NC_GUIWorld's interactive capability claim.

### What Remains Novel Despite Prior Work

1. **Application to OS/GUI domain**: NC_GUIWorld is the first (pre-NeuralOS) or co-first (concurrent with NeuralOS) diffusion model approach for desktop OS GUI simulation. The domain novelty is real.

2. **CLI simulation (NC_CLIGen)**: No prior work found on terminal/CLI video model simulation. This is genuinely novel in domain.

3. **NC conceptual framework**: The formal NC/CNC abstraction (h_t formalism, four CNC conditions) is a novel organizing framework for thinking about neural systems as computing substrates.

4. **Four-mode injection ablation**: While the design space was explored by prior work, the systematic study in OS/GUI context with these four specific modes is new.

5. **SVG cursor supervision**: The finding that SVG cursor supervision raises cursor accuracy from 8.7% to 98.7% is a novel training insight specific to GUI simulation.

---

## Evidence Bank for Phase-3-5c

### For NC Novelty Claim 1: "NC is an emerging machine form distinct from world models"

**Supporting Evidence**:
- None of the five papers adopt the NC/CNC formalism
- GameNGen, DIAMOND explicitly frame as "game engines" or "world models for RL agents"
- NeuralOS frames as "generative OS" not "neural computer"
- The distinction is coherent at the conceptual level

**Challenging Evidence**:
- The implementation-level distinction is unclear: all five papers and NC_GUIWorld generate next visual frames from past frames + actions — the same computational operation
- The NC paper does not formally prove that its "runtime" claim is measurably distinct from NeuralOS's "OS simulation" at the evaluation level

### For NC Novelty Claim 2: "NC_GUIWorld is a first neural computer prototype for OS/GUI"

**Supporting Evidence**:
- No prior diffusion model trained for Ubuntu XFCE GUI simulation (NeuralOS uses RNN+diffusion but architecturally different)
- First systematic four-mode injection ablation for OS/GUI context

**Challenging Evidence**:
- GameNGen (August 2024): Same technical paradigm applied to games — direct precedent
- NeuralOS (ICLR 2026): Same domain, same data source, architecturally more sophisticated (explicit RNN state)
- AVID/DWS (ICLR 2025): Same adaptation problem in adjacent domains
- DIAMOND (NeurIPS 2024 Spotlight): Interactive diffusion environments for human play with fixed human data

### For NC Novelty Claim 3: "NC_CLIGen is a first neural computer prototype for CLI"

**Supporting Evidence**:
- No prior work found on video model for CLI/terminal simulation
- The PSNR 26.89 dB with detailed captions is a concrete measured result
- Reprompting boosting arithmetic from 4% to 83% is a novel steerability finding

**Challenging Evidence**:
- None specifically found — this prototype appears more genuinely novel

---

## New CFR Entries Recommended

### CFR-NEW-1: Missing Citations for NC_GUIWorld Technical Precedents (HIGH)
- GameNGen (ICLR 2025): Direct technical precedent; uncited
- DIAMOND (NeurIPS 2024 Spotlight): Interactive diffusion environment; uncited
- AVID (ICLR 2025): Action-conditioned video diffusion adaptation; uncited
- DWS (ICLR 2025): Per-block action modulation for video diffusion; uncited

These four papers collectively establish the technical design space in which NC_GUIWorld operates. Their omission means the NC paper cannot properly situate NC_GUIWorld's incremental contributions.

### CFR-NEW-2: NeuralOS Under-Discussion vs. Direct Technical Competition (HIGH)
NeuralOS (ICLR 2026) directly competes with NC_GUIWorld in the same domain (Ubuntu XFCE GUI), using the same data source (Claude CUA), and demonstrates closed-loop operation while NC_GUIWorld only demonstrates open-loop. The NC paper's ~1-sentence acknowledgment is insufficient given this level of direct competition.
