# Architecture Document Template

Use this as the default structure for `Architecture_Document.md`.

## 1. Executive Summary
- Initiative name
- Problem statement
- Recommended architecture direction
- Top 3 decision drivers
- Top 3 risks or open issues

## 2. Business Context
- Background
- Business goals and expected outcomes
- Scope and out-of-scope items
- Stakeholders and decision owners
- Constraints and dependencies

## 3. Source and Confidence Summary
| Topic | Source | Confidence | Notes |
|---|---|---|---|
| Example requirement | BRD v2 | Confirmed | Approved by sponsor |

## 4. Baseline State
- Existing systems
- Current process pain points
- Current integrations
- Current operational issues

## 5. Target State
- Target business capability
- Target user journey or operating model
- Target system landscape
- Expected benefits and measurable outcomes

## 6. Requirements Summary
### Functional Requirements
| ID | Requirement | Source | Status | Notes |
|---|---|---|---|---|

### Non-Functional Requirements
Reference `NFR_Catalog.md` and summarize only the architecture-significant items here.

## 7. Architecture Principles and Assumptions
### Principles
- Principle

### Assumptions
| ID | Assumption | Impact if False | Status |
|---|---|---|---|

## 8. Candidate Architecture Options
### Option 1 — <Name>
- Summary
- Main components
- Data and integration approach
- Security implications
- Deployment model
- Pros
- Cons
- Risks
- Best-fit conditions

### Option 2 — <Name>
- Same structure

### Option 3 — <Name>
- Same structure if relevant

## 9. Option Comparison Matrix
| Criterion | Option 1 | Option 2 | Option 3 | Notes |
|---|---|---|---|---|
| Business fit |  |  |  |  |
| Delivery speed |  |  |  |  |
| Scalability |  |  |  |  |
| Security/compliance fit |  |  |  |  |
| Operability |  |  |  |  |
| Cost/complexity |  |  |  |  |

## 10. Recommended Architecture
- Chosen option
- Why it was chosen
- What was rejected and why
- Preconditions for success

## 11. Architecture Visuals Summary
### Required Stakeholder Diagrams
- Context diagram
- Container or component diagram
- Critical process or sequence diagram
- Deployment or environment diagram
- ER diagram for key business entities

For each diagram include:
- Diagram ID
- Purpose
- Audience
- Source references
- Link to Mermaid, SVG, or Visio build notes

## 12. Domain Views
### Business Architecture View
- Core business process changes
- Roles and responsibilities

### Application Architecture View
- Major services or applications
- Component responsibilities
- Interface overview

### Data Architecture View
- Key entities and ownership
- Sources of truth
- Data movement and retention notes

### Technology Architecture View
- Runtime platform
- Network or hosting considerations
- Deployment topology

### Integration View
- Upstream/downstream systems
- Integration style
- Contract and failure handling notes

### Security View
- Identity and access approach
- Sensitive data handling
- Threat or control highlights

### Operations View
- Logging, monitoring, alerting
- Support model
- Backup, recovery, and resilience notes

## 13. Domain Image Prompt Summary
Reference `Domain_Image_Prompts.md` and summarize what visual prompt exists for:
- Business architecture
- Data architecture
- Application architecture
- Technology architecture

## 14. NFR Impact Summary
| NFR ID | Requirement | Architectural Impact | Validation Approach |
|---|---|---|---|

## 15. Risks, Dependencies, and Mitigations
| ID | Type | Description | Impact | Mitigation | Owner |
|---|---|---|---|---|---|

## 16. Unresolved Items and Questions
| ID | Question | Why It Matters | Needed From | Status |
|---|---|---|---|---|

## 17. Next Steps
- Immediate decisions needed
- Information still required
- Follow-up sessions or validations
