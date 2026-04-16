# Devil's Advocate Review: Neural Computers (arXiv:2604.06425)

## Phase 7-0

---

## Executive Summary

| Metric | Count |
|--------|-------|
| Total CFR findings reviewed | 25 |
| Classifications challenged | 18 |
| Escalations recommended | 3 |
| Downgrades recommended | 4 |
| Severity standardizations | 2 (MAJOR → HIGH) |
| New issues identified | 2 (CFR-026, CFR-027) |
| Patterns detected | 2 (CFR-PATTERN-A escalated to CRITICAL) |

---

## Part 1: CFR Classification Challenges

### 1.1 HIGH Findings Challenge Table

| CFR ID | Current | Challenge Question | Escalate? | Downgrade? | Decision |
|--------|---------|-------------------|-----------|-----------|----------|
| HIGH-001 | HIGH | Is 1-page related work paradigm-level integrity failure? | No | No | Maintain HIGH |
| HIGH-002 | HIGH | Is unvalidated LLM captioning actually fatal? | No | Yes | Downgrade to MEDIUM |
| HIGH-003 | HIGH | Does parameter confound invalidate injection conclusions? | No | No | Maintain HIGH |
| HIGH-004 | HIGH | Is open-loop gap CRITICAL for a prototype paper? | Yes | No | Escalate to CRITICAL |
| HIGH-007 | HIGH | Is SSIM delta=0.006 actually HIGH severity? | No | Yes | Downgrade to MEDIUM |
| HIGH-009 | HIGH | Is no-statistics systemic gap CRITICAL? | No | No | Maintain HIGH |
| HIGH-011 | HIGH | Are missing citations CRITICAL given author awareness of GameNGen? | Yes | No | Escalate to CRITICAL |
| HIGH-012 | HIGH | Is NeuralOS treatment HIGH given NeuralOS is concurrent/later work? | No | No | Maintain HIGH |
| CFR-015 | HIGH | Is closed-loop demo absence really a field standard gap? | No | No | Confirm HIGH (merge with HIGH-004) |
| CFR-021 | HIGH | Is Sora2 config undisclosure really HIGH severity? | No | Yes | Downgrade to MEDIUM |
| CFR-022 | HIGH | Does disclosed early-stopping invalidate injection hierarchy? | No | Yes | Downgrade to MEDIUM |

### 1.2 Escalation Cases — Detailed Rationale

#### HIGH-004 → CRITICAL: Open-Loop Evaluation Cannot Validate "Runtime" Claim

The paper's central conceptual claim is not that NC_GUIWorld generates good-looking frames. The claim is that the model instantiates "early NC primitives of a running computer" with "persistent latent runtime state h_t." The NC formalism (Eq. 2.1) defines runtime as h_t evolving through the model's own output feeding back as x_t. Without a single closed-loop experiment, the runtime state persistence claim has zero experimental support.

The counterargument — that the paper explicitly discloses this limitation in Section 3.2.4 — does not reduce severity. A finding is classified by what it means for validity, not by whether it is disclosed. The paper demonstrates open-loop I/O alignment, which is empirically indistinguishable from what GameNGen and DIAMOND demonstrate. The word "runtime" does no additional empirical work beyond "simulation."

Escalation criteria met: Issue affects core claims (the entire NC vs. world model differentiation rests on the runtime property); issue affects interpretation of all 10 experiments (which are measured as open-loop metrics but labeled as NC primitive demonstrations).

#### HIGH-011 → CRITICAL: Author-Aware Citation Omission Misrepresents Paradigm Novelty

The project blog separately mentions GameNGen, confirming author awareness. The paper body does not cite it. This converts a "citation gap" into a deliberate presentation decision. For a paper claiming NC_GUIWorld "demonstrates a pioneering paradigm for interactive OS simulation," the deliberate exclusion of the most directly comparable paradigm-establishing paper (GameNGen, ICLR 2025) represents a misrepresentation of the state of the art.

The four missing papers together establish that:
- Two-phase interaction-data-to-diffusion paradigm: GameNGen (2024)
- Interactive diffusion from fixed human data at ~10 FPS: DIAMOND (2024)
- Per-frame scale/shift action conditioning: AVID (2025)
- Per-block modulation for video DiTs: DWS (2025)

NC_GUIWorld's paradigm novelty claim requires repositioning from "pioneering" to "first systematic application to OS/GUI domain." This is still a meaningful contribution, but it is a fundamentally different contribution category. The author awareness of GameNGen makes the omission a presentation choice with direct impact on how the contribution is assessed.

Escalation criteria met: Would change interpretation of main results; classification based on presentation choice rather than evidence gap.

#### CFR-PATTERN-A (NEW): Paradigm Claim Integrity Pattern — CRITICAL

**Related findings**: HIGH-001 (thin related work), HIGH-011 (4 missing ICLR/NeurIPS citations, author-aware omission), HIGH-012 (NeuralOS 1-sentence treatment while NeuralOS architecturally outperforms NC on the key dimension), CFR-024 (code derived from NeuralOS confirmed but not disclosed in paper body), CFR-014 (NC formalism mathematically equivalent to world models)

**Pattern description**: These five findings together describe a systematic pattern of paradigm positioning through selective disclosure:
1. Project blog mentions GameNGen; paper body does not cite it
2. NeuralOS receives one sentence in a paper whose code pipeline derives from NeuralOS's codebase
3. NC formalism is mathematically identical to GameNGen's formalism; this equivalence is not acknowledged
4. Related Work section is 1 page; the most important competitors are either undercited or uncited
5. CNC four-condition definition is never applied to verify existing systems fail to satisfy it

This pattern is not coincidental. It creates a coherent presentation of NC as a paradigm originator rather than a domain extender. No individual finding reaches CRITICAL on its own; combined they constitute a systematic misrepresentation of paradigm originality that a reviewer encountering the full pattern would treat as an integrity concern.

**Severity**: CRITICAL (combined pattern)

---

## Part 2: Downgrade Rationale

### HIGH-002 → MEDIUM: LLM Caption Quality

CLIGen Clean (all controlled experiments in the paper, Experiments 2-6) uses scripted captions derived from VHS scripts, not LLM-generated captions. The LLM caption quality issue affects only:
- CLIGen General (the exploratory, not the controlled, dataset)
- Experiment 3 / Table 3 (the caption tier ablation)

The paper's architecture validity, injection mode findings, cursor supervision finding, and data quality finding do not depend on LLM caption accuracy. The 5 dB PSNR gap between caption tiers may reflect semantic informativeness rather than factual accuracy — a hallucination could still produce a more informative conditioning signal than a sparse caption. MEDIUM is appropriate.

### HIGH-007 → MEDIUM: Internal vs. Residual SSIM Delta

The FVD difference (internal 14.5 vs. residual 18.8, 23% relative improvement) is a robust, practically significant finding that points the same direction as the SSIM comparison. The SSIM delta (0.006) is one metric of three. The LPIPS reversal (residual 0.138 vs. internal 0.141, a difference of 0.003) is also within noise. The overall recommendation "internal conditioning achieves best SSIM/FVD trade-off" is weakened on the SSIM dimension but survives on FVD. MEDIUM captures that the SSIM result is not reliable without further validation; it does not justify HIGH because the core recommendation stands on FVD.

### CFR-021 → MEDIUM: Sora2 Configuration Undisclosed

The directional finding (commercial models outperform NC_CLIGen: 71% vs. 4%) is so large that no plausible configuration variation could reverse it. The inconsistent disclosure standard (Table 5 vs. Table 10 footnote) is a presentation concern, not a scientific integrity issue. The paper explicitly provides Table 6 with three hypotheses for Sora2's advantage, demonstrating awareness of the gap. MEDIUM is appropriate.

### CFR-022 → MEDIUM: External Injection Mode Early-Stopped

This stopping decision was explicitly disclosed in a Table 10 footnote — distinguishing it from undisclosed outcome-dependent stopping. The three fully trained modes (contextual, residual, internal) are sufficient to establish the injection depth hierarchy. External mode is the weakest condition and its precise performance level does not change the primary recommendation. MEDIUM captures the appropriate caution about ablation completeness without overstating the impact on the paper's primary conclusions.

---

## Part 3: Pattern Analysis

### Pattern A: Paradigm Claim Integrity

**Related findings**: HIGH-001, HIGH-011, HIGH-012, CFR-024, CFR-014

**Individual severities**: HIGH, HIGH, HIGH, HIGH, MEDIUM

**Combined severity**: CRITICAL (new CFR-PATTERN-A)

**Why combined is worse**: Each finding alone is fixable and could be explained by editorial omission. Combined, they show that every major comparative reference point — GameNGen (citation), DIAMOND (citation), NeuralOS (attribution and code lineage), mathematical equivalence of NC formalism — was handled in the way that maximizes the appearance of originality. This is not how knowledge gaps look; this is how deliberate positioning looks.

### Pattern B: Injection Mode Ablation Compound Weakness

**Related findings**: HIGH-003 (parameter count confound), CFR-007/now MEDIUM (SSIM within noise), HIGH-009 (no statistics), CFR-022/now MEDIUM (external early-stopped)

**Individual severities**: HIGH, MEDIUM, HIGH, MEDIUM

**Combined assessment**: The injection mode ablation (NC_GUIWorld's primary technical finding) is simultaneously affected by unequal parameter counts, a noise-level SSIM difference, absent statistical validation, and an underfitted anchor condition. The FVD-based hierarchy (internal 14.5 < residual 18.8 < contextual 24.8) is the only credible finding from Table 10. The full four-mode recommendation in the paper should be treated as preliminary and directional, not definitive.

**No new CFR entry required**: the individual HIGH findings (HIGH-003, HIGH-009) adequately capture the concern; the pattern is a reading note for reviewers, not an additional finding.

---

## Part 4: Assumption Challenges

### Claim 1: NC_GUIWorld Demonstrates "Early NC Primitives of a Running Computer"

| Element | Assessment |
|---------|-----------|
| Supporting evidence | FVD 14.72, SSIM 0.863, cursor accuracy 98.7% |
| Counter-evidence | All experiments open-loop oracle-conditioned; runtime state property never exercised |
| Alternative explanation | The paper demonstrates a well-trained open-loop video prediction model for OS interaction data — empirically equivalent to what GameNGen demonstrated for DOOM |
| Challenge strength | Strong — escalated to CRITICAL (HIGH-004 → CRITICAL) |

**Verdict**: The "running computer" framing is aspirational, not evidential. The paper would be more accurately described as demonstrating promising open-loop OS interaction video generation.

### Claim 2: NC_CLIGen is a Genuinely Novel Contribution

| Element | Assessment |
|---------|-----------|
| Supporting evidence | Verified novel across ~250 candidates in Phase-3-5c |
| Counter-evidence | None found |
| Alternative explanation | Domain novelty real; whether terminal video simulation serves a practical use case is unaddressed |
| Challenge strength | Weak — novelty claim stands |

**Verdict**: NC_CLIGen's novelty survives all scrutiny. The paper's weakest claim here is not novelty but the absent demonstration that terminal video simulation serves any agent training use case.

### Claim 3: SVG Cursor Supervision is a Decisive Novel Training Insight

| Element | Assessment |
|---------|-----------|
| Supporting evidence | d > 5.0, 90 pp improvement, no prior work |
| Counter-evidence | Baseline (8.7%) may be trivially weak |
| Alternative explanation | Coordinate-only conditioning fails catastrophically, making SVG look better than it needs to be |
| Challenge strength | Weak — even a trivially weak baseline makes the 98.7% result practically valuable |

**Verdict**: Confirmed decisive. The prior phases were correct.

### Claim 4: Data Quality Over Quantity is a Generalizable Design Principle

| Element | Assessment |
|---------|-----------|
| Supporting evidence | CUA 110h FVD 14.72 vs. Random Fast 1,400h FVD 48.17 |
| Counter-evidence | 42x action density difference (CFR-006); tested with contextual conditioning only |
| Alternative explanation | Sparse vs. dense interactions, not goal-directedness |
| Challenge strength | Moderate — practical recommendation survives even if mechanism is wrong |

**Verdict**: The recommendation is robust; the stated mechanism is unverified. The paper overstates scope by presenting this as a generalizable principle without cross-mode validation.

### Claim 5: NC/CNC Framework is a New Formal Abstraction

| Element | Assessment |
|---------|-----------|
| Supporting evidence | No prior paper uses NC/CNC language or four-condition specification |
| Counter-evidence | h_t mathematically equivalent to q(o_n|o_<n,a_<=n); CNC conditions never applied to existing systems |
| Alternative explanation | Terminological reframing of interactive world model research |
| Challenge strength | Moderate — new vocabulary is not the same as a new formal structure |

**Verdict**: Prior phases correctly rated "Partially Novel." The conceptual contribution is real but precarious; it depends on closed-loop experimental support that the paper does not provide, and on a formal proof that GameNGen/DIAMOND fail the CNC four conditions, which is never attempted.

---

## Part 5: Overlooked Issues

### CFR-026 (NEW — HIGH): Missing Zero-Shot Wan2.1 Baseline in NC_CLIGen Training Ablation

The paper's Tables 2-4 track NC_CLIGen training progression across checkpoints (3% to 54% character accuracy, PSNR across steps, OCR metrics). None of these tables include a zero-shot Wan2.1 baseline — the base model's performance on CLIGen data without any fine-tuning.

Without this baseline, the paper cannot demonstrate that CLIGen fine-tuning produces improvement over Wan2.1's base video generation capability. The 26.89 dB PSNR result could reflect Wan2.1's general video generation quality applied to terminal content, not learned CLI simulation. For the core NC_CLIGen empirical claim (that fine-tuning teaches the model to simulate CLI behavior), the zero-shot Wan2.1 row is structurally required.

This was identified in Phase-3-4 as a "development direction" but never elevated to a CFR finding. Given that it directly affects the attribution of NC_CLIGen's performance to fine-tuning, it meets HIGH severity criteria.

**Severity**: HIGH

### CFR-027 (NEW — MEDIUM): Reprompting Comparison with Base Wan2.1 Absent

The paper's Figure 6 shows NC_CLIGen rising from 4% to 83% under reprompting and frames this as "steerability as an alternative to RL." This interpretation requires showing that NC_CLIGen with reprompting outperforms Wan2.1 with reprompting — not just that reprompting improves NC_CLIGen.

If base Wan2.1 achieves comparable arithmetic accuracy under reprompting (which is plausible since Wan2.1 is the NC_CLIGen backbone), the 83% result reflects Wan2.1's text-conditioned video generation capability, not a distinctive NC property from fine-tuning. No prior phase identified this missing comparison explicitly.

**Severity**: MEDIUM

---

## Part 6: Cross-Phase Consistency Check

| Issue | Phase-3-x | Phase-4-x | Phase-5-6-x | Consistent? | Note |
|-------|-----------|-----------|-------------|-------------|------|
| Open-loop evaluation | HIGH | HIGH confirmed | HIGH + field standard gap | Yes | DA escalates to CRITICAL |
| Missing citations | HIGH | HIGH confirmed | Field standard gap | Yes | DA escalates to CRITICAL |
| Parameter count confound | HIGH | HIGH confirmed | Not re-examined | Yes | Maintained |
| NeuralOS treatment | HIGH | HIGH confirmed | HIGH confirmed | Yes | Maintained |
| LLM caption quality | HIGH | HIGH confirmed | Not re-examined | Yes | DA downgrades to MEDIUM |
| Injection SSIM delta | HIGH | HIGH confirmed | Not re-examined | Yes | DA downgrades to MEDIUM |
| External baseline | Not raised pre-6 | N/A | HIGH (Phase-6-2b) | Yes (within phase-6) | DA downgrades to MEDIUM |
| NeuralOS code attribution | Not raised pre-6 | N/A | MAJOR (non-standard) | Inconsistent naming | DA standardizes to HIGH |
| Episode packaging absent | Not raised pre-6 | N/A | MAJOR (non-standard) | Inconsistent naming | DA standardizes to HIGH |

**Key inconsistency resolved**: CFR-023 and CFR-024 were labeled "MAJOR" in Phase-6-3 language, which is not in the standard CRITICAL/HIGH/MEDIUM/LOW vocabulary. Both standardized to HIGH.

---

## Part 7: Final Severity Audit

### Post-DA CFR Severity Distribution

**CRITICAL (3)**:
- HIGH-004 (escalated): Open-loop only evaluation — runtime claim experimentally ungrounded
- HIGH-011 (escalated): Author-aware missing citations — paradigm novelty misrepresented
- CFR-PATTERN-A (new): Paradigm claim integrity pattern — systematic omission of comparative context

**HIGH (10)**:
- HIGH-001: Related Work insufficient
- HIGH-003: Injection mode parameter count confound
- HIGH-009: Systemic absence of statistical reporting
- HIGH-012: NeuralOS technical advantage unacknowledged
- CFR-015: No closed-loop interactive demonstration
- CFR-016: Missing human perceptual study
- CFR-019: Captioning pipeline absent from repository
- CFR-023 (standardized from MAJOR): Episode packaging absent
- CFR-024 (standardized from MAJOR): NeuralOS code lineage undisclosed in paper body
- CFR-026 (new): Missing zero-shot Wan2.1 baseline

**MEDIUM (12)**:
- MEDIUM-001: CLIGen Clean filtering undocumented
- MEDIUM-002: Missing hyperparameters
- HIGH-002 (downgraded): LLM caption quality unvalidated
- HIGH-007 (downgraded): Internal vs. residual SSIM delta within noise
- CFR-005: Arithmetic probe n=100 insufficient
- CFR-006: Action density confound
- CFR-008: Meta vs. raw-action effect sizes small
- CFR-010: Reprompting 83% without data table
- CFR-013: Positive-only visualization gallery
- CFR-014: NC formalism indistinguishable from world models
- CFR-017: No inference speed reported
- CFR-018: No OSWorld task coverage analysis
- CFR-020: No per-file attribution in NeuralOS-derived code
- CFR-021 (downgraded): Sora2 configuration undisclosed
- CFR-022 (downgraded): External injection early-stopped
- CFR-025: OSWorld task instructions uncited
- CFR-027 (new): Reprompting comparison with base Wan2.1 absent

**LOW (0)**

---

## Part 8: Defense of Paper Where Prior Phases Were Too Harsh

**Defense 1 — Transparency mitigates some weaknesses**: The paper's explicit "open-loop" disclosure in Section 3.2.4, the "Position" label on Section 4, and the frank acknowledgment of failure modes in Section 3.2.5 demonstrate that the authors do not oversell. This transparency does not change CFR severity ratings (severity is about validity impact, not disclosure quality), but it means the paper's positive findings have higher credibility because negative evidence is not suppressed.

**Defense 2 — NC_CLIGen domain novelty is confirmed**: The verified novelty of CLI/terminal video simulation across ~250 candidates is the strongest single claim in the paper. No amount of paradigm-framing concerns affects this.

**Defense 3 — SVG cursor supervision finding is decisively confirmed**: d > 5.0, no prior work, practical impact clear. This finding would be publishable independently and survives all scrutiny.

**Defense 4 — Data quality finding is directionally robust**: Even if the mechanism is action density rather than goal-directedness (CFR-006), the practical recommendation (curated sparse interaction > massive random exploration) is the same. The magnitude (12.7x more random data still loses by 70% on FVD) is compelling.

**Defense 5 — Two complementary systems is structurally stronger than prior work**: Having both NC_CLIGen and NC_GUIWorld under one framework, with 10 quantitative experiments across two qualitatively different interface paradigms, exceeds the scope of GameNGen, DIAMOND, or NeuralOS individually.

**Defense 6 — HIGH-002 and HIGH-007 were overstated**: LLM caption quality affects only exploratory CLIGen General data, not the controlled experiments. The internal vs. residual recommendation survives on FVD regardless of the SSIM noise-level result.

---

## Summary: Where Prior Phases Were Too Lenient vs. Too Harsh

### Too Lenient (Escalations)

**HIGH-004 → CRITICAL**: The "running computer" / "NC primitive" framing is the paper's central differentiator from GameNGen, DIAMOND, and NeuralOS. Every experiment measures open-loop oracle-conditioned performance. The property that makes NC an NC (persistent runtime state through self-generated inputs) has no experimental support at all. This is a CRITICAL gap that should have been escalated in Phase-3-3 when it was first identified.

**HIGH-011 → CRITICAL**: Author awareness of GameNGen (confirmed via project blog) and the confirmed NeuralOS code derivation (CFR-024) together indicate that the missing citations are a positioning choice, not an oversight. A paper that claims to be pioneering a paradigm while excluding from its references the most directly comparable paper in that paradigm — and doing so with awareness — has a CRITICAL related-work integrity issue.

**Pattern CFR-PATTERN-A (CRITICAL, new)**: No prior phase assessed the systematic nature of the omissions. Each finding was analyzed in isolation. The combined pattern — GameNGen awareness but omission, NeuralOS code derivation confirmed but undisclosed in paper body, mathematical equivalence of NC formalism to GameNGen's formalism without acknowledgment, 1-page related work — is worse than the sum of its parts.

### Too Harsh (Downgrades)

**HIGH-002 → MEDIUM**: CLIGen Clean controls eliminate LLM caption risk from 8 of 10 experiments.

**HIGH-007 → MEDIUM**: FVD hierarchy survives the SSIM noise issue.

**CFR-021 → MEDIUM**: 71% vs. 4% gap is robust to configuration variation.

**CFR-022 → MEDIUM**: Explicitly disclosed; three fully trained modes are sufficient.

### Missed Entirely

**CFR-026 (HIGH)**: No zero-shot Wan2.1 baseline in training ablation — structurally required to attribute CLIGen learning to fine-tuning.

**CFR-027 (MEDIUM)**: No reprompting comparison with base Wan2.1 — required for the "steerability as RL alternative" interpretation.
