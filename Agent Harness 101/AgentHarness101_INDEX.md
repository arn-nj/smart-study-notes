# AgentHarness101 — Topic Index

> Quick-navigation index for all pages, concepts, and review items.

## Table of Contents
| # | Page Title | Difficulty | Topics Covered |
|---|---|---|---|
| 2 | From Prompt Engineering to Context Engineering | Easy | Prompt engineering, Context engineering, Context window |
| 3 | Tool Calling, MCP, and RAG as Context Controls | Medium | Tool calling, MCP-style integration, RAG |
| 4 | The Summarization Trap in Long-Running Tasks | Hard | Context summarization, False completion signal, Execution drift |
| 5 | Harness Engineering as a Controlled Iteration Loop | Medium | Agent harness, Iteration reset, Task decomposition |
| 6 | How Prompt, Context, and Harness Layers Fit Together | Medium | Prompt layer, Context layer, Harness layer |
| 7 | From Cloud Agents to Autonomous Production Cycles | Medium | Cloud agent, Artifact output, Recurring automation |

## All Key Concepts (A–Z)
- **Agent harness** — The orchestration environment controlling how an agent starts, works, verifies, and stops. *(Page 5)*
- **Artifact output** — Deliverable result such as a pull request or status message. *(Page 7)*
- **Cloud agent** — Agent run that continues outside the local developer machine. *(Page 7)*
- **Context engineering** — Selection of the right working set for the current step. *(Page 2)*
- **Context layer** — Operational layer that provides the current working information and tools. *(Page 6)*
- **Context summarization** — Compression of prior task state to fit within a limited window. *(Page 4)*
- **Context window** — The bounded memory budget available to one model call. *(Page 2)*
- **Execution drift** — Loss of alignment between current behavior and original task intent. *(Page 4)*
- **False completion signal** — Mistaken belief that a step was fully done or verified. *(Page 4)*
- **Harness layer** — Lifecycle layer that sequences planning, execution, testing, and stopping. *(Page 6)*
- **Iteration reset** — A fresh prompt and context at the start of each bounded loop. *(Page 5)*
- **MCP-style integration** — Structured external capability surface added around the model. *(Page 3)*
- **Prompt engineering** — Instruction design for the model role and behavior. *(Page 2)*
- **Prompt layer** — Instructional layer that tells the model who it is and how it should behave. *(Page 6)*
- **RAG** — Retrieval-augmented generation from external knowledge stores. *(Page 3)*
- **Recurring automation** — Scheduled reruns that keep a system updated without manual prompting. *(Page 7)*
- **Task decomposition** — Breaking a large goal into independently verifiable units. *(Page 5)*
- **Tool calling** — Model-triggered use of external actions or repo inspection commands. *(Page 3)*

## Flashcard Export
Use `AgentHarness101_Flashcards.csv` as the canonical active-recall source.
- Total cards: 24
- Tag groups: density-layer:2, density-layer:1, definition/purpose, sequence/order, application/scenario, comparison/trade-off, section:origins, lesson:prompt-to-context

## Quick-Find by Topic
### Foundations
- Page 2: From Prompt Engineering to Context Engineering — Prompt engineering
- Page 3: Tool Calling, MCP, and RAG as Context Controls — Tool calling
### Reliability Patterns
- Page 4: The Summarization Trap in Long-Running Tasks — Context summarization
- Page 5: Harness Engineering as a Controlled Iteration Loop — Agent harness
### System Layering & Production
- Page 6: How Prompt, Context, and Harness Layers Fit Together — Prompt layer
- Page 7: From Cloud Agents to Autonomous Production Cycles — Cloud agent
