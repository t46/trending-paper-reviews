# Methodology Evaluation: Neural Computers (arXiv:2604.06425)

## Phase 3-2 — Methodology Evaluation

---

## 1. Methodology Description

### High-Level Approach

The paper operationalizes the NC abstraction (Eq. 2.1: h_t = F_theta(h_{t-1}, x_t, u_t); x_{t+1} ~ G_theta(h_t)) by fine-tuning the Wan2.1 image-to-video (I2V) diffusion model on curated screen-interaction datasets. Two separate systems are trained without shared weights: NC_CLIGen (terminal/CLI) and NC_GUIWorld (desktop GUI). The strategy is to learn NC primitives — I/O alignment and short-horizon control — purely from collected I/O traces without privileged access to program state.

### Key Components

**NC_CLIGen:**
- Data engine: ~824k video streams from public asciinema .cast recordings (CLIGen General); ~128k scripted VHS traces in Dockerized containers (CLIGen Clean)
- Caption pipeline: Llama 3.1 70B generates three-tier captions (semantic / regular / detailed) from raw terminal buffers
- Architecture: Wan2.1 I2V — VAE encoder, CLIP image encoder, T5 text encoder; conditioning features concatenated with diffusion noise, projected through zero-initialized linear layer, fed to DiT stack; decoupled cross-attention for joint caption and first-frame context
- Training: AdamW, lr=5e-5, weight decay 1e-2, bfloat16, gradient clipping 1.0, dropout 0.1 on encoders; ~15k H100 GPU hours (General) + ~7k (Clean)

**NC_GUIWorld:**
- Data: Random Slow (~1,000h), Random Fast (~400h), Claude CUA supervised (~110h); Ubuntu 22.04 / XFCE4 / 1024x768 / 15 FPS; Xvfb/VNC/noVNC + mss + xdotool
- Two action encoders: raw-action v1 (182-d multi-hot) and meta-action v2 (API-like typed schema; 5 action types, S=2 slots per frame)
- Four injection modes studied as separate ablations: external (modulates VAE input), contextual (action tokens in joint self-attention with structured temporal mask), residual (ControlNet-style block-external branches), internal (CA_action sub-layer added inside transformer blocks)
- Cursor supervision: explicit SVG cursor rendering → per-frame binary masks and reference frames; temporal contrastive loss (InfoNCE-style) aligning action and frame embeddings
- Training: 64 GPUs, ~15 days, ~23k GPU hours, 64k steps; diffusion loss + temporal contrastive loss

### Innovation Points Claimed
1. Data engines for synchronized CLI/GUI video with multi-tier captioning
2. Systematic four-mode ablation of action injection depth in a diffusion transformer
3. Explicit cursor visual supervision achieving 98.7% cursor accuracy
4. Finding that data quality (110h supervised) outperforms data quantity (1,400h random) for action-response learning
5. Reprompting as a system-level conditioning lever without RL

---

## 2. Methodology Soundness

### Current State

The core mapping of the NC abstraction onto I2V fine-tuning is technically sound. The diffusion transformer's video latents z_t correctly instantiate the latent runtime state h_t; the forward pass instantiates F_theta; the VAE decoder instantiates G_theta. The temporal contrastive loss for action-frame alignment has solid grounding in self-supervised contrastive learning. The internal conditioning equation h' = FFN(h + CA_text(SA(h), c) + CA_action(h, a)) is a standard residual cross-attention composition. The ControlNet-style residual branch follows Zhang et al. (2023) and is an established approach.

The methodology is logically coherent: data engines produce aligned (frame, action/caption) pairs; the model architecture consumes those pairs; evaluation metrics directly test whether the model reproduces conditioning-implied interface states.

**Logical coherence concern.** The paper states all injection mode runs keep "backbone and all non-action components fixed" (Section 3.2.3), but the internal mode adds new CA_action sub-layers inside transformer blocks that must be initialized and trained from scratch — these cannot be pre-existing "non-action components." This creates a confound between injection architecture and trainable parameter count.

### Development Directions

- Report parameter counts for all added modules per injection mode (model size breakdown: backbone fixed vs. added action modules per mode)
- Clarify whether "tune only the action encoder" includes the newly initialized CA_action sub-layers in internal mode
- A capacity-controlled comparison (match parameters across modes) would strengthen the injection mode ablation into a clean architectural finding

---

## 3. Appropriateness Assessment

### Current State

Using Wan2.1 as the prototype backbone is well-argued: video models are the most practical current substrate, and the paper explicitly frames this as a pragmatic choice while acknowledging the long-term need for a new architecture (Section 1, p.2). The separation of CLIGen General (broad diversity) from CLIGen Clean (controlled evaluation) is sound methodological practice.

The explicit SVG cursor supervision is justified by results: coordinate-only achieves 8.7% cursor accuracy vs. 98.7% with explicit visual supervision (Experiment 8, Table 9). The three-tier caption design is validated by the 5 dB PSNR gain from semantic to detailed captions (Experiment 3, Table 3).

**Design choices with missing justification:**
- S=2 action slots per frame in the meta-action encoder: no ablation over S is provided; the choice is not motivated
- Exact layers selected for residual/internal injection: "a subset of layers" is not specified

**Alternatives not considered:**
- Dedicated sequence models (Mamba, state-space models) for the latent h_t runtime state
- Explicit world model architectures (RSSM from Dreamer) as baselines
- Whether the diffusion training objective is mismatched with NC primitive learning (PSNR plateau at 25k steps, Experiment 2, suggests potential objective mismatch)

**Key assumptions:**
1. Screen pixels are sufficient observables for learning NC primitives — reasonable for prototype scope
2. 15 FPS suffices for GUI interaction — borderline given Random Fast's 195 px/frame average cursor speed; temporal aliasing of transient cursor positions is a noted but unquantified failure mode
3. Open-loop evaluation suffices for prototype assessment — explicitly acknowledged as a limitation; the gap to closed-loop behavior is unmeasured

### Development Directions

- Justify S=2 for action slots or provide an ablation over S
- Specify which transformer layers are selected for residual/internal injection, with a rationale
- Discuss why diffusion training objective was preferred over alternative objectives given the plateau behavior observed in Experiment 2
- Report quantitative characterization of temporal aliasing at 15 FPS given Random Fast cursor velocity statistics

---

## 4. Preliminary Innovation Assessment

(Note: Comprehensive novelty verification with independent literature search is deferred to Phase-3-5.)

**Claimed innovations vs. acknowledged prior work:**
- Contextual injection mode: the paper acknowledges similarity to Gato (Reed et al., 2022) and World and Human Action Model (Kanervisto et al., 2025) for token-based action representations
- Internal cross-attention injection: the paper acknowledges similarity to Matrix-Game-2 (He et al., 2025) for multi-stream injection strategies
- The systematic four-mode comparison under identical conditions and the GUI-specific cursor supervision scheme are the paper's distinguishing contributions over these acknowledged prior works

**Apparently novel components (pending Phase-3-5 verification):**
- The CLIGen data pipeline (asciinema replay + LLM three-tier captioning)
- The explicit SVG cursor rendering + reference frame conditioning approach
- The specific data quality finding (110h supervised >> 1,400h random) in the NC training context

---

## 5. Clarity and Presentation

### Current State

The parallel subsection structure across NC_CLIGen and NC_GUIWorld (data pipeline / model architecture / implementation details / evaluation setup / visualizations) is a clear organizational strength. Figure 7 (four injection modes) effectively communicates both architecture and injection point in a single diagram. Figure 12 (contextual attention mask) is a well-designed visualization of the lag-aware temporal structure. The appendix provides well-organized supplementary documentation (trajectory format examples in Appendix C, full action schema in Appendix D, metric formulas in Appendix B).

**Reproducibility gaps identified:**
1. The action conditioning module architecture (for external mode: "small stack of temporal self-attention and action cross-attention layers") lacks exact layer counts, hidden dimensions, and attention head counts
2. Transformer layer indices/counts for residual and internal injection are not specified
3. Temporal contrastive loss temperature tau is not reported
4. CLIGen Clean filtering criterion for the 51.21% retention rate is not described
5. Window size w and lag l for the contextual attention mask are described as "fixed hyperparameters" but their numerical values are absent from both main text and appendix

### Development Directions

- Add a configuration table in the appendix listing all action module hyperparameters (layer counts, dimensions, w, l, tau)
- Describe the CLIGen Clean filtering criteria explicitly
- Clarify which transformer layers are used for residual/internal injection with exact counts or indices

---

## 6. Potential Concerns

### Technical Concern 1: Parameter Count Confound in Injection Mode Comparison

The four injection modes add different numbers of new trainable parameters. The internal mode adds CA_action sub-layers inside transformer blocks; residual adds block-external branches; contextual changes only the attention mask (minimal parameters); external adds a temporal stack outside the backbone. Section 3.2.3 states "tune only the action encoder and learning-rate schedule" but the internal mode's CA_action sub-layers are newly initialized inside the backbone and must be trained. This creates a confound: the internal mode's SSIM 0.863/FVD 14.5 advantage (Table 10) could partly reflect greater trainable-parameter capacity rather than purely architectural advantage of deep injection.

### Technical Concern 2: Open-Loop Evaluation Gap

All evaluations use open-loop rollout against ground-truth conditioning sequences. The model is never tested on its own generated frames as context. Section 3.2.4 acknowledges this explicitly ("evaluation remains open-loop rather than closed-loop"), but the performance degradation under closed-loop conditions is unmeasured. For a paper claiming "early NC primitives" as a running computer, the absence of any closed-loop metric is a material methodological gap.

### Technical Concern 3: Sora2 Comparison Methodology

Experiment 5 (Table 5) compares NC_CLIGen (4%) against Sora2 (71%) on arithmetic probes. The generation configuration for Sora2 (temperature, sampling steps, system prompt) is not reported. The paper provides hypotheses for Sora2's advantage (Table 6) and correctly notes this comparison is rough, but the early-stopped external baseline in Table 10 receives an explicit footnote caveat while the Sora2 comparison in Table 5 does not, creating an inconsistent treatment of methodological limitations.

### Technical Concern 4: LLM Caption Generation Without Validation

Llama 3.1 70B generates CLIGen General training captions from terminal buffers with no human validation, hallucination rate, or caption accuracy metric reported. Given that Experiment 3 shows caption specificity has a 5 dB PSNR effect, caption quality is a material upstream dependency. See HIGH-002 in CFR.

### Technical Concern 5: CLIGen Clean Filtering Undocumented

CLIGen Clean starts from ~250k scripts and retains ~128k (51.21%) after undescribed filtering. Experiments 2–6 all use CLIGen Clean. The retained subset's representativeness is unknown. See MEDIUM-001 in CFR.

### Scalability and Generalizability

- ~22k-38k H100 GPU hours per system limits reproducibility to well-funded institutions; parameter-efficient alternatives are not discussed
- CLIGen General draws from asciinema archives biased toward developer workflows; distribution not characterized
- GUIWorld uses a fixed app set on Ubuntu/XFCE4; generalization to other OS/themes/apps is untested

---

## 7. Methodological Rigor

The ten experiments are clearly numbered, color-coded by system, and each produces a specific quantitative takeaway. Most ablations isolate one variable at a time (Experiments 7–10). The paper correctly distinguishes conditioned performance from native computation in Experiment 6 (reprompting), explicitly stating: "We do not treat it as direct evidence of native arithmetic inside the NC backbone." The early-stopping of external baseline in Table 10 is flagged in a footnote. These are marks of intellectual honesty.

The paper's acknowledgment that Experiment 2 shows PSNR plateau at 25k steps suggests "most learnable structured patterns are acquired early" and does not overinterpret this as a problem-free finding. The three hypotheses for Sora2's advantage (Table 6) reflect epistemic humility about a confounded comparison.

Weaknesses: the injection mode ablation is not parameter-controlled (HIGH-003); the CLIGen Clean filtering is undescribed (MEDIUM-001); key hyperparameters are missing (MEDIUM-002).

---

## 8. Upstream Dependency Analysis

### 8.1 Dependency Chain Diagram

```
NC_CLIGen Pipeline:
Raw asciinema .cast files
  → [Stage 1] Replay + render (agg, ffmpeg) → Terminal video frames
  → [Stage 2] Segmentation (5s clips, content-aware splits) → Clip segments
  → [Stage 3] LLM captioning (Llama 3.1 70B from terminal buffers) → Three-tier captions
  → [Stage 4] Fine-tuning Wan2.1 on (first frame, caption, video) → NC_CLIGen weights
  → [Stage 5] Evaluation: OCR (Tesseract), PSNR/SSIM, arithmetic probes → Results

NC_GUIWorld Pipeline:
Screen capture (mss/ffmpeg) + xdotool action logging
  → [Stage 1] Temporal alignment (align pointer/key events to nearest frame) → Aligned (frame, action) pairs
  → [Stage 2] Cursor rendering (SVG template → per-frame masks/references) → Cursor supervision tensors
  → [Stage 3] Action encoding (raw-action v1 or meta-action v2) → Action embeddings
  → [Stage 4] Injection-mode-specific conditioning → Conditioned diffusion model
  → [Stage 5] Evaluation: FVD/SSIM/LPIPS (global + +15 post-action) → Results
```

### 8.2 Upstream Dependency Inventory

| Stage | Upstream Dependency | Criticality | Validated in Paper? | Concern Level |
|-------|---------------------|-------------|---------------------|---------------|
| CLIGen Stage 1 | Replay fidelity of asciinema (terminal geometry, palette, timing) | Medium | Partial (Exp 1: VAE reconstruction at font sizes) | MEDIUM |
| CLIGen Stage 2 | Content-aware clip segmentation quality | Low | Not validated | LOW |
| CLIGen Stage 3 | LLM caption accuracy (Llama 3.1 70B) | High | Not validated | HIGH |
| CLIGen Stage 4 | Filtering criterion for 51.21% CLIGen Clean retention | Medium | Not documented | MEDIUM |
| CLIGen Stage 5 | OCR tool reliability (Tesseract on CLI frames) | High | Partial (protocol in App B.2; no OCR-of-ground-truth baseline reported) | HIGH |
| GUIWorld Stage 1 | Temporal alignment quality (action logs to video frames) | High | Partial (App B; "drop clips with residual misalignment" — no residual rate reported) | MEDIUM |
| GUIWorld Stage 2 | Cursor coordinate normalization accuracy | Medium | Validated by Exp 8 (98.7% accuracy) | LOW |
| GUIWorld Stage 3 | Action encoding completeness | Medium | Partial (Table 7 statistics; completeness not validated) | MEDIUM |
| GUIWorld Stage 4 | Injection mode parameter count equivalence | High | Not validated | HIGH |

### 8.3 Validation Status for HIGH Criticality Dependencies

| Dependency | How Paper Validates | Adequacy | Gap |
|------------|---------------------|----------|-----|
| LLM caption accuracy (CLIGen Stage 3) | Not validated | None | Human review of sampled captions; hallucination rate; OCR cross-check of caption content vs. rendered frames |
| OCR reliability (CLIGen Stage 5) | Protocol defined in App B.2 | Partial | Baseline OCR accuracy on ground-truth frames not reported; measurement noise is unknown |
| Injection mode parameters (GUIWorld Stage 4) | Not addressed | None | Parameter counts per injection mode; capacity-matched comparison |

### 8.4 Unvalidated Dependency Analysis

#### Unvalidated Dependency: LLM Caption Quality (CLIGen)

**What it is**: Llama 3.1 70B generates all CLIGen General training captions from raw terminal buffers at three tiers (semantic/regular/detailed). Captions serve as the conditioning signal during training.

**Why it's critical**: Experiment 3 shows a 5 dB PSNR gap between semantic and detailed captions (Table 3: 21.90 vs. 26.89 dB). This demonstrates that caption quality directly determines model performance. If the LLM hallucinates terminal content (especially in the detailed tier, which transcribes exact text, colors, and formatting), the model learns incorrect conditioning relationships.

**What validation is needed**:
- Human evaluation of 50–100 sampled captions per tier for factual accuracy
- Automated OCR cross-check: apply Tesseract to rendered frames and compare lexical overlap with LLM captions
- Caption consistency analysis across similar terminal states

**Risk if unvalidated**: Systematic hallucinations in detailed captions would introduce noise in the most informative conditioning signal, setting an unknown ceiling on NC_CLIGen performance that cannot be separated from model capacity limits.

**CFR Entry**: HIGH-002 (added)

#### Unvalidated Dependency: Injection Mode Parameter Count (GUIWorld)

**What it is**: Four injection modes (external, contextual, residual, internal) add different numbers of new parameters. The internal mode adds CA_action cross-attention sub-layers inside transformer blocks that must be trained from scratch.

**Why it's critical**: The paper's central architectural recommendation is that internal conditioning achieves the best SSIM/FVD trade-off (Table 10: SSIM 0.863, FVD 14.5). If internal conditioning has substantially more trainable parameters than other modes, this recommendation conflates injection depth with parameter capacity.

**What validation is needed**:
- Table of trainable parameter counts per injection mode
- Capacity-matched comparison (e.g., match external/contextual to internal parameter count)

**Risk if unvalidated**: The design recommendation for NC engineering practice may be capacity-driven rather than architecture-driven, misleading future practitioners.

**CFR Entry**: HIGH-003 (added)

### 8.5 Error Propagation Analysis

NC_CLIGen results are subject to compound measurement noise: LLM caption quality (E_cap, unknown) affects training quality; Tesseract OCR accuracy (E_ocr, unknown) introduces measurement noise. The observed character accuracy of 0.54 at 60k steps (Table 4) is the product of both generation quality and measurement quality. Since neither error rate is reported, relative trends across training steps are interpretable, but absolute accuracy values and cross-model comparisons carry unknown noise.

### 8.6 LLM-Specific Validation

- No LLM self-evaluation loop in the evaluation pipeline (Tesseract, not an LLM, performs OCR evaluation). No circular bias concern for evaluation.
- LLM is used as a training data generator (captions), not as an evaluator. This raises training data quality concerns (HIGH-002) rather than evaluation bias concerns.
- Experiment 6 correctly identifies that reprompting provides the answer in the caption and explicitly disclaims this as evidence of native computation. This methodological distinction is handled correctly.

---

## 9. CFR Entries Added in Phase 3-2

| ID | Severity | Description |
|----|----------|-------------|
| HIGH-002 | HIGH | LLM caption quality unvalidated — Llama 3.1 70B generates CLIGen training captions with no human audit or hallucination rate reported |
| HIGH-003 | HIGH | Injection mode parameter count confound — internal mode adds more trainable parameters than other modes; no capacity-controlled comparison reported |
| MEDIUM-001 | MEDIUM | CLIGen Clean filtering criteria undocumented — 51.21% retention rate with no description of filtering rules |
| MEDIUM-002 | MEDIUM | Missing hyperparameters — w, l (temporal window), tau (contrastive temperature), layer indices for residual/internal injection not reported |

---

## 10. Two-Layer Summary

### Current State

The methodology is technically sound in its core design decisions. The NC-to-I2V mapping is coherent; the data engines produce appropriately aligned training signals; the four-mode injection ablation is a principled systematic study; explicit cursor visual supervision is a creative and empirically validated design choice (8.7% → 98.7% cursor accuracy). The appendix provides above-average documentation for a systems paper. The paper correctly acknowledges multiple limitations: open-loop evaluation, the conditioned-vs.-native computation distinction, the rough-reference status of early-stopped baselines.

Three areas fall short: (1) two HIGH criticality upstream dependencies are unvalidated (LLM caption quality, injection mode parameter count); (2) several key hyperparameters are unreported, limiting reproducibility; (3) evaluation is entirely open-loop, creating an acknowledged but unmeasured gap between NC claims and measurement methodology.

### Development Directions

1. **LLM caption validation**: Human study of 50–100 sampled captions per tier plus automated OCR cross-check would validate the upstream training data quality assumption.
2. **Injection mode parameter audit**: A table of trainable parameter counts per mode, or a capacity-matched comparison, would convert the injection mode finding from suggestive to architecturally conclusive.
3. **CLIGen Clean filtering documentation**: Describe filtering criteria explicitly to enable reproducibility of Experiments 2–6.
4. **Hyperparameter reporting**: A configuration table (w, l, tau, layer indices, module dimensions) in the appendix would close the reproducibility gap without main text changes.
5. **Partial closed-loop evaluation**: Even a limited closed-loop test on scripted CLIGen Clean tasks would provide evidence about the gap between open-loop metrics and claimed NC runtime behavior.
6. **Sora2 comparison caveats**: Apply the same footnote-caveat treatment used for the early-stopped external baseline to the Sora2 comparison in Table 5, reporting Sora2's generation configuration.
