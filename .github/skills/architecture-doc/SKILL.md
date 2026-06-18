---
name: architecture-doc
description: >
  Generate and maintain a TOGAF-oriented architecture document from BRDs, meeting transcripts,
  wiki updates, and related source material. Use when: creating a solution architecture document
  from business requirements; comparing architecture options with pros and cons; capturing NFRs,
  assumptions, risks, unresolved questions, decision changes, and stakeholder-facing diagrams over time;
  updating an existing architecture package after new meetings or revised business documents.
argument-hint: "one or more source paths plus optional target folder, for example: docs/brd.md transcripts/kickoff.txt --target ProjectA/architecture/"
user-invocable: true
---

# Requirements and Meeting Inputs → TOGAF-Oriented Architecture Document

## What This Skill Does
Given one or more business and delivery inputs, produce and maintain a living architecture package:
1. **`Architecture_Document.md`** — primary architecture narrative and design package
2. **`Architecture_Decision_Log.md`** — option comparisons, decisions, reversals, and rationale
3. **`Architecture_Change_Log.md`** — what changed after each new BRD, transcript, or wiki update
4. **`Source_Index.md`** — source inventory, precedence, timestamps, and evidence mapping
5. **`Open_Items_and_Questions.md`** — unresolved items, dependencies, assumptions, and questions for stakeholders
6. **`NFR_Catalog.md`** — consolidated NFRs, measurable targets, and traceability to source evidence
7. **`Stakeholder_Diagrams.md`** — embedded Mermaid diagrams, architecture views, and diagram notes
8. **`Domain_Image_Prompts.md`** — one image-generation prompt per TOGAF domain for hand-drawn stakeholder visuals
9. **`diagram-assets/`** — generated diagram source files such as Mermaid, SVG, and Visio-friendly exports

All outputs should live in a dedicated project folder, for example:

```text
<ProjectName>/architecture-package/
├── input/
│   ├── business-docs/
│   │   ├── brd.md
│   │   ├── brd_v2.docx
│   │   └── wiki_export_2026-06-25.md
│   ├── transcripts/
│   │   └── teams_call_2026-06-18.txt
│   ├── images/
│   │   └── current-state-diagram.png
│   └── reference/
│       └── dependency-notes.md
├── output/
│   ├── Architecture_Document.md
│   ├── Architecture_Decision_Log.md
│   ├── Architecture_Change_Log.md
│   ├── Source_Index.md
│   ├── Open_Items_and_Questions.md
│   ├── NFR_Catalog.md
│   ├── Stakeholder_Diagrams.md
│   ├── Domain_Image_Prompts.md
│   └── diagram-assets/
│       ├── mermaid/
│       ├── svg/
│       └── visio/
└── archive/
```

## Accepted Inputs
- Markdown BRD files
- BRD documents in doc/docx or equivalent exported text form
- Exported transcript text from Teams calls or workshops
- Wiki exports in markdown, text, or similar document form, including multiple versions over time
- Existing architecture notes and prior architecture documents
- Image-based diagrams, whiteboard snapshots, and exported system diagrams
- Supplemental notes, backlog summaries, requirement lists, or dependency lists

If a source is not already plain text or markdown, convert it first or extract the relevant text before synthesis. For image diagrams, capture visible labels, system names, interfaces, and ambiguity as source evidence in `Source_Index.md`.

## TOGAF Orientation
The architecture document should reflect TOGAF thinking without turning into framework theater.

Always cover:
- Business context, drivers, scope, constraints, stakeholders, and expected outcomes
- Baseline state, target state, and key gaps
- Architecture vision and success measures
- Business, data, application, technology, integration, security, and operational viewpoints where relevant
- Candidate architecture options with pros, cons, risks, cost/complexity implications, and fit-for-purpose guidance
- NFRs with measurable targets and traceability to business need or source evidence
- Architecture assumptions, dependencies, and decisions still pending
- Questions the architect must raise before committing to a design
- Stakeholder-ready diagrams that help business, delivery, and platform audiences discuss the design

## Procedure

### Step 1 — Create or Reuse the Architecture Package Folder
- Use a stable folder per initiative, for example `<ProjectName>/architecture-package/`
- Keep raw source files grouped in `input/business-docs/`, `input/transcripts/`, `input/images/`, and `input/reference/`
- Write all generated artifacts into `output/`
- Treat the generated markdown files and diagram sources as the living architecture baseline

### Step 2 — Build the Source Index First
Create `Source_Index.md` before writing design conclusions.

Track for every input:
- File name and path
- Source type: BRD, transcript, wiki, backlog, dependency note
- Source date or version if known
- Trust level: draft, working, approved, inferred
- Main topics covered
- Conflicts or overlaps with other sources
- Whether the source is text, diagram image, wiki revision, or prior architecture artifact

Also define source precedence explicitly:
1. Approved business documents
2. Later approved wiki or design updates
3. Meeting transcripts with named stakeholder decisions
4. Draft notes or inferred context

If two sources disagree, keep both visible and log the conflict instead of silently picking one.

### Step 3 — Extract the Requirement Baseline
Read all sources and normalize the requirement set into:
- Functional requirements
- Business rules
- Data requirements
- Integration requirements
- Security and compliance requirements
- Operational requirements
- Constraints and dependencies
- Known unknowns

Assign stable IDs where possible, for example:
- `FR-01`, `FR-02`
- `NFR-01`, `NFR-02`
- `Q-01`, `Q-02`
- `A-01` for assumptions

Do not hide uncertainty. Mark items as:
- Confirmed
- Inferred
- Conflicting
- Pending validation

### Step 4 — Produce the NFR Catalog Early
Create `NFR_Catalog.md` as a dedicated artifact, not as a side note.

Capture at minimum:
- Availability
- Performance and latency
- Scalability
- Security and privacy
- Auditability
- Resilience and recovery
- Observability and supportability
- Maintainability and deployability
- Data retention and compliance
- Cost guardrails

For each NFR, include:
- Requirement ID
- Statement
- Source evidence
- Why it matters
- Measurable target or acceptance signal
- Impact on architecture options
- Open question if the target is still unclear

### Step 5 — Generate the Main Architecture Document
Use the structure in [architecture-document-template](./references/architecture-document-template.md).

The document should explain:
- What problem is being solved
- Why the architecture exists
- What options were considered
- Why the preferred option is preferred
- What is still unresolved
- What decisions could change the design later

### Step 6 — Generate Stakeholder Diagram Artifacts
Create diagram assets under `output/diagram-assets/` and document them in `Stakeholder_Diagrams.md`.

Required diagram coverage when relevant:
- Mermaid context or system landscape diagram
- Mermaid container or component interaction diagram
- Mermaid process or sequence diagram for a critical business flow
- Mermaid deployment or environment view
- ER diagram for the most important business data entities and relationships
- Integration diagram showing upstream/downstream systems, protocols, and ownership boundaries
- Security or trust-boundary diagram when the solution crosses security zones

Preferred output layout:
```text
output/diagram-assets/
├── mermaid/
│   ├── context.mmd
│   ├── containers.mmd
│   ├── process-flow.mmd
│   ├── deployment.mmd
│   └── data-er.mmd
├── svg/
│   ├── context.svg
│   ├── containers.svg
│   └── data-er.svg
└── visio/
  ├── diagram-index.md
  └── visio-build-notes.md
```

Visio guidance:
- The skill should generate Visio-friendly build notes, shape lists, connectors, swimlanes, and page suggestions in markdown if native `.vsdx` generation is not available.
- If SVG export is possible, use SVG as the interchange artifact for later Visio recreation.

### Step 7 — Generate One Image Prompt per TOGAF Domain
Create `Domain_Image_Prompts.md` with one prompt for each architecture domain:
- Business Architecture
- Data Architecture
- Application Architecture
- Technology Architecture

Each prompt should include:
- Audience and meeting purpose
- What the hand-drawn image should emphasize
- Mandatory labels and entities
- Layout guidance
- Color/style guidance
- Items to avoid

Prompts should be suitable for image-generation models and optimized for stakeholder workshops, not just documentation.

### Step 8 — Compare Candidate Architecture Options
Every architecture document should include at least 2-3 realistic options unless the problem is truly constrained.

For each option, document:
- Short description
- Main components and responsibilities
- Deployment style
- Data and integration implications
- Security posture implications
- Strengths
- Weaknesses
- Delivery risk
- Operational risk
- Cost and complexity tradeoffs
- Best-fit conditions
- Reasons to reject

Avoid fake options that nobody would actually choose.

### Step 9 — Create the Decision Log
Create `Architecture_Decision_Log.md` with entries such as:
- Decision ID
- Title
- Date
- Status: proposed, accepted, superseded, rejected, needs review
- Options considered
- Decision drivers
- Chosen direction
- Consequences
- Follow-up actions

This file is the control point for architecture drift.

### Step 10 — Capture Open Questions and Evaluation Items
Create `Open_Items_and_Questions.md` with sections for:
- Questions for business stakeholders
- Questions for security
- Questions for platform or infrastructure teams
- Questions for integration owners
- Questions for data owners
- Questions for support and operations
- External dependencies and blockers

This section is mandatory. Architecture quality drops fast when unresolved items are buried in prose.

### Step 11 — Keep the Package Updated Over Time
Use the workflow in [living-architecture-update-workflow](./references/living-architecture-update-workflow.md).

Update modes:
- **Initialize**: first architecture package from BRD and early transcripts
- **Refresh**: new transcript or wiki update modifies existing sections
- **Rebaseline**: major business or platform change invalidates previous assumptions

For every update:
1. Add the new source to `input/`
2. Append it to `output/Source_Index.md`
3. Identify changed requirements, decisions, assumptions, NFRs, and diagrams
4. Update `output/Architecture_Document.md`
5. Update `output/Stakeholder_Diagrams.md` and the relevant files under `output/diagram-assets/`
6. Update `output/Domain_Image_Prompts.md` if domain understanding changed
7. Record the delta in `output/Architecture_Change_Log.md`
8. Supersede or reopen decisions in `output/Architecture_Decision_Log.md` where required
9. Add any newly exposed uncertainty to `output/Open_Items_and_Questions.md`

Never rewrite history silently. Show what changed and why.

## Output Standards

### Architecture_Document.md must include
- Executive summary
- Business context and scope
- Stakeholders and concerns
- Baseline state
- Target state
- Architecture principles and assumptions
- Functional summary
- NFR summary
- Candidate options with pros and cons
- Recommended architecture and rationale
- Domain details: business, application, data, technology, security, integration, operations
- Deployment and environment view
- Risks and mitigations
- Traceability summary
- Unresolved items and next evaluation steps

### Stakeholder_Diagrams.md must include
- Diagram index with purpose, audience, and source references
- Mermaid source blocks or links to `.mmd` files
- Notes on when to use each diagram in stakeholder discussions
- Cross-links to the architecture sections they support

### Domain_Image_Prompts.md must include
- One prompt each for business, data, application, and technology architecture
- Optional extra prompts for integration and security when useful
- Update notes when the design direction changes

### Architecture_Decision_Log.md must include
- One dated decision record per major decision
- Reversal or superseded history when decisions change

### Architecture_Change_Log.md must include
- Source that triggered the update
- Sections changed
- Old assumption or statement
- New assumption or statement
- Impact to options, NFRs, timeline, or dependencies

## Questions the Architect Should Always Ask
- What is approved versus only discussed?
- Which requirements are mandatory for day one versus later phases?
- What are the measurable NFR targets, not just adjectives like fast or secure?
- Which systems are sources of truth?
- What integration contracts already exist?
- What data cannot leave a boundary for legal, privacy, or residency reasons?
- What operational team will support the solution and with what tooling?
- What change cadence is expected after go-live?
- What assumptions would invalidate the current design if they turn out false?

## Best Practices
- Prefer evidence-backed statements over generic architecture prose
- Separate confirmed fact from inference
- Keep option analysis honest and decision-oriented
- Trace NFRs to actual source statements or explicit stakeholder asks
- Log contradictions instead of smoothing them over
- Keep unresolved items visible until closed
- Rebaseline when new sources materially change scope or constraints
- Keep diagrams versioned with the narrative, not as disconnected presentation assets
- Update ER, context, and deployment diagrams whenever the underlying assumptions change
- Use Mermaid for diff-friendly text diagrams and SVG for shareable exports
- Use Visio build notes when stakeholders need enterprise-diagram recreation in standard tooling

## Invocation Examples

```text
/architecture-doc docs/brd.md transcripts/kickoff.txt images/current-state.png --target ProjectA/architecture-package/
```

```text
/architecture-doc ProjectA/architecture-package/input/business-docs/brd_v2.md ProjectA/architecture-package/input/business-docs/wiki_update_2026-06-25.md --target ProjectA/architecture-package/ --mode refresh
```

```text
/architecture-doc docs/brd.md docs/wiki_export.md transcripts/solutioning_call.txt
Focus on TOGAF-aligned options, NFRs, unresolved items, ER and stakeholder diagrams, and decision deltas.
```

## Quality Checklist
- [ ] All source files are logged in `Source_Index.md`
- [ ] Contradictions are marked explicitly
- [ ] The architecture document includes baseline, target, and gaps
- [ ] At least 2-3 real options are evaluated when feasible
- [ ] Every major option has pros, cons, risks, and fit criteria
- [ ] NFRs have measurable targets or open questions where targets are missing
- [ ] Open questions are captured separately from assumptions
- [ ] Decision changes are tracked over time, not overwritten
- [ ] Diagram artifacts are stored under `output/diagram-assets/` and referenced from `Stakeholder_Diagrams.md`
- [ ] `Domain_Image_Prompts.md` contains one prompt for each TOGAF domain
