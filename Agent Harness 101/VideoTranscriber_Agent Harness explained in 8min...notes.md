# Agent Harness Explained (8 min) — Notes

## Core idea
**Harness engineering** = designing the environment/orchestration around an agent so it can complete longer, complex tasks reliably.

It builds on (does not replace):
- **Prompt engineering** (agent role, behavior, constraints)
- **Context engineering** (tool use, retrieval, context loading/summarization)

---

## Why harnessing emerged
Early LLMs had very small context windows (~4k tokens), so one-shot prompting was limited.

To scale, builders introduced context-engineering techniques:
- **Tool calling** (load only relevant files/actions)
- **MCP-like integrations** (model/vendor capabilities)
- **RAG** (on-demand access to external knowledge)

This improved outcomes, but long-running tasks still failed due to:
- partial implementations
- untested features
- incorrect assumptions after context summarization
- drift over long durations (e.g., 12-hour tasks)

---

## Main limitation of pure context engineering
When context fills up, agents summarize and continue.

If summaries are lossy, agents can:
- think incomplete work is done
- skip edge cases
- lose critical details

So “long-task capability” was often brittle.

---

## What harness engineering changes
Harnessing introduces a **looped execution model** with stricter process control:
1. Create a high-level requirements/spec document
2. Break into smaller tasks (often structured data like JSON)
3. Iterate task-by-task in a loop
4. For each loop: fresh prompt/context, execute, test, document
5. Repeat until all tasks complete

### Key benefit
Each iteration starts with a clean working set, reducing context drift and improving completion reliability.

---

## Relationship between the 3 layers
- **Prompt engineering:** identity/persona/rules
- **Context engineering:** retrieving and managing relevant info/tools
- **Harness engineering:** orchestrating iterative execution lifecycle

Harness engineering **leverages both** prompt + context engineering as components.

---

## Architectural trend highlighted
The video points out that effective harness systems are often:
- surprisingly lightweight
- loop-centric
- orchestration-first

Also mentions:
- hierarchical/sub-agent patterns
- swarm/multi-agent patterns
- cloud/background agents + integrations (e.g., PR automation, Slack triggers)

---

## Practical takeaway
For complex tasks, don’t rely on one-shot prompts or unbounded agent runs.
Use a harness with:
- explicit planning artifacts
- bounded iterative loops
- per-iteration verification/testing
- progress documentation
- clear completion criteria

That process is the difference between “impressive demos” and reliable autonomous execution.
