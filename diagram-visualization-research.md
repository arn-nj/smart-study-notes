# Diagram Visualization Research and Evaluation

## Purpose
This document answers five practical questions:

1. **How do I know what diagram to draw for a given context?**
2. **What frameworks help choose the right visual?**
3. **What tools are easiest to use?**
4. **What is the current `content-to-sketch` skill actually doing today?**
5. **What should be improved if the goal is truly semantic, learner-facing sketches rather than boxes and arrows?**

---

# Executive Summary

## Short answer
If you struggle with "what diagram should I draw?", the best approach is **not** to start with tools.

Start with a **three-layer decision model**:

1. **What kind of question am I answering?**
   - structure?
   - flow over time?
   - decision/tradeoff?
   - filtering?
   - hierarchy?
   - failure/recovery?
   - state?

2. **Which visual framework matches that question?**
   - C4 for software architecture structure
   - sequence/activity/BPMN for process and interaction flow
   - state diagrams for lifecycle/state change
   - Wardley maps for strategic evolution/commodity vs differentiator
   - service blueprints for frontstage/backstage service delivery
   - custom semantic scene families for metaphor-first teaching visuals

3. **Which tool best fits the output style?**
   - Excalidraw or tldraw for sketch-like conceptual thinking
   - Mermaid / D2 / PlantUML / Structurizr for diagrams-as-code
   - diagrams.net for structured manual diagrams
   - hybrid approach for high-value work: **formal view + sketch view**

## My bottom-line recommendation
For your use case, the best system is a **hybrid framework**:

- **formal architecture view** when precision matters
- **semantic sketch view** when explanation, recall, and pedagogy matter

That means:
- use **C4 / sequence / BPMN / Wardley / service blueprint** to decide the *kind* of diagram
- use **Excalidraw** to create the final learner-facing sketch
- use a custom **scene-family + premium-sketch** layer to turn abstract concepts into physical-world metaphors

## Assessment of the current skill
The current skill is now **much stronger than before**, but it is still not a fully general "diagram invention engine".

### What it does well now
- chooses scene families
- enforces hot path visibility
- avoids generic text grids
- uses Excalidraw as the sketch medium
- adds object palettes, shape quotas, forbidden geometry, and premium sketch cues
- supports arrow routing and occlusion hygiene
- can produce learner-facing scenes that are more memorable than formal architecture diagrams

### What it does **not** fully do yet
- it does **not** automatically choose among formal frameworks like C4, BPMN, ArchiMate, Wardley, etc.
- it does **not** yet have a fully general renderer that can invent rich object silhouettes for any arbitrary concept from first principles
- it still depends on curated scene families and brief quality
- it is better at **metaphor-first conceptual teaching diagrams** than at **industry-standard modeling**

So the current skill is best described as:

> a strong custom Excalidraw-based semantic-sketch pipeline,
> not yet a universal diagram framework engine.

---

# Part 1 — How to know what diagram to draw

The biggest mistake is asking:

> "What picture should I draw?"

Instead ask:

> "What kind of meaning am I trying to reveal?"

That gives you the diagram family.

## A practical decision tree

### 1. Is the problem mainly about **system structure**?
Use:
- **C4**
- **component diagrams**
- **deployment diagrams**
- **ArchiMate** at enterprise scope

Examples:
- what services exist?
- what is inside the system?
- how do subsystems relate?
- where is this deployed?

### 2. Is the problem mainly about **interaction over time**?
Use:
- **sequence diagrams**
- **activity diagrams**
- **BPMN**
- **workflow diagrams**

Examples:
- what happens first/next/last?
- how do user, agent, tool, and database interact?
- where does retry happen?

### 3. Is the problem mainly about **state or lifecycle**?
Use:
- **state machine diagrams**
- **transition diagrams**

Examples:
- draft → pending → verified → published
- queued → running → failed → retried → done

### 4. Is the problem mainly about **filtering, triage, or routing**?
Use:
- flowchart / BPMN if formal
- semantic metaphor scene if teaching-oriented

Examples:
- context filtering
- safety checks
- permission gates
- output parsing

### 5. Is the problem mainly about **tradeoffs or strategic position**?
Use:
- **Wardley maps**
- **decision matrices**
- **comparison boards**

Examples:
- build vs buy
- differentiator vs commodity
- product decisions with consequences

### 6. Is the problem mainly about **service delivery across people/process/props**?
Use:
- **service blueprint**
- **journey map**

Examples:
- frontstage/backstage experience
- customer touchpoint to operational support flow

### 7. Is the problem mainly about **teaching an abstract mechanism**?
Use:
- **semantic sketch / metaphor-first scene**

Examples:
- prompt/context/harness layering
- summarization trap
- verification loop
- state persistence

This is where your custom skill is strongest.

---

# Part 2 — Frameworks that help choose the right visual

## 1. C4 Model
**Best for:** software architecture structure and zoom levels.

The C4 model gives a hierarchy:
- system context
- container
- component
- code
plus supporting views like dynamic and deployment.

### Strengths
- simple
- developer-friendly
- excellent for software architecture communication
- tool-agnostic

### Weaknesses
- not a metaphorical teaching framework
- not ideal for pedagogy-heavy visuals
- not meant for sketch-world learner diagrams

### Best use
Use C4 when the core question is:
> what exists, at what level, and how does it relate structurally?

**Source:** https://c4model.com/

---

## 2. UML
**Best for:** formal software design and behavior.

Relevant diagram types include:
- class diagrams
- sequence diagrams
- activity diagrams
- state diagrams
- deployment diagrams

### Strengths
- comprehensive and standardized
- precise behavioral and structural modeling

### Weaknesses
- often overkill for conceptual explanation
- can be too formal for learners
- often poor for quick visual thinking

### Best use
Use UML when you need implementation-level or precise behavioral description.

**Sources:**
- https://www.cybermedian.com/uml-vs-other-standards-c4-archimate-and-bpmn/
- https://meta.linked.archi/docs/practice/c4-structurizr-vs-uml/

---

## 3. BPMN
**Best for:** explicit business/workflow process modeling.

### Strengths
- rigorous for process flow
- handles branching, lanes, events, gateways, exceptions
- excellent when operational process precision matters

### Weaknesses
- can feel heavy for lightweight reasoning
- not ideal for sketch-like learner explanation

### Best use
Use BPMN when the question is:
> what process happens, who does it, and where do branches/exceptions occur?

**Sources:**
- https://meta.linked.archi/docs/guide/modeling-languages-guide/
- https://www.nilus.be/blog/archimate_vs_bpmn_in_enterprise_architecture_practice/
- https://bizzdesign.com/blog/how-combine-archimater-industry-standards-better-ea

---

## 4. ArchiMate
**Best for:** enterprise architecture across business/application/technology layers.

### Strengths
- good for enterprise-wide transformation views
- cross-layer architecture reasoning
- useful for governance and traceability

### Weaknesses
- not the easiest for quick diagram invention
- not ideal for pedagogical metaphor sketches

### Best use
Use ArchiMate when the question is:
> how do business, application, data, and technology layers align?

**Sources:**
- https://meta.linked.archi/docs/guide/modeling-languages-guide/
- https://www.nilus.be/blog/archimate_vs_bpmn_in_enterprise_architecture_practice/

---

## 5. Wardley Maps
**Best for:** strategy, evolution, and value chain positioning.

Wardley maps show:
- user need
- value chain visibility
- evolution from genesis/custom-built → product → commodity

### Strengths
- excellent for strategic thinking
- explains where investment/differentiation belongs
- helpful when architecture decisions are strategic, not just structural

### Weaknesses
- not a general-purpose architecture diagram
- not a flow/process sketch

### Best use
Use Wardley maps when the question is:
> where in the value chain is this, and how evolved/commoditized is it?

**Sources:**
- https://www.wardleymaps.com/ea
- https://www.wardleymaps.com/downloads/Wardley-Maps-in-EA.pdf

---

## 6. Service Blueprint
**Best for:** service systems spanning user touchpoints and internal operations.

### Strengths
- great for frontstage/backstage relationships
- useful for operations-heavy systems and user experience flows

### Weaknesses
- not meant for low-level software architecture
- not a strong metaphor-first drawing framework

### Best use
Use service blueprints when the question is:
> what user-visible steps depend on which backstage systems/teams/processes?

**Source:** https://www.nngroup.com/articles/service-blueprinting-faq/

---

## 7. Visual Grammar / Information Design Frameworks
These are less about a named enterprise notation and more about **how to make diagrams effective**.

Important ideas from research:
- visual notation needs syntax + semantics + spatial arrangement
- position itself can carry meaning
- graphical languages need a vocabulary and grammar
- diagrams are effective when meaning is visually encoded, not only described in text

### Why this matters for your skill
This is the theoretical basis for why your objection was correct:

> if meaning is still mostly in text labels, the image is not truly semantic enough

These sources support your direction toward:
- object vocabulary
- scene grammar
- spatial semantics
- hot-path salience
- failure branch placement

**Sources:**
- https://arxiv.org/pdf/1903.05941
- http://csis.pace.edu/~ogotel/professional/RE09%20Tutorial%20-%20Designing%20Effective%20Visual%20Notations.pdf
- https://www.jbe-platform.com/content/journals/10.1075/idj.25.3.05ric
- https://yuriweb.com/engelhardt-graphic-syntax.pdf

---

# Part 3 — Tooling: what is easiest to use?

## 1. Excalidraw
**Best for:** fast conceptual sketching, whiteboard feel, hand-drawn architecture thinking.

### Strengths
- extremely low friction
- sketch-like aesthetic by default
- great for explanation, teaching, conceptual design
- editable JSON scene format
- collaborative and open source

### Weaknesses
- not ideal for strict standards compliance
- manual precision is lower than formal tools
- can drift toward improvised geometry unless guided by a strong framework

### Best use
- conceptual architecture
- educational diagrams
- semantic metaphor scenes
- whiteboard-first design thinking

### Current skill status
**Yes — the current skill uses Excalidraw as its primary rendering medium.**
It generates `.excalidraw` scenes and compiles them via browser-based export.

**Sources:**
- https://excalidraw.com/
- https://github.com/excalidraw/excalidraw/

---

## 2. tldraw
**Best for:** infinite-canvas whiteboarding and interactive diagramming.

### Strengths
- great canvas experience
- modern, fluid whiteboard interaction
- strong if you want a programmable canvas app feel

### Weaknesses
- less iconic hand-drawn look than Excalidraw
- your current skill is not built around it

### Best use
- collaborative canvas work
- custom whiteboard applications
- visual exploration with fewer formal constraints

### Current skill status
**No — the current skill is not using tldraw.**

---

## 3. Mermaid
**Best for:** diagrams embedded in docs and version-controlled text.

### Strengths
- simple text syntax
- native in many markdown ecosystems
- good for flowcharts, sequence diagrams, ER diagrams, mindmaps

### Weaknesses
- limited layout precision
- weak for hand-drawn metaphor scenes
- complex diagrams can become hard to tune

### Best use
- docs-as-code
- quick flow/sequence diagrams
- lightweight architecture docs

### Current skill status
**Partially.** The workspace supports Mermaid as an alternate path, but the sketch skill’s primary learner-facing flow is Excalidraw PNG, not Mermaid.

**Sources:**
- Mermaid usage in docs ecosystems and Structurizr export: https://docs.structurizr.com/export/mermaid
- comparison summary: https://blobstreaming.org/notes/open-source-diagramming-tools-2026/

---

## 4. D2
**Best for:** modern diagrams-as-code with more styling flexibility than Mermaid.

### Strengths
- cleaner diagrams-as-code story
- architecture-friendly
- supports C4 concepts in documentation/ecosystem

### Weaknesses
- still code-first, not sketch-first
- weaker for hand-drawn metaphor scenes than Excalidraw

### Best use
- architecture diagrams in code repos
- diagrams that need versionability plus better styling control than Mermaid

### Current skill status
**No — the current skill is not using D2.**

**Source:** https://d2lang.com/blog/c4/

---

## 5. PlantUML / Structurizr
**Best for:** formal architecture and model-based consistency.

### Strengths
- excellent for architecture-as-code
- Structurizr is especially strong for C4 consistency across views
- ideal when you want one model feeding multiple diagrams

### Weaknesses
- not sketch-like
- less suitable for metaphor-first educational visuals

### Best use
- serious architecture documentation
- repeatable model-driven software diagrams
- when C4 fidelity matters

### Current skill status
**No — the current sketch skill is not based on Structurizr or PlantUML.**
It is not a model-as-code architecture framework.

**Sources:**
- https://structurizr.com/
- https://docs.structurizr.com/ai
- https://docs.structurizr.com/export/mermaid

---

## 6. diagrams.net (draw.io)
**Best for:** structured manual diagrams with a broad shape library.

### Strengths
- huge stencil library
- easy for formal boxes/flows/infrastructure drawings
- strong manual control

### Weaknesses
- less sketch-like
- can encourage over-structured enterprise-card visuals
- weaker as a learner-memory tool than metaphor sketches

### Best use
- formal architecture diagrams
- network/infrastructure diagrams
- process diagrams for business audiences

### Current skill status
**No — the current sketch skill is not using diagrams.net.**

---

## 7. Miro / FigJam / Whimsical / Lucidchart
**Best for:** collaborative teams and workshops.

### Strengths
- easy group editing
- presentation-friendly
- good for brainstorming and team sessions

### Weaknesses
- less programmable
- weaker for automated pipeline generation
- often subscription/freemium-heavy

### Current skill status
**No — not part of the current automated generation pipeline.**

---

# Part 4 — Easiest tool by use case

## If you want to think quickly and sketch concepts
Use:
- **Excalidraw**

## If you want docs-as-code
Use:
- **Mermaid** for lightweight use
- **D2** for richer diagrams-as-code
- **Structurizr** for C4/model consistency

## If you want formal architecture artifacts manually
Use:
- **diagrams.net**
- **Lucidchart** / **Miro** if collaboration matters more than code

## If you want memorable teaching visuals
Use:
- **Excalidraw + semantic scene-family framework**

That last one is closest to what your skill is trying to do.

---

# Part 5 — What the current skill is actually employing

## Tooling used today
From the local skill package:
- `@excalidraw/excalidraw`
- `puppeteer`
- browser-based headless compilation via `scripts/compile-excalidraw.js`

So the actual technical stack is:

1. semantic brief
2. custom scene-family / premium-sketch guidance
3. `.excalidraw` JSON generation
4. browser export to PNG using Excalidraw runtime

## It is **not** currently built on
- Structurizr
- D2
- Mermaid as primary path
- PlantUML
- ArchiMate tooling
- BPMN tooling
- tldraw

## What conceptual framework it uses now
The current skill uses a **custom internal framework**, not a standard industry notation.

That framework now includes:
- scene families
- object palettes
- shape quotas
- forbidden geometry
- label budgets
- scene tests
- premium sketch language
- premium generation playbook
- connector hygiene rules

This is basically a custom **semantic visualization grammar** for learner-facing diagrams.

## What it resembles
It resembles a blend of:
- whiteboard sketching
- visual grammar principles
- semantic scene composition
- metaphor-first instructional design

more than it resembles:
- C4
- BPMN
- UML
- ArchiMate

---

# Part 6 — Does the current skill employ the right frameworks?

## Yes, partially
It now employs several good principles:

### It does employ
- scene-family thinking
- object vocabulary thinking
- hot path salience
- failure branch placement
- anti-template constraints
- premium sketch cues
- connector hygiene
- semantic brief-first generation

### It does **not** fully employ
- formal diagram-type selection frameworks automatically
- model-based architecture consistency like Structurizr
- standardized process notation like BPMN
- enterprise-layer notation like ArchiMate
- a deep automatic renderer that can always invent non-box silhouettes from arbitrary context

So the honest evaluation is:

## Current maturity level
### Strong at:
- metaphor-first conceptual teaching diagrams
- learner-facing sketch generation
- semantic scene direction

### Weak at:
- automatic standardized diagram selection
- universal diagram coverage
- precise enterprise modeling
- arbitrary context → perfect scene invention without manual brief quality

---

# Part 7 — The best framework stack for your problem

If your real pain is:

> "I don't know what visual to choose for a given context"

then the best stack is:

## Layer A — Diagram-type decision framework
Use a decision map like this:

- **structure** → C4 / architecture diagram
- **interaction over time** → sequence / activity / BPMN
- **state change** → state diagram
- **strategic evolution** → Wardley map
- **service experience + operations** → service blueprint
- **teaching an abstract mechanism** → semantic sketch scene family

## Layer B — Scene-family framework for teaching visuals
For semantic teaching visuals, use the custom scene-family catalog:
- machine room
- theater stack
- cargo screening line
- QA lane
- control room
- archive tier stack
- repair routing workshop
- specialist office
- etc.

## Layer C — Tool selection
- formal / code-first → Structurizr, Mermaid, D2, PlantUML
- manual formal → diagrams.net
- learner-facing sketch → Excalidraw

This is the most reliable system.

---

# Part 8 — What I would recommend you do in practice

## Recommendation 1
For every concept, ask these 3 questions:

1. **Is this primarily structure, flow, state, decision, or strategy?**
2. **Is the audience learning or implementing?**
3. **Do I need precision or memorability first?**

## Recommendation 2
Use **two visuals** for important concepts:

### Formal view
Examples:
- C4
- sequence
- BPMN
- Wardley

### Teaching view
Examples:
- machine room
- cargo screening line
- QA lane
- theater stack

This is often the best answer because one picture rarely satisfies both precision and memorability perfectly.

## Recommendation 3
For your skill, keep Excalidraw as the learner-facing renderer
This is still a good choice because:
- it matches the hand-drawn goal
- it is easy to edit manually
- it compiles well to PNG
- it supports the organic look you want better than formal tools

## Recommendation 4
If you want easier manual drawing outside the skill
Use:
- **Excalidraw** first
- **diagrams.net** for formal polished architecture
- **Mermaid/D2** for docs-as-code

## Recommendation 5
If you want the skill to improve further
The next capability gap is not just tooling.
It is **automatic visual reasoning**.

The skill needs to get better at:
- picking the right scene family from context
- inventing strong silhouettes
- avoiding card framing
- introducing prop density and asymmetry systematically
- combining formal diagram selection with metaphorical teaching visuals

---

# Part 9 — Concrete recommendation for this repository

## Keep the current rendering medium
Keep:
- Excalidraw
- browser-based compilation
- PNG outputs

## Add a standard "formal diagram companion" path
For future improvement, consider adding an optional companion path:
- **C4/Structurizr** for structure
- **Mermaid/D2** for sequence/flow/state

Then every important concept could have:
- `formal_view.*`
- `semantic_sketch.*`

This would solve the tension between:
- architecture precision
and
- learner memorability

## Keep evolving the current skill as the sketch engine
The current skill should remain the:
- metaphor engine
- scene-family engine
- premium sketch engine

not the only diagram framework in the stack.

---

# Final Conclusion

If the question is:

> how do I know what diagram to draw for any given context?

then the answer is:

1. choose the **question type** first
2. map it to a **diagram framework**
3. map that to a **tool**
4. for pedagogy, convert it into a **semantic sketch scene family**

## Best frameworks by intent
- **C4** → architecture structure
- **UML/BPMN** → behavior and process
- **ArchiMate** → enterprise layers
- **Wardley maps** → strategy/evolution
- **Service blueprint** → service operations and touchpoints
- **Custom semantic sketch families** → teaching / memory / explanatory visuals

## Best easy tools by intent
- **Excalidraw** → easiest sketch-first conceptual drawing
- **diagrams.net** → easiest manual formal diagramming
- **Mermaid / D2** → easiest docs-as-code diagramming
- **Structurizr** → best C4/model consistency

## Current skill evaluation
The current skill is:
- **good and increasingly strong** for learner-facing semantic sketches
- **not yet a universal formal diagram engine**
- correctly centered on **Excalidraw** for sketch output
- improved by your recent direction toward scene families, object palettes, premium sketch language, and connector hygiene

The biggest remaining opportunity is to build a hybrid workflow where:
- formal frameworks decide the diagram class
- the sketch skill produces the explanatory learner-facing version

---

# References

## Frameworks and standards
- C4 Model: https://c4model.com/
- Structurizr: https://structurizr.com/
- Structurizr AI/MCP notes: https://docs.structurizr.com/ai
- Structurizr Mermaid export: https://docs.structurizr.com/export/mermaid
- D2 C4 support: https://d2lang.com/blog/c4/
- ArchiMate/BPMN guidance: https://meta.linked.archi/docs/guide/modeling-languages-guide/
- ArchiMate vs BPMN practice: https://www.nilus.be/blog/archimate_vs_bpmn_in_enterprise_architecture_practice/
- Bizzdesign on combining ArchiMate with BPMN/UML/etc: https://bizzdesign.com/blog/how-combine-archimater-industry-standards-better-ea
- Wardley Maps for EA: https://www.wardleymaps.com/ea
- Wardley mapping paper/pdf: https://www.wardleymaps.com/downloads/Wardley-Maps-in-EA.pdf
- Service blueprinting: https://www.nngroup.com/articles/service-blueprinting-faq/

## Tooling and comparisons
- Excalidraw app: https://excalidraw.com/
- Excalidraw repository: https://github.com/excalidraw/excalidraw/
- Diagram-as-code comparison: https://diagrams.so/learn/diagram-as-code-comparison
- Diagramming tools comparison: https://blobstreaming.org/notes/open-source-diagramming-tools-2026/
- Excalidraw vs tldraw vs draw.io comparison: https://stackcompare.net/excalidraw-vs-tldraw-vs-draw-io-2026-free-diagramming-tool-comparison/
- General free-tool comparison: https://blixamo.com/blog/best-free-diagram-tools-2026

## Visual grammar / information design
- Scientific basis of graphical representation design: https://arxiv.org/pdf/1903.05941
- Effective visual notations in requirements engineering: http://csis.pace.edu/~ogotel/professional/RE09%20Tutorial%20-%20Designing%20Effective%20Visual%20Notations.pdf
- The DNA of information design for charts and diagrams: https://www.jbe-platform.com/content/journals/10.1075/idj.25.3.05ric
- Syntactic structures in graphics: https://yuriweb.com/engelhardt-graphic-syntax.pdf

## Local repository artifacts evaluated
- `copilot-skills/skills/content-to-sketch/SKILL.md`
- `copilot-skills/skills/content-to-sketch/package.json`
- `copilot-skills/skills/content-to-sketch/scripts/compile-excalidraw.js`
- `copilot-skills/skills/content-to-sketch/references/canonical-scene-families.md`
- `copilot-skills/skills/content-to-sketch/references/premium-sketch-language.md`
- `copilot-skills/skills/content-to-sketch/references/premium-generation-playbook.md`
