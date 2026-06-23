# Visual Decision Guide — One Page

## 1) Ask one question first
What is the main thing I’m trying to show?

| Question | Intent | Best formal framework | Best semantic scene family |
|---|---|---|---|
| What exists? | Structure | C4, UML component, ArchiMate | `machine-room-hub` |
| What happens in order? | Interaction over time | Sequence | `dispatch-control-room`, `relay-loop-track` |
| What process/branch/retry happens? | Workflow/process | BPMN, activity | `qa-lane`, `repair-routing-workshop`, `cargo-screening-line` |
| What changes state? | State/lifecycle | State diagram | `mission-control-board`, `compression-press-checklist` |
| What gets filtered or routed? | Filtering/routing | Flowchart, BPMN | `cargo-screening-line`, `sorting-desk`, `security-gate-checkpoint` |
| What decision changes behavior? | Decision/tradeoff | Decision matrix, Wardley (sometimes) | `control-room-levers` |
| What is layered or hierarchical? | Layered control | C4 conceptual stack | `layered-theater-stack` |
| What user-visible steps depend on backstage work? | Service experience | Service blueprint | service-oriented custom scene |
| What is strategic / evolving / commoditizing? | Strategy/evolution | Wardley map | scaffold / strategy-board metaphor |
| What is abstract and hard to teach? | Teaching metaphor | custom-semantic-sketch | scene-family-driven sketch |

---

## 2) Tool shortcut

| Need | Best tool |
|---|---|
| Hand-drawn learner sketch | **Excalidraw** |
| Docs-as-code flow/sequence/state | **Mermaid** |
| Richer diagrams-as-code | **D2** |
| Proper C4 / model consistency | **Structurizr** |
| Polished manual formal diagrams | **diagrams.net** |
| Collaborative workshop whiteboard | **Miro / FigJam** |

---

## 3) Best scene-family shortcuts

| If the concept is about... | Draw this |
|---|---|
| central system + support systems | `machine-room-hub` |
| layered orchestration | `layered-theater-stack` |
| filtering + bounded capacity | `cargo-screening-line` |
| verification + rework | `qa-lane` |
| capability routing / tool choice | `dispatch-control-room` |
| memory tiers | `archive-tier-stack` |
| classification into outputs | `sorting-desk` |
| error recovery paths | `repair-routing-workshop` |
| delegation to specialists | `specialist-office` |
| persistence / checkpoint / resume | `mission-control-board` |
| summarization loss / false done | `compression-press-checklist` |
| decisions changing machine behavior | `control-room-levers` |

---

## 4) Precision vs memorability

| Need | Do this |
|---|---|
| Precision first | formal diagram only |
| Memorability first | semantic sketch only |
| Both | **formal companion + learner sketch** |

### Best pair examples
- C4 + machine-room-hub
- Sequence/BPMN + qa-lane
- State diagram + mission-control-board
- Flowchart + cargo-screening-line
- Wardley map + scaffold/strategy sketch

---

## 5) Fast rule of thumb
If stuck, ask:

> Am I showing **what exists**, **what happens**, **what changes**, **what gets filtered**, or **what choice matters**?

Then choose:
1. **formal framework** for correctness
2. **semantic scene family** for understanding
3. **Excalidraw** if you want a memorable learner-facing sketch

---

## 6) What the current skill is best at
The current skill is best at:
- **semantic learner-facing sketches**
- **metaphor-first explanation**
- **Excalidraw-based whiteboard visuals**

It is not yet a full universal formal-diagram engine.

So the best practical workflow is:

**intent → framework → scene family → tool**
