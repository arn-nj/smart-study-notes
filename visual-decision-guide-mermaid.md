# Mermaid Visual Decision Guide

Use this guide when choosing a Mermaid diagram for architecture, application, and data documentation.

## Default rule

- **`flowchart`** = structure, components, capabilities, data flows, interfaces
- **`sequenceDiagram`** = runtime interactions, API calls, event flow
- **`erDiagram`** = data model, tables, entity relationships
- **`stateDiagram-v2`** = lifecycle, workflow states, transitions
- **`classDiagram`** = contracts, DTOs, interfaces, type relationships
- **`gantt`** = rollout plans, migrations, delivery timelines

## Quick chooser

| If you need to show... | Use this Mermaid diagram | Best for |
|---|---|---|
| System structure, boundaries, capabilities | `flowchart` | architecture context, components, app layout |
| Who talks to whom, and in what order | `sequenceDiagram` | APIs, sync/async calls, event choreography |
| Data entities and relationships | `erDiagram` | domain model, database design |
| State changes over time | `stateDiagram-v2` | approval flows, session state, order lifecycle |
| API/interface/type structure | `classDiagram` | services, contracts, DTOs |
| Project phases or migration steps | `gantt` | delivery plans, cutovers |
| Hierarchy of ideas or capabilities | `mindmap` | capability maps, topic breakdowns |

## Decision tree

```mermaid
flowchart TD
  A([Need a diagram]) --> B{What is the main question?}

  B -->|What is it made of?| C[Use flowchart]
  B -->|Who talks to whom, and when?| D[Use sequenceDiagram]
  B -->|What data exists and how does it relate?| E[Use erDiagram]
  B -->|How does it change state?| F[Use stateDiagram-v2]
  B -->|What are the contracts or types?| G[Use classDiagram]
  B -->|What happens over time in a project?| H[Use gantt]
  B -->|How is capability hierarchy organized?| I[Use mindmap]

  C --> C1[Default to flowchart LR]
  C1 --> C2[Use subgraph for boundaries]
  C1 --> C3[Label arrows with verbs: reads, writes, calls, publishes]

  D --> D1[Use when order matters]
  D1 --> D2[Show actors, messages, and responses]

  E --> E1[Use for domain or data modeling]
  E1 --> E2[Keep it about persistent data only]

  F --> F1[Use for lifecycle and transitions]
  F1 --> F2[Keep states mutually exclusive]

  G --> G1[Use for interfaces, DTOs, inheritance]
  G1 --> G2[Use sparingly in architecture docs]
```

## Practical architecture guidance

- Use **one diagram per question**.
- Prefer **`flowchart LR`** as the default backbone for architecture docs.
- Add `sequenceDiagram` only when timing or ordering matters.
- Keep labels verb-focused: `calls`, `reads`, `writes`, `publishes`, `authenticates`.
- Use `subgraph` to show trust boundaries, domains, or deployment zones.
- Avoid mixing data model and runtime flow in the same diagram.

