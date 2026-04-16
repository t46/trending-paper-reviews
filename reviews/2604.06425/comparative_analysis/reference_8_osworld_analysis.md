# Reference Paper 8: OSWorld — Benchmarking Multimodal Agents for Open-Ended Tasks in Real Computer Environments

## Reading Documentation

- **Paper URL**: https://arxiv.org/abs/2404.07972
- **Full Text Access**: Partial — Abstract and key facts from arXiv metadata and literature_candidates.md; HTML returned 404 in Phase-5-2 fetch attempt
- **Sections Read**:
  - [x] Abstract (from arXiv)
  - [x] Key contributions (from reference_papers.md)
  - [ ] Full method section (not accessible via HTML)
  - [ ] Full results section (not accessible via HTML)
- **Reading Notes**: HTML fetch returned 404. Characterization based on abstract and Phase-5-1 summary. Comparison limited to benchmark-level information.

## Research Problem

- **Problem addressed**: Creating a comprehensive, scalable benchmark for evaluating multimodal agents on open-ended computer tasks across real OS environments (Ubuntu, Windows, macOS)
- **Source**: Abstract
- **Problem scope**: Medium — benchmark for computer-use agent evaluation; not a world model system
- **Motivation**: Existing benchmarks are too narrow (single app, toy tasks); need real-world complexity with multi-app workflows
- **Gap identified**: No comprehensive benchmark exists for open-ended real computer use by AI agents

## Methodological Approach

- **Core technique**: Benchmark contribution — 369 hand-annotated tasks across Ubuntu/Windows/macOS; automated evaluation using OS state checking (not just screenshot comparison)
- **Innovation type**: Benchmark/evaluation infrastructure
- **Technical complexity**: Low (benchmark) — complexity is in task curation and evaluation automation

## Experimental Design

- **Datasets**: 369 tasks across Ubuntu, Windows, macOS; real desktop + web + multi-app workflows
- **Baselines**: Multiple LLM and VLM agents (GPT-4V, Claude, GPT-4, FLAN-T5, BLIP-2, others)
- **Key quantitative results**: 72.36% human performance; best AI agent ~12.24% at time of publication
- **Experimental scale**: Large — 369 tasks, 3 OS environments, multiple agent baselines, human ceiling study

## Relevance to NC Paper

- **Problem overlap**: Medium-High (indirect) — OSWorld defines the computer-use evaluation landscape; NC_GUIWorld's training data (Claude CUA trajectories) comes from agents operating in OSWorld-like environments
- **Method similarity**: None — OSWorld is a benchmark, not a world model
- **NC citation status**: NOT cited by NC paper; should be cited as the standard for computer-use evaluation
- **Key insight for NC comparison**:

  OSWorld establishes that real computer use on Ubuntu requires 369 diverse tasks across categories: web browsing, office productivity, file management, development tools, multi-app workflows. NC_GUIWorld trains on 8 fixed applications (Firefox, GIMP, VLC, VS Code, Calculator, Terminal, File Manager, Mahjongg) and is evaluated within those apps only. This means:

  1. NC_GUIWorld covers approximately 3 of OSWorld's major task categories (web/Firefox, productivity/VS Code, system/Terminal + File Manager) and omits others (e.g., office suite tasks, cross-app data transfer, system configuration)
  2. NC_GUIWorld has never been evaluated on OSWorld's standardized task set — it is unknown whether the simulation supports the action types and app states needed to complete OSWorld tasks
  3. The claim that NC_GUIWorld could serve as a training environment for computer-use agents (one of the practical motivations cited in the NC paper) would need to be validated against OSWorld's task coverage

- **The 12.24% AI vs. 72.36% human gap on OSWorld**: This gap exists in the real environment. NC_GUIWorld simulates a subset of that environment — whether NC's simulation quality is sufficient to train agents that can improve on OSWorld is completely untested.

## Comparison Readiness

- **Sufficient for technical comparison**: Partial — full text not accessible; benchmark-level information is sufficient for evaluation context comparison
- **If Partial, reason**: HTML not accessible; key metric (task coverage mapping to NC_GUIWorld apps) requires full task list access
