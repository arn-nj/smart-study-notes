TOGAF Practitioner — GoodNotes-style DETAILED Study Notebook
===========================================================

Format: Each video/lesson from the transcript is one page. Each page follows your rules: notebook-style headings, callouts, ASCII sketches, analogy, visual sketch, real-world example, exam relevance, flashcards, practice questions, one-page revision and 8 memory bullets to remember in 30 days. Pages are concise but detailed enough for study and spaced repetition.

-- Page 1 — Introduction & Course Structure

Big Picture
- TOGAF helps enterprises plan & govern change to realize business value.

Key Concepts
- Purpose: guide effective change via current vs target state and governance.
  - Analogy: City master plan — shows what to build, when, and who approves.
  - Visual sketch (ASCII):
    [Baseline] --gap--> [Target]
       |                   |
      models            roadmaps

- Stakeholders & Governance
  - Real-world: Execs approve vision; EA team writes roadmap and manages risks.
  - Exam relevance: Understand role of Request for Architecture Work and Statement of
    Architecture Work.

Why It Matters
- Prevents wasted projects, aligns investments, reduces risk.

Process Flow (mini)
- Request → Preliminary → Phase A (Vision) → B–D (domain architectures) → E/F (roadmap & migration)

Common Mistakes
- Over-scoping the first architecture project.
- Skipping stakeholder confirmation.

Visual Memory Hooks
- Icon set: 🗺️ (map) 🎯 (vision) 🔁 (iteration)

Flashcards
- Q: What triggers an ADM cycle? A: Request for Architecture Work.

Practice Questions
- Q: What is the Statement of Architecture Work for? (Short answer)

One-Page Revision
- EA = map; Vision = direction; ADM = method; Repo = single source

What to remember 30 days from now
- EA guides change to deliver value
- Request starts ADM
- Vision must be stakeholder-aligned
- Keep scope minimal
- Use repository first
- Roadmaps show transitions
- Contracts ensure compliance
- Measure value, not just outputs

-- Page 2 — TOGAF Core Concepts (levels, continuum, states)

Big Picture
- Organize large landscapes using levels (strategic/segment/capability) and continuum (generic→specific).

Key Concepts
- Architecture Levels
  - Analogy: Map zoom (world → country → city)
  - ASCII:
    [Strategic]
      |
    [Segment]
      |
    [Capability]
  - Example: Strategic defines enterprise vision; capability defines a payroll process.
  - Exam: Identify correct scope & time horizon per level.

- Architecture Continuum
  - Analogy: Reference library → custom design
  - Visual: Generic <--- foundation --- Specific
  - Use: Promote reuse and reduce redundancy.

- Architecture States: Baseline, Transition(s), Target, Candidate, Resting
  - Real-world: Baseline = legacy systems; transition = phased migration; target = new cloud platform.

Why It Matters
- Choose right granularity and reuse models to save time.

Process tips
- Only update landscape when a justified project requests it; avoid speculative work.

Common Mistakes
- Mixing levels in a single model; over-detailing strategic architectures.

Flashcards
- Q: Name 3 architecture levels. A: Strategic, Segment, Capability.

Practice Question
- Given scenario with enterprise-wide vision, which level to use? (Strategic)

One-Page Revision
- Levels = breadth vs detail; Continuum = reuse; States = baseline→target

30-day bullets
- 3 levels & their purpose
- Continuum = generic→specific
- Baseline vs target distinction
- Use models for storytelling
- Roadmaps come from gaps
- Maintain approved architectures
- Scope projects to requests
- Reuse rather than redesign

-- Page 3 — Architecture Development Method (ADM) — Overview + Phase A deep dive

Big Picture
- ADM is the stepwise cycle to develop and maintain architecture.

Key Concepts
- ADM sequence (A→B→C→D→E→F→G→H) with Requirements Management at center.
  - Analogy: Project lifecycle with gates and reviews.
  - ASCII:
    (Reqs)
      •
    A → B → C → D → E → F → G → H

- Phase A (Architecture Vision): essential exam focus
  - Steps: scope → identify stakeholders & concerns → confirm goals/drivers → develop vision → statement of architecture work
  - Analogy: Pitch deck that gets executive buy-in.
  - Visual: [Stakeholder map] -> [High-level baseline/target] -> [Vision summary]
  - Real World: If stakeholders disagree, the project stalls; align early.
  - Exam relevance: know inputs (request for architecture work, principles, repository) and outputs (Statement of Architecture Work, Architecture Vision, Communication Plan).

Why It Matters
- Phase A sets the contract and scope—errors here amplify downstream.

Process Flow (Phase A condensed)
- Receive request → Scope (breadth/depth/time) → Stakeholders → Team capability check → Draft vision → Secure approval

Common Mistakes
- Failing to scope breadth/time properly; insufficient stakeholder map.

Flashcards
- Q: Primary output of Phase A? A: Statement of Architecture Work + Architecture Vision.

Practice Questions
- Scenario: Sponsor provides a vague request—what step next? (Scope & stakeholder identification)

One-Page Revision
- Memorize Phase A steps and artifacts; find Statement of Architecture Work in exam.

30-day bullets
- Phase A establishes the project
- Statement of Architecture Work = contract
- Stakeholder map directs views
- Use repository assets early
- Scope breadth vs depth tradeoff
- Confirm team capability early
- Vision summarizes value & KPIs
- Communication Plan = who, when, how

Worked Example — Phase A (quick)
- Scenario: Sponsor requests 'improve customer onboarding' across two business units.
  Steps: 1) Scope breadth: org units A+B; 2) Stakeholders: Head of Sales, Head of Ops, CIO; 3) Baseline: current onboarding flow; 4) Draft vision: reduce onboarding time by 50% in 12 months; 5) Outputs: Statement of Architecture Work, stakeholder map, initial KPIs.

Quick ASCII Sketch (Phase A stakeholder map)
  [Sponsor]
     |       
  [Head Sales] - [Head Ops] - [CIO]
     \         |         /
      ---- [EA Team] -----

Inputs & Outputs (Phase A) — study checklist
- Key Inputs:
  - Request for Architecture Work (formal trigger)
  - Business goals & strategies
  - Applicable principles & constraints
  - Existing repository assets (reference models, templates)
- Key Outputs:
  - Statement of Architecture Work (SoAW)
  - Architecture Vision (1‑page summary + KPIs)
  - Communication Plan (stakeholder messages & schedule)

Phase A: Quick checklist for study & exam (tick list)
- Confirm trigger & sponsor
- Define scope (org units, capabilities, time horizon)
- Identify top 8 stakeholders and their concerns
- Draft measurable vision (SMART goal + 2 KPIs)
- Identify one reusable repo asset per deliverable
- Produce SoAW with success criteria and governance points

Sample stakeholder concerns (common exam patterns)
- Sponsor: ROI, time-to-value, executive visibility
- CIO: integration risk, infra readiness, licensing
- Head Ops: process disruption, training, SLA impact
- Head Sales: customer experience, reporting needs
Extra Flashcards — Phase A
- Q: Name two non-architectural inputs to Phase A. A: Request for Architecture Work, business drivers/goals.
- Q: What's the main purpose of the Communication Plan? A: Deliver right info to right stakeholders at right time.

-- Page 4 — Phase B: Business Architecture (details & techniques)

Big Picture
- Business architecture defines capabilities, value streams, org maps, and processes that target the business strategy.

Key Concepts & Techniques
- Business Capability Map
  - Analogy: Catalog of abilities
  - ASCII (mini): [Strategic]—[Core]—[Supporting]
  - Use: Heatmap capabilities by maturity/value/cost.

- Value Streams
  - Analogy: Conveyor belt of perceived stakeholder value
  - ASCII: Advertise -> Select -> Pay -> Deliver
  - Map stages to capabilities and processes.

- Information Mapping (nouns→entities)
  - Tip: Use noun-challenge to extract key data entities.

- Organization Map vs Org Chart
  - Org map shows interactions across boundaries (not hierarchy).

Approach (GAP method)
- Baseline → Target → Gap Analysis → Candidate roadmap components → Impact resolution → Stakeholder review

Real-world pointers
- Use existing assets (reference models) in the repo; avoid reinventing models.

Exam Relevance
- Know artifacts: capability map, value streams, information maps, and typical matrices used in Phase B.

Common Mistakes
- Overly detailed baselines; inconsistent levels of detail between baseline and target.

Flashcard
- Q: What technique links capabilities to value stream stages? A: Mapping & matrices (capability ↔ value stream)

Practice Qs
- Short scenario: Which artifact helps show which org unit supports which capability? (Org map)

One-Page Revision
- Build baseline only to necessary level; use same level of detail for baseline & target.

30-day bullets
- Capabilities = business abilities
- Value streams show stakeholder-perceived flow
- Info map = nouns → relationships
- Org map = network of actors
- Heatmaps show priority/maturity
- Reuse industry reference models
- Gap→work packages→roadmap
- Stakeholder approval needed for target

Worked Example — Business Capability Mapping
- Problem: Sales process has duplicated capabilities across regions.
  Steps: 1) Create level-1 capability map; 2) Heatmap for duplication (red = duplicated); 3) Propose consolidation work package; 4) Map to org units and applications.

ASCII: Capability heatmap legend
  [Green]=good [Yellow]=improve [Red]=missing/duplicated

Capability mapping: practical steps & mini-example
- Steps:
  1) List Level‑1 capabilities (e.g., Lead Mgmt, Quote, Order Fulfilment, Billing)
  2) For each region, mark presence/ownership and maturity (1–5)
  3) Produce heatmap: color by duplication or misalignment
  4) Identify consolidation candidates (same capability, different apps)
  5) Draft Work Package: Consolidate Capabilities — Pilot Region

Mini-example (table style)
Capability | Region A owner | Region B owner | Maturity A | Maturity B | Action
Lead Mgmt | Sales A         | Sales B         | 4          | 2          | Consolidate -> Pilot
Billing   | Finance A       | Finance B       | 3          | 3          | Standardize interfaces

Study tip: when asked to show a capability heatmap in exam, sketch two columns (capability vs regions) and mark colors/maturities — explain consolidation rationale.

Extra Flashcards — Phase B
- Q: What does a value stream stage represent? A: An incremental value-adding activity for stakeholders.
- Q: Why use an org map? A: To show cross-boundary interactions and responsibilities.

-- Page 5 — Phase C: Information Systems (Data & Application)

Big Picture
- Data and application architectures enable the business architecture.

Key Concepts
- Data meta-model: Data Entity, Logical Data Component, Physical Data Component
  - Analogy: Entity = noun, Logical grouping = folder, Physical = database/schema
  - ASCII snippet: Customer -> Contract -> Address

- Application artifacts: Application Portfolio Catalog, App Comm Diagram, App-Org Matrix

Data considerations
- Data at rest / in motion / in use / open data
- Governance, migration, quality attributes

App Architecture pointers
- Use industry models (TRM, TRIPLE-ERM) and vendor reference models to save time.

Exam relevance
- Recognize which artifacts are data vs application; know purpose of logical vs physical models.

Common Mistakes
- Confusing entities with attributes; modelling too many attributes early.

Flashcard
- Q: Three meta-model entities for data? A: Data entity, logical component, physical component.

Practice Q
- Given requirements to share data enterprise-wide, which data principle supports this? (Data shared principle)

One-Page Revision
- Data meta-model + key diagrams + governance basics

30-day bullets
- Data entity ≠ attribute
- Logical vs physical components
- Data migration & governance are vital
- App portfolio catalogs list logical & physical apps
- App communication diagrams show interfaces
- Use repo & reference models
- Keep data models concise at first
- Trace ownership for data entities

Worked Example — Data entity mapping
- Scenario: 'Customer' entity used in Billing and CRM.
  Steps: 1) List attributes used by both systems; 2) Decide canonical source (Authoritative Source = Billing); 3) Define data access policy & migration steps.

ASCII: Data flow (simple)
  [Billing DB] --> (API) --> [CRM]

Extra Flashcards — Phase C
- Q: When to use logical vs physical data models? A: Logical for design/requirements, physical for implementation details.
- Q: What are three 'states' of data to consider? A: At rest, in motion, in use.

-- Page 6 — Phase D: Technology Architecture

Big Picture
- Technology architecture defines platforms, infrastructure, and standards to support apps & data.

Key Concepts
- Technology Portfolio Catalog, Platform Decomposition, Environments & Locations
  - Analogy: Building materials and utilities for the city

Considerations
- Technology can be a driver of change; anticipate innovation but manage discontinuities.

Exam relevance
- Understand artifacts and when to apply them; TRM and platform decomposition diagrams.

Common Mistakes
- Letting technology push architecture without business alignment.

Flashcard
- Q: Purpose of Technology Portfolio Catalog? A: Life-cycle management of tech products & standards basis.

Practice Q
- Which diagram shows OS used at each location? (Environment & Location diagram)

One-Page Revision
- Tech = platforms + standards + lifecycle; map to apps & data.

30-day bullets
- Tech supports apps & data
- Platform decomposition shows building blocks
- Catalogue aids lifecycle mgmt
- Anticipate innovation benefits & risks
- Reuse standards library
- Map tech to locations/environments
- Keep diagrams logical, not overly detailed
- Align tech choices to business value

Visual sketch (ASCII): Platform stack (concise)
  [Business Apps]
    |
  [Middleware / Services]
    |
  [Platform: Containers / App Servers]
    |
  [Infrastructure: VMs / Baremetal / Cloud]
    |
  [Network / Storage]

Study tip: label one platform with a standard (e.g., Kubernetes) and one tech component mapping to show traceability.

-- Page 7 — Phases E & F: Opportunities & Solutions / Migration Planning

Big Picture
- E identifies delivery vehicles and builds initial roadmap; F finalizes migration plan and order.

Key Concepts
- Consolidated Gaps, Solutions & Dependencies Matrix
- Implementation Factor Catalog
- Work Packages, Transition Architectures, Roadmap, Implementation & Migration Plan

Analogy
- Road trip planning: gaps = distance, work packages = legs, transition states = overnight stops.

Process Flow
- Consolidate gaps → prioritize based on value/risk → group into work packages → define transitions → timeline & costs → confirm with stakeholders

Exam relevance
- Know the matrix types and the purpose of work packages vs projects vs transition architectures.

Common Mistakes
- Ignoring dependencies; sequencing work incorrectly.

Flashcard
- Q: What is a work package? A: Grouping of activities to realize capability increments.

Practice Q
- How to choose greenfield vs evolutionary approach? (Based on constraints, risk, legacy)

One-Page Revision
- Use consolidated matrices; define clear outcomes for transitions.

30-day bullets
- Roadmap = timeline of work packages
- Consolidated gap matrix central to planning
- Dependencies define sequence
- Work packages → projects → portfolios
- Choose implementation approach per context
- Proof-of-concept = implementation, not architecture
- Cost/benefit & risk prioritize projects
- Update repo with roadmap outputs

Worked Example — Creating a Work Package
- Gap: No shared CRM across regions; solution options: (A) Build in-house, (B) Buy SaaS, (C) Hybrid.
  Steps: 1) Consolidate gaps; 2) Cost estimate + value index; 3) Define Work Package: "CRM consolidation—Phase 1 (pilot region)"; 4) Dependencies: Data migration, SSO, Org training.

ASCII: Work package -> dependencies
  [Work Package: CRM P1]
     |-- Data migration
     |-- SSO integration
     |-- Training

Extra Flashcards — E/F
- Q: What table documents solution building blocks across transitions? A: Transition Architecture State Evolution table.
- Q: Name a key input to Phase E. A: Candidate architecture roadmap components from B–D.

-- Page 8 — Phase G: Implementation Governance

Big Picture
- Ensure delivered solutions comply with the approved architecture.

Key Concepts
- Architecture Contract, Compliance Reviews, Post-Implementation Reviews

Analogy
- QA and inspections during construction: architect checks contractor.

Process Flow
- Confirm scope → identify resources/skills → guide deployment → run compliance reviews → publish post-implementation results

Exam relevance
- Know compliance levels (irrelevant → fully conformant → non-conformant) and what a compliance review checks.

Common Mistakes
- Over-reliance on reviews without developer feedback loops.

Flashcard
- Q: What is an architecture contract? A: Joint agreement on deliverables, quality, fitness.

Practice Q
- Which artifact documents acceptance criteria for an architecture project? (Statement of Architecture Work)

One-Page Revision
- Governance enforces compliance; contracts define expectations.

30-day bullets
- Contracts connect architecture to implementation
- Compliance reviews at checkpoints
- Use repo to track decisions
- Train teams on expectations
- Update baseline once deployed
- Post-implementation reviews capture lessons
- Architecture board handles major approvals
- Use artifacts to demonstrate value

Visual sketch (ASCII): Deployment & compliance flow
  [Design Approved]
    |
  [Dev & Test] --> [Compliance Review]
    |                |
  [Pre-Prod] ---------+--> [Remediation/Approve]
    |
  [Production]

Quick note: mark compliance checkpoints at Dev/Test, Pre-Prod and Production for review dates.

-- Page 9 — Phase H & Requirements Management

Big Picture
- H manages change post-deployment; Requirements Management runs continuously across the ADM.

Key Concepts
- Change Requests, Value Realization, Monitoring, Risk & Classification (simplification, incremental, re-architecting)

Analogy
- Maintenance cycle & continuous backlog refinement.

Process Flow
- Monitor → assess → classify change → decide: small update or new ADM cycle

Exam relevance
- Know change request content and how requirements feed phases.

Common Mistakes
- Not documenting change rationale or impact fully.

Flashcard
- Q: Requirements repository purpose? A: Single point of truth for requirements across ADM cycles.

Practice Q
- What triggers a new ADM cycle? (Major change/re-architecting request)

One-Page Revision
- Requirements are central; H decides whether to reopen ADM.

30-day bullets
- Requirements management is continuous
- Change requests must include impact assessment
- Classify changes: simplification/incremental/re-architect
- Value realization is measured & tracked
- Monitor performance KPIs
- Use governance to approve updates
- Document lessons & decisions
- Keep requirements repo current

Visual sketch (ASCII): Change request lifecycle
  [Change Raised]
    |
  [Impact Assessment] --(minor)-> [Implement]
    |--(major)-> [New ADM?]
    |
  [Approval] -> [Plan & Schedule] -> [Implement]

Study tip: in exams, briefly outline impact assessment steps and decision criteria for new ADM vs direct implement.

-- Page 10 — Techniques: Gap Analysis, Trade-offs, Business Scenario

Big Picture
- Concrete techniques help derive actionable roadmap items.

Key Concepts
- Gap analysis: eliminated/new/impacted building blocks
- Architecture Trade-Off Method: define criteria → investigate alternatives → select/merge
- Business Scenario Technique: SMART scenarios drive architecture requirements

Analogy
- Gap = pothole on the road; trade-off = choosing speed vs cost.

Exam relevance
- Demonstrate trade-off facilitation and ability to justify alternatives with criteria.

Common Mistakes
- Using subjective criteria without agreed weighting.

Flashcard
- Q: 3 steps of trade-off method? A: Select criteria → define alternatives → select/assemble best.

Practice Q
- Given two alternatives with similar value, what do you examine next? (Dependencies, risk, stakeholder priorities)

One-Page Revision
- Document criteria, estimate gaps, perform stakeholder review.

30-day bullets
- Gap types & examples
- Trade-offs require shared value metrics
- Business scenario = SMART
- Use matrices to consolidate gaps
- Weighting criteria is essential
- Engage stakeholders early in trade-offs
- Document chosen alternative & rationale
- Reuse viewpoints for stakeholder views

Worked Example — Trade-off Analysis (compact)
- Decision: Replace legacy ERP vs wrap with API layer.
  Criteria: Cost (30%), Time (25%), Risk (25%), Strategic fit (20%).
  Scores: Replace (7,5,6,8) -> weighted = (2.1+1.25+1.5+1.6)=6.45
           Wrap (5,8,7,6) -> weighted = (1.5+2.0+1.75+1.2)=6.45
  Result: tie -> use secondary criteria: organizational readiness -> choose Wrap + plan for Replace later.

ASCII: Trade-off table (mini)
  Criteria | Replace | Wrap
  Cost     | 7       | 5
  Time     | 5       | 8
  Risk     | 6       | 7
  Fit      | 8       | 6

Trade-off scoring: formula & tie-break rules (study-ready)
- Weighted score formula: WeightedScore = sum( weight_i * score_i ) for all criteria i.
  - Normalise weights so they sum to 1 (or use percentage weights as shown).
  - Use consistent scoring scale (1–9 or 1–10) and document scale in answer.
- Tie-break guidance (exam):
  1) Use secondary criterion (e.g., organizational readiness, compliance) pre-agreed with stakeholders.
  2) If still tied, prefer approach with smaller implementation risk or shorter time-to-value.
  3) Document rationale concisely: show weighted scores, secondary criteria and final rationale.

Quick exam phrasing tip: "I used criteria A–D with weights X; scored alternatives out of 9; weighted totals tie; selected Wrap due to higher organizational readiness and lower up-front cost, with plan to revisit for full replacement in roadmap." 

Extra Flashcards — Techniques
- Q: What secondary step after scoring equals? A: Use secondary criteria or stakeholder negotiation.
- Q: What is the purpose of the consolidated gap matrix? A: Group gaps and map to potential solutions and dependencies.

-- Page 11 — Security & Risk (summary)

Big Picture
- Security architecture is pervasive; risk management is integral to all ADM phases.

Key Concepts
- Security Service Catalog, Trust Framework, Risk Register, Controls & Audit

Analogy
- Safety protocols built into building codes.

Process Flow
- Capture security requirements in Phase A → design controls in B–D → test & audit in G → monitor in H

Exam relevance
- Know difference between business vs cyber risk; classification and mitigation planning.

Common Mistakes
- Adding security late; not mapping controls to assets.

Flashcard
- Q: Risk assessment dimensions? A: Effect × Frequency (→ initial risk classification)

Practice Q
- Where to record security building blocks? (Security Service Catalog / Repository)

One-Page Revision
- Security = design + controls + monitoring + awareness.

30-day bullets
- Security crosses all phases
- Use security service catalog
- Risk = effect × frequency
- Controls trace to assets & services
- Audit & pen tests in Phase G
- Training & awareness are required
- Include security in migration planning
- Update repo with security classifications

Worked Example — Risk Assessment (compact)
- Asset: Customer PII in CRM; Threat: Data breach; Effect = Critical, Frequency = Occasional → Initial risk = High.
  Mitigations: Encryption at rest & in transit, IAM controls, regular pen tests.

ASCII: Risk matrix (qualitative)
  Impact \ Likelihood
      | Likely | Occasional | Unlikely
  High|  X     |    X      |
  Med |        |    X      |

Risk scoring: simple numerical example (study-ready)
- Use numeric scales for repeatable answers:
  - Impact: 1 (Low), 2 (Medium), 3 (High)
  - Likelihood: 1 (Unlikely), 2 (Occasional), 3 (Likely)
  - Risk score = Impact × Likelihood (1–9)
  - Example: Customer PII -> Impact=3, Likelihood=2 → Risk=6 (High/Action)

Mitigation mapping (short)
- Controls: Encryption, IAM, Logging
- Residual risk calculation: ResidualRisk = InitialRisk × (1 - Effectiveness)
  - If controls reduce likelihood by 50% (Effectiveness=0.5): ResidualRisk=6 × 0.5 = 3 (Medium)

Exam tip: show quick math and mitigation mapping — impact×likelihood, list 2–3 controls, give residual score and recommended next step (accept/mitigate/transfer).

Extra Flashcards — Security
- Q: What does IAM stand for? A: Identity and Access Management.
- Q: Where to record mitigation decisions? A: Governance repository / Implementation Factor Catalog.

-- Page 12 — Architecture Repository, Standards & Metamodel

Big Picture
- Repository stores landscapes, standards, governance logs, requirements, and SBS.

Key Concepts
- Standards lifecycle (proposed → provisional → standard → phasing out → retired)
- Enterprise metamodel = types & relationships; supports traceability & completeness.

Analogy
- Repo = indexed library with version control.

Exam relevance
- Know repository elements and what goes in each section.

Common Mistakes
- Uncontrolled duplication and no versioning.

Flashcard
- Q: Three classes of standards? A: Legal/regulatory, Industry, Organizational.

Practice Q
- Which repository element holds decision logs? (Governance repository)

One-Page Revision
- Keep repo tidy, versioned, and accessible.

30-day bullets
- Repo = single source
- Standards classified & lifecycle-managed
- Metamodel supports completeness checks
- Governance repo stores decision logs
- Requirements repo central for ADM
- SBS stored in resolution landscape
- Use repo assets before creating new ones
- Keep templates & viewpoints reusable

Visual sketch (ASCII): Repository structure (example)
  /repository
    /landscapes
      /strategic
      /segment
    /standards
      /api-security
      /data-governance
    /reference
      /templates
      /viewpoints
    /requirements
    /governance

Study tip: point to a file path in the repo when answering exam scenarios to show traceability (e.g., /repository/standards/api-security.md).

Enterprise metamodel: quick example (study-ready)
- Types: Capability, Application Component, Data Entity, Technology Component, Requirement, Work Package
- Example relationships (triples):
  - Capability "realized by" Application Component
  - Application Component "uses" Data Entity
  - Work Package "implements" Requirement

Standards lifecycle entry example
- Standard: "REST API security standard"
  - Status: Provisional
  - Owner: Security Architecture Board
  - Effective date: 2026-01-01
  - Rationale: Align APIs to enterprise IAM
  - Deprecation plan: Review in 12 months

Study tip: in exam scenarios, point to metamodel triples to show traceability from stakeholder concern → requirement → work package.

-- Page 13 — Exam Preparation & Time Management (detailed)

Big Picture
- Part 2 exam tests application of TOGAF in scenarios; practice under exam conditions.

Key Tips
- Use TOC of provided PDFs for quick lookup.
- Time strategy: allocate ~11 min / question; skip and return to hard ones.
- Question strategy: identify ADM phase and stakeholder concerns, eliminate distractors.

Practice Drill
- Simulate 8-question sets under 90 minutes; review incorrect answers and map to phases/artifacts.

Flashcard
- Q: Passing score? A: 24/40 (60%)

One-Page Revision
- Practice, timeboxing, TOC navigation skills.

30-day bullets
- Simulate full exam conditions
- Learn TOC positions for quick lookup
- Identify ADM phase from scenario
- Eliminate obviously wrong answers first
- Use repository references when allowed
- Check remaining time & review
- Prioritize quick wins
- Learn to extract facts from scenarios

Visual sketch (ASCII): Exam timebox matrix
  [90 minutes total]
  -----------------------------
  | Question 1-2: 20m | Quick wins |
  | Question 3-6: 44m | Mid-depth |
  | Question 7-8: 26m | Deep thought |
  -----------------------------

Exam tip: flag hard questions and return; use first 10 minutes to scan all 8 scenarios for quick wins.

Exam Drill — Quick Checklist (during exam)
- 1) Identify ADM phase(s) in scenario
- 2) List 3 affected stakeholders & their concerns
- 3) Find the artifact most likely required (e.g., Statement of Architecture Work, Roadmap, Requirements Spec)
- 4) Eliminate options that conflict with principles or constraints
- 5) Choose best-fit and note rationale in margin

Extra Flashcards — Exam Prep
- Q: How many questions in part 2? A: 8 scenario-based questions.
- Q: What's the passing %? A: 60% (24/40).

-- End of notebook --

If you want: I can export this file into separate GoodNotes pages (PDF) or split into one markdown file per video. Which export would you like next?

-- Additional per-lesson pages (expanded) --

-- Page: Course Structure (lesson)

Big Picture
- Course organized in nine sections; this lesson orients on structure and goals.

Key Points
- Course map: Intro → Core concepts → ADM → Techniques → Content → Capability → Security → Exam prep
  - Analogy: Course = roadmap; each section a milestone.
  - Visual (ASCII): [Intro] -> [Core] -> [ADM] -> [Techniques] -> [Exam]

Why It Matters
- Knowing structure helps chunk study sessions and schedule spaced repetition.

Exam relevance
- Recognize which sections produce which artifacts.

Practice Q
- How many sections are in the course? (Answer: 9 main sections)

30-day bullets
- Use roadmap to plan study sessions
- Prioritize ADM phases for practice
- Map videos to practice flashcards

Visual sketch (ASCII): Course map (chunking)
  [Intro] -> [Core Concepts] -> [ADM] -> [Techniques] -> [Exam Prep]

Study tip: plan 30–60 minute sessions per chunk; review flashcards after each chunk.

-- Page: Course Instructors (lesson)

Big Picture
- Two instructors: practical consultant and academic researcher—both bring applied examples.

Key Points
- Their backgrounds (consulting, PhD) signal balance of practice and theory.
  - Real-world tip: Listen for their examples; instructors often hint at exam-relevant distinctions.

Why It Matters
- Instructor emphasis signals exam focus (practical governance, artifacts).

Flashcard
- Q: Why note instructor background? A: It indicates practical vs theoretical emphasis.

30-day bullets
- Note recurring real-world examples
- Track instructor tips for exam prep

Visual sketch (ASCII): Instructor signal map
  [Instructor A: Practical] ---> real-world tips, governance examples
  [Instructor B: Academic ] ---> theory, definitions, exam rationale

Study tip: tag instructor quotes in notes as "practical" vs "theory" for quick review.

-- Page: Certification Program (lesson)

Big Picture
- Part 2 is scenario-based, open-book, 8 complex questions, 90 minutes (+60 if ESL).

Key Facts
- Scoring: best=5, second=3, third=1, distractor=0; pass = 24/40 (60%).
- Use provided PDFs; learn TOC navigation.

Exam Tips
- Practice finding terms in the provided PDFs quickly; bookmark common artifacts.

Practice Q
- What is the point structure for the best answer? (5 points)

30-day bullets
- 8 scenario questions, 90 minutes
- Passing score 24/40
- Open-book: get fast at TOC lookup

Visual sketch (ASCII): Exam essentials checklist
  [Format: 8 scenario Qs]  [Time: 90m]  [Open-book: PDFs]
  [Scoring: 5/3/1/0]  [Pass: 24/40]

Study tip: create a single-page cheat sheet with TOC anchors to common artifacts.

-- Page: Enterprise Architecture Purpose (lesson)

Big Picture
- EA guides change by describing baseline, target, and gaps; supports governance of change.

Key Concepts
- Purpose: align change to value, direct and control change activity, enable governance and risk mgmt.
  - Analogies: Map + governance compass.

Real-World
- Use EA to decide retire or upgrade legacy systems by tracing value.

Exam relevance
- Expect scenario questions asking about governance roles and outputs.

30-day bullets
- EA = baseline vs target
- Governance = direction + control
- Traceability to value is essential

Visual sketch (ASCII): Baseline → Gap → Target (value link)
  [Baseline] --(gaps)-> [Target]
      |                     |
  [Assets]             [Value Delivered]

Study tip: when answering exam scenarios, always map requirements to value delivery steps.

-- Page: Enterprise Architecture Landscape (lesson)

Big Picture
- Landscape is composed of multiple models and views populated over time via projects.

Key Concepts
- Models trade-off formality vs purpose; reuse is key; landscapes updated per projects only.

Visual Hook
- Multi-model stack: diagrams, catalogs, matrices, roadmaps.

Exam relevance
- Know that landscapes are developed incrementally—not all at once.

Practice Q
- Why not build the whole landscape proactively? (Answer: waste of effort without need)

30-day bullets
- Landscape = many connected models
- Formal models enable reuse
- Update per project

Visual sketch (ASCII): Model stack
  [Catalogs]
  [Diagrams]
  [Matrices]
  [Roadmaps]

Study tip: in a scenario, call out which model provides the quickest evidence (e.g., catalog vs diagram).

-- Page: Architecture States (lesson)

Big Picture
- Baseline, Candidate, Transition(s), Target, Resting states capture approval and realization status.

Key Concepts
- Transition architectures provide milestones and measurable business value.

Analogy
- Staircase: each step = transition architecture toward the top (target).

Exam relevance
- Roadmaps and transition architecture timing questions likely.

Practice Q
- What is a resting architecture? (A state with value even if change activity pauses)

30-day bullets
- Baseline = current reference
- Target = approved future
- Transition = incremental states

Visual sketch (ASCII): Staircase to Target
  [Baseline] -> [Transition1] -> [Transition2] -> [Target]

Study tip: identify measurable outcomes for each transition in answers (time, capability, KPI).

-- Page: Digital Enterprise (lesson)

Big Picture
- Four contexts for digital enterprise maturity: individual founder → team → teams of teams → enduring enterprise.

Key Concepts
- Each context has different EA focus: concept, product mgmt, coordination, governance & compliance.

Real-World
- Small startups emphasize rapid delivery; large enterprises emphasize governance and risk.

Exam relevance
- Recognize appropriate EA focus per organizational context.

30-day bullets
- 4 contexts: founder, team, teams-of-teams, enduring
- Focus shifts from product to governance

Visual sketch (ASCII): Context maturity funnel
  Founder -> Team -> Teams-of-teams -> Enduring

Study tip: match architecture emphasis (speed vs governance) to context in scenarios.

-- Page: Preliminary Phase (lesson)

Big Picture
- Build architecture capability: org model, tools, principles, governance baseline.

Key Steps
- Review org context, scope affected elements, define roles, tailor TOGAF, set maturity targets.

Analogy
- Set up workshop before starting a big program—define who, how, what.

Exam relevance
- Know that preliminary is about capability, not a deliverable architecture.

Practice Q
- What is a primary output of preliminary phase? (Answer: tailored architecture framework and principles)

30-day bullets
- Define org model and processes
- Set architecture principles
- Tailor TOGAF to org needs

Visual sketch (ASCII): Capability setup checklist
  [Org model] [Tools] [Principles] [Governance Board] [Templates]

Study tip: list 3 tailoring decisions and justify them by org constraints in exam answers.

-- Page: ADM Iteration (lesson)

Big Picture
- Iterations manage complexity: full ADM cycles, development iterations, capability iterations, transition planning iterations.

Key Points
- Use iterations to converge on detail only where needed; combine strategies (concurrent cycles + nested iterations).

Exam relevance
- Expect scenario where iteration choice affects scope and governance.

Practice Q
- When to run a preliminary-phase iteration? (If capability or principles need updating)

30-day bullets
- Iteration types: full ADM, development, capability, governance, transition
- Iterate to reduce risk and focus effort

Visual sketch (ASCII): Nested iterations model
  [Full ADM]
    [Development iterations]
      [Capability mini-iterations]

Study tip: explain iteration choice by risk, stakeholder readiness and delivery cadence.

-- Page: Business Scenario Technique (lesson)

Big Picture
- Structured way to derive architecture requirements from business problems (SMART criteria).

Key Steps
- Premise formulation → initial verification → refinement; document actors, outcomes, environment, value streams.

Exam relevance
- Use scenario technique to justify architecture choices in exam questions.

Practice Q
- What does SMART stand for? (Specific, Measurable, Actionable, Realistic, Time-bound)

30-day bullets
- Business scenarios inform requirements
- Use noun challenge for info concepts
- Iterate until fit-for-purpose

Visual sketch (ASCII): Business Scenario template
  Premise: ______
  Actors: ____ | Outcomes: ____ | Value: ____ | Timebox: ____

Study tip: in exam answers, format one-line business scenario using this template before proposing requirements.

-- Page: Gap Analysis (lesson)

Big Picture
- Identify accidental, deliberate, or open shortfalls between baseline and target.

Key Points
- Use metrics and matrices; classify gaps (eliminated/new/impacted) and create gap-closure options.

Exam relevance
- Gap matrices often basis for roadmaps and work packages.

Practice Q
- Name 2 gap types. (Eliminated, New)

30-day bullets
- Gaps drive work packages
- Use matrices to consolidate
- Map gaps to solutions & dependencies

Visual sketch (ASCII): Gap matrix (mini)
  Capability | Baseline | Target | Gap | Work Package
  X         |   2      |   4    |  +2 | WP-123

Study tip: show one-row gap matrix in scenario answers to justify chosen work package.

-- Page: Architecture Trade-off (lesson)

Big Picture
- Trade-off method: choose criteria, define alternatives, assess impacts, and select/merge.

Key Steps
- Define evaluation criteria from vision/principles → model alternatives → stakeholder review → select.

Exam relevance
- You may be asked to justify selection between alternatives using trade-off reasoning.

Practice Q
- What are typical trade-off criteria? (Value, cost, risk, time, compliance)

30-day bullets
- Define criteria explicitly
- Weight criteria with stakeholders
- Document rationale for chosen alternative

Visual sketch (ASCII): Trade-off scoring (mini)
  Criteria | Weight | Alt A score | Alt B score | Weighted A | Weighted B
  Cost     | 30%    | 7           | 5           | 2.1        | 1.5

Study tip: always state the scoring scale and tie-breaker when writing trade-off answers.

