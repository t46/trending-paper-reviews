# Literature Candidate Papers

## Search Summary
- **Total papers examined**: ~250
- **Candidates identified**: 35
- **Search date**: 2026-04-15
- **Time period covered**: 2014–2026

---

## HIGH Relevance Candidates (Prioritize for Deep Reading)

### Candidate 1
- **Title**: NeuralOS: Towards Simulating Operating Systems via Neural Generative Models
- **Authors**: Luke Rivard, Sun Sun, Hongyu Guo, Wenhu Chen, Yuntian Deng
- **Year**: 2025 (July; revised March 2026)
- **Venue**: ICLR 2026
- **URL**: https://arxiv.org/abs/2507.08800
- **Why potentially relevant**: Directly simulates Ubuntu XFCE GUI by predicting screen frames from user inputs (mouse/keyboard) using an RNN for state tracking + diffusion renderer. Operates on the same Ubuntu desktop environment as NC_GUIWorld. The paper itself calls NeuralOS "most closely related" but provides less than half a paragraph of differentiation.
- **Potential overlap type**: Both (Problem + Method)
- **Cited by target paper**: Yes (Section 2.1)
- **Key concern**: NeuralOS architecture (RNN + diffusion renderer) vs. NC_GUIWorld (DiT fine-tuning + action conditioning) needs explicit comparative analysis. Both predict screen frames from user actions on the same OS.
- **Recommended for deep reading**: Yes — CRITICAL

### Candidate 2
- **Title**: Diffusion Models Are Real-Time Game Engines (GameNGen)
- **Authors**: Dani Valevski, Yaniv Leviathan, Moab Arar, Shlomo Fruchter
- **Year**: 2024 (August)
- **Venue**: arXiv preprint (ICLR 2025)
- **URL**: https://arxiv.org/abs/2408.14837
- **Why potentially relevant**: First neural game engine using a diffusion model for action-conditioned game simulation (DOOM) at 20+ FPS. Phase-1 RL agent collects trajectories; Phase-2 trains diffusion model on (frames, actions). Very closely related to NC_GUIWorld's approach; uses diffusion for interactive video simulation from interaction data.
- **Potential overlap type**: Method — action-conditioned video diffusion for interactive environments
- **Cited by target paper**: No
- **Recommended for deep reading**: Yes — CRITICAL

### Candidate 3
- **Title**: Diffusion for World Modeling: Visual Details Matter in Atari (DIAMOND)
- **Authors**: Eloi Alonso, Adam Jelley, Vincent Micheli et al.
- **Year**: 2024 (May, revised)
- **Venue**: NeurIPS 2024 Spotlight
- **URL**: https://arxiv.org/abs/2405.12399
- **Why potentially relevant**: Diffusion world model for RL agent training (Atari). Uses action-conditioned diffusion for next-frame generation in sequential decision-making. Introduces diffusion models as interactive neural game engines (extended to CS:GO). Very relevant to the "NC as interactive environment" claim.
- **Potential overlap type**: Method — diffusion for interactive game simulation
- **Cited by target paper**: No
- **Recommended for deep reading**: Yes — CRITICAL

### Candidate 4
- **Title**: AVID: Adapting Video Diffusion Models to World Models
- **Authors**: Marc Rigter et al.
- **Year**: 2024 (October)
- **Venue**: ICLR 2025
- **URL**: https://arxiv.org/abs/2410.12822
- **Why potentially relevant**: Adapts pretrained video diffusion models to action-conditioned world models using lightweight adapters on domain-specific action-labeled data — methodologically parallel to NC_GUIWorld's approach of fine-tuning Wan2.1 with action conditioning modules. Does NOT require access to pretrained model weights.
- **Potential overlap type**: Method — adapting video diffusion for action conditioning
- **Cited by target paper**: No
- **Recommended for deep reading**: Yes — HIGH PRIORITY

### Candidate 5
- **Title**: Pre-Trained Video Generative Models as World Simulators
- **Authors**: Zhanyi He, Xiaofan Zhang et al.
- **Year**: 2025 (February)
- **Venue**: ICLR 2025
- **URL**: https://arxiv.org/abs/2502.07825
- **Why potentially relevant**: Directly proposes Dynamic World Simulation (DWS) to transform pre-trained video generative models into controllable world simulators with action conditioning. Introduces lightweight action-conditioned modules that integrate into existing models. Applies to both diffusion and autoregressive transformer models. Methodologically very close to NC_GUIWorld.
- **Potential overlap type**: Both (Problem + Method)
- **Cited by target paper**: No
- **Recommended for deep reading**: Yes — HIGH PRIORITY

### Candidate 6
- **Title**: Genie: Generative Interactive Environments
- **Authors**: Jake Bruce, Michael Dennis, Ashley Edwards et al. (Google DeepMind)
- **Year**: 2024 (February)
- **Venue**: ICML 2024
- **URL**: https://arxiv.org/abs/2402.15391
- **Why potentially relevant**: Foundation world model at 11B parameters trained unsupervised from internet videos with latent action model. Enables action-controllable virtual world generation. The "Genie" lineage (Genie 1, 2, 3) is the closest public-system comparator to the NC video model concept from a research perspective.
- **Potential overlap type**: Both (Problem framing + Method)
- **Cited by target paper**: Yes (Bruce et al. 2024)
- **Recommended for deep reading**: Yes — for baseline understanding

### Candidate 7
- **Title**: Computer-Using World Model (CUWM)
- **Authors**: Yiming Guan, Rui Yu, John Zhang et al.
- **Year**: 2026 (February)
- **Venue**: arXiv preprint
- **URL**: https://arxiv.org/abs/2602.17365
- **Why potentially relevant**: Desktop software world model (Microsoft Office) that predicts next UI state from current state + action. Uses text-then-visual factorization; reinforcement-learning refined. Addresses the same desktop GUI simulation problem as NC_GUIWorld. Key conceptual difference: CUWM is a planning/simulation tool for agents, not an execution substrate claim. Postdates the NC paper.
- **Potential overlap type**: Problem overlap (GUI state prediction)
- **Cited by target paper**: No (postdates)
- **Recommended for deep reading**: Yes — as contemporary parallel work

### Candidate 8
- **Title**: Vid2World: Crafting Video Diffusion Models to Interactive World Models
- **Authors**: Huang et al.
- **Year**: 2025 (May)
- **Venue**: OpenReview (under review as of search date; latest version March 2026)
- **URL**: https://arxiv.org/abs/2505.14357
- **Why potentially relevant**: Systematically transforms pre-trained video diffusion models into interactive world models using causal masks on temporal attention and Diffusion Forcing. Uses action-per-frame conditioning via lightweight MLP. Closely related to NC_GUIWorld's four action injection mode ablation.
- **Potential overlap type**: Method
- **Cited by target paper**: No (likely postdates or concurrent)
- **Recommended for deep reading**: Yes — for methodological comparison

---

## MEDIUM Relevance Candidates

### Candidate 9
- **Title**: ViMo: A Generative Visual GUI World Model for App Agents
- **Authors**: Dezhao Luo et al.
- **Year**: 2025 (April)
- **Venue**: OpenReview
- **URL**: https://arxiv.org/abs/2504.13936
- **Why potentially relevant**: Visual world model for mobile app agents that generates future GUI observations as images. Introduces Symbolic Text Representation (STR) to handle text in image patches. Downstream: improves task completion from 33.19% to 40.95%. Mobile (not desktop) focus.
- **Potential overlap type**: Problem (GUI state prediction for agents)
- **Cited by target paper**: No
- **Recommended for deep reading**: Maybe — mobile vs. desktop distinction limits direct overlap

### Candidate 10
- **Title**: iVideoGPT: Interactive VideoGPTs are Scalable World Models
- **Authors**: Jialong Wu, Shaofeng Yin et al. (Tsinghua/Mingsheng Long lab)
- **Year**: 2024 (May)
- **Venue**: NeurIPS 2024
- **URL**: https://arxiv.org/abs/2405.15223
- **Why potentially relevant**: Autoregressive transformer integrating visual observations, actions, and rewards into a token sequence for world modeling. Pre-trained on millions of trajectories; can be adapted for action-conditioned video prediction, visual planning, model-based RL. Relevant to the video model + interaction data paradigm.
- **Potential overlap type**: Method
- **Cited by target paper**: No
- **Recommended for deep reading**: Maybe — RL focus differs from NC's "computer" framing

### Candidate 11
- **Title**: AdaWorld: Learning Adaptable World Models with Latent Actions
- **Authors**: Shenyuan Gao, Siyuan Zhou, Yilun Du, Jun Zhang, Chuang Gan
- **Year**: 2025 (March)
- **Venue**: ICML 2025
- **URL**: https://arxiv.org/abs/2503.18938
- **Why potentially relevant**: Pretrains world model using self-supervised latent actions from videos (no explicit action labels), then adapts to specific environments. Addresses the same problem of building interactive world models from unlabeled video at scale.
- **Potential overlap type**: Method (latent action extraction for world models)
- **Cited by target paper**: No
- **Recommended for deep reading**: Maybe — focus on robotics/games, not GUI

### Candidate 12
- **Title**: Latent Action Pretraining from Videos (LAPA)
- **Authors**: Seonghyeon Ye et al. (NVIDIA)
- **Year**: 2024 (October)
- **Venue**: ICLR 2025
- **URL**: https://arxiv.org/abs/2410.11758
- **Why potentially relevant**: First unsupervised VLA pretraining without ground-truth action labels using VQ-VAE-based latent actions between frames. Can be used as a world model for closed-loop evaluation. Methodologically relevant to the CLIGen approach of learning from collected I/O traces without privileged state.
- **Potential overlap type**: Method (unsupervised learning from interaction videos)
- **Cited by target paper**: No
- **Recommended for deep reading**: Maybe — robotics application differs

### Candidate 13
- **Title**: MineWorld: A Real-Time and Open-Source Interactive World Model on Minecraft
- **Authors**: Microsoft Research
- **Year**: 2025 (April)
- **Venue**: arXiv
- **URL**: https://arxiv.org/abs/2504.08388
- **Why potentially relevant**: Visual-action autoregressive Transformer for real-time Minecraft interaction (4–7 FPS). Parallel decoding algorithm for spatial tokens. Evaluates visual quality AND action following capacity. Similar problem framing to NC_GUIWorld in terms of evaluating whether the model correctly responds to actions.
- **Potential overlap type**: Method (action-conditioned interactive video model)
- **Cited by target paper**: No
- **Recommended for deep reading**: Maybe — game (not GUI OS) focus

### Candidate 14
- **Title**: Code2World: A GUI World Model via Renderable Code Generation
- **Authors**: AMAP-ML team
- **Year**: 2026 (February)
- **Venue**: arXiv
- **URL**: https://arxiv.org/abs/2602.09856
- **Why potentially relevant**: GUI world model via code-based state prediction; uses Render-Aware Reinforcement Learning; achieves competitive results with GPT-5 and Gemini-3-Pro on next UI prediction. Alternative technical approach (code vs. video pixels) to the same GUI simulation problem.
- **Potential overlap type**: Problem (GUI state simulation)
- **Cited by target paper**: No (postdates)
- **Recommended for deep reading**: Maybe — code-based approach vs. pixel-based NC approach is a useful contrast

### Candidate 15
- **Title**: Generative Visual Code Mobile World Models (gWorld)
- **Authors**: Trillion Labs team
- **Year**: 2026 (February)
- **Venue**: arXiv
- **URL**: https://arxiv.org/abs/2602.01576
- **Why potentially relevant**: Mobile GUI world model via code generation. 8B and 32B models. Power-law data scaling. Downstream: improves mobile GUI policy performance. Mobile focus; different from NC_GUIWorld's desktop focus.
- **Potential overlap type**: Problem (GUI simulation)
- **Cited by target paper**: No (postdates)
- **Recommended for deep reading**: No — mobile focus + postdates

### Candidate 16
- **Title**: Matrix-Game: Interactive World Foundation Model
- **Authors**: SkyworkAI
- **Year**: 2025 (June)
- **Venue**: arXiv:2506.18701
- **URL**: https://arxiv.org/abs/2506.18701
- **Why potentially relevant**: Interactive game world model with real-time video generation from mouse/keyboard inputs. Cited in the NC paper. Game-focused (Unreal Engine + GTA5).
- **Potential overlap type**: Method (interactive video from actions)
- **Cited by target paper**: Yes (mentioned)
- **Recommended for deep reading**: Maybe — for completeness given direct citation

### Candidate 17
- **Title**: Matrix-Game 2.0
- **Authors**: SkyworkAI
- **Year**: 2025 (August)
- **Venue**: arXiv:2508.13009
- **URL**: https://arxiv.org/abs/2508.13009
- **Why potentially relevant**: Real-time (25 FPS) streaming interactive world model. Autoregressive diffusion with few-step distillation. ~1200h of interaction data. Game focus.
- **Potential overlap type**: Method
- **Cited by target paper**: Yes (mentioned as contemporaneous)
- **Recommended for deep reading**: No — game focus, not computer/OS

### Candidate 18
- **Title**: Wan: Open and Advanced Large-Scale Video Generative Models (Wan2.1 Technical Report)
- **Authors**: Wan-Video team (Alibaba)
- **Year**: 2025 (March)
- **Venue**: arXiv:2503.20314
- **URL**: https://arxiv.org/abs/2503.20314
- **Why potentially relevant**: Technical description of the backbone model used by both NC prototypes. Describes the 3D causal VAE, DiT architecture, and training setup. Relevant for understanding the pretrained substrate and its capabilities/limitations.
- **Potential overlap type**: Method (backbone)
- **Cited by target paper**: Yes (Wan 2025)
- **Recommended for deep reading**: Maybe — for understanding backbone capabilities

### Candidate 19
- **Title**: DreamerV3: Mastering Diverse Domains through World Models
- **Authors**: Danijar Hafner, Jurgis Pasukonis, Jimmy Ba, Timothy Lillicrap
- **Year**: 2023 (January) / Nature 2025
- **Venue**: arXiv:2301.04104; Nature 2025
- **URL**: https://arxiv.org/abs/2301.04104
- **Why potentially relevant**: State-of-the-art latent dynamics world model for RL. Uses RSSM with categorical latent states. Highly relevant as the canonical "world model predicts dynamics for agent" system that the paper contrasts with. Cited in paper.
- **Potential overlap type**: Conceptual baseline (world model for agent)
- **Cited by target paper**: Yes
- **Recommended for deep reading**: No — already cited; known work

### Candidate 20
- **Title**: WorldGUI: An Interactive Benchmark for Desktop GUI Automation from Any Starting Point
- **Authors**: worldGUI team (Show Lab NUS)
- **Year**: 2025 (February)
- **Venue**: arXiv:2502.08047
- **URL**: https://arxiv.org/abs/2502.08047
- **Why potentially relevant**: Desktop GUI automation benchmark (611 tasks, 10 apps) with novel "any starting point" evaluation. Tests GUI agents' planning robustness. Relevant as an evaluation context for NC_GUIWorld-like systems.
- **Potential overlap type**: Problem (GUI automation evaluation)
- **Cited by target paper**: No
- **Recommended for deep reading**: No — benchmark paper, not competing technical approach

### Candidate 21
- **Title**: OSWorld: Benchmarking Multimodal Agents for Open-Ended Tasks in Real Computer Environments
- **Authors**: Tianbao Xie et al. (xlang-ai)
- **Year**: 2024 (April)
- **Venue**: NeurIPS 2024
- **URL**: https://arxiv.org/abs/2404.07972
- **Why potentially relevant**: Real-computer environment benchmark (369 tasks, Ubuntu/Win/Mac, web+desktop+multi-app). State-of-the-art GUI agent evaluation. Cited in methodology context (NC_GUIWorld uses Claude CUA data which runs on real Ubuntu environments).
- **Potential overlap type**: Evaluation context
- **Cited by target paper**: No (Sager et al. is cited, not OSWorld directly)
- **Recommended for deep reading**: No — benchmark, but useful reference

### Candidate 22
- **Title**: A Modern Self-Referential Weight Matrix That Learns to Modify Itself
- **Authors**: Kazuki Irie, Imanol Schlag, Róbert Csordás, Jürgen Schmidhuber
- **Year**: 2022
- **Venue**: ICML 2022
- **URL**: https://arxiv.org/abs/2202.05780
- **Why potentially relevant**: Extends Schmidhuber's fast weight programmer lineage into modern neural architecture. Directly in the NC paper's intellectual ancestry (Schmidhuber 1990s fast weight literature cited repeatedly). Relevant for understanding what "neural computation" has been explored prior to NC framing.
- **Potential overlap type**: Intellectual ancestry
- **Cited by target paper**: No (but parent Schmidhuber works cited)
- **Recommended for deep reading**: No — more relevant to background reading

### Candidate 23
- **Title**: Decision Transformer: Reinforcement Learning via Sequence Modeling
- **Authors**: Lili Chen, Kevin Lu, Aravind Rajeswaran et al.
- **Year**: 2021 (June)
- **Venue**: NeurIPS 2021
- **URL**: https://arxiv.org/abs/2106.01345
- **Why potentially relevant**: Casts RL as sequence modeling over (return, state, action) tuples using causal Transformer. Highly influential in the "learn from interaction traces" paradigm. Relevant background for NC's claim of learning from I/O traces without program state access.
- **Potential overlap type**: Method analogy (sequence modeling of interaction)
- **Cited by target paper**: No
- **Recommended for deep reading**: No — too indirect

### Candidate 24
- **Title**: Neural Turing Machines
- **Authors**: Alex Graves, Greg Wayne, Ivo Danihelka
- **Year**: 2014
- **Venue**: arXiv:1410.5401
- **URL**: https://arxiv.org/abs/1410.5401
- **Why potentially relevant**: The founding paper in the NTM/DNC lineage that the NC paper explicitly differentiates from. The NTM concern is differentiable external memory, not "becoming" the computer.
- **Potential overlap type**: Conceptual differentiation
- **Cited by target paper**: Yes (Graves et al. 2014)
- **Recommended for deep reading**: No — well-known foundational work, already cited

### Candidate 25
- **Title**: Hybrid computing using a neural network with dynamic external memory (DNC)
- **Authors**: Alex Graves, Greg Wayne et al.
- **Year**: 2016
- **Venue**: Nature 2016
- **URL**: https://www.nature.com/articles/nature20101
- **Why potentially relevant**: DNC paper extending NTM with dynamic memory allocation and temporal linking. Together with NTM, forms the lineage the NC paper explicitly contrasts with.
- **Potential overlap type**: Conceptual differentiation
- **Cited by target paper**: Yes (Graves et al. 2016)
- **Recommended for deep reading**: No — already cited

### Candidate 26
- **Title**: World Models
- **Authors**: David Ha, Jürgen Schmidhuber
- **Year**: 2018
- **Venue**: NeurIPS 2018 workshop / arXiv:1803.10122
- **URL**: https://arxiv.org/abs/1803.10122
- **Why potentially relevant**: Founding paper of the "world models" paradigm as it applies to RL agents. The NC paper explicitly contrasts NCs with world models. Ha & Schmidhuber separate the world model (predictive dynamics) from the controller (agent) — a separation the NC paper claims to dissolve.
- **Potential overlap type**: Conceptual baseline
- **Cited by target paper**: Yes
- **Recommended for deep reading**: No — already cited; foundational

### Candidate 27
- **Title**: One Big Net For Everything
- **Authors**: Jürgen Schmidhuber
- **Year**: 2018
- **Venue**: arXiv:1802.08864
- **URL**: https://arxiv.org/abs/1802.08864
- **Why potentially relevant**: Collapses RL agent and world model into a single network through distillation. This is cited in Section 4.4 of the NC paper as a "systems-level realization" of the ONE concept. The NC paper's vision partially builds on this concept.
- **Potential overlap type**: Intellectual ancestor
- **Cited by target paper**: Yes (Schmidhuber 2018)
- **Recommended for deep reading**: No — already cited

### Candidate 28
- **Title**: Neural Programmer-Interpreters
- **Authors**: Scott Reed, Nando de Freitas
- **Year**: 2015/2016
- **Venue**: ICLR 2016 / arXiv:1511.06279
- **URL**: https://arxiv.org/abs/1511.06279
- **Why potentially relevant**: NPI learns to represent and execute programs by recursively composing programs. A key prior work in neural execution of programs. The NC paper explicitly contrasts with NPI as part of the differentiable programming lineage.
- **Potential overlap type**: Conceptual differentiation
- **Cited by target paper**: Yes (Reed & de Freitas 2015)
- **Recommended for deep reading**: No — already cited

---

## LOW Relevance Candidates (For Context Only)

### Candidate 29
- **Title**: Oasis: A Universe in a Transformer (Minecraft neural game)
- **Authors**: Decart AI / Etched
- **Year**: 2024 (October)
- **Venue**: Blog post / technical report (no arXiv)
- **URL**: https://decart.ai/publications/oasis-interactive-ai-video-game-model
- **Why potentially relevant**: Action-conditioned Minecraft game simulation using diffusion transformer (500M open-sourced version). Similar concept to NC_GUIWorld but for game environments.
- **Potential overlap type**: Problem analogy (interactive diffusion world model)
- **Cited by target paper**: No
- **Recommended for deep reading**: No — no arXiv paper; blog-only; game not OS

### Candidate 30
- **Title**: LLM-Brained GUI Agents: A Survey
- **Authors**: Chaoyun Zhang et al.
- **Year**: 2024 (November)
- **Venue**: arXiv:2411.18279
- **URL**: https://arxiv.org/abs/2411.18279
- **Why potentially relevant**: Comprehensive survey of LLM-based GUI agents including agents, world models, and environment perception. Useful for understanding the GUI agent landscape in context.
- **Potential overlap type**: Survey context
- **Cited by target paper**: No
- **Recommended for deep reading**: No — survey; not direct competition

### Candidate 31
- **Title**: Genie 2 (foundation world model)
- **Authors**: Google DeepMind
- **Year**: 2024 (December)
- **Venue**: Blog post / no arXiv paper
- **URL**: https://deepmind.google/discover/blog/genie-2-a-large-scale-foundation-world-model/
- **Why potentially relevant**: Large-scale world model generating action-controllable 3D environments. No arXiv paper.
- **Potential overlap type**: Problem space
- **Cited by target paper**: No (Genie 3 mentioned, not Genie 2)
- **Recommended for deep reading**: No — no formal paper

### Candidate 32
- **Title**: Genie 3 (interactive world model)
- **Authors**: Google DeepMind
- **Year**: 2025 (August; research preview)
- **Venue**: Blog post / no arXiv paper as of April 2026
- **URL**: https://deepmind.google/blog/genie-3-a-new-frontier-for-world-models/
- **Why potentially relevant**: Real-time 24 FPS interactive world model generating explorable 3D environments from text prompts; autoregressive decoder-only spatiotemporal transformer. Mentioned in the NC paper as contemporaneous.
- **Potential overlap type**: Method (interactive video generation)
- **Cited by target paper**: Yes (mentioned as contemporaneous)
- **Recommended for deep reading**: No — no formal arXiv paper

### Candidate 33
- **Title**: iVideoGPT: Interactive VideoGPTs are Scalable World Models
- **Authors**: Jialong Wu, Shaofeng Yin, Mingsheng Long et al.
- **Year**: 2024 (May)
- **Venue**: NeurIPS 2024
- **URL**: https://arxiv.org/abs/2405.15223
- **Why potentially relevant**: Autoregressive transformer integrating observations, actions, rewards for interactive world modeling. Compressive visual tokenization. Pre-trained on large trajectory datasets.
- **Potential overlap type**: Method (action-conditioned video world modeling)
- **Cited by target paper**: No
- **Recommended for deep reading**: No — game/robot focus

### Candidate 34
- **Title**: ControlNet: Adding Conditional Control to Text-to-Image Diffusion Models
- **Authors**: Lvmin Zhang, Anyi Rao, Maneesh Agrawala
- **Year**: 2023
- **Venue**: ICCV 2023
- **URL**: https://arxiv.org/abs/2302.05543
- **Why potentially relevant**: The residual injection method used in NC_GUIWorld's "residual" mode is explicitly described as "ControlNet-style." Understanding ControlNet's zero-initialized residual branches is important for evaluating the action injection architecture claims.
- **Potential overlap type**: Method (architectural prior for action injection)
- **Cited by target paper**: No (technique used but not cited)
- **Recommended for deep reading**: No — direct citation gap; not competing work

### Candidate 35
- **Title**: Cosmos World Foundation Model Platform for Physical AI
- **Authors**: NVIDIA team
- **Year**: 2025 (January)
- **Venue**: arXiv:2501.03575
- **URL**: https://arxiv.org/abs/2501.03575
- **Why potentially relevant**: Foundation world models for physical AI, including action-conditioned video prediction. Cosmos-Predict2 enables robot/action-conditioned video generation. Broader physical AI focus (robotics), not GUI/OS.
- **Potential overlap type**: Method (video world model platform)
- **Cited by target paper**: No
- **Recommended for deep reading**: No — robotics/physical AI focus differs

---

## Candidates NOT Cited by Target Paper

The following are papers not cited in Neural Computers that emerged from this search and warrant attention in Phase-3-5b:

| Paper | Year | Venue | Why Important to Note |
|-------|------|-------|----------------------|
| GameNGen (arXiv:2408.14837) | 2024 | ICLR 2025 | First diffusion game engine; nearly identical technical approach to NC_GUIWorld for interactive environments |
| DIAMOND (arXiv:2405.12399) | 2024 | NeurIPS 2024 Spotlight | Diffusion world model for RL; interactive game engine extension |
| AVID (arXiv:2410.12822) | 2024 | ICLR 2025 | Adapter-based video diffusion action conditioning — direct method analog |
| Pre-Trained Video as World Simulators (arXiv:2502.07825) | 2025 | ICLR 2025 | Lightweight universal action-conditioned module for pretrained video models |
| Vid2World (arXiv:2505.14357) | 2025 | Under review | Causal masking + action conditioning of video diffusion |
| ViMo (arXiv:2504.13936) | 2025 | Under review | Visual GUI world model for mobile agents |
| AdaWorld (arXiv:2503.18938) | 2025 | ICML 2025 | Latent action world model from videos |
| LAPA (arXiv:2410.11758) | 2024 | ICLR 2025 | Latent action pretraining from videos; world model use |
| Computer-Using World Model (arXiv:2602.17365) | 2026 | arXiv | Desktop GUI world model; same domain, different framing |
| MineWorld (arXiv:2504.08388) | 2025 | arXiv | Real-time interactive world model (Microsoft) |
| ControlNet (arXiv:2302.05543) | 2023 | ICCV 2023 | Used but not cited (residual injection mode) |

**Note**: Some papers (Vid2World, CUWM, Code2World, gWorld) postdate the NC paper (April 2026 arXiv submission) and thus cannot be "missing citations." The papers from 2024 and early-to-mid 2025 that predate the NC submission are the critical missing citations: GameNGen, DIAMOND, AVID, Pre-Trained Video as World Simulators, LAPA.

---

## Recommendations for Phase-3-5b Deep Reading

Based on this search, the following papers should be prioritized for deep reading in Phase-3-5b, ordered by priority:

**Priority 1 — CRITICAL (Must Read)**

1. **NeuralOS (arXiv:2507.08800)** — Most closely related system per the paper's own acknowledgment; needs formal differentiation. Key question: Is NC_GUIWorld's approach (DiT fine-tuning + action injection) meaningfully different from NeuralOS's (RNN + diffusion renderer) at the conceptual level of "being the computer"?

2. **GameNGen (arXiv:2408.14837)** — Not cited but directly relevant; first diffusion-based game engine using same interaction-data → video model paradigm. Key question: What is the claimed difference between a "neural game engine" (GameNGen) and a "neural computer" (NC)?

3. **AVID (arXiv:2410.12822)** — Not cited; ICLR 2025; adapter approach to the same problem of action-conditioning pretrained video diffusion models. Key question: Does AVID's approach (learned mask modifying intermediate outputs) overlap with NC_GUIWorld's injection modes?

**Priority 2 — HIGH (Should Read)**

4. **Pre-Trained Video as World Simulators (arXiv:2502.07825)** — ICLR 2025; introduces DWS, a lightweight universal action-conditioned module directly applicable to existing models. Key question: Does DWS apply to Wan2.1-type models? Does the paper's internal injection approach overlap?

5. **DIAMOND (arXiv:2405.12399)** — NeurIPS 2024 Spotlight; diffusion world model for games; explicitly extended to interactive neural game engine. Key question: How does DIAMOND's agent-training framing differ from NC's "computer" framing?

6. **Vid2World (arXiv:2505.14357)** — May postdate NC but the most methodologically parallel approach; causal masking + action conditioning of video diffusion. Key question: Is NC_GUIWorld's internal injection mode equivalent to Vid2World's causal masking approach?

**Priority 3 — MEDIUM (Should Read for Context)**

7. **ViMo (arXiv:2504.13936)** — GUI world model for mobile agents; visual generation approach. Demonstrates that visual GUI world modeling for agent planning is an active research direction.

8. **Computer-Using World Model (arXiv:2602.17365)** — Postdates NC; confirms desktop GUI simulation is an active concurrent research direction. The two-stage (text-then-visual) approach contrasts with NC_GUIWorld's end-to-end pixel approach.

9. **Genie 1 (arXiv:2402.15391)** — Already cited; deep reading would help characterize the latent action model approach versus NC_GUIWorld's explicit action conditioning.

10. **LAPA (arXiv:2410.11758)** — Latent action pretraining; contrasts with NC's explicit action conditioning philosophy.
