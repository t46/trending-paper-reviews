# Implementation Guides: Neural Computers (arXiv:2604.06425)
# Phase 8-2 — Concrete Actionable Implementation Guides

---

## Executive Summary

This document provides concrete, step-by-step implementation guides for the top 10 improvements from the Phase 8-1 roadmap. Each guide specifies exactly what to do, which files to edit, what experiments to run, and what text to write.

**Guides are organized by timeline:**
- Short-term (writing-only, no new experiments): R2, R3, R5, R10
- Medium-term (require evaluation runs or training): R1, R4, R7, R8
- Engineering work (code release): R9
- Mixed (writing + training run): R6

**Quick wins** (highest impact-to-effort ratio, can be done in 1–2 days):
- R3: Disclose NeuralOS code attribution — half a day, resolves CRITICAL component
- R4: Add zero-shot Wan2.1 baseline — 1 evaluation run, resolves structurally required control
- R8: Add Wan2.1 + reprompting baseline — 1 evaluation run, resolves headline result attribution

---

## R1: Add Minimal Closed-Loop Evaluation

**Priority**: CRITICAL  
**Timeline**: Medium-term (1–2 weeks compute + 1 day writing)  
**Effort**: High  
**CFR Source**: HIGH-004, escalated CRITICAL

### Current State

Every experiment in the paper uses oracle ground-truth frame conditioning. The NC-defining property — "persistent latent runtime state h_t" evolving through the model's own generated outputs (Eq. 2.1) — has never been exercised in any experiment. The paper's title and central claim depend on this property, but it has zero experimental support. Section 3.2.4 discloses this as a limitation, but disclosure does not substitute for measurement.

### Target State

The paper contains at least one experiment demonstrating autoregressive (closed-loop) rollout, where the model's generated frame at step t serves as conditioning input for step t+1. Even 5 steps with a resulting accuracy degradation curve constitutes the first empirical evidence that the NC runtime property has been exercised.

### Implementation Steps

**Step 1: Locate the NC_CLIGen inference/evaluation code.**

In the repository, find the evaluation loop used for Tables 2-4 (character accuracy, PSNR, SSIM, FVD). This loop currently reads ground-truth frames from the dataset to condition each prediction step. The file is likely named something like `evaluate.py`, `inference.py`, or `eval_clicgen.py`.

**Step 2: Add a `--closed_loop` flag to the evaluation script.**

Modify the evaluation loop so that when `--closed_loop` is passed, the model's generated frame (output of the previous step) is used as the frame conditioning input for the current step, rather than the ground-truth frame from the dataset. A minimal code change looks like:

```python
# Existing oracle-conditioned evaluation loop (pseudocode):
for step in range(eval_steps):
    conditioning_frame = ground_truth_frames[step]  # oracle
    pred_frame = model.generate(conditioning_frame, action[step], prompt)
    metrics[step] = compute_metrics(pred_frame, ground_truth_frames[step+1])

# Add closed-loop variant:
for step in range(eval_steps):
    if args.closed_loop and step > 0:
        conditioning_frame = pred_frame  # use model's own output
    else:
        conditioning_frame = ground_truth_frames[step]  # oracle
    pred_frame = model.generate(conditioning_frame, action[step], prompt)
    metrics[step] = compute_metrics(pred_frame, ground_truth_frames[step+1])
```

**Step 3: Select the evaluation configuration.**

Use the best-performing NC_CLIGen configuration: internal conditioning mode, CLIGen Clean data, semantic captions (the configuration that achieves ~54% character accuracy in the oracle-conditioned setting). This gives the closed-loop experiment its best chance of showing non-trivial performance.

**Step 4: Design the experiment.**

- Sample 100 scripted CLI task sequences from the CLIGen Clean evaluation set
- Run each sequence for 5–10 autoregressive steps in closed-loop mode
- Collect character accuracy at each step (step 1, 2, 3, 4, 5)
- Run the same 100 sequences in oracle-conditioned mode to get the baseline accuracy curve
- Record mean character accuracy ± SD across the 100 sequences at each step

**Step 5: Run the evaluation.**

This requires no new training. The existing best NC_CLIGen checkpoint is used with the modified evaluation loop. Total compute: one model inference pass over 100 sequences × 5–10 steps = roughly 500–1000 forward passes. On typical GPU hardware, this should complete in hours to a few days depending on batch parallelism.

**Step 6: Report the result.**

Add "Experiment 11: Closed-Loop Error Accumulation" to Section 3 (or as Appendix F). Report a table or figure with two curves: oracle-conditioned character accuracy (flat, near 54%) and closed-loop character accuracy (likely decreasing across steps). Example presentation format:

| Step | Oracle-Conditioned (%) | Closed-Loop (%) |
|------|------------------------|-----------------|
| 1    | 54.2 ± 1.3             | 54.2 ± 1.3      |
| 2    | 54.1 ± 1.4             | [value]         |
| 3    | 54.0 ± 1.5             | [value]         |
| 4    | 53.9 ± 1.4             | [value]         |
| 5    | 53.8 ± 1.3             | [value]         |

**Step 7: Write the experiment description.**

Add to Section 3 or Appendix F. Suggested language:

> "To evaluate NC_CLIGen's behavior under self-conditioned rollout — the runtime property central to the NC formalism (Eq. 2.1) — we conducted a closed-loop error accumulation experiment. We evaluated the best-performing NC_CLIGen configuration (internal conditioning, CLIGen Clean, semantic captions) on 100 scripted CLI task sequences, feeding the model's generated frame at step t as conditioning input for step t+1 rather than the ground-truth frame. Character accuracy across 5 autoregressive steps is reported in Table [X], alongside the oracle-conditioned baseline for reference."

**Step 8: Update Section 4 (Future Work) with the result.**

If the degradation is rapid (e.g., 54% → 15% by step 3), state: "NC_CLIGen demonstrates limited closed-loop stability at [N] autoregressive steps, with character accuracy degrading to [X%] by step 5. Improving closed-loop stability is an explicit research target for future NC development." If degradation is gradual (54% → 42% by step 5), state: "NC_CLIGen maintains [X%] character accuracy under 5-step closed-loop rollout, demonstrating partial NC primitive behavior and establishing a baseline for future improvement."

**Step 9: Update the abstract and introduction.**

Add one sentence to the abstract noting the closed-loop experiment: "We additionally demonstrate [result] under self-conditioned closed-loop rollout, providing the first empirical characterization of NC_CLIGen's runtime state properties." Revise the NC-primitive claim in the introduction to reference this experiment.

### Verification Checklist

- [ ] Evaluation code runs with `--closed_loop` flag without crashing
- [ ] Closed-loop results collected for 100 sequences × 5 steps
- [ ] Oracle-conditioned baseline collected on same sequences for direct comparison
- [ ] Mean ± SD reported at each step (not just final step)
- [ ] Result table or figure added to paper
- [ ] Experiment description written and placed in Section 3 or Appendix F
- [ ] Abstract and introduction updated to reference the closed-loop result
- [ ] Section 4 future work updated based on the result

### Expected Impact

This converts the paper's central NC-primitive claim from experimentally ungrounded assertion to at least partially empirically characterized. It is the single most important addition for the paper's scientific credibility. Whatever the result — graceful or rapid degradation — it is informative and publishable.

---

## R2: Add Citations and Reframe NC_GUIWorld Paradigm Contribution

**Priority**: CRITICAL  
**Timeline**: Short-term (writing-only, 3 days)  
**Effort**: Medium  
**CFR Source**: HIGH-011 (escalated CRITICAL); CFR-PATTERN-A (CRITICAL)

### Current State

Four directly relevant papers are absent from the paper's citations:
- GameNGen (arXiv:2408.14837, ICLR 2025): establishes the two-phase interaction-data-to-diffusion-model paradigm
- DIAMOND (arXiv:2405.12399, NeurIPS 2024 Spotlight): interactive diffusion simulation from fixed human gameplay data
- AVID (arXiv:2410.12822, ICLR 2025): per-frame scale/shift action conditioning for video diffusion models
- DWS (arXiv:2502.07825, ICLR 2025): per-block two-linear-layer modulation for video DiTs

The project blog mentions GameNGen, establishing author awareness. The paper currently claims NC_GUIWorld "demonstrates a pioneering paradigm for interactive OS simulation." This claim is not defensible given the prior-work landscape.

### Target State

The paper's citation set is complete. NC_GUIWorld's contribution is accurately characterized as "first systematic application of the established paradigm to OS/GUI computing environments, with a comprehensive injection mode ablation extending the design space established by AVID and DWS." The introduction and contribution list no longer claim paradigm origination for the technical design.

### Implementation Steps

**Step 1: Obtain the four papers and read their core technical sections.**

Download and read:
- GameNGen (arXiv:2408.14837): focus on their formal environment definition and two-phase training procedure
- DIAMOND (arXiv:2405.12399): focus on interactive diffusion model architecture and fixed-data training
- AVID (arXiv:2410.12822): focus on per-frame action conditioning mechanism (Section 3)
- DWS (arXiv:2502.07825): focus on per-block two-linear-layer modulation (Section 3–4)

Also retrieve the GameNGen formal interactive environment definition and compare it to NC Eq. 2.1.

**Step 2: Add to the BibTeX references file (likely `references.bib` or `bibliography.bib`).**

Add four entries:
```bibtex
@inproceedings{valevski2024gamengn,
  title={Diffusion Models Are Real-Time Game Engines},
  author={Valevski, Dani and Leviathan, Yaniv and Arar, Moab and Fruchter, Shlomi},
  booktitle={ICLR},
  year={2025},
  note={arXiv:2408.14837}
}

@inproceedings{alonso2024diamond,
  title={Diffusion for World Modeling: Visual Details Matter in Atari},
  author={Alonso, Eloi and others},
  booktitle={NeurIPS},
  year={2024},
  note={arXiv:2405.12399}
}

@inproceedings{avid2024,
  title={AVID: Adapting Video Diffusion Models to World Models},
  author={[authors]},
  booktitle={ICLR},
  year={2025},
  note={arXiv:2410.12822}
}

@inproceedings{dws2025,
  title={[DWS title]},
  author={[authors]},
  booktitle={ICLR},
  year={2025},
  note={arXiv:2502.07825}
}
```
(Fill in accurate author and title details from the actual papers.)

**Step 3: Revise the Related Work / Preliminaries section.**

Expand the existing Related Work paragraph into three subsections (see R12 for the full restructuring guide). At minimum, add:

For GameNGen (place in an "Action-Conditioned Video Simulation" subsection):
> "GameNGen [cite] establishes the two-phase paradigm for neural game simulation: RL-policy data collection followed by diffusion model fine-tuning for action-conditioned frame generation. GameNGen achieves 20 FPS real-time interactive play for Doom on a single TPU, with human raters unable to distinguish neural from real game footage. NC_GUIWorld applies this paradigm to desktop GUI computing environments, where the input space (cursor, keyboard, window state) and output space (high-resolution OS screenshots) differ substantially from game environments."

For DIAMOND (same subsection):
> "DIAMOND [cite] demonstrates interactive diffusion simulation from fixed human gameplay data at approximately 10 FPS, achieving performance sufficient to train RL agents in world model imagination. NC_GUIWorld similarly trains from recorded human interaction data (GUIWorld dataset) rather than requiring RL policy rollouts."

For AVID and DWS (in an "Action Injection Design" subsection):
> "AVID [cite] establishes per-frame scale/shift action conditioning for pretrained video diffusion models, while DWS [cite] proposes per-block two-linear-layer modulation for video DiTs. NC_GUIWorld's injection mode ablation (Section 3.2.3) systematically compares four conditioning architectures — external, contextual, residual, and internal — within the OS/GUI domain, extending the design space explored by AVID and DWS to a new application domain."

**Step 4: Revise the contribution list in the introduction.**

Find the sentence claiming NC_GUIWorld "demonstrates a pioneering paradigm." Replace with:

> "NC_GUIWorld is the first systematic application of the action-conditioned diffusion simulation paradigm [GameNGen, DIAMOND] to desktop GUI computing environments, with a comprehensive four-mode action injection ablation that extends the design space established by AVID and DWS."

**Step 5: Revise the abstract.**

Find any abstract-level paradigm origination claim for NC_GUIWorld. Replace the framing with: "first application to OS/GUI computing" or "first systematic OS/GUI simulation study within the established action-conditioned diffusion paradigm."

**Step 6: Check Section 2.1 for mathematical equivalence acknowledgment.**

Add one sentence near Eq. 2.1 acknowledging the relationship to existing formalisms:
> "This formalism is mathematically equivalent to GameNGen's formal interactive environment definition [cite] and DIAMOND's diffusion world model formulation [cite]; the CNC four conditions (Section 2.2) formally specify what distinguishes NC from these world model instantiations."

(This bridges R2 and R5, and is necessary only if the CNC conditions table from R5 is added.)

### Verification Checklist

- [ ] All four papers (GameNGen, DIAMOND, AVID, DWS) appear in the bibliography
- [ ] Each paper has 1–3 sentences of substantive characterization in Related Work
- [ ] Each entry states how NC_GUIWorld differs from or extends the cited work
- [ ] "Pioneering paradigm" or equivalent origination language is removed from introduction
- [ ] Abstract correctly characterizes NC_GUIWorld as domain extension, not paradigm origination
- [ ] Eq. 2.1 note acknowledges mathematical equivalence to existing formalisms (if R5 is addressed)
- [ ] No remaining claim in the paper body asserts NC_GUIWorld created the two-phase paradigm

---

## R3: Disclose NeuralOS Code Attribution in Paper Body

**Priority**: CRITICAL  
**Timeline**: Short-term (writing-only, half a day)  
**Effort**: Low  
**CFR Source**: CFR-024 (HIGH); CFR-PATTERN-A (CRITICAL component)

### Current State

Section 3.2.1 presents the GUIWorld data collection pipeline as a paper contribution. Repository Issue #5 (maintainer-confirmed, post-publication) establishes that the pipeline derives from NeuralOS's codebase. This attribution is disclosed in the repository README but not in the paper body. A researcher reading only the paper cannot know that the pipeline derives from prior code.

### Target State

Section 3.2.1 contains an explicit attribution statement identifying NeuralOS as the source of the pipeline's infrastructure, with a clear statement of what NC contributed originally. The paper body and repository are consistent in their attribution.

### Implementation Steps

**Step 1: Review the NeuralOS paper and codebase attribution.**

Read NeuralOS (cited in the paper as the "most closely related" work) and identify the specific components that NC's GUIWorld pipeline derives from. Also read the repository README's current attribution statement to understand exactly what is already disclosed there.

**Step 2: Identify what is original in the NC GUIWorld pipeline.**

Make a list of the specific adaptations NC made to the NeuralOS infrastructure: e.g., new app scripts, new action type handling, new recording format, integration with the episode packaging system, etc. This will inform the attribution statement's second clause.

**Step 3: Add attribution to Section 3.2.1 in the paper's LaTeX source.**

Find Section 3.2.1 in the LaTeX source file (likely `main.tex`, `method.tex`, or a section file). Find the paragraph that describes the GUIWorld data collection pipeline. Add a sentence at the paragraph's end or after the first description of the pipeline:

> "Our data collection infrastructure builds on the GUI interaction recording system from NeuralOS \cite{neuramos}; we extended it to support [specific adaptations: e.g., multi-application recording, action-timestamp alignment, and integration with the episode packaging system described in Appendix B]."

Adjust the bracketed content to accurately reflect the actual adaptations made.

**Step 4: Add per-file attribution comments to derived repository files.**

In the repository, for each file that derives from NeuralOS's codebase, add a comment at the top of the file:

```python
# Derived from NeuralOS (https://github.com/[neuramos-repo])
# Original file: [source filename]
# Modifications: [brief description of changes]
# License: [NeuralOS license type]
```

This step is repository-level hygiene consistent with standard open-source attribution practice. It does not require paper revision, but should accompany the paper-body change.

**Step 5: Verify consistency between paper body and README.**

After adding the paper-body attribution, re-read both the new Section 3.2.1 sentence and the existing README attribution. They should describe the same set of derived components. If the README is more specific, the paper sentence should be consistent (though it can be higher-level for space reasons).

### Key Language Template

The following template sentence can be placed directly in Section 3.2.1 with [brackets] filled in:

> "Our data collection pipeline builds on the GUI interaction recording infrastructure from NeuralOS \cite{[neuramos_cite_key]}; we adapted [component names, e.g., the application scripting framework and action logging module] for our OS/GUI data collection workflow and extended it with [original contributions, e.g., support for [N] additional applications, keyboard-action timestamping, and integration with the episode packaging system]."

### Verification Checklist

- [ ] Section 3.2.1 in the paper LaTeX source contains an explicit NeuralOS attribution sentence
- [ ] Attribution sentence identifies both what derives from NeuralOS AND what NC added
- [ ] NeuralOS is cited (not just mentioned) in the attribution sentence
- [ ] Repository-level per-file attribution comments added to derived files
- [ ] Paper body and README are consistent in their attribution scope
- [ ] Attribution statement reviewed by co-authors for accuracy

---

## R4: Add Zero-Shot Wan2.1 Baseline to NC_CLIGen Tables

**Priority**: CRITICAL  
**Timeline**: Medium-term (1–2 days compute + half day writing)  
**Effort**: Low  
**CFR Source**: CFR-026 (HIGH)

### Current State

Tables 2-4 document NC_CLIGen's training progression starting from epoch 1 (character accuracy approximately 3%). Wan2.1's zero-shot performance on CLIGen evaluation data is unknown. Without this baseline, the training progression cannot establish whether fine-tuning teaches CLI simulation or whether Wan2.1 was already capable of generating terminal-like frames.

### Target State

Tables 2-4 each contain a "Wan2.1 (zero-shot)" row reporting PSNR, SSIM, FVD, character accuracy, and exact-line accuracy for the unmodified Wan2.1 model on the CLIGen Clean evaluation set. The training progression is interpretable as fine-tuning improvement measured against a defined starting point.

### Implementation Steps

**Step 1: Identify the evaluation script and evaluation set.**

In the repository, find the evaluation script used to generate Tables 2-4. Identify the CLIGen Clean evaluation set (the subset used for Tables 2 and 3, the controlled ablation experiments). Confirm the five metrics being computed: PSNR, SSIM, FVD, character accuracy, exact-line accuracy.

**Step 2: Run zero-shot evaluation.**

Load Wan2.1 without any NC fine-tuning weights. Run the standard evaluation script on the CLIGen Clean evaluation set using the same prompts and action conditioning used for Tables 2-4. The only change is that the model checkpoint loaded is the pretrained Wan2.1 base, not any fine-tuned NC_CLIGen checkpoint.

Command-line example (pseudocode):
```bash
python evaluate_clicgen.py \
    --checkpoint wan2.1_base \
    --eval_set clicgen_clean_eval \
    --zero_shot \
    --output_path results/wan21_zeroshot/
```

This requires no GPU training — only one inference pass over the evaluation set. Compute time: hours to 1 day depending on evaluation set size and hardware.

**Step 3: Compute character accuracy.**

Character accuracy requires reading predicted terminal frame characters. Confirm that the OCR/parsing pipeline used for Tables 2-4 is applied identically to the zero-shot Wan2.1 outputs. The pretrained Wan2.1 is unlikely to generate coherent terminal text, so character accuracy will likely be near 0% or very low — which is an informative result.

**Step 4: Add row to Tables 2, 3, and 4 in the paper.**

For each of Tables 2, 3, and 4, add "Wan2.1 (zero-shot)" as the first row (before epoch 1 of fine-tuning). Suggested table format:

| Model | PSNR | SSIM | FVD | Char Acc. (%) | Exact-Line Acc. (%) |
|-------|------|------|-----|----------------|----------------------|
| Wan2.1 (zero-shot) | [value] | [value] | [value] | [value] | [value] |
| NC_CLIGen (epoch 1) | ... | ... | ... | 3.1 | ... |
| NC_CLIGen (best)   | ... | ... | ... | 54.2 | ... |

**Step 5: Add row to Table 5 (arithmetic probe) if applicable.**

If Table 5 (arithmetic probe: NC_CLIGen 4% vs. Wan2.1 0%) already includes a Wan2.1 row, verify consistency with the zero-shot evaluation. If it does not, add the zero-shot arithmetic accuracy to Table 5 as well for consistency.

**Step 6: Update the text in Section 3.1 (NC_CLIGen experiments).**

Add one or two sentences interpreting the zero-shot baseline:

> "Wan2.1 (zero-shot) achieves [X% character accuracy / FVD Y] on the CLIGen Clean evaluation set without fine-tuning, establishing the pretrained model's inherent performance on terminal video content. Fine-tuning on NC_CLIGen data improves character accuracy from [zero-shot baseline] to 54.2% at best, demonstrating that fine-tuning teaches the model CLI-specific video generation rather than leveraging pretrained capabilities."

If zero-shot performance is near 0%: "Wan2.1 (zero-shot) achieves near-zero character accuracy ([X]%) on CLIGen evaluation data, confirming that the fine-tuning benefit is attributable to NC_CLIGen training rather than Wan2.1's pretrained generation quality."

### Verification Checklist

- [ ] Wan2.1 base checkpoint loaded without any NC fine-tuning weights
- [ ] Evaluation uses identical evaluation set, prompts, metrics, and OCR pipeline as Tables 2-4
- [ ] All five metrics collected: PSNR, SSIM, FVD, character accuracy, exact-line accuracy
- [ ] "Wan2.1 (zero-shot)" row added as the first row in Tables 2, 3, and 4
- [ ] Table 5 (arithmetic probe) updated if it did not already include Wan2.1 zero-shot result
- [ ] Section 3.1 text updated to interpret the baseline relative to fine-tuned performance
- [ ] Zero-shot result is clearly labeled as "no fine-tuning" to avoid reader confusion

---

## R5: Apply CNC Four Conditions Formally

**Priority**: CRITICAL  
**Timeline**: Short-term (writing and analysis, 1–2 days)  
**Effort**: Low-Medium  
**CFR Source**: CFR-014 (MEDIUM); CFR-PATTERN-A (CRITICAL component)

### Current State

The paper defines four CNC conditions (Turing completeness, universal programmability, behavioral consistency, architectural advantage) as the formal specification distinguishing NC from world models. However, these conditions are never applied to: (a) verify that NC_CLIGen and NC_GUIWorld satisfy or approach them, or (b) verify that GameNGen and DIAMOND do not. Table 13 gestures toward this comparison but does not apply the four conditions explicitly.

### Target State

The paper contains a formal analysis table applying the four CNC conditions to five systems: NC_CLIGen (current), NC_GUIWorld (current), GameNGen, DIAMOND, and NeuralOS. Each cell shows "Satisfied / Partially Satisfied / Not Satisfied" with a brief justification. The NC/CNC framework's formal contribution is demonstrated by showing which conditions existing systems fail.

### Implementation Steps

**Step 1: Re-read the CNC conditions as stated in the paper.**

Identify precisely where the four conditions are defined (likely Section 2.2 or similar). Write out the exact specification for each condition:
1. Turing completeness (or equivalent)
2. Universal programmability
3. Behavioral consistency
4. Architectural advantage

If the conditions are defined informally, draft precise enough interpretations to apply to each system.

**Step 2: Apply each condition to each of the five target systems.**

For each (system, condition) pair, make a determination: Satisfied / Partially Satisfied / Not Satisfied, with a one-sentence justification. Work through the five systems:

- **GameNGen**: Likely fails Turing completeness (fixed game engine; no programmability) and universal programmability (single game domain). May partially satisfy behavioral consistency (accurate game simulation) and architectural advantage (speed, accessibility).
- **DIAMOND**: Similar to GameNGen; fixed-domain game simulation.
- **NeuralOS**: Better satisfies persistent state (256-frame RNN) and OS-domain behavioral consistency; may fail Turing completeness claim.
- **NC_CLIGen (current)**: Partially satisfies CLIGen behavioral consistency (54% character accuracy oracle-conditioned); does not currently satisfy Turing completeness or universal programmability at demonstrated scale; closed-loop evaluation needed for state persistence claim.
- **NC_GUIWorld (current)**: Similar partial satisfaction; open-loop only.

**Step 3: Build a formal CNC condition analysis table.**

Add a new table (Table 2b or Table in Section 2.2) with the following structure:

| System | Turing Complete | Universal Programmability | Behavioral Consistency | Architectural Advantage |
|--------|-----------------|--------------------------|------------------------|------------------------|
| NC_CLIGen (current) | Partial | Partial | Partial (54% oracle) | Yes |
| NC_GUIWorld (current) | Not yet | Partial | Partial (FVD 14.72) | Yes |
| GameNGen | No | No | Yes (game domain) | Yes |
| DIAMOND | No | No | Yes (game domain) | Yes |
| NeuralOS | Partial | Partial | Yes (OS, 256-frame) | Partial |

Adjust cell values to be accurate per the conditions' actual definitions.

**Step 4: Add an explanatory paragraph to Section 2.2.**

After the table, add a paragraph explaining its interpretation:

> "Table [X] shows that GameNGen and DIAMOND do not satisfy the Turing completeness or universal programmability conditions, as they are trained on fixed game domains and lack general instruction execution capability. NeuralOS partially satisfies behavioral consistency through its 256-frame state persistence, but its hierarchical RNN architecture does not claim Turing completeness. NC_CLIGen and NC_GUIWorld are early prototypes that partially satisfy the conditions in their respective domains — behavioral consistency under oracle conditioning, and architectural advantage through pretrained visual generation. The closed-loop state persistence property required for full NC realization remains an open challenge addressed in Section 4."

**Step 5: Add one sentence near Eq. 2.1 acknowledging mathematical equivalence.**

> "Note that Eq. 2.1 is mathematically equivalent to the formal interactive environment definitions in GameNGen [cite] and DIAMOND [cite]; the four CNC conditions specified above provide the formal distinguishing criteria."

### Verification Checklist

- [ ] All four CNC conditions are precisely identified from the paper
- [ ] Formal analysis table covers all five systems (NC_CLIGen, NC_GUIWorld, GameNGen, DIAMOND, NeuralOS)
- [ ] Each cell has a brief justification (not just Satisfied/Not Satisfied without reasoning)
- [ ] Table placement is in or near Section 2.2 (CNC definition section)
- [ ] Explanatory paragraph added after the table
- [ ] Mathematical equivalence of Eq. 2.1 to existing formalisms acknowledged
- [ ] Table is internally consistent with claims made elsewhere in the paper
- [ ] Best done after R2 is drafted (so GameNGen, DIAMOND citations are already in place)

---

## R6: Per-Mode Parameter Counts and Capacity Baseline

**Priority**: HIGH  
**Timeline**: Short-term for parameter counts (writing, 1 day); Medium-term for capacity baseline (training run, 2–4 weeks)  
**Effort**: Low for parameter counts; High for training run  
**CFR Source**: HIGH-003

### Current State

Table 10 (injection mode ablation) recommends an architectural hierarchy (internal > residual > contextual on FVD) but the internal mode adds CA_action cross-attention sub-layers — newly initialized parameters — while the paper states "only the action encoder and learning-rate schedule are tuned." No per-mode parameter count is reported. The hierarchy could reflect injection depth or parameter capacity differences.

### Target State

Table 10's caption or a new Appendix column reports the number of trainable parameters for each injection mode. If the parameter counts differ substantially, either a capacity-controlled baseline is added or the recommendations are qualified accordingly.

### Implementation Steps — Part A: Parameter Count Reporting (1 day)

**Step 1: Compute trainable parameter counts for each injection mode.**

In the training code, add a parameter counting utility. For each mode, count only the trainable (non-frozen) parameters:

```python
def count_trainable_params(model):
    return sum(p.numel() for p in model.parameters() if p.requires_grad)

# Run for each mode configuration:
print(f"External mode: {count_trainable_params(external_model):,}")
print(f"Contextual mode: {count_trainable_params(contextual_model):,}")
print(f"Residual mode: {count_trainable_params(residual_model):,}")
print(f"Internal mode: {count_trainable_params(internal_model):,}")
```

**Step 2: Add parameter counts to Table 10.**

Add a column "Trainable Parameters" to Table 10. Example:

| Mode | Trainable Params | FVD | SSIM | PSNR |
|------|-----------------|-----|------|------|
| External | [N]M | ... | ... | ... |
| Contextual | [N]M | ... | ... | ... |
| Residual | [N]M | ... | ... | ... |
| Internal | [N]M | ... | ... | ... |

**Step 3: Add a note to Table 10's caption.**

> "Trainable parameter counts differ across injection modes due to the additional CA_action cross-attention sub-layers in the internal mode. Readers should consider the parameter efficiency (FVD per million parameters) alongside absolute FVD values."

**Step 4: Qualify the architectural recommendation in the paper text.**

If parameter counts differ substantially, revise the recommendation from "internal conditioning is the preferred architecture" to: "Internal conditioning achieves best FVD performance; we note that it also introduces [X]M additional parameters compared to the contextual mode. Whether this advantage reflects injection depth, parameter capacity, or both is addressed by the capacity-controlled experiment in Appendix [Y]." If parameter counts are similar (e.g., within 5%), the confound is minor and can be noted as such.

### Implementation Steps — Part B: Capacity-Controlled Baseline (2–4 weeks)

**Step 5: Design the capacity-controlled contextual mode.**

Identify the number of parameters in internal mode's CA_action sub-layers. Create a modified contextual mode that adds randomly initialized parameters equal in count to the CA_action layers, but placed at the contextual injection point (not inside transformer blocks). This controls for parameter count while keeping injection location at the contextual level.

**Step 6: Train the capacity-controlled contextual mode.**

Train the capacity-controlled contextual mode with the same budget as the other modes. Add its result to Table 10:

| Mode | Trainable Params | FVD | SSIM | PSNR |
|------|-----------------|-----|------|------|
| Contextual | [N]M | ... | ... | ... |
| Contextual (capacity-matched) | [internal N]M | ... | ... | ... |
| Internal | [N]M | ... | ... | ... |

**Step 7: Update the interpretation.**

If capacity-matched contextual underperforms internal, injection depth explains the FVD hierarchy. If capacity-matched contextual matches internal, parameter capacity is the operative factor. Update the recommendation accordingly.

### Verification Checklist — Part A (Minimum Viable)

- [ ] Trainable parameter counts computed and reported for all four injection modes
- [ ] Parameter count column added to Table 10
- [ ] Table 10 caption acknowledges parameter count difference
- [ ] Recommendation text qualified if parameter counts differ substantially
- [ ] No claim that all modes have equal parameter counts (unless they actually do)

---

## R7: Multi-Seed Statistical Validation

**Priority**: HIGH  
**Timeline**: Medium-term (3–6 weeks for training + 1 day for bootstrap CIs)  
**Effort**: High (training runs); Low (bootstrap CIs from existing data)  
**CFR Source**: HIGH-009

### Current State

No variance measures appear in any of the 10 experiment tables. For Tables 10-11, effect sizes are estimated at Cohen's d of 0.06–0.40 (negligible to small). The internal vs. residual SSIM delta of 0.006 is almost certainly within noise at a single seed. Architectural recommendations cannot be validated without knowing whether the differences exceed experimental variation.

### Target State

Tables 10 and 11 report mean ± SD across 2–3 random seeds. Tables 3 and 8 report bootstrap 95% CIs across evaluation clips. The architectural hierarchy claims are qualified to reflect statistical confidence.

### Implementation Steps — Part A: Bootstrap CIs for Tables 3 and 8 (1 day)

**Step 1: Implement bootstrap CI computation from existing evaluation data.**

Tables 3 and 8 likely involve multiple evaluation clips per condition. The bootstrap approach:

```python
import numpy as np

def bootstrap_ci(metric_values, n_bootstrap=10000, ci=0.95):
    """Compute bootstrap CI for metric values across evaluation clips."""
    boot_means = []
    for _ in range(n_bootstrap):
        sample = np.random.choice(metric_values, size=len(metric_values), replace=True)
        boot_means.append(np.mean(sample))
    lower = np.percentile(boot_means, (1 - ci) / 2 * 100)
    upper = np.percentile(boot_means, (1 + ci) / 2 * 100)
    return lower, upper

# Apply to each condition's per-clip metric values
psnr_ci = bootstrap_ci(clip_psnr_values)  # [lower, upper]
```

**Step 2: Add bootstrap CIs to Tables 3 and 8.**

Report as "mean [lower, upper]" or "mean ± half-CI" in the table cells. Note in the caption: "95% bootstrap confidence intervals computed over [N] evaluation clips."

### Implementation Steps — Part B: Multi-Seed Runs for Tables 10–11 (3–6 weeks)

**Step 3: Identify the random seed dependencies.**

In the training code for NC_GUIWorld, identify all points where random seeds affect the result: weight initialization, data shuffling, data augmentation, evaluation clip sampling. Set up seed control:

```python
import torch, random, numpy as np

def set_seed(seed):
    torch.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)
    np.random.seed(seed)
    random.seed(seed)
```

**Step 4: Run 2–3 seeds for the injection mode conditions (Table 10).**

Rerun the internal, contextual, and residual injection modes (the three main conditions) with seeds 1, 2, and 3. The external mode, which was early-stopped, should either be completed (see R13) or excluded from the multi-seed comparison. Compute mean ± SD for FVD, SSIM, PSNR across seeds.

**Step 5: Run 2–3 seeds for the meta-action encoder comparison (Table 11).**

Rerun the meta-action encoding conditions with the same 2–3 seeds. Compute mean ± SD for all metrics.

**Step 6: Update Tables 10 and 11.**

Replace single-value cells with "mean ± SD" format:

| Mode | FVD (mean ± SD) | SSIM (mean ± SD) | PSNR (mean ± SD) |
|------|----------------|-----------------|-----------------|
| Internal | 14.5 ± [X] | 0.856 ± [X] | [Y] ± [X] |
| Residual | 18.8 ± [X] | 0.850 ± [X] | [Y] ± [X] |
| Contextual | [Y] ± [X] | [Y] ± [X] | [Y] ± [X] |

**Step 7: Revise the recommendation based on multi-seed results.**

Expected outcomes:
- If FVD hierarchy survives across seeds (internal < residual < contextual): "Internal conditioning achieves the lowest FVD across [N] seeds (mean ± SD: [value]); the SSIM difference between internal and residual modes (Δ = 0.006) does not reach significance across seeds, indicating this distinction is below the noise threshold."
- If SSIM differences show overlapping intervals: "The SSIM advantage for internal over residual conditioning (Δ = 0.006) falls within experimental variation across seeds and should not be treated as a reliable architectural signal."

### Verification Checklist

- [ ] Bootstrap CIs computed and added to Tables 3 and 8 (from existing data, no new training needed)
- [ ] Evaluation clip sample sizes reported for all tables
- [ ] 2–3 seed runs completed for Tables 10 and 11
- [ ] Mean ± SD reported for all metrics in Tables 10 and 11
- [ ] Recommendation text updated to reflect statistical confidence (or lack thereof) for SSIM differences
- [ ] FVD-based hierarchy retained or revised based on multi-seed evidence

---

## R8: Add Wan2.1 + Reprompting Baseline to Figure 6

**Priority**: HIGH  
**Timeline**: Medium-term (1–2 days compute + half day writing)  
**Effort**: Low  
**CFR Source**: CFR-027 (MEDIUM)

### Current State

Figure 6 reports NC_CLIGen + reprompting achieving 83% arithmetic accuracy — the paper's largest improvement finding. NC_CLIGen is fine-tuned Wan2.1. Since reprompting exploits the model's text-conditioned generation capability, the 83% result may reflect Wan2.1's base reprompting ability applied to terminal content rather than a benefit of NC-specific fine-tuning.

### Target State

Figure 6 includes a "Wan2.1 (zero-shot) + reprompting" bar, enabling direct attribution of the reprompting benefit to fine-tuning versus pretrained capability. If Wan2.1 + reprompting substantially underperforms NC_CLIGen + reprompting, the fine-tuning benefit for reprompting is established.

### Implementation Steps

**Step 1: Obtain or implement the reprompting protocol from the paper.**

Identify in the paper (likely Section 3 or Appendix) the exact reprompting procedure used to achieve 83% accuracy. This likely involves: generating an initial response, detecting failure cases, issuing a re-generation prompt, and iterating up to a fixed number of attempts. Document the protocol precisely.

**Step 2: Run zero-shot Wan2.1 on the arithmetic probe with the same reprompting protocol.**

Load Wan2.1 base (no fine-tuning). Apply the same arithmetic probe and the same reprompting protocol. Use the same 100-problem evaluation set (or whichever size was used for Figure 6). Measure arithmetic accuracy with reprompting.

Command-line example (pseudocode):
```bash
python eval_reprompting.py \
    --checkpoint wan2.1_base \
    --eval_set arithmetic_probe \
    --reprompting_rounds [N] \
    --output_path results/wan21_reprompting/
```

This is the same evaluation run as R4's zero-shot evaluation, but run through the reprompting loop rather than direct evaluation.

**Step 3: Add the result to Figure 6.**

Figure 6 currently shows (at minimum) NC_CLIGen without reprompting and NC_CLIGen with reprompting. Add two additional bars:
- "Wan2.1 (zero-shot)" — without reprompting (this result may already be available from R4)
- "Wan2.1 (zero-shot) + reprompting" — the new result from this step

The figure should now have four bars in order: Wan2.1 zero-shot | Wan2.1 + reprompting | NC_CLIGen | NC_CLIGen + reprompting.

**Step 4: Update the Figure 6 caption and Section 3 text.**

If NC_CLIGen + reprompting (83%) substantially outperforms Wan2.1 + reprompting:
> "Wan2.1 (zero-shot) + reprompting achieves [X]% arithmetic accuracy, compared to NC_CLIGen + reprompting's 83%, establishing that [41]% of the reprompting gain is attributable to NC_CLIGen fine-tuning rather than Wan2.1's base capability."

If performance is comparable:
> "Wan2.1 (zero-shot) + reprompting achieves [X]% arithmetic accuracy — comparable to NC_CLIGen + reprompting's 83% — indicating that the reprompting benefit is primarily attributable to Wan2.1's pretrained text-conditioned generation capability. NC_CLIGen's fine-tuning provides [marginal / no additional] benefit for reprompting-assisted arithmetic evaluation."

The second outcome would require revising the headline claim about the 83% result. The first outcome strongly supports the paper's claim.

### Verification Checklist

- [ ] Reprompting protocol documented precisely (number of rounds, detection criterion, prompt template)
- [ ] Wan2.1 base checkpoint loaded without any NC fine-tuning weights
- [ ] Same arithmetic probe evaluation set used as in Figure 6
- [ ] Same reprompting protocol applied to Wan2.1 as to NC_CLIGen
- [ ] Result added to Figure 6 as a new bar
- [ ] Figure caption updated to reference the new baseline
- [ ] Section 3 text updated to interpret the comparison (attribution to fine-tuning vs. pretrained capability)
- [ ] If result shows Wan2.1 matches NC_CLIGen on reprompting, headline claim is revised accordingly

---

## R9: Release Captioning Pipeline and Episode Packaging System

**Priority**: HIGH  
**Timeline**: Medium-term (1–2 weeks code engineering)  
**Effort**: Medium-High  
**CFR Source**: CFR-019 (HIGH), CFR-023 (HIGH)

### Current State

Two pipeline components that are mandatory for reproducing NC_CLIGen training experiments are absent from the repository:
1. The Llama 3.1 70B captioning pipeline (generates three-tier semantic captions from terminal buffers; directly drives the 5 dB PSNR improvement in Table 3)
2. The episode packaging system (described in Appendix B as "would be released" but currently absent)

Without these, users cannot proceed from raw CLIGen data collection to any training experiment.

### Target State

The repository contains a `captioning/` directory with the captioning pipeline and a `packaging/` or `data_prep/` directory with the episode packaging system. Each has a README explaining how to use it. Researchers can reproduce NC_CLIGen training from raw data collection.

### Implementation Steps

**Step 1: Prepare the captioning pipeline for release.**

Create a `captioning/` directory in the repository. Include:

- `caption_generator.py`: Main script that takes terminal buffer recordings as input and outputs three-tier captions (command-level, step-level, semantic-level)
- `prompts/`: Directory containing the prompt templates used for each caption tier
  - `command_level_prompt.txt`
  - `step_level_prompt.txt`  
  - `semantic_prompt.txt`
- `requirements.txt`: Dependencies (e.g., `transformers`, `llama-cpp-python`, or API client library)
- `README.md`: Instructions for running the captioning pipeline, including:
  - How to set up Llama 3.1 70B (local or API)
  - Input format (terminal buffer format)
  - Output format (caption file format)
  - How to integrate with the training pipeline

**Step 2: Handle the Llama 3.1 70B dependency.**

If the original pipeline used proprietary API access, provide:
- The prompt templates (which are not model-specific)
- Instructions for substituting an available open-source model (e.g., Llama 3.1 70B via HuggingFace, or a smaller model like Llama 3.1 8B for testing)
- A note that the results in the paper used Llama 3.1 70B and smaller models may produce different caption quality

```python
# captioning/caption_generator.py
# Example structure:
import argparse
from pathlib import Path

def generate_captions(terminal_buffer_path, output_path, model="llama-3.1-70b"):
    """
    Generate three-tier captions from terminal buffer recordings.
    
    Args:
        terminal_buffer_path: Path to recorded terminal buffer
        output_path: Where to save generated captions
        model: LLM model to use for caption generation
    
    Caption tiers:
        - command: Identifies the specific command executed
        - step: Describes the operation being performed  
        - semantic: High-level description of computational intent
    """
    prompts = load_prompts("captioning/prompts/")
    # ... implementation
```

**Step 3: Prepare the episode packaging system.**

Create a `packaging/` or `data_prep/` directory. Include:

- `package_episodes.py`: Main script that takes raw frame recordings and action logs and packages them into the training format
- `README.md`: Documentation of the episode format (frame extraction, action alignment, file structure)
- `episode_format.md`: Specification of the packaged episode format (what Appendix B describes)

The packaging script should implement what Appendix B documents. If the code already exists privately, clean it up and add docstrings.

**Step 4: Add end-to-end reproduction instructions to the main README.**

In the main repository README, add a "Reproducing NC_CLIGen Training" section with numbered steps:

```markdown
## Reproducing NC_CLIGen Training

1. **Data Collection**: Record terminal sessions using `scripts/record_cli.py`
2. **Episode Packaging**: Package raw recordings into training format:
   ```bash
   python packaging/package_episodes.py --input raw_recordings/ --output episodes/
   ```
3. **Caption Generation**: Generate three-tier captions:
   ```bash
   python captioning/caption_generator.py --input episodes/ --output captions/ --model llama-3.1-70b
   ```
4. **Training**: Launch NC_CLIGen training:
   ```bash
   python train.py --data episodes/ --captions captions/ --config configs/nc_clicgen.yaml
   ```
```

**Step 5: Test the reproduction pipeline.**

Run the complete pipeline from raw data collection to training data on a small sample (e.g., 10 episodes). Verify that the packaged format is compatible with the training script. Document any issues encountered.

**Step 6: Add paper reference to the repository.**

Update the repository README to link the released code to the specific paper experiments it enables:
- "The captioning pipeline enables reproduction of Table 3 (semantic caption tier ablation)"
- "The episode packaging system enables reproduction of all NC_CLIGen training experiments (Tables 2-9)"

### Verification Checklist

- [ ] `captioning/` directory created with `caption_generator.py` and prompt templates
- [ ] `packaging/` directory created with `package_episodes.py`
- [ ] Both directories have README files with clear usage instructions
- [ ] Llama 3.1 70B dependency documented with alternatives provided
- [ ] Main README updated with end-to-end reproduction steps
- [ ] Pipeline tested on a small sample dataset
- [ ] Input and output formats documented (Appendix B format specification)
- [ ] Paper claims (e.g., three-tier caption structure) are verifiable from released code
- [ ] No private API keys or credentials in released code

---

## R10: Add Formal NeuralOS Comparison Subsection

**Priority**: HIGH  
**Timeline**: Short-term (writing, 2–3 days)  
**Effort**: Medium  
**CFR Source**: HIGH-012; CFR-PATTERN-A (component)

### Current State

NeuralOS is described as "most closely related" in a single sentence. NC_GUIWorld is framed as conceptually superior on the "runtime vs. simulation" distinction. However, NeuralOS's hierarchical RNN architecture demonstrates 256-frame OS state persistence in closed-loop interaction — the precise property that NC_GUIWorld lacks and acknowledges as a future challenge. The paper omits that NeuralOS outperforms NC_GUIWorld on the defining property of the "running computer" concept.

### Target State

The paper contains a Section 2.2 (or subsection of Related Work) "Comparison with NeuralOS" of approximately half to one page that accurately characterizes NeuralOS's strengths, positions NC_GUIWorld as a proof-of-concept prototype using a more accessible backbone, and identifies what each system offers that the other does not.

### Implementation Steps

**Step 1: Read the NeuralOS paper in full.**

Focus on: (a) NeuralOS's hierarchical RNN architecture for long-horizon state persistence; (b) the 256-frame closed-loop demonstration; (c) NeuralOS's inference speed (15 FPS); (d) NeuralOS's multi-application generalization capability; (e) NeuralOS's GUIWorld data collection pipeline (to understand what NC derived from it).

**Step 2: Draft a structured comparison.**

Organize the comparison around four dimensions:
1. State persistence: NeuralOS (256-frame RNN) vs. NC_GUIWorld (open-loop only)
2. Backbone architecture: NeuralOS (purpose-built RNN) vs. NC_GUIWorld (pretrained video DiT — Wan2.1)
3. Visual generation quality: NeuralOS (RNN output) vs. NC_GUIWorld (DiT — likely higher visual quality)
4. Domain coverage: NeuralOS ([N] apps, generalization demonstrated) vs. NC_GUIWorld (8 apps, same-distribution evaluation)

**Step 3: Write the comparison section.**

Create a new Section 2.2 "Relationship to NeuralOS" or add a subsection in the expanded Related Work (see R12). Suggested content structure and language:

> **2.2 Relationship to NeuralOS**
>
> NeuralOS [cite] is the most architecturally comparable system in the OS simulation literature. NeuralOS's hierarchical RNN architecture maintains O(1) per-timestep complexity and demonstrates 256-frame closed-loop OS state persistence — concretely addressing the long-horizon state retention challenge that NC_GUIWorld identifies as future work (Section 4). In terms of persistent runtime state, NeuralOS currently outperforms NC_GUIWorld's open-loop prototype implementation.
>
> NC_GUIWorld and NeuralOS differ in their foundational design choices. NeuralOS employs a purpose-built recurrent architecture optimized for state persistence; NC_GUIWorld leverages a pretrained video diffusion transformer (Wan2.1) as its backbone, offering the visual generation quality of large-scale pretraining while currently lacking the closed-loop stability that NeuralOS achieves through architectural specialization.
>
> NC_GUIWorld's contributions relative to NeuralOS are: (1) the first application of the pretrained video DiT paradigm to OS simulation, enabling leverage of Wan2.1's pretrained visual prior; (2) the CLIGen domain, which is absent from NeuralOS; (3) the systematic four-mode action injection ablation, providing design guidance for video DiT-based OS simulation; and (4) the NC/CNC conceptual framework (Section 2.1), which provides vocabulary for reasoning about neural systems as computing substrates rather than simulators.
>
> The NC/CNC "runtime vs. simulation" distinction is an architectural target for future work rather than a description of NC_GUIWorld's current prototype capabilities. We acknowledge that NeuralOS demonstrably addresses the runtime state persistence challenge that NC_GUIWorld does not yet solve. Our code pipeline also builds on NeuralOS's data collection infrastructure [see Section 3.2.1]; we extend it to [specific adaptations].

**Step 4: Add a comparison table.**

Optionally, add a compact comparison table:

| Property | NC_GUIWorld | NeuralOS |
|----------|-------------|----------|
| Backbone | Pretrained video DiT (Wan2.1) | Purpose-built hierarchical RNN |
| State persistence | Open-loop (oracle-conditioned) | 256-frame closed-loop |
| Inference speed | [measure — see R11] | 15 FPS |
| Training data | GUIWorld (8 apps) | [NeuralOS dataset] |
| Visual generation | High (pretrained DiT prior) | [RNN quality] |
| CLIGen domain | Yes | No |
| Cross-app generalization | Not demonstrated | Demonstrated |

**Step 5: Revise the introduction's NeuralOS comparison language.**

Remove or qualify any language suggesting NC is currently superior to NeuralOS. Replace with: "NC_GUIWorld represents a complementary approach to NeuralOS, trading NeuralOS's closed-loop state persistence for the visual generation quality and pretrained visual prior of a large-scale video DiT."

### Verification Checklist

- [ ] Section 2.2 or equivalent subsection created with approximately half to one page on NeuralOS
- [ ] NeuralOS's 256-frame state persistence acknowledged as superior to NC_GUIWorld's current prototype
- [ ] Clear statement that runtime superiority is architectural target, not current achievement
- [ ] NeuralOS code derivation referenced (linking to Section 3.2.1 attribution from R3)
- [ ] NC_GUIWorld's complementary contributions clearly identified (DiT backbone, CLIGen, injection ablation, NC/CNC framework)
- [ ] Comparison table included (optional but recommended)
- [ ] Introduction's NeuralOS comparison language revised to remove current superiority claims
- [ ] R3 (code attribution) completed before or alongside this section for consistency

---

## Consolidated Quick Wins

These improvements have the highest impact-to-effort ratio and should be done first:

| Item | Effort | Time | Impact |
|------|--------|------|--------|
| R3: NeuralOS code attribution | 0.5 days | Immediate | Resolves CRITICAL component (CFR-PATTERN-A) |
| R4: Zero-shot Wan2.1 baseline | 1 eval run | 1–2 days | Resolves structurally required control condition |
| R8: Wan2.1 + reprompting baseline | 1 eval run | 1–2 days | Resolves headline result attribution |
| R5: CNC conditions table | 1–2 days writing | Immediate | Resolves CRITICAL component; formally differentiates NC from GameNGen/DIAMOND |
| R2 (partial): Add 4 citations | 0.5 days writing | Immediate | Resolves most urgent citation gaps |

**Day 1 action sequence**: Start R3 immediately (half-day writing task). While writing R3, initiate the zero-shot Wan2.1 evaluation run for R4 (can run overnight). These two actions resolve two CFR-PATTERN-A components and one structurally required control condition within 48 hours.

**Week 1 action sequence**: Complete R3 → R4 evaluation collects → R8 evaluation runs in parallel → begin R2 citation additions and R5 CNC conditions table (both writing-only, can proceed in parallel).

---

## Common Pitfalls to Avoid

**On R1 (closed-loop evaluation)**:
- Do not run more than 10 autoregressive steps without verifying computational feasibility first
- Do not cherry-pick sequences where closed-loop is stable — report mean and SD across the full sample
- If performance collapses rapidly, report it accurately — this is informative, not embarrassing

**On R2 (citation additions)**:
- Read GameNGen, DIAMOND, AVID, and DWS before writing the related work characterizations — do not paraphrase abstracts alone
- Ensure the contribution reframing is not defensive; "first OS/GUI application of the established paradigm" is a meaningful and positive contribution

**On R3 (NeuralOS attribution)**:
- Be specific about which components derive from NeuralOS — vague attribution ("inspired by") is insufficient
- Confirm with NeuralOS's license terms that the use and attribution approach is compliant

**On R4 (zero-shot baseline)**:
- Use identical prompts and evaluation protocol to Tables 2-4 — any difference in evaluation procedure will make the baseline non-comparable
- Run the zero-shot model in inference mode (no gradients) to avoid unintended adaptation

**On R7 (multi-seed validation)**:
- Record all three seeds' individual results before reporting the mean — if one seed is a severe outlier, investigate before averaging
- Do not run partial seeds (e.g., seeds 1 and 2 but not 3) and then average — specify the number of seeds in the protocol and complete all of them

**On R9 (code release)**:
- Test the released pipeline on a fresh machine before publication — dependencies and paths that work in the development environment may not work in others
- Do not release code that contains private API keys, internal IP addresses, or proprietary data paths

---

## Resources and References

**Papers to read before implementing R2 and R5**:
- GameNGen: https://arxiv.org/abs/2408.14837
- DIAMOND: https://arxiv.org/abs/2405.12399
- AVID: https://arxiv.org/abs/2410.12822
- DWS: https://arxiv.org/abs/2502.07825
- NeuralOS: (cited in paper — obtain from citation)
- OSWorld: https://arxiv.org/abs/2404.07972

**Statistical methods for R7**:
- Bootstrap confidence intervals: scipy.stats.bootstrap (Python) — standard library, no installation needed beyond scipy
- Cohen's d effect size: pip install pingouin or compute manually as (mean1 - mean2) / pooled_SD

**Code evaluation tools for R1 and R4**:
- Character accuracy for terminal output: compare predicted terminal buffer text to ground truth using character-level edit distance or exact match
- FVD (Frechet Video Distance): standard implementation available at https://github.com/google-research/google-research/tree/master/frechet_video_distance

**Captioning model alternatives for R9**:
- Llama 3.1 70B via HuggingFace: https://huggingface.co/meta-llama/Meta-Llama-3.1-70B
- Llama 3.1 8B (smaller alternative for testing): https://huggingface.co/meta-llama/Meta-Llama-3.1-8B-Instruct
- Together AI API (hosted inference): https://www.together.ai/models

**License compliance for R3 and R9**:
- Review NeuralOS repository license before releasing derived code
- Common licenses: MIT, Apache 2.0 require attribution; GPL requires source disclosure
- If license is unclear, contact NeuralOS authors directly
