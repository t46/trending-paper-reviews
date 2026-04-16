# Reference Paper 10: SeeAct — GPT-4V(ision) is a Generalist Web Agent, if Grounded

## Reading Documentation

- **Paper URL**: https://arxiv.org/abs/2401.01614
- **Full Text Access**: Partial — WebFetch returned structured summary covering method, experiments, and results
- **Sections Read**:
  - [x] Abstract
  - [x] Method overview (visual understanding + action grounding pipeline)
  - [x] Experimental setup (Mind2Web, baselines, evaluation settings)
  - [x] Key quantitative results (task completion rates)
  - [x] Limitations section
  - [ ] Full technical details
- **Reading Notes**: WebFetch returned good coverage of the key comparison points

## Research Problem

- **Problem addressed**: Can large multimodal models (GPT-4V) serve as generalist web agents if given appropriate action grounding mechanisms?
- **Source**: Abstract, introduction
- **Problem scope**: Medium-narrow — web agent (subset of computer use)
- **Gap**: Prior web agents rely on HTML input (noisy, token-inefficient); LMM visual capabilities underutilized for web interaction

## Methodological Approach

- **Core technique**: Two-stage pipeline: (1) GPT-4V analyzes webpage screenshot → textual action description; (2) Convert description to executable browser event via three grounding strategies (element attribute matching, textual choices from candidates, image annotation with bounding boxes)
- **Source**: Method section (from WebFetch)
- **Innovation type**: Novel multi-strategy grounding pipeline for visual LLM-based web agents
- **Key insights**: Grounding (not visual understanding) is the primary bottleneck for web agent performance; oracle grounding reveals GPT-4V's true task understanding capability (51.1% success)

## Experimental Design

- **Datasets**: Mind2Web (2000+ complex web tasks across 137 websites); online live website evaluation
- **Baselines**: FLAN-T5-XL, BLIP-2-T5, GPT-3.5, GPT-4 (text-only), CogAgent
- **Key quantitative results**:
  - Oracle grounding: 51.1% whole task success (live websites)
  - Textual choices grounding: 37.8% success
  - GPT-4 (text-only): 13.3% success
  - FLAN-T5: 8.9% success
- **Experimental scale**: 137 websites, 2000+ tasks, online + offline evaluation; multiple grounding strategies

## Relevance to NC Paper

- **Problem overlap**: Medium — web agent (browser interaction on real web) vs. NC (OS/GUI simulation); both concern computer use but at different levels
- **Method similarity**: Very low — LLM + grounding pipeline vs. video diffusion model
- **NC citation status**: NOT cited by NC paper; selected as paradigm contrast paper

- **Key insight for NC comparison**:

  SeeAct establishes the state-of-the-art for the agent paradigm in computer interaction: 51.1% task success with oracle grounding on live websites. This is the best available reference for what the "competing paradigm" (agents operating on real environments) achieves.

  1. **Agent vs. simulation paradigm**: NC frames itself as going "beyond agents" to a simulation approach. But NC_GUIWorld has no demonstration of supporting a use case that agents cannot support — it is unclear whether NC's simulation paradigm offers practical advantages over SeeAct-style agents for any task class.

  2. **What 51.1% means**: With the best possible grounding (oracle), the best agent paradigm achieves 51.1% web task success. NC_GUIWorld's open-loop evaluation does not produce a comparable task success metric, making paradigm comparison impossible.

  3. **NC's potential advantage over agents**: NC_GUIWorld could theoretically enable: (a) training agents without requiring real OS interactions (cheaper, safer, faster iteration); (b) studying agent behavior in controlled simulation; (c) parallel simulation at scale. None of these advantages are demonstrated in the NC paper.

  4. **NC_CLIGen as complement to SeeAct**: For CLI tasks (terminal interaction), NC_CLIGen simulates the terminal at 26.89 dB PSNR with 54% character accuracy. Agents like SeeAct operate on web; a CLI simulation could complement them for development tasks. This complementarity is not discussed in the NC paper.

- **SeeAct grounding bottleneck relevance**: SeeAct identifies grounding as the primary bottleneck (gap between oracle 51.1% and best grounding 37.8%). NC_GUIWorld simulates the visual environment — if NC simulation quality is sufficient for agent training, it could help train better grounding models by providing diverse simulated training scenarios. This potential is entirely unexplored in the NC paper.

## Comparison Readiness

- **Sufficient for comparison**: Yes — sufficient for paradigm contrast comparison; limited for technical method comparison (entirely different approach)
