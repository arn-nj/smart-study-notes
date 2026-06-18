# Living Architecture Update Workflow

This workflow keeps the architecture package current as new BRDs, meeting transcripts, and wiki updates arrive.

## Core Rule
Do not treat the architecture document as a one-time deliverable. Treat it as a controlled baseline that evolves with evidence.

## Recommended Package Behavior
- Keep one stable architecture folder per initiative
- Store every new source under `input/`
- Keep generated artifacts under `output/`
- Never overwrite source history silently
- Update the architecture package through explicit deltas
- Keep diagrams and prompt documents version-aligned with the narrative

## Update Modes

### 1. Initialize
Use when creating the first architecture package.

Inputs:
- BRD
- Early meeting transcripts
- Available wiki or backlog notes

Actions:
- Create all baseline artifacts
- Generate the first stakeholder diagram set and domain image prompts
- Mark low-confidence areas clearly
- Seed the open question list aggressively

### 2. Refresh
Use when a new transcript, wiki update, or requirement delta arrives but the core initiative remains the same.

Actions:
- Add the new source to `Source_Index.md`
- Compare it against the current baseline
- Update changed sections only
- Regenerate affected Mermaid, ER, SVG, or Visio build-note artifacts
- Log all deltas in `Architecture_Change_Log.md`
- Reopen affected decisions where needed

### 3. Rebaseline
Use when scope, platform assumptions, compliance posture, or integration reality changes enough that old conclusions no longer hold.

Triggers:
- Major BRD revision
- New enterprise constraint
- Vendor or platform direction changes
- Security or legal constraints invalidate prior design
- A previously rejected option becomes viable or required

Actions:
- Preserve prior decisions as history
- Mark superseded content explicitly
- Rewrite impacted sections with the new baseline in mind
- Rework diagrams whose assumptions or boundaries changed
- Highlight what became invalid and why

## Change Detection Checklist
For each new source, assess whether it changes:
- Business goals
- Scope boundaries
- Functional requirements
- NFR targets
- Data ownership or residency
- Integration contracts
- Security controls
- Delivery sequencing
- Operating model or support expectations
- Cost guardrails
- Diagram boundaries, system relationships, or domain ownership

## Delta Logging Format
Use a compact record in `Architecture_Change_Log.md`:

| Date | Source | Changed Area | Previous State | New State | Impact |
|---|---|---|---|---|---|
| 2026-06-18 | teams_call_01.txt | Authentication | SSO assumed later | SSO required for phase 1 | Option 2 loses fit |

## Decision Hygiene
When a change affects architecture direction:
- Do not delete the old decision
- Mark it `superseded` or `needs review`
- Add a new decision entry with the updated context
- Link the decision back to the triggering source

When a change affects diagram meaning:
- Update the corresponding Mermaid or SVG source file
- Record the affected diagram IDs in `Architecture_Change_Log.md`
- Refresh the related image prompt if the stakeholder narrative changed

## Handling Missing Meeting Transcripts
If no transcript exists for a meeting:
- Use the updated wiki or BRD as the new evidence source
- Mark the decision confidence as lower if no explicit decision record exists
- Add a question requesting confirmation where ambiguity remains

## Recommended Cadence
- Refresh after every meaningful workshop, design review, or BRD revision
- Rebaseline only when previous assumptions are materially broken
- Review open items before each major architecture discussion
- Review the diagram set before each stakeholder playback so the visuals do not lag the written design

## Practical Governance Rules
- Separate fact, inference, and proposal in every update
- Keep unresolved items visible until explicitly closed
- Prefer traceable markdown diffs over silent rewrites
- If a new source contradicts an approved source, log the contradiction and ask for decision authority

## Minimal Operating Loop
1. Ingest source
2. Update source index
3. Detect deltas
4. Update NFR catalog and open items
5. Update architecture narrative and option analysis
6. Update stakeholder diagrams, ER model, SVG exports, and Visio build notes where impacted
7. Update domain image prompts if domain understanding changed
8. Update decision log
9. Write change log entry
