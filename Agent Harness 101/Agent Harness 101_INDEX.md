# Agent Harness 101 — Topic Index

> Quick-navigation index for all pages, concepts, and review items.

## Table of Contents
| # | Page Title | Difficulty | Topics Covered |
|---|---|---|---|
| 1 | Why Agent Harnessing Appeared | Easy | prompt limits, context window, context engineering |
| 2 | Context Engineering Wins and Limits | Medium | tool calling, MCP-style integration, RAG |
| 3 | The Summarization Trap in Long Tasks | Hard | context summarization, false completion, execution debt |
| 4 | Harness Engineering = Controlled Iteration Loop | Medium | requirements artifact, task decomposition, iteration reset |
| 5 | Layer Model — Prompt, Context, Harness | Easy | orchestration layer, guardrails, completion criteria |
| 6 | Practical Blueprint for Reliable Agent Delivery | Medium | cloud agents, approval workflow, autonomous maintenance |

## All Key Concepts (A–Z)
- **Agent Harness** — orchestration environment that controls how autonomous work starts, validates, and finishes. *(Page 4)*
- **Autonomous Maintenance Loop** — scheduled or event-driven workflow that keeps systems updated continuously. *(Page 6)*
- **Cloud Agent** — remote-running agent that continues work independent of local machine state. *(Page 6)*
- **Completion Criteria** — explicit pass/fail conditions that define a true done state. *(Page 5)*
- **Context Engineering** — process for selecting and supplying relevant information for each step. *(Page 1)*
- **Context Summarization** — compression of prior state to stay within token limits during long runs. *(Page 3)*
- **Context Window** — temporary token-limited memory for a model interaction. *(Page 1)*
- **Dependency Drift** — progressive misalignment across related components during extended execution. *(Page 2)*
- **Execution Debt** — hidden unfinished work accumulated when loops continue without full verification. *(Page 3)*
- **False Completion Signal** — mistaken belief that work is complete despite missing verification evidence. *(Page 3)*
- **Guardrails** — constraints that prevent unsafe or low-quality agent decisions. *(Page 5)*
- **Human-in-the-Loop Approval** — governance checkpoint where a person approves high-impact automated changes. *(Page 6)*
- **Iteration Reset** — fresh prompt and context applied at each loop cycle. *(Page 4)*
- **Orchestration Layer** — control plane that sequences tasks and enforces closure checks. *(Page 5)*
- **Prompt Engineering** — design of agent role, behavior, and instruction framing. *(Page 1)*
- **RAG** — retrieval-augmented generation from external knowledge sources. *(Page 2)*
- **Task Decomposition** — splitting large goals into independently testable work units. *(Page 4)*
- **Tool Calling** — model-invoked execution of external functions and file operations. *(Page 2)*

## All Flashcard Questions
| Q | A | Page |
|---|---|---:|
| Why did prompt-only workflows break on larger tasks? | They lacked enough memory and process control for long execution. | 1 |
| What changed after prompt engineering? | Teams introduced context engineering to feed only relevant information. | 1 |
| What problem did tool calling solve first? | It reduced irrelevant context by reading only necessary files. | 2 |
| Why can long runs still fail with strong context engineering? | Execution drifts over time and verification is often incomplete. | 2 |
| What is the main risk of aggressive summarization? | It drops critical details and causes incorrect completion assumptions. | 3 |
| Why is this hard to spot early? | Output may appear complete while deeper behavior remains untested. | 3 |
| What is the signature difference in harnessing? | Strict iterative orchestration with test-and-document loops. | 4 |
| Why does fresh context per iteration help? | It limits drift and keeps each step bounded and verifiable. | 4 |
| Does harness engineering deprecate prompt engineering? | No, it depends on prompt and context as supporting layers. | 5 |
| Which layer decides task loop and closure logic? | The harness/orchestration layer. | 5 |
| What turns a cool demo into a reliable workflow? | Bounded loops, test gates, and explicit completion controls. | 6 |
| Why add human approval before merge? | It preserves governance while keeping automation speed. | 6 |

## Quick-Find by Topic
### Foundations and Evolution
- Page 1: Why Agent Harnessing Appeared — transition from prompt-only to context-aware workflows
- Page 2: Context Engineering Wins and Limits — why early techniques improved but did not complete the picture

### Reliability and Failure Modes
- Page 2: Context Engineering Wins and Limits — long-duration drift risks
- Page 3: The Summarization Trap in Long Tasks — memory compression and false completion

### Harness Architecture
- Page 4: Harness Engineering = Controlled Iteration Loop — iterative execution model and closure logic
- Page 5: Layer Model — Prompt, Context, Harness — responsibilities across three engineering layers

### Production Operations
- Page 6: Practical Blueprint for Reliable Agent Delivery — cloud agents, PR workflow, and scheduled automation
