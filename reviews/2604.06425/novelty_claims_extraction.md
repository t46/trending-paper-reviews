# Authors' Novelty Claims Extraction

## Paper Information
- **Title**: Neural Computers
- **Authors**: Mingchen Zhuge et al. (19 authors, KAUST affiliation)
- **arXiv**: 2604.06425
- **Date**: April 2026

---

## Claimed Main Contributions

### Contribution 1: The Neural Computer (NC) Abstraction
- **Authors' Statement**: "We introduce Neural Computers (NCs) — an emerging machine form that unifies computation, memory, and I/O in a learned runtime state."
- **Location**: Abstract, p.1; Introduction, p.2
- **Type**: Novel conceptual abstraction / new machine form definition
- **Formal model**: h_t = F_theta(h_{t-1}, x_t, u_t); x_{t+1} ~ G_theta(h_t) (Eq. 2.1)

### Contribution 2: Distinction from Prior Machine Forms
- **Authors' Statement**: "Unlike conventional computers, which execute explicit programs, agents, which act over external execution environments, and world models, which learn environment dynamics, NCs aim to make the model itself the running computer."
- **Location**: Abstract, p.1; Introduction, p.2; Section 4.3, pp.25–26
- **Type**: Paradigm differentiation claim

### Contribution 3: Distinction from NTM/DNC
- **Authors' Statement**: "Our concern is not differentiable external memory but whether a learning machine can assume the role of a running computer."
- **Location**: Section 1, p.2
- **Type**: Differentiation from historical neural computation lineage

### Contribution 4: NC_CLIGen — CLI Video Generator
- **Authors' Statement**: Two prototype instantiations as video models; CLIGen operates over CLI/terminal interface traces; CLIGen achieves PSNR 26.89 dB with detailed captions, char acc 0.54, and reprompting boosts arithmetic from 4% to 83%.
- **Location**: Section 3.1, pp.5–13
- **Type**: System implementation + empirical findings

### Contribution 5: NC_GUIWorld — Desktop GUI Video Generator
- **Authors' Statement**: GUIWorld achieves FVD 14.72 with CUA data; SVG cursor supervision raises cursor accuracy from 8.7% to 98.7%; internal injection mode achieves best FVD 14.5.
- **Location**: Section 3.2, pp.14–21
- **Type**: System implementation + empirical findings

### Contribution 6: Completely Neural Computer (CNC) Roadmap
- **Authors' Statement**: "The long-term goal is the Completely Neural Computer (CNC): the mature, general-purpose realization of this emerging machine form, with stable execution, explicit reprogramming, and durable capability reuse."
- **Location**: Abstract; Section 4, pp.22–28
- **Type**: Vision/position statement + formal 4-condition definition

---

## Claimed Gaps in Prior Work

- **Gap 1**: "No prior work has asked whether a neural system can *become* the computer itself — not predict it, not interface with it."
  - Location: Section 1, Introduction (implicit); Section 2.1, Related Work
- **Gap 2**: NTM/DNC concern is differentiable external memory, not whether model can run as a computer
  - Location: Section 1, p.2
- **Gap 3**: World models "learn environment dynamics" but retain the execution runtime outside the model
  - Location: Section 4.3, p.25–26
- **Gap 4**: AI agents "act over external execution environments" — strict separation between model and execution
  - Location: Section 4.3, pp.25–26
- **Gap 5**: NeuralOS and Imagine with Claude are "most closely related" but treated as prior art, not differentiated in depth
  - Location: Section 2.1 (brief mention)

---

## Authors' Differentiation Claims

- **vs. NTM/DNC (Graves et al. 2014, 2016)**: Authors claim NTM/DNC concern is external memory structures; NC concern is whether the model can *be* the running computer — not a memory module attached to a controller
- **vs. World Models (Ha & Schmidhuber 2018; Hafner DreamerV3)**: Authors claim world models "learn environment dynamics" while NCs "are" the computer — runtime is inside vs. outside the model
- **vs. AI Agents (Anthropic CUA, OpenAI)**: Authors claim agents act over external environments; NC makes the neural model itself the execution substrate
- **vs. Genie 3 / Veo 3 / Sora 2**: Authors acknowledge these as video models but do not claim they adopt the NC abstraction (no latent runtime state formalization, no NC primitive framing)
- **vs. NeuralOS**: Briefly mentioned in Section 2.1 as "most closely related"; no formal differentiation provided — this is the largest acknowledged gap
- **vs. Imagine with Claude**: Briefly mentioned in Section 2.1; not formally differentiated

---

## Related Work Coverage (from paper, Section 2.1)

Papers cited in Related Work (~1 page, embedded in Preliminaries):

1. Graves et al. 2014 — Neural Turing Machines
2. Graves et al. 2016 — Differentiable Neural Computers
3. Reed & De Freitas 2015 — Neural Programmer-Interpreters
4. Schmidhuber 1990–2018 — Fast weight programmers, One Big Net For Everything
5. Ha & Schmidhuber 2018 — World Models
6. Hafner et al. — DreamerV3 (cited as world model representative)
7. Bruce et al. 2024 — Genie (generative interactive environments)
8. Google DeepMind 2025 — Genie 3 (mentioned as contemporaneous)
9. Google DeepMind 2025 — Veo 3 (video model, mentioned)
10. OpenAI 2025 — Sora 2 (mentioned, used in Experiment 5 Table 5)
11. SkyworkAI 2025 — Matrix-Game-2 (mentioned as contemporaneous)
12. Wan 2025 — Wan2.1 (backbone model)
13. Anthropic 2024–2025 — CUA / Computer Use (data source for GUIWorld)
14. NeuralOS (Rivard et al. 2025) — mentioned as most closely related
15. "Imagine with Claude" — mentioned as closely related
16. Sager et al. 2025 — agent benchmark (cited)
17. Zhuge et al. 2024a, 2024b, 2026a, 2026b — language agents

---

## Initial Observations

### Gaps in Related Work Coverage Identified at Level 0-1

1. **GameNGen (Valevski et al. 2024, arXiv:2408.14837)**: First neural game engine using diffusion models for action-conditioned game simulation — highly relevant to NC prototype claims; NOT cited
2. **DIAMOND (Alonso et al. 2024, arXiv:2405.12399)**: Diffusion world model for Atari with RL agent; NeurIPS 2024 Spotlight; NOT cited
3. **AVID (Rigter et al. 2024, arXiv:2410.12822)**: Adapting video diffusion models to action-conditioned world models using lightweight adapters; ICLR 2025; NOT cited
4. **Vid2World (Huang et al. 2025, arXiv:2505.14357)**: Crafting video diffusion models into interactive world models with causal masking; may postdate paper
5. **Computer-Using World Model / CUWM (Guan et al. 2026, arXiv:2602.17365)**: Desktop GUI world model for Microsoft Office; uses text-then-visual factorization; NOT cited (likely postdates paper)
6. **ViMo (Luo et al. 2025, arXiv:2504.13936)**: Generative visual GUI world model for mobile app agents; NOT cited (may postdate paper)
7. **Code2World (arXiv:2602.09856)**: GUI world model via code generation — different technical approach; NOT cited (postdates)
8. **gWorld (arXiv:2602.01576)**: Mobile GUI world models via code generation; NOT cited (postdates)
9. **MineWorld (Microsoft 2025, arXiv:2504.08388)**: Real-time open-source Minecraft interactive world model; NOT cited
10. **Oasis (Decart/Etched 2024)**: Action-conditioned Minecraft world model; NOT cited
11. **iVideoGPT (Wu et al. 2024, arXiv:2405.15223)**: Interactive VideoGPT scalable world models with actions+rewards; NeurIPS 2024; NOT cited
12. **Pre-Trained Video Generative Models as World Simulators (He et al. 2025, arXiv:2502.07825)**: ICLR 2025; directly addresses fine-tuning video models for action conditioning; NOT cited
13. **DreamerV3 (Hafner 2023, Nature 2025)**: Key representative world model; IS cited
14. **AdaWorld (Gao et al. 2025, arXiv:2503.18938)**: Latent action world model, ICML 2025; NOT cited (may postdate)
15. **LAPA (arXiv:2410.11758)**: Latent action pretraining from videos; ICLR 2025; NOT cited
