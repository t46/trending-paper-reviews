# Paper Metadata

## Basic Information
- **Title**: Neural Computers
- **Authors**:
  - Mingchen Zhuge (Meta AI, KAUST) — Core Contributor
  - Changsheng Zhao (Meta AI) — Core Contributor
  - Haozhe Liu (Meta AI, KAUST) — Core Contributor
  - Zijian Zhou (Meta AI)
  - Shuming Liu (Meta AI, KAUST) — Core Contributor
  - Wenyi Wang (KAUST)
  - Ernie Chang (Meta AI)
  - Gael Le Lan (Meta AI)
  - Junjie Fei (Meta AI, KAUST) — Core Contributor
  - Wenxuan Zhang (Meta AI, KAUST) — Core Contributor
  - Yasheng Sun (KAUST)
  - Zhipeng Cai (Meta AI)
  - Zechun Liu (Meta AI)
  - Yunyang Xiong (Meta AI)
  - Yining Yang (Meta AI)
  - Yuandong Tian (Meta AI)
  - Yangyang Shi (Meta AI)
  - Vikas Chandra (Meta AI)
  - Jürgen Schmidhuber (KAUST)
- **Affiliations**:
  - Meta AI
  - KAUST (King Abdullah University of Science and Technology)
- **Venue**: arXiv preprint (cs.LG, cs.AI)
- **Publication Date**: April 7, 2026 (v1 submission); Date field in paper: April 9, 2026
- **Paper URL**: https://arxiv.org/abs/2604.06425
- **DOI**: https://doi.org/10.48550/arXiv.2604.06425
- **Paper Type**: Preprint (arXiv)
- **Length**: 75 pages

## Abstract

We propose a new frontier: Neural Computers (NCs)—an emerging machine form that unifies computation, memory, and I/O in a learned runtime state. Unlike conventional computers, which execute explicit programs, agents, which act over external execution environments, and world models, which learn environment dynamics, NCs aim to make the model itself the running computer. Our long-term goal is the Completely Neural Computer (CNC): the mature, general-purpose realization of this emerging machine form, with stable execution, explicit reprogramming, and durable capability reuse. As an initial step, we study whether early NC primitives can be learned solely from collected I/O traces, without instrumented program state. Concretely, we instantiate NCs as video models that roll out screen frames from instructions, pixels, and user actions (when available) in CLI and GUI settings. These implementations show that learned runtimes can acquire early interface primitives, especially I/O alignment and short-horizon control, while routine reuse, controlled updates, and symbolic stability remain open. We outline a roadmap toward CNCs around these challenges. If overcome, CNCs could establish a new computing paradigm beyond today's agents, world models, and conventional computers.

## Keywords

Not explicitly listed; inferred from content:
- Neural Computers
- Completely Neural Computer (CNC)
- Video models
- World models
- CLI/GUI environments
- Learned runtime state
- Computing paradigm
- I/O traces
- Screen frame generation
- AI agents

## Subject Categories
- Machine Learning (cs.LG) — primary
- Artificial Intelligence (cs.AI)

## Additional Notes
- Correspondence: mczhuge@gmail.com, cszhao@meta.com
- Blog post: https://metauto.ai/neuralcomputer
- GitHub data pipeline referenced in paper
- Paper is in English
- Confirmed academic research paper (not a blog post or news article)
- PDF file size: ~25 MB (25.3 MB)
- Paper structure: Introduction, Preliminaries, Implementation of Neural Computers, Position: Toward Completely Neural Computers, Conclusion, Appendix
