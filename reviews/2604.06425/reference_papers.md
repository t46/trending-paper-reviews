# Reference Papers for Comparative Analysis

## Target Paper
- **Title**: Neural Computers
- **Authors**: Mingchen Zhuge, Changsheng Zhao, Haozhe Liu et al. (Meta AI, KAUST)
- **Year**: 2026 (arXiv April 7, 2026)
- **Domain**: Interactive world models / neural computing / video generation
- **Subfield**: Action-conditioned video diffusion models for GUI/CLI environment simulation
- **Method Type**: Pretrained video diffusion model (Wan2.1 DiT backbone) fine-tuned with action injection modules; two-system architecture (NC_CLIGen for CLI, NC_GUIWorld for desktop GUI)
- **Paper URL**: https://arxiv.org/abs/2604.06425

---

## Selected Reference Papers

### Reference 1: Diffusion Models Are Real-Time Game Engines (GameNGen)

**Basic Information**:
- **Authors**: Dani Valevski, Yaniv Leviathan, Moab Arar, Shlomi Fruchter (Google DeepMind)
- **Year**: 2024 (submitted August 27, 2024; revised April 24, 2025)
- **Venue**: ICLR 2025
- **URL**: https://arxiv.org/abs/2408.14837
- **Citations**: ~200+ (estimated from Semantic Scholar; high-impact ICLR 2025 paper)

**Reading Status (This Phase)**:
- **Reading Level**: Level 3 (full paper including experiments — read in Phase-3-5b)
- **Access Status**: Full HTML read in Phase-3-5b; deep reading summaries available at `artifacts/deep_reading_summaries/2408.14837_GameNGen.md`
- **To Be Read in Phase-5-2**: Experiments/results sections for detailed metric comparison

**Relevance** (based on full paper reading from Phase-3-5b):
- **Problem Similarity**: High
  - *Rationale*: Addresses the identical paradigm — interactive environment simulation where a neural model generates next frames conditioned on user actions, trained on collected interaction data. GameNGen does this for DOOM; NC_GUIWorld does it for Ubuntu XFCE desktop GUI.
- **Method Similarity**: High
  - *Rationale*: Two-phase training (interaction data collection → diffusion model trained on frames+actions) is structurally identical to NC_GUIWorld's pipeline. Action conditioning via cross-attention. Phase-3-5b verified formal equivalence between GameNGen's q(o_n|o_<n,a_<=n) and NC's Eq. 2.1. NC paper does not cite GameNGen despite this direct precedence.
- **Selection Reason**: Highest-priority comparison target. Establishes the two-phase interactive diffusion paradigm that NC_GUIWorld directly instantiates for the GUI domain. ICLR 2025 venue and strong citations make it an authoritative benchmark. Not cited by target despite being a direct technical predecessor.

**Content Summary** (based on full paper reading from Phase-3-5b):
- **Research Problem**: Can a diffusion model serve as a real-time interactive game engine, replacing traditional programmed game loops?
- **Main Contribution**: First neural game engine; two-phase training (RL agent → diffusion model on interaction trajectories); conditioning augmentations for stable autoregressive generation; decoder fine-tuning for visual fidelity
- **Datasets Used**: DOOM gameplay (RL-collected interaction data; ~T_agent training sessions)
- **Baselines Compared**: No direct quantitative baselines — novel capability demonstration; evaluated via PSNR (29.4) and human perceptual studies (raters ~chance at distinguishing real vs. simulated clips)
- **Experimental Scale**: Single game domain (DOOM); 20+ FPS on single TPU; 5-minute continuous generation sessions; human perceptual study

**Comparison Potential**:
- Can compare: Training paradigm design (two-phase vs. one-phase), action conditioning method (RL data collection vs. CUA agent data), video quality metrics (PSNR), generation quality evaluation methodology
- Primary contrast: Game domain (DOOM) vs. OS/GUI domain (Ubuntu XFCE) — NC_GUIWorld's contribution is domain extension, not paradigm novelty

---

### Reference 2: Diffusion for World Modeling: Visual Details Matter in Atari (DIAMOND)

**Basic Information**:
- **Authors**: Eloi Alonso, Adam Jelley, Vincent Micheli, Anssi Kanervisto, Amos Storkey, Tim Pearce, François Fleuret
- **Year**: 2024 (submitted May 2024; revised)
- **Venue**: NeurIPS 2024 Spotlight
- **URL**: https://arxiv.org/abs/2405.12399
- **Citations**: 197 (Semantic Scholar, as of April 2026)

**Reading Status (This Phase)**:
- **Reading Level**: Level 2+ (Method fully read + project page for CS:GO extension — read in Phase-3-5b)
- **Access Status**: Full HTML (v1) + project page read in Phase-3-5b; deep reading summaries available at `artifacts/deep_reading_summaries/2405.12399_DIAMOND.md`
- **To Be Read in Phase-5-2**: Atari 100k experimental results for metric extraction

**Relevance** (based on full paper reading from Phase-3-5b):
- **Problem Similarity**: High
  - *Rationale*: DIAMOND's CS:GO extension demonstrates human-interactive diffusion game simulation from fixed human gameplay data (87 hours, no RL) — the same paradigm as NC_GUIWorld trained on CUA interaction data. The project page explicitly states: "diffusion model functions as an interactive neural game engine where users provide actions and the model autoregressively generates subsequent frames." This directly parallels NC_GUIWorld's approach.
- **Method Similarity**: High
  - *Rationale*: Action conditioning via AdaGN (adaptive group normalization); diffusion model generates next frames from actions + history; trained on human-collected interaction data. Precedes NC by ~2 years and is a NeurIPS 2024 Spotlight (high-impact, peer-reviewed). Not cited by target.
- **Selection Reason**: High-impact NeurIPS 2024 Spotlight. The CS:GO interactive game engine extension establishes the "human-collected data → interactive diffusion simulation" paradigm that NC_GUIWorld extends to OS/GUI. 197 citations confirms broad community recognition. Not cited by target despite direct paradigm overlap.

**Content Summary** (based on full paper reading from Phase-3-5b):
- **Research Problem**: Do diffusion world models better preserve visual details for RL agent training compared to discrete latent representations?
- **Main Contribution**: DIAMOND (DIffusion As a Model Of eNvironment Dreams): diffusion-based world model for RL; demonstrates that preserving visual detail in world models improves agent performance; CS:GO interactive game engine extension using 87h human gameplay data
- **Datasets Used**: Atari 100k benchmark (primary); CS:GO static human gameplay dataset (87 hours) for interactive extension
- **Baselines Compared**: Other world model RL agents (IRIS, TWM); DIAMOND achieves new best for agents trained entirely within a world model (score: 1.46 on Atari 100k)
- **Experimental Scale**: Atari 100k (26 games); CS:GO interactive demo; ~10 FPS human-interactive play

**Comparison Potential**:
- Can compare: Interactive simulation paradigm design, data collection strategy (human data vs. RL agent data), video generation quality, action conditioning architecture choices
- Primary contrast: RL agent training focus (DIAMOND) vs. "computing environment" framing (NC); game domain vs. OS/GUI domain

---

### Reference 3: NeuralOS: Towards Simulating Operating Systems via Neural Generative Models

**Basic Information**:
- **Authors**: Luke Rivard, Sun Sun, Hongyu Guo, Wenhu Chen, Yuntian Deng
- **Year**: 2025 (submitted July 11, 2025; revised March 12, 2026)
- **Venue**: ICLR 2026
- **URL**: https://arxiv.org/abs/2507.08800
- **Citations**: Not yet well-indexed (ICLR 2026 paper; postdates NC paper submission; cited by target with one sentence)

**Reading Status (This Phase)**:
- **Reading Level**: Level 3 (full paper including appendices — read in Phase-3-5b)
- **Access Status**: Full HTML (v1 and v2) read in Phase-3-5b; deep reading summaries available at `artifacts/deep_reading_summaries/2507.08800_NeuralOS.md`
- **To Be Read in Phase-5-2**: Architecture section and evaluation results for metric extraction

**Relevance** (based on full paper reading from Phase-3-5b):
- **Problem Similarity**: High (maximum)
  - *Rationale*: Exact same problem — simulates Ubuntu XFCE GUI by predicting next screen frames from mouse/keyboard inputs, trained on Anthropic CUA agent interaction data. Same operating system, same data source, same goal. NC paper itself calls NeuralOS "most closely related" but provides only one sentence of differentiation.
- **Method Similarity**: Medium-High
  - *Rationale*: Architecturally different: NeuralOS uses hierarchical RNN (O(1) per-timestep state tracking) + diffusion renderer; NC_GUIWorld uses DiT fine-tuning + action injection modules. Key difference: NeuralOS's RNN provides long-horizon state persistence (256+ frames), which NC_GUIWorld's open-loop approach lacks (identified as CFR-004). The two systems solve the same problem with different architectural choices, enabling direct architectural comparison.
- **Selection Reason**: The most directly comparable paper to NC_GUIWorld. Same domain, same data source, same goal. ICLR 2026 acceptance confirms high quality. Phase-3-5b found NeuralOS's RNN architecture solves the long-horizon state problem that NC_GUIWorld leaves as future work — a critical comparison point.

**Content Summary** (based on full paper reading from Phase-3-5b):
- **Research Problem**: Can neural generative models simulate an operating system's GUI without any programmed OS code?
- **Main Contribution**: Hierarchical RNN + diffusion renderer for Ubuntu XFCE simulation; 256-frame memory retention via recurrent state; Gaussian cursor encoding; demonstrates generalization to applications not seen during training (DOOM)
- **Datasets Used**: Ubuntu XFCE recordings (random interactions + Anthropic CUA agent interactions); same data source as NC_GUIWorld
- **Baselines Compared**: Compares to video diffusion baselines (from Appendix); NeuralOS RNN approach vs. autoregressive diffusion approaches
- **Experimental Scale**: Ubuntu XFCE environment; multiple applications; 256+ frame memory demonstrations; cross-app generalization test

**Comparison Potential**:
- Can compare: Architecture (RNN+renderer vs. DiT+injection), long-horizon state handling (explicit RNN state vs. open-loop), data source (same: CUA), evaluation domain (same: Ubuntu XFCE), visual quality metrics
- Critical comparison: NeuralOS's RNN-based long-term memory vs. NC_GUIWorld's acknowledged lack of persistent state across sessions — this is the key architectural tradeoff to analyze in Phase-5-2

---

### Reference 4: AVID: Adapting Video Diffusion Models to World Models

**Basic Information**:
- **Authors**: Marc Rigter, Tarun Gupta, Agrin Hilmkil, Chao Ma (Microsoft Research)
- **Year**: 2024 (submitted October 1, 2024; revised November 24, 2024)
- **Venue**: ICLR 2025
- **URL**: https://arxiv.org/abs/2410.12822
- **Citations**: ~50-100 (estimated; ICLR 2025 paper published ~6 months before NC submission)

**Reading Status (This Phase)**:
- **Reading Level**: Level 2 (Method section fully read with equations — read in Phase-3-5b)
- **Access Status**: Full HTML read in Phase-3-5b; deep reading summaries available at `artifacts/deep_reading_summaries/2410.12822_AVID.md`
- **To Be Read in Phase-5-2**: Experimental results for quantitative comparison data

**Relevance** (based on full paper reading from Phase-3-5b):
- **Problem Similarity**: Medium-High
  - *Rationale*: Addresses adapting pretrained video diffusion models to action-conditioned world models — the same core technical challenge as NC_GUIWorld. Motivated by the same observation: pretrained video models have strong visual priors but lack action conditioning. Domain differs (video games + robotics vs. desktop GUI).
- **Method Similarity**: High
  - *Rationale*: AVID's per-frame scale/shift conditioning from action embeddings via adaptive normalization (Section 3.3: gamma/beta conditioning, masking mechanism) directly establishes the action injection design space that NC_GUIWorld's four-mode injection ablation (external/internal/residual/concatenation) explores. Phase-3-5b verified this is a direct methodological precedent. AVID predates NC by ~18 months at ICLR 2025.
- **Selection Reason**: Direct methodological predecessor to NC_GUIWorld's core contribution (action injection into pretrained video diffusion). ICLR 2025 publication makes it peer-reviewed comparable work. Not cited by target despite being a direct design space predecessor.

**Content Summary** (based on full paper reading from Phase-3-5b):
- **Research Problem**: How can we adapt pretrained (potentially closed-source) video diffusion models to action-conditioned world models without access to model weights?
- **Main Contribution**: Adapter-based approach with learned mask modifying intermediate outputs of pretrained video diffusion models; per-frame scale/shift from action embeddings; works without access to pretrained model parameters
- **Datasets Used**: Video game data; real-world robotics data
- **Baselines Compared**: Other diffusion model adaptation approaches; AVID outperforms "existing baselines for diffusion model adaptation"
- **Experimental Scale**: Two domains (games + robotics); adapter trained on small domain-specific datasets

**Comparison Potential**:
- Can compare: Action injection architecture (learned mask vs. NC's cross-attention modes), data efficiency (small adapter datasets vs. NC's full fine-tuning), access requirements (no weight access vs. NC's full fine-tuning of Wan2.1)
- Key contrast: AVID works without model weight access (black-box adaptation); NC_GUIWorld requires direct fine-tuning of Wan2.1 weights

---

### Reference 5: Pre-Trained Video Generative Models as World Simulators (DWS)

**Basic Information**:
- **Authors**: Haoran He, Yang Zhang, Liang Lin, Zhongwen Xu, Ling Pan
- **Year**: 2025 (submitted February 10, 2025)
- **Venue**: ICLR 2025
- **URL**: https://arxiv.org/abs/2502.07825
- **Citations**: ~30-60 (estimated; ICLR 2025 paper; ~2 months before NC submission)

**Reading Status (This Phase)**:
- **Reading Level**: Level 2 (Method section fully read with equations — read in Phase-3-5b)
- **Access Status**: Full HTML read in Phase-3-5b; deep reading summaries available at `artifacts/deep_reading_summaries/2502.07825_DWS.md`
- **To Be Read in Phase-5-2**: Experimental results table for quantitative metric comparison

**Relevance** (based on full paper reading from Phase-3-5b):
- **Problem Similarity**: High
  - *Rationale*: Directly proposes converting pre-trained video generative models into controllable world simulators that execute action trajectories — an exact description of what NC_GUIWorld does by fine-tuning Wan2.1. Addresses the same problem of "how do we add action control to an existing video model?"
- **Method Similarity**: High
  - *Rationale*: DWS introduces per-block lightweight action conditioning (two linear layers, scale-shift: x^i = x^i + FFN(LayerNorm(x^i)*(1+alpha^i)+beta^i)) inserted at each transformer block — directly equivalent to NC_GUIWorld's "internal injection mode" (per-block cross-attention). Phase-3-5b verified this is the same design with different parameterization (two linear layers vs. cross-attention). DWS precedes NC by ~14 months at ICLR 2025.
- **Selection Reason**: Closest methodological match to NC_GUIWorld's internal injection mode. Both convert pretrained video transformer models to action-conditioned simulators using per-block modulation. ICLR 2025 publication, architecture-agnostic claim (applies to diffusion and autoregressive transformers). Not cited by target.

**Content Summary** (based on full paper reading from Phase-3-5b):
- **Research Problem**: How can pre-trained video generative models (both diffusion and autoregressive) be transformed into controllable action-conditioned world simulators?
- **Main Contribution**: Dynamic World Simulation (DWS): lightweight per-block action conditioning (architecture-agnostic); motion-reinforced loss for action controllability; prioritized imagination mechanism for downstream RL
- **Datasets Used**: Games domain; robotics domain (specific benchmarks not specified in abstract)
- **Baselines Compared**: State-of-the-art methods in model-based RL; outperforms existing approaches
- **Experimental Scale**: Games + robotics; two model types (diffusion + autoregressive transformer)

**Comparison Potential**:
- Can compare: Per-block modulation architecture (scale-shift via linear layers vs. cross-attention), architecture-agnostic vs. Wan2.1-specific design, motion-reinforced loss vs. standard video loss, downstream RL application
- Key overlap: DWS's per-block conditioning of pretrained video transformer is essentially NC_GUIWorld's internal injection mode — needs explicit acknowledgment in NC paper

---

### Reference 6: Wan: Open and Advanced Large-Scale Video Generative Models (Wan2.1)

**Basic Information**:
- **Authors**: Team Wan (60+ collaborators, Alibaba)
- **Year**: 2025 (submitted March 26, 2025; revised April 19, 2025)
- **Venue**: arXiv preprint (cs.CV), arXiv:2503.20314
- **URL**: https://arxiv.org/abs/2503.20314
- **Citations**: Not yet well-indexed (submitted ~2 weeks before NC paper)

**Reading Status (This Phase)**:
- **Reading Level**: Level 0-1 (Abstract + architectural overview from search results and literature_candidates.md)
- **Access Status**: arXiv available; abstract and key facts extracted
- **To Be Read in Phase-5-2**: Architecture section (3D causal VAE, DiT specifics, action conditioning hooks)

**Relevance** (based on abstract/technical overview):
- **Problem Similarity**: Low (Wan2.1 itself is a general video generation model, not an interactive world model)
  - *Rationale*: Wan2.1 is the pretrained backbone used by NC_GUIWorld. It does not itself address GUI simulation or computer use. It is selected as a reference for understanding the substrate capabilities and limitations of NC's approach.
- **Method Similarity**: High (as backbone)
  - *Rationale*: NC_GUIWorld fine-tunes Wan2.1's DiT architecture. Understanding Wan2.1's 3D causal VAE, transformer architecture, training approach, and capability profile is essential for evaluating NC_GUIWorld's claimed contributions relative to the pretrained backbone.
- **Selection Reason**: NC_GUIWorld directly builds on Wan2.1; all performance claims are relative to this backbone. Understanding Wan2.1's architecture, capabilities, and benchmarks is essential context for evaluating how much of NC_GUIWorld's contribution is architectural novelty vs. domain application of an existing model.

**Content Summary** (based on abstract/overview):
- **Research Problem**: How to build an open-source, high-quality, efficient video generation foundation model?
- **Main Contribution**: Wan suite: 3D causal VAE, DiT-based architecture, scalable pretraining, 1.3B and 14B model sizes; covers T2V, I2V, video editing, and personal video generation; open-source release
- **Datasets Used**: Internal large-scale video dataset; evaluated on internal + external benchmarks; "consistently outperforms open-source and commercial solutions"
- **Baselines Compared**: Open-source and commercial video generation models (specific names not in abstract)
- **Experimental Scale**: 60-page technical report; 8 downstream tasks; two model sizes (1.3B and 14B)

**Comparison Potential**:
- Can compare: NC_GUIWorld's video quality vs. Wan2.1's pretrained quality, architecture modifications needed for action conditioning, computational overhead of NC's fine-tuning
- Key question for Phase-5-2: What percentage of NC_GUIWorld's visual quality (FVD 14.72) is attributable to Wan2.1's pretrained capabilities vs. the action conditioning fine-tuning?

---

### Reference 7: Genie: Generative Interactive Environments

**Basic Information**:
- **Authors**: Jake Bruce, Michael Dennis, Ashley Edwards et al. (Google DeepMind)
- **Year**: 2024 (submitted February 23, 2024)
- **Venue**: ICML 2024
- **URL**: https://arxiv.org/abs/2402.15391
- **Citations**: ~400-500 (estimated; highly cited ICML 2024 paper)

**Reading Status (This Phase)**:
- **Reading Level**: Level 0 (Abstract only — not read in Phase-3-5b)
- **Access Status**: arXiv available
- **To Be Read in Phase-5-2**: Architecture section (latent action model, spatiotemporal transformer) and evaluation

**Relevance** (based on abstract):
- **Problem Similarity**: High
  - *Rationale*: Genie is an interactive world model that enables action-controllable virtual world generation from internet videos. It directly addresses the problem of generative interactive environments from unstructured data — the same paradigm space as NC. Cited by the NC paper.
- **Method Similarity**: Medium
  - *Rationale*: Genie uses an unsupervised latent action model (learned, not explicit actions) and an 11B spatiotemporal transformer. NC uses explicit action conditioning (mouse/keyboard) and a fine-tuned DiT. The architectural approaches differ significantly (latent actions vs. explicit actions), making this a useful contrast case.
- **Selection Reason**: Foundational work in the interactive world model paradigm; cited by NC paper; ICML 2024; establishes the "foundation world model" concept that NC positions its NC_GUIWorld within. High citation count confirms community importance.

**Content Summary** (based on abstract):
- **Research Problem**: Can a large-scale model trained unsupervised on internet videos generate action-controllable interactive virtual worlds?
- **Main Contribution**: 11B parameter foundation world model with latent action model for unsupervised action discovery; trained on internet videos; enables image-to-interactive-world generation
- **Datasets Used**: Internet video data (large-scale, unstructured)
- **Baselines Compared**: Not specified in abstract — novel capability demonstration
- **Experimental Scale**: 11B parameter model; large-scale internet video training; platformer-style 2D environments

**Comparison Potential**:
- Can compare: Paradigm positioning (foundation model vs. fine-tuned model), action conditioning approach (latent vs. explicit), scale (11B vs. Wan2.1 14B), training data type (internet video vs. domain-specific interaction traces)
- Key contrast: Genie uses latent/implicit actions from videos; NC uses explicit mouse/keyboard signals — different philosophical approach to action conditioning

---

### Reference 8: OSWorld: Benchmarking Multimodal Agents for Open-Ended Tasks in Real Computer Environments

**Basic Information**:
- **Authors**: Tianbao Xie, Danyang Zhang, Jixuan Chen et al. (xlang-ai, multiple institutions)
- **Year**: 2024 (submitted April 11, 2024; revised May 30, 2024)
- **Venue**: NeurIPS 2024 (Datasets and Benchmarks Track)
- **URL**: https://arxiv.org/abs/2404.07972
- **Citations**: ~300+ (estimated; highly cited benchmark paper)

**Reading Status (This Phase)**:
- **Reading Level**: Level 0-1 (Abstract + summary from search results and literature_candidates.md)
- **Access Status**: arXiv available; abstract and key facts extracted
- **To Be Read in Phase-5-2**: Task categories, evaluation protocol, agent results for context on GUI agent landscape

**Relevance** (based on abstract/overview):
- **Problem Similarity**: Medium-High
  - *Rationale*: OSWorld defines the "real computer use" evaluation landscape that NC_GUIWorld's training data (Anthropic CUA agent trajectories) is sourced from. Not a competing system — OSWorld is a benchmark, not a world model — but it defines the evaluation context and the agent systems against which NC's training data was generated.
- **Method Similarity**: Low (benchmark paper, not a technical system)
  - *Rationale*: OSWorld provides a benchmark for agent evaluation; NC provides a simulation system. They address different problems but share the domain (computer use on real OS).
- **Selection Reason**: NeurIPS 2024 benchmark that defines the real-computer-use evaluation landscape. The Claude CUA agent whose trajectories train NC_GUIWorld operates on OSWorld-type environments. Understanding OSWorld's task taxonomy and evaluation criteria helps contextualize what "computer use competence" means and whether NC's evaluation captures it.

**Content Summary** (based on abstract/overview):
- **Research Problem**: What is a comprehensive, scalable benchmark for evaluating multimodal agents on open-ended computer tasks across real OS environments?
- **Main Contribution**: 369 computer tasks on Ubuntu/Windows/macOS; real desktop + web + multi-app workflows; 72.36% human performance vs. 12.24% best AI baseline at time of publication
- **Datasets Used**: 369 hand-annotated tasks; Ubuntu + Windows environments (43 additional tasks)
- **Baselines Compared**: Multiple LLM and VLM agents; best agent achieves 12.24% vs. 72.36% human — large capability gap
- **Experimental Scale**: 369 tasks; 3 OS environments; multiple agent baselines; human evaluation for ceiling

**Comparison Potential**:
- Can compare: Whether NC_GUIWorld's visual simulation accurately represents the kinds of interactions OSWorld benchmarks; whether NC's training data (CUA trajectories) covers OSWorld task types; whether NC simulation could be used for agent training in the OSWorld context
- Key question: Does NC_GUIWorld's learned simulation generalize to the diverse tasks in OSWorld, or only to the specific CUA agent trajectories used for training?

---

### Reference 9: The Dawn of GUI Agent: A Preliminary Case Study with Claude 3.5 Computer Use

**Basic Information**:
- **Authors**: Siyuan Hu, Mingyu Ouyang, Difei Gao, Mike Zheng Shou (Show Lab, NUS)
- **Year**: 2024 (submitted November 15, 2024)
- **Venue**: arXiv preprint (cs.AI)
- **URL**: https://arxiv.org/abs/2411.10323
- **Citations**: ~50-100 (estimated; practical impact paper)

**Reading Status (This Phase)**:
- **Reading Level**: Level 0-1 (Abstract + search result summary)
- **Access Status**: arXiv available
- **To Be Read in Phase-5-2**: Task evaluation section and capability/limitation analysis for NC context

**Relevance** (based on abstract):
- **Problem Similarity**: Medium
  - *Rationale*: Studies Claude 3.5 Computer Use as a GUI agent operating on real desktop environments — the same agent system whose trajectories provide NC_GUIWorld's training data. Understanding the capabilities and limitations of Claude CUA (the data source) is essential for interpreting NC_GUIWorld's learned simulation fidelity.
- **Method Similarity**: Low (agent paper, not world model)
  - *Rationale*: This is an evaluation of an LLM-based GUI agent that takes actions on a real computer. NC proposes to simulate that computer. They represent the two sides of the "neural computer" paradigm: agent-based (this paper) vs. simulation-based (NC).
- **Selection Reason**: Directly characterizes the Claude 3.5 Computer Use agent — the primary data source for NC_GUIWorld's training. Understanding what actions CUA takes, what tasks it performs, and its failure modes is critical context for evaluating NC's learned simulation. Provides the "agent paradigm" contrast case to NC's "simulation paradigm."

**Content Summary** (based on abstract/overview):
- **Research Problem**: What are the capabilities and limitations of Claude 3.5 Computer Use as the first frontier multimodal GUI agent?
- **Main Contribution**: Systematic evaluation across diverse desktop software domains; out-of-the-box agent framework for deploying GUI automation models; analysis of planning, action, and critic components
- **Datasets Used**: Curated tasks across various domains and software; available on GitHub
- **Baselines Compared**: Claude 3.5 Computer Use as primary subject; comparison to prior agent approaches implicit
- **Experimental Scale**: Multiple domains and software applications; 40-page study; qualitative and quantitative analysis

**Comparison Potential**:
- Can compare: What tasks CUA can do vs. what NC_GUIWorld can simulate; gap between agent action generation and learned simulation fidelity; whether NC's "computer use" training data represents the full diversity of real computer tasks
- Key relationship: CUA is NC_GUIWorld's data generator — this paper helps assess data source quality and coverage

---

### Reference 10: GPT-4V(ision) is a Generalist Web Agent, if Grounded (SeeAct)

**Basic Information**:
- **Authors**: Boyuan Zheng, Boyu Gou, Jihyung Kil, Huan Sun, Yu Su (Ohio State University)
- **Year**: 2024 (submitted January 3, 2024; revised March 12, 2024)
- **Venue**: ICML 2024
- **URL**: https://arxiv.org/abs/2401.01614
- **Citations**: ~200+ (estimated; influential ICML 2024 paper on GUI agents)

**Reading Status (This Phase)**:
- **Reading Level**: Level 0-1 (Abstract + search result summary)
- **Access Status**: arXiv available
- **To Be Read in Phase-5-2**: Grounding methodology and benchmark results for agent paradigm comparison

**Relevance** (based on abstract):
- **Problem Similarity**: Medium
  - *Rationale*: SeeAct addresses GUI agent task completion on live websites using multimodal LLMs — the "agent" paradigm for computer interaction, which NC explicitly contrasts with. NC frames itself as moving "beyond agents" to a simulation-based approach; SeeAct represents the state of the art in the agent paradigm.
- **Method Similarity**: Low (LLM-based agent, not video diffusion)
  - *Rationale*: SeeAct uses GPT-4V for visual understanding + action generation + HTML grounding; NC uses video diffusion for environment simulation. Fundamentally different technical approaches to computer interaction.
- **Selection Reason**: Represents the paradigm alternative to NC — agent-based computer use. NC's paper positions NCs as distinct from agents; SeeAct (ICML 2024) is a concrete representative of what the top-performing agent paradigm looks like. The 51.1% task completion on live websites (with manual grounding) sets a concrete bar for GUI agent competence. Useful for "alternative paradigm" comparison.

**Content Summary** (based on abstract/overview):
- **Research Problem**: Can large multimodal models serve as generalist web agents if given proper action grounding?
- **Main Contribution**: SeeAct framework: visual understanding via GPT-4V + textual plan to executable action grounding; demonstrates 51.1% task completion on live websites with manual grounding; identifies grounding as primary bottleneck
- **Datasets Used**: MIND2WEB benchmark (offline cached + online live website evaluation)
- **Baselines Compared**: GPT-4 (text-only), FLAN-T5, BLIP-2; SeeAct grounding strategies outperform prior supervised fine-tuning approaches
- **Experimental Scale**: MIND2WEB benchmark; live website evaluation; multiple grounding strategy ablations

**Comparison Potential**:
- Can compare: Agent paradigm (SeeAct: LLM + real environment) vs. simulation paradigm (NC: video diffusion model); task completion rates vs. simulation fidelity metrics; what "computer use competence" means across paradigms
- Key contrast: SeeAct interacts with the real web; NC simulates the environment — the two paradigms serve different purposes (task execution vs. environment simulation/training)

---

## Selection Balance Summary

| Category | Papers | Count |
|----------|--------|-------|
| Highly similar: same problem + method | GameNGen (Ref 1), NeuralOS (Ref 3), DWS (Ref 5) | 3 |
| Same/adjacent problem, different method | DIAMOND (Ref 2), Genie (Ref 7), CUWM [excluded — postdates NC] | 2 |
| Similar method, different problem | AVID (Ref 4), Wan2.1 (Ref 6) | 2 |
| Agent/evaluation paradigm context | OSWorld (Ref 8), Claude CUA study (Ref 9), SeeAct (Ref 10) | 3 |
| **Total** | | **10** |

## Citation Coverage Notes

**Papers cited by NC target that are also selected as references**: Genie (Ref 7) — cited by target; Wan2.1 (Ref 6) — cited by target; NeuralOS (Ref 3) — cited by target (one sentence)

**Papers NOT cited by NC target despite direct relevance** (selected as references): GameNGen (Ref 1), DIAMOND (Ref 2), AVID (Ref 4), DWS (Ref 5), OSWorld (Ref 8)

**Papers selected specifically for paradigm contrast** (appropriately not cited by NC target): Claude CUA study (Ref 9), SeeAct (Ref 10)
