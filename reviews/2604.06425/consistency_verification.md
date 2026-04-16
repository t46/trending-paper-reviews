# Consistency Verification: Neural Computers (arXiv:2604.06425)

## Overall Assessment: Partially Consistent

~20-25% of paper is released (data pipeline only). For the released code, consistency is high. The 75-80% covering model code has no code to check.

## Key Findings

### CONSISTENT
- 17 VHS command categories match code exactly
- Clean-state Docker containers (Ubuntu 22.04, XFCE4, Arc-Dark, 1024×768, 15 FPS)
- CUA agent model (claude-sonnet-4-20250514) matches paper
- Parallel container execution implemented
- Table 7 data splits match code collection modes
- All internal quantitative cross-checks pass

### MAJOR Discrepancies (New CFR)
- CFR-023: Episode packaging system described in Appendix B but not implemented
- CFR-024: GUIWorld Section 3.2.1 omits NeuralOS code derivation attribution

### MODERATE Discrepancies
- CFR-025: OSWorld task instructions used for CUA collection but OSWorld not cited
- CSV format has undocumented evolution (two naming variants normalized silently)

### Already Known (Confirmed)
- CFR-019: Captioning pipeline absent
- MEDIUM-001: CLIGen Clean filtering criteria undocumented

## Reproducibility
Tables 2-11 (all 10 experiments): Cannot be reproduced from released code.
Data collection: Can be reproduced (minus captioning and episode packaging).

## New CFR Entries
- CFR-023 (MAJOR): Episode packaging absent
- CFR-024 (MAJOR): NeuralOS attribution omitted from paper Section 3.2.1
- CFR-025 (MODERATE): OSWorld task instructions uncited
