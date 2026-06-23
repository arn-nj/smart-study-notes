# Visual Decision Guide

A fast cheat sheet for deciding:
1. **what kind of visual problem** you have
2. **which formal framework** fits it
3. **which semantic scene family** teaches it well
4. **which tool** to use

---

# 1) The 10-second decision flow

## Ask these in order

### A. What is the main question?
- **What exists?** → structure
- **What happens over time?** → interaction/process
- **What changes state?** → lifecycle/state
- **What gets filtered/routed?** → filtering/routing
- **What choice changes behavior?** → decision/tradeoff
- **What is layered or hierarchical?** → layered control
- **What does the user see vs backstage systems do?** → service experience
- **What is strategic / differentiating / commoditized?** → strategy/evolution
- **What is hard to explain abstractly and needs a metaphor?** → teaching metaphor

### B. Do I need precision or memorability first?
- **precision first** → formal diagram
- **memorability first** → semantic sketch
- **both** → make a formal companion + learner sketch

### C. Who is the audience?
- engineers / architects → formal view often needed
- learners / stakeholders → semantic sketch often stronger
- mixed audience → use both

---

# 2) Intent → framework → scene family → tool

| Intent | Best formal framework | Best semantic scene family | Easiest tool |
|---|---|---|---|
| Structure | C4, UML component, ArchiMate | `machine-room-hub` | Structurizr / diagrams.net / Excalidraw |
| Interaction over time | Sequence diagram | `dispatch-control-room`, `relay-loop-track` | Mermaid / PlantUML / Excalidraw |
| Workflow / process | BPMN, activity diagram | `qa-lane`, `repair-routing-workshop`, `cargo-screening-line` | Mermaid / diagrams.net / Excalidraw |
| State / lifecycle | State diagram | `mission-control-board`, `compression-press-checklist` | Mermaid / PlantUML / Excalidraw |
| Filtering / routing | Flowchart, BPMN | `cargo-screening-line`, `sorting-desk`, `security-gate-checkpoint` | Excalidraw / Mermaid |
| Decision / tradeoff | Decision matrix, Wardley (sometimes) | `control-room-levers`, comparison board | Excalidraw / diagrams.net |
| Layered control | C4 conceptual stack, layered architecture | `layered-theater-stack` | Excalidraw / diagrams.net |
| Service experience | Service blueprint | service-oriented custom scene | diagrams.net / Miro / Excalidraw |
| Strategy / evolution | Wardley map | scaffold / strategy-board metaphors | Wardley tools / Excalidraw |
| Teaching metaphor | custom-semantic-sketch | scene-family driven | Excalidraw |

---

# 3) When to use which formal framework

## C4
Use when the question is:
- what systems/containers/components exist?
- how are they related structurally?

Good for:
- software architecture
- container boundaries
- context diagrams

Bad for:
- teaching nuanced mechanisms by itself

---

## Sequence
Use when the question is:
- who talks to whom, in what order?

Good for:
- API/tool/model interactions
- agent/tool/database flow

Bad for:
- static architecture
- strategic tradeoffs

---

## BPMN / Activity
Use when the question is:
- what process happens?
- where are branches, gateways, retries, approvals?

Good for:
- harness loops
- review/approval flows
- operational workflows

Bad for:
- metaphor-first memory visuals

---

## State diagram
Use when the question is:
- what states exist and how do transitions happen?

Good for:
- retry lifecycle
- execution status
- persistence / recovery states

Bad for:
- structural decomposition

---

## ArchiMate
Use when the question is:
- how do business, application, and technology layers relate?

Good for:
- enterprise architecture
- transformation roadmaps

Bad for:
- quick learner-facing sketches

---

## Wardley Map
Use when the question is:
- where is value created?
- what is differentiating vs commoditized?
- what is evolving?

Good for:
- strategic technology decisions
- platform vs product thinking

Bad for:
- low-level workflows

---

## Service Blueprint
Use when the question is:
- what does the user experience depend on backstage systems/processes?

Good for:
- support workflows
- service operations
- cross-functional service delivery

Bad for:
- detailed software internals

---

# 4) When to use which semantic scene family

## `machine-room-hub`
Use for:
- central system + support subsystems
- harness definition
- core plus peripherals

Think:
- one engine, surrounding support systems, output path

---

## `layered-theater-stack`
Use for:
- layered control
- stacked orchestration
- prompt/context/harness style concepts

Think:
- booth → deck → stage

---

## `cargo-screening-line`
Use for:
- filtering
- context management
- bounded capacity
- selection vs discard

Think:
- intake → gate → accepted carrier, rejected pile

---

## `qa-lane`
Use for:
- verification
- testing
- pass/fail
- rework loops

Think:
- work item → stations → pass tray / rework chute

---

## `dispatch-control-room`
Use for:
- capability routing
- tool selection
- targeted retrieval
- MCP / RAG style branching

Think:
- request hub → specialized stations → filtered return

---

## `archive-tier-stack`
Use for:
- memory hierarchy
- cache / shelf / archive distinctions

Think:
- desk notes → index → shelves → archive

---

## `sorting-desk`
Use for:
- classification
- output parsing
- handoff vs answer vs action request

Think:
- incoming item → sorter → destination trays

---

## `repair-routing-workshop`
Use for:
- error handling
- retries vs escalation vs approval

Think:
- broken item → classify → different repair paths

---

## `specialist-office`
Use for:
- subagent orchestration
- delegation with control

Think:
- manager desk → specialist rooms → summary return

---

## `mission-control-board`
Use for:
- state persistence
- checkpointing
- recovery/resume

Think:
- tracked board → checkpoint → resume lane

---

## `compression-press-checklist`
Use for:
- summarization loss
- compression drift
- false completion

Think:
- large checklist → press → tiny summary + missing scraps

---

## `control-room-levers`
Use for:
- decision-driven behavior changes
- architectural choice consequences

Think:
- lever bank → changed machine behavior → gauges / output lane

---

# 5) Tool guide: easiest by job

## Excalidraw
Use when you want:
- hand-drawn look
- fast conceptual sketching
- learner-facing semantic visuals
- metaphor scenes

Best for:
- the current `content-to-sketch` pipeline

---

## Mermaid
Use when you want:
- quick diagrams in markdown/docs
- sequence/flow/state basics
- version control friendliness

Best for:
- docs-as-code
- lightweight formal diagrams

---

## D2
Use when you want:
- diagrams-as-code with more design flexibility than Mermaid
- architecture diagrams in repos

---

## Structurizr
Use when you want:
- proper C4 model consistency
- one model → many views
- software architecture rigor

---

## diagrams.net
Use when you want:
- polished structured manual diagrams
- stencils and formal enterprise visuals

---

## Miro / FigJam
Use when you want:
- workshop collaboration
- brainstorming with people live

---

# 6) Use both when the topic is important

For high-value concepts, make two visuals:

## Formal companion
Examples:
- C4
- sequence
- BPMN
- state diagram
- Wardley map

## Teaching sketch
Examples:
- machine room
- screening line
- QA lane
- theater stack
- specialist office

This is the best answer when you need both:
- precision
- memorability

---

# 7) Fast heuristics

## If the concept has a bottleneck
Use:
- `cargo-screening-line`
- or `dispatch-control-room`

## If the concept has pass/fail + retry
Use:
- `qa-lane`
- or BPMN formally

## If the concept has stacked responsibilities
Use:
- `layered-theater-stack`
- or layered architecture formally

## If the concept has one core and support modules
Use:
- `machine-room-hub`
- or C4/container/component formally

## If the concept is about choosing among capabilities
Use:
- `dispatch-control-room`
- with a sequence diagram companion if exact order matters

## If the concept is about state persistence/recovery
Use:
- `mission-control-board`
- with a state diagram companion

## If the concept is about a strategic technology choice
Use:
- Wardley map first
- semantic sketch second only if you need explanation help

---

# 8) What the current skill is best at

The current skill is best at:
- **semantic learner-facing sketch generation**
- **metaphor-first concept explanation**
- **Excalidraw-based whiteboard visuals**

It is not yet best at:
- fully automatic formal framework selection
- universal formal architecture modeling
- arbitrary context → perfect invented scene with no curation

So for now:

## Best workflow
1. classify intent
2. choose formal framework
3. choose scene family
4. use Excalidraw for learner-facing sketch
5. optionally pair with a formal companion

---

# 9) Mini examples

## Example: Tool calling / MCP / RAG
- intent: `filtering-routing`
- formal framework: `sequence`
- semantic scene: `dispatch-control-room`
- tool: Excalidraw for sketch, Mermaid/PlantUML for formal sequence

## Example: Harness loop
- intent: `workflow-process`
- formal framework: `bpmn`
- semantic scene: `qa-lane`
- tool: Excalidraw for sketch, Mermaid/diagrams.net for formal flow

## Example: Prompt / context / harness
- intent: `layered-control`
- formal framework: `c4` conceptual stack or layered architecture
- semantic scene: `layered-theater-stack`
- tool: Excalidraw for sketch

## Example: Summarization trap
- intent: `teaching-metaphor`
- formal framework: `state-diagram` or flowchart companion
- semantic scene: `compression-press-checklist`
- tool: Excalidraw

## Example: Context management
- intent: `filtering-routing`
- formal framework: `flowchart`
- semantic scene: `cargo-screening-line`
- tool: Excalidraw

---

# 10) Personal rule of thumb

If you are stuck, ask:

> Am I trying to show **what exists**, **what happens**, **what changes**, **what gets filtered**, or **what choice matters**?

Then choose:
- formal framework for correctness
- semantic scene family for understanding

That is the fastest path to good diagram choices.
