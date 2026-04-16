# Experimental Design: Target (NC) vs. References

## Dataset Selection Comparison

### Overview of Datasets Used Across References

| Dataset/Domain | Used By | Used By NC |
|----------------|---------|------------|
| Ubuntu XFCE GUI (CUA data) | NeuralOS (Ref 3) | Yes (110h CUA, NC_GUIWorld) |
| Random desktop exploration | NeuralOS (Ref 3) | Yes (1,400h, NC_GUIWorld) |
| DOOM gameplay (RL) | GameNGen (Ref 1) | No |
| Atari 100k | DIAMOND (Ref 2), DWS (Ref 5) | No |
| CS:GO human gameplay | DIAMOND (Ref 2) | No |
| Video game data | AVID (Ref 4), DWS (Ref 5) | No |
| Robotics (BAIR, RT1) | AVID (Ref 4), DWS (Ref 5), Genie (Ref 7) | No |
| Internet platformer video | Genie (Ref 7) | No |
| OSWorld tasks (real OS) | OSWorld (Ref 8) | No |
| Web tasks (Mind2Web) | SeeAct (Ref 10) | No |
| Asciinema CLI recordings | None among references | Yes (824k videos, NC_CLIGen) |
| Scripted VHS terminal | None among references | Yes (128k scripts, NC_CLIGen) |

### Analysis

**Datasets NC Uses Well**:

- Ubuntu XFCE GUI with CUA agent data: The NC_GUIWorld dataset is directly comparable to NeuralOS's data (same OS, same CUA data source, similar scale). This is the most important dataset for the paper's core claim.

- CLIGen datasets (asciinema + VHS scripted): Unique domain with no direct comparable reference. Represents genuine novelty in dataset construction for CLI simulation.

**Critical Datasets NC Doesn't Use**:

- **OSWorld tasks**: NC_GUIWorld trains on CUA agent trajectories but is never evaluated on OSWorld's 369 standardized computer tasks. OSWorld (NeurIPS 2024) defines what "computer use competence" means — it has coverage across Ubuntu, Windows, and macOS, multiple application categories (web, file management, development, media), and established human baselines (72.36%). NC_GUIWorld's evaluation on its own fixed 8-app set does not demonstrate whether the simulation generalizes to the diversity of OSWorld scenarios. This is a critical evaluation gap.

- **Cross-domain generalization**: NeuralOS demonstrates DOOM synthesis on a system where DOOM was never installed — learned purely from fabricated training demonstrations. NC_GUIWorld has no equivalent cross-app generalization test. All evaluation apps overlap with training apps.

- **Standard interactive world model benchmarks**: The NC paper does not evaluate on Atari 100k (DIAMOND, DWS standard) or any equivalent benchmark that would allow cross-system FVD/SSIM comparison. This is appropriate given the different domain, but means NC_GUIWorld's FVD 14.72 cannot be directly compared to DWS's FVD 9.1 (Atari) or DIAMOND's Atari results.

**Overall Dataset Assessment**:

- For NC_GUIWorld: Dataset is appropriate and well-constructed for the target domain; scale is competitive with NeuralOS; the absence of cross-app generalization testing and OSWorld-type task evaluation is the main gap.
- For NC_CLIGen: Dataset is novel and appears to be the first of its kind; limited by the absence of a standard evaluation benchmark for CLI simulation.

---

## Baseline Selection Comparison

### NC_CLIGen Baselines

| Baseline | Role | Appropriateness |
|----------|------|-----------------|
| Wan2.1 (base model) | Zero-shot reference | Appropriate — tests backbone without domain fine-tuning |
| Veo3.1 (Google) | Commercial video model | Rough reference — not a CLI-specialized system; reported for completeness |
| Sora2 (OpenAI) | Commercial video model | Rough reference — different architecture; no configuration details reported |

**Assessment**: The NC_CLIGen baseline set is minimal but defensible given the novelty of the CLI video simulation domain. No directly comparable prior systems exist. However, the Sora2 comparison (Table 5) lacks configuration details (temperature, system prompt, generation steps) — an inconsistency noted in the methodology evaluation (CFR-009).

### NC_GUIWorld Baselines

| Baseline | Role | Appropriateness |
|----------|------|-----------------|
| Untrained baseline | Lower bound | Appropriate — establishes floor |
| External conditioning (early-stopped) | One ablation condition at ~50% compute | Flagged as rough reference; not a proper baseline |

**Critical Baseline Gaps**:

The NC_GUIWorld baseline set is critically weak by field standards. The paper includes no comparison against any of the following directly relevant systems:

1. **GameNGen (ICLR 2025)**: Most technically similar system; PSNR 29.4 on DOOM. Could serve as a reference point even though domains differ.

2. **NeuralOS (ICLR 2026)**: Direct domain competitor (same Ubuntu XFCE environment, same CUA data source). A head-to-head comparison — even qualitative — is conspicuously absent despite the paper calling NeuralOS "most closely related." NeuralOS achieves ±1.6px cursor accuracy vs. NC_GUIWorld's 98.7% binary cursor accuracy (different metrics, but the underlying capability is directly comparable).

3. **DIAMOND (NeurIPS 2024)**: CS:GO extension at ~10 FPS — could provide a reference point for interactive diffusion generation quality from human-collected data.

4. **DWS (ICLR 2025)**: Per-block scale-shift modulation on pretrained video transformers — directly comparable design space to NC_GUIWorld's injection modes. DWS reports FVD 9.1 and PSNR 43.4 on Atari with iVideoGPT+DWS (different domain, but demonstrates the approach).

Why comparison is difficult but still expected:

The primary challenge for cross-system comparison is that these systems use different domains (games vs. OS/GUI), different resolutions, and different action spaces. Direct FVD comparison would require implementing all systems in the same environment, which is a major experimental undertaking. However, the NC paper does not even provide a **qualitative** comparison showing side-by-side generated frames under comparable conditions. A qualitative comparison to NeuralOS on the same Ubuntu XFCE tasks would be feasible and is standard practice when two systems operate in the same domain.

**Overall Baseline Assessment**: Weak for NC_GUIWorld — only two baselines (one of which is an early-stopped ablation condition, not an independent system). NC_CLIGen's baseline set is minimal but justifiable given domain novelty. The most significant gap: no comparison against NeuralOS despite identical domain and data source.

---

## Ablation Study Comparison

### Ablation Practices Across References

| Paper | Ablation Focus | Ablation Depth |
|-------|---------------|----------------|
| GameNGen | Noise augmentation, decoder fine-tuning | 3-4 conditions |
| DIAMOND | EDM vs. DDPM; denoising steps (1 vs. 3); architecture size | 4-5 ablations |
| NeuralOS | Without RNN, without Gaussian cursor encoding, training stage ablations | 3-4 ablations |
| AVID | No mask (PoE), no initial frame, no per-frame conditioning | 3 ablations |
| DWS | Without motion-reinforced loss, per-block vs. not, diffusion vs. AR | 4 ablations |
| Genie | Model scale (40M to 11B); tokenizer choices | Scale analysis |

**NC paper ablations**:

1. **Experiment 3 (CLIGen)**: Caption specificity (semantic/regular/detailed) — 3 conditions, clear monotonic result
2. **Experiment 7 (GUIWorld)**: Data source quality (untrained/Random Slow/Random Fast/CUA) — 4 conditions
3. **Experiment 8 (GUIWorld)**: Cursor supervision loss (position-only/Fourier/SVG) — 3 conditions
4. **Experiment 9 (GUIWorld)**: Injection mode (external/contextual/residual/internal) — 4 modes
5. **Experiment 10 (GUIWorld)**: Action representation (raw-action/meta-action) — 2 conditions

Total: 5 distinct ablation dimensions across 10 experiments. This is competitive with the reference papers' ablation depth. The injection mode ablation (4 conditions) is the most thorough single ablation in the paper and covers a dimension that most references do not explore (they typically use one fixed injection approach).

**Ablation gaps**:

- **Missing**: Ablation over number of training hours (how much data is sufficient for NC_GUIWorld)
- **Missing**: Ablation over context window length (how many past frames are needed)
- **Missing**: Capacity-matched comparison for injection modes (CFR HIGH-003: internal mode likely has more parameters than other modes)
- **Missing**: Ablation over S (number of action slots per frame) in meta-action encoder
- **Missing**: Generalization ablation (training and testing on different app sets)

**Comparison to field standard**: The NC paper's ablation depth is at the field median. The absence of the capacity-controlled injection mode comparison (CFR HIGH-003) is the most consequential gap relative to reference practices.

---

## Statistical Rigor Comparison

### Statistical Practices in References

| Practice | GameNGen | DIAMOND | NeuralOS | AVID | DWS | NC |
|----------|----------|---------|---------|------|-----|----|
| Multiple runs / seeds | Partial | Yes | Not stated | Not stated | Not stated | No |
| Error bars in main tables | Some | Yes (mean over games) | Not fully stated | Not fully stated | Not fully stated | No |
| Confidence intervals | Human rater CI | No | No | No | No | No |
| Significance testing | No | No | No | No | No | No |
| Sample size stated | Yes | N=26 games | Yes | Not fully | Yes | Partial |

**Assessment**:

Statistical reporting in video generation and world model papers is generally weak across the field — this is not exclusively an NC paper problem. DIAMOND is the best statistical reporter (results across 26 Atari games provide implicit variance). Most papers, including several references, do not report standard deviations for single-dataset experiments.

However, the NC paper's systemic absence of variance measures across all 10 experiments (CFR-009) is more severe than typical because: (a) several key comparisons involve small absolute differences (internal vs. residual SSIM: 0.006 difference; meta vs. raw: 0.016 SSIM difference) where statistical noise is decision-relevant; (b) the arithmetic probe results are based on n=100 single draws with no stated confidence intervals (CFR-005); (c) the reprompting result (83%) has no data table, no sample size, and no CI (CFR-010).

The field standard from the best reference papers (DIAMOND) is to at minimum report results across multiple environments to provide implicit variance. The NC paper cannot do this in the same way, but could report results across multiple application evaluations or multiple evaluation runs.

---

## Evaluation Metric Comparison

### Metrics Used Across References

| Metric | GameNGen | DIAMOND | NeuralOS | AVID | DWS | NC_CLIGen | NC_GUIWorld |
|--------|----------|---------|---------|------|-----|-----------|------------|
| PSNR | Yes (29.4) | No | Not primary | Not primary | Yes (43.4 Atari) | Yes (26.89) | No |
| SSIM | No | No | Not primary | Not primary | Yes (98.2 Atari) | Yes (0.867) | Yes (0.885) |
| FVD | No | Atari: HNS | Not stated | Yes | Yes (9.1 Atari) | No | Yes (14.72) |
| LPIPS | No | No | No | Yes | No | No | Yes (0.144) |
| Human perceptual study | Yes | No | No | No | No | No | No |
| Task completion rate | No | Atari HNS | No | No | RL performance | 4%/83% probe | No |
| Cursor accuracy | No | No | ±1.6px | No | No | No | 98.7% binary |
| Character/OCR accuracy | No | No | No | No | No | Yes (0.54) | No |

**Assessment**:

The NC paper's metric selection is appropriate for the domains: FVD/SSIM/LPIPS are standard video quality metrics for GUIWorld; PSNR/SSIM/OCR accuracy are appropriate for CLIGen (where text legibility is the primary concern). The post-action variants (SSIM+15, FVD+15, LPIPS+15) are a novel contribution — no reference paper uses action-triggered metric windows, which is a genuine methodological contribution.

**Gaps relative to references**:

- **No human perceptual study**: GameNGen includes a human rater study (real vs. simulated clips); Genie includes human playability assessment. NC_GUIWorld lacks any human evaluation. Given the paper's claim of "interactive computer simulation," a human perceptual study would strengthen the evidence considerably.

- **No task completion metric**: NC_GUIWorld has no metric for whether simulated interactions produce correct outcomes at the task level. NeuralOS demonstrates application launches and file operations as binary capabilities. NC_GUIWorld's FVD measures perceptual quality but not functional correctness.

- **No cross-app generalization metric**: NeuralOS's DOOM cross-app generalization is a capability metric. NC_GUIWorld has no equivalent.

---

## Experimental Scale Comparison

### Reference Papers' Experimental Scale

| Paper | Domains | Conditions | Ablation Depth | Human Eval | Scale |
|-------|---------|-----------|---------------|-----------|-------|
| GameNGen | 1 (DOOM) | Ablations only | Moderate | Yes (perceptual) | Medium |
| DIAMOND | 26 games (Atari) + CS:GO | Multiple baselines | Comprehensive | No | Large |
| NeuralOS | Ubuntu XFCE (multi-app) | RNN vs. diffusion | Moderate | No | Medium-Large |
| AVID | 2 (game + robotics) | Multiple adapter configs | Moderate | No | Medium |
| DWS | 4 environments (2 game, 2 robot) | DiffModel vs. AR model | Moderate-High | No | Medium-Large |
| Genie | Platformers + robotics | Scale ablation (7 sizes) | Comprehensive | Yes (playability) | Large |

**NC Paper's Scale**:

| Metric | NC_CLIGen | NC_GUIWorld |
|--------|-----------|-------------|
| Domains | 1 (CLI) | 1 (Ubuntu XFCE, 8 apps) |
| Baselines | 3 (1 own backbone + 2 commercial) | 2 (untrained + early-stopped ablation) |
| Ablation dimensions | 2 (caption tier, training steps) | 3 (data quality, cursor, injection mode) + meta-action |
| Human eval | No | No |
| Closed-loop testing | No | No |
| Cross-domain generalization | No | No |

**Overall Scale Assessment**:

The NC paper's experimental scale is medium to medium-low relative to the reference benchmark. The number of ablation dimensions is comparable to the field standard. The lack of closed-loop evaluation, cross-domain generalization, and human perceptual study keeps the total evaluation footprint below most primary technical comparison papers (GameNGen, DIAMOND, NeuralOS). The two-system scope (CLI + GUI) provides breadth across paradigms, but each system's evaluation depth is shallower than NeuralOS or DIAMOND.

The most impactful scale gap: all 10 experiments are open-loop only, which means the evaluation never directly addresses the primary NC claim (persistent runtime state across self-generated sequences). This is not a matter of adding more ablations — it is a fundamentally different type of evaluation that the paper's experimental design does not currently include.
