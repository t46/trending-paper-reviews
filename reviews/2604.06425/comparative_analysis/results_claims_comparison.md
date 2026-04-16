# Results and Claims: Target (NC) vs. References

## Performance Numbers Comparison

### Video Quality Metrics

**PSNR Comparison (where applicable)**:

| System | Domain | PSNR | Notes |
|--------|--------|------|-------|
| GameNGen | DOOM (game) | 29.4 dB | Full model; comparable to lossy JPEG |
| NC_CLIGen | CLI terminal | 26.89 dB | Detailed captions; Table 3 |
| NC_CLIGen (semantic) | CLI terminal | 21.90 dB | Semantic captions; Table 3 |
| DWS (iVideoGPT) | Atari | 43.4 dB | Very high due to constrained game domain |
| DWS (Open-Sora) | Atari | Not reported | FVD primary metric |
| Wan2.1 VAE (reconstruction) | CLI frames | 40.77 dB | No NC fine-tuning; reconstruction only |

**Direct comparison note**: NC_CLIGen's 26.89 dB is below Wan2.1's own VAE reconstruction quality of 40.77 dB — expected, since generation is harder than reconstruction. GameNGen reports 29.4 dB for a different domain (game graphics) under different conditioning. These numbers are not directly comparable across domains.

**SSIM Comparison**:

| System | Domain | SSIM | Notes |
|--------|--------|------|-------|
| NC_CLIGen | CLI terminal | 0.867 | Detailed captions; Table 3 |
| NC_GUIWorld (CUA) | Ubuntu XFCE | 0.885 (SSIM_all) | Table 8 |
| NC_GUIWorld (internal) | Ubuntu XFCE | 0.863 (SSIM+15) | Post-action metric; Table 10 |
| DWS (iVideoGPT+DWS) | Atari | 0.982 | High due to constrained game domain |
| Wan2.1 VAE (reconstruction) | CLI frames | 0.989 | Reconstruction floor |

**FVD Comparison**:

| System | Domain | FVD | Notes |
|--------|--------|-----|-------|
| NC_GUIWorld (CUA, internal) | Ubuntu XFCE | 14.72 (overall), 14.5 (FVD+15) | Table 8/10 |
| NC_GUIWorld (Random Fast) | Ubuntu XFCE | 48.17 | Table 8 |
| NC_GUIWorld (Untrained) | Ubuntu XFCE | 149.61 | Table 8 |
| DWS (iVideoGPT+DWS) | Atari | 9.1 | Different domain |
| DWS (Open-Sora+DWS) | Not specified | Not directly extracted | |

**Cross-system comparison caveat**: FVD scores cannot be directly compared across domains because the reference distribution differs. Atari frames have much lower visual entropy than Ubuntu XFCE GUI frames. A lower FVD on Atari does not imply better performance than a higher FVD on Ubuntu XFCE.

### Capability Metrics

**Cursor Accuracy Comparison**:

| System | Metric | Value | Notes |
|--------|--------|-------|-------|
| NeuralOS | Pixel error (Gaussian encoding) | ±1.6 px | Absolute cursor positioning error |
| NC_GUIWorld (SVG supervision) | Binary cursor accuracy | 98.7% | Fraction of frames with correct cursor |
| NC_GUIWorld (position-only) | Binary cursor accuracy | 8.7% | Without SVG supervision |

**Metric alignment issue**: NeuralOS reports absolute pixel error (±1.6px); NC_GUIWorld reports binary cursor accuracy (correct/incorrect). These metrics measure the same capability from different angles. A ±1.6px error would be sub-pixel for many cursor locations, likely mapping to very high binary accuracy. However, neither paper cross-reports the other's metric, preventing direct calibrated comparison.

**Interactive Capability Comparison**:

| System | Interactive Mode | FPS | Context | User-Tested |
|--------|-----------------|-----|---------|-------------|
| GameNGen | Closed-loop (RL + human) | 20 FPS | 64 frames | Yes (human rater study) |
| DIAMOND CS:GO | Closed-loop (human play) | ~10 FPS | L past frames | Yes (playable demo) |
| NeuralOS | Closed-loop (user input) | 15 FPS | 256-frame RNN memory | Yes (capability demos) |
| NC_GUIWorld | Open-loop only | Not reported (no real-time inference test) | Not reported | No |

This table reveals the most significant capability gap: NC_GUIWorld is the only system among the primary technical comparators that has not been demonstrated in closed-loop interactive operation. GameNGen at 20 FPS represents the practical target; DIAMOND at ~10 FPS and NeuralOS at 15 FPS are in the same range. NC_GUIWorld's inference speed is not reported, and no closed-loop test is conducted.

---

## Claims Strength Comparison

### Claims Made by References

**Narrow, Well-Supported Claims** (GameNGen, DIAMOND):

GameNGen (Abstract): "the first game engine powered entirely by a neural model that also enables real-time interaction with a complex environment over long trajectories at high quality."
- Evidence: PSNR 29.4, human perceptual study (0.58 rater accuracy ≈ chance), 20 FPS on TPU, 5-minute stable generation
- Assessment: Narrow claim fully supported by evidence. No overclaiming.

DIAMOND (Abstract): "diamond achieves a mean human normalized score of 1.46 on the competitive Atari 100k benchmark; a new best for agents trained entirely within a world model."
- Evidence: Direct benchmark results across 26 Atari games
- Assessment: Specific, measurable claim directly supported by reported numbers.

**Moderate Claims** (NeuralOS, AVID, DWS):

NeuralOS: "simulates an operating system's graphical interface entirely using deep neural networks" with "256-frame memory retention."
- Evidence: Capability demonstrations (file operations, app launches), cross-app generalization (DOOM), cursor accuracy ±1.6px
- Assessment: Demonstrated capabilities, though operating-system coverage remains partial (acknowledged in Appendix B).

**Broad Conceptual Claims** (Genie, NC):

Genie: "Genie has learned to take action in a vast diversity of worlds, and can be prompted to generate an endless variety of action-controllable virtual worlds."
- Evidence: 11B model, FVD ~40, 8 discrete latent actions, behavioral cloning experiments
- Assessment: Broader claim, partially supported; "vast diversity" is relative to training data distribution.

**NC Paper Claims**:

The NC paper's claims span multiple levels:
1. "Neural Computers (NCs) are an emerging machine form." — Paradigm-level claim.
2. "This enables them to take over the runtime responsibilities of physical computers." — Capability claim.
3. NC_GUIWorld "demonstrates early NC primitives." — Prototype claim.
4. Reprompting raises arithmetic performance from 4% to 83%. — Specific quantitative claim.
5. SVG cursor supervision achieves 98.7% cursor accuracy. — Specific quantitative claim.

**Assessment by claim layer**:

- Claims 4 and 5 are specific, directly supported, and appropriately presented (though CFR-010 notes reprompting lacks a data table). These are the best-calibrated claims.
- Claim 3 is reasonable as a prototype demonstration but weakened by the open-loop-only evaluation.
- Claims 1 and 2 are paradigm-level assertions that are not formally proven relative to existing systems. The paper does not demonstrate that NC_GUIWorld satisfies all four CNC conditions (Turing completeness, universal programmability, behavioral consistency, machine-native semantics) — these are specified as goals for the emerging paradigm, not demonstrated achievements.

**Comparison to references**: NC's paradigm-level claims (1, 2) are the broadest among all references. Genie comes closest with its "vast diversity" language, but Genie's 11B model is correspondingly larger. GameNGen's and NeuralOS's claims are the best-calibrated to their evidence.

---

## Generalization Evidence

### How References Demonstrate Generalization

| Paper | Generalization Evidence |
|-------|------------------------|
| GameNGen | Single domain (DOOM); no cross-game generalization tested |
| DIAMOND | 26 Atari games; mean + median across games = implicit cross-game generalization |
| NeuralOS | Cross-app generalization (DOOM on system without DOOM installed) |
| DWS | Two domains (games + robotics), two model architectures (diffusion + AR) |
| Genie | Internet videos → any platformer domain; robotics (RT1) |
| SeeAct | 137 diverse websites on Mind2Web |

**NC paper's generalization evidence**:

- NC_CLIGen General: Diverse asciinema recordings (developer workflows across different tools and environments)
- NC_CLIGen Clean: Controlled scripted scenarios — limited generalization scope
- NC_GUIWorld: Fixed 8-app set (Firefox, GIMP, VLC, VS Code, Calculator, Terminal, File Manager, Mahjongg); no cross-app or cross-OS generalization tested

**Comparison**:

NC_GUIWorld's generalization evidence is among the weakest in the reference set. Only NeuralOS (also single-OS) has comparably limited generalization evidence, but NeuralOS compensates with the DOOM cross-app generalization demonstration. The NC paper has no equivalent cross-scope test.

DWS demonstrates generalization across two fundamentally different domains (games + robotics) AND two model architectures (diffusion + AR) — a level of generalization that exceeds NC_GUIWorld's single-domain, single-architecture evaluation.

DIAMOND demonstrates generalization across 26 Atari games — while all games, the breadth across game types (and the mean/median reporting) provides much stronger evidence of method generality.

The NC paper's generalization gap is not fatal for a prototype-level demonstration, but it is inconsistent with the breadth of the paradigm-level claims being made.

---

## What Would Strengthen NC's Results Presentation

**Priority 1 - Critical**:

1. **Closed-loop evaluation**: Even one controlled demonstration of NC_GUIWorld's autoregressive stability (e.g., 60-second interaction sequence with generated frames fed back as input) would directly address the primary claim about NC runtime state. This is the single most impactful addition relative to field standards.

2. **Comparison against NeuralOS on identical tasks**: Side-by-side generated frames for the same Ubuntu XFCE task sequence (same starting frame, same action sequence) from NC_GUIWorld and NeuralOS would be the most informative comparison the paper could provide, given identical domains.

3. **Human perceptual study**: GameNGen's human rater study (0.58 accuracy at distinguishing real vs. simulated clips) is the field's best example of a claim-independent evaluation. An equivalent study for NC_GUIWorld would significantly strengthen the interactive simulation claim.

**Priority 2 - Important**:

4. **Cross-app generalization test**: NC_GUIWorld should be tested on at least one app not present in training data. NeuralOS's DOOM test is the reference example.

5. **Reprompting data table**: The 4% → 83% reprompting result should be accompanied by a data table with sample size and confidence interval (CFR-010).

6. **Inference speed measurement**: Reporting FPS on NC_GUIWorld during inference would allow direct comparison to GameNGen (20 FPS), DIAMOND (~10 FPS), and NeuralOS (15 FPS).

**Priority 3 - Nice-to-Have**:

7. **Statistical variance**: At minimum, report multiple evaluation runs for the injection mode comparison (Table 10) where differences are small (internal vs. residual SSIM 0.006).

8. **Per-app performance breakdown**: Rather than aggregate FVD/SSIM across all 8 apps, per-app breakdown would reveal whether performance is uniform or driven by easier apps.
