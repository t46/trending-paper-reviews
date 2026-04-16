# Problem Analysis: Neural Computers (arXiv:2604.06425)

## Research Problem Statement

The paper poses: "Can a single set of weights act as a 'computer'?" Formalized as: a Neural Computer (NC) unifies computation, memory, and I/O inside a single learned latent runtime state. Tractable first-step: "whether early NC primitives can be learned solely from collected I/O traces, without instrumented program state."

**Formal model (Eq. 2.1)**: h_t = F_theta(h_{t-1}, x_t, u_t), x_{t+1} ~ G_theta(h_t)

## Problem Scope

**Prototype scope**: Can video models learn early runtime primitives (I/O alignment, short-horizon control) from interface I/O traces in CLI and GUI environments?

**Long-term vision (CNC)**: Four formal requirements — Turing completeness, universal programmability, behavior consistency, and realization of architectural/programming-language advantages.

**Scope limitations**: Screen-based interfaces only; Wan2.1 backbone only; open-loop evaluation; controlled environments only.

## Motivation

1. **Fragmentation argument**: Computation, memory, I/O currently reside in separate system objects — an architectural accident, not fundamental necessity.
2. **Data-asymmetry argument**: Paired user I/O traces far more abundant than high-quality code.
3. **Timeliness**: Video models now capable enough to serve as credible substrates.

## Gap Analysis

**Prior work and gaps**:
- NTM/DNC: External memory, but runtime lives outside model
- World models: Predict dynamics but executable state resides outside model
- AI agents: Preserve strict separation between learned model and execution runtime
- NeuralOS/Imagine with Claude: Acknowledged but not deeply differentiated

**Gap claimed**: No prior work has asked whether a neural system can *become* the computer itself — not predict it, not interface with it.

**Concern**: Related Work is ~1 page embedded in Preliminaries — insufficient depth for paradigm-level claims.

## Problem Clarity

- Formal model: Clear (Eq. 2.1)
- NC vs CNC distinction: Well-maintained
- Success criteria: Quantitative for prototypes; formal 4-condition definition for CNC
- **Weakness**: "Being the running computer" remains partly metaphorical even after formal definition

## Problem Significance

- **Novelty**: High — NC abstraction distinct from NTM/DNC, world models, agents
- **Difficulty**: Moderate at prototype level; high at CNC level
- **Impact**: Potentially significant — alternative computing substrate
- **Timeliness**: Very high (April 2026 timing aligns with video model capabilities and agent debates)

## Two-Layer Analysis

### Current State
Problem is novel, clearly defined, well-motivated, and timely. Gap between NCs and prior work is genuine but Related Work section too brief to fully substantiate bold paradigm claims. Distinction from NeuralOS particularly underexplored.

### Development Directions
1. Formal separation from world models (computational criterion needed)
2. Problem scope in multi-modal environments
3. Sharper intermediate benchmarks on path to CNC
4. NeuralOS / Imagine with Claude comparison needs deepening

## Critical Assessment

- Problem worth solving: Yes
- Problem formulation appropriate: Mostly — defines NC by what it does rather than what it is
- **Problem weakness**: Thin Related Work relative to paradigm claim boldness

## CFR Findings

**HIGH-001: Related Work Insufficient for Paradigm-Level Claims**
- Severity: HIGH
- Impact: Central paradigm claim weakened without thorough differentiation from NeuralOS and interactive world models
