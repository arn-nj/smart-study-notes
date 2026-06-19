# Freemind Mindmap Format

## File Structure
```xml
<map version="1.0.1">
  <node TEXT="Document Title">
    <node TEXT="Section 1">
      <node TEXT="Concept Deep Dive">
        <node TEXT="Mechanism explained in plain language"/>
      </node>
      <node TEXT="Worked Example">
        <node TEXT="Scenario: ..."/>
        <node TEXT="Inputs: ..."/>
        <node TEXT="Result: ..."/>
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Goal: what the demo proves"/>
        <node TEXT="Setup: environment and prerequisites"/>
        <node TEXT="Steps: ordered actions"/>
        <node TEXT="Expected Result: what should happen"/>
        <node TEXT="Why this works: concept-backed explanation"/>
      </node>
      <node TEXT="Advanced Scenario">
        <node TEXT="Scenario with constraints and trade-offs"/>
        <node TEXT="Recommended decision"/>
        <node TEXT="Concept-backed answer"/>
      </node>
      <node TEXT="Trade-offs">
        <node TEXT="Option A vs Option B with costs and benefits"/>
      </node>
    </node>
  </node>
</map>
```

## Mandatory Rules
1. **Escape ampersands**: `&` → `&amp;` in every TEXT attribute
2. **No control characters** (tabs, form feeds, non-printable bytes) in TEXT attributes
3. **UTF-8 encoding** declared in XML header: `<?xml version="1.0" encoding="UTF-8"?>`
4. Root `<map>` contains exactly **one** top-level `<node>` (the document or course name)
5. For each section node, include this exact Level 2 schema in this order: `Concept Deep Dive`, `Worked Example`, `Demo Walkthrough`, `Advanced Scenario`, `Trade-offs`
6. `Demo Walkthrough` children must be exactly: `Goal`, `Setup`, `Steps`, `Expected Result`, `Why this works`
7. `Advanced Scenario` must include: scenario setup, constraints, recommended decision, concept-backed answer
8. `Trade-offs` must include options, benefits, costs, and decision guidance
9. Do not include Flashcards as mindmap nodes
10. Never include nodes titled or themed as In This Section, What You'll Learn, Narrative Flow, Q/A, Interesting Talking Points, or Pitfalls & Clarifications
11. Never include instructional/meta coaching text in node content (for example: Why it matters, In summary, you'll learn)
12. Level 3+ nodes must be elaborative, context-rich phrases (not terse labels)
13. Do not add `Spaced Repetition` or `One-Page Revision` nodes to mindmaps

## Level Convention
| Level | Content |
|-------|---------|
| 0 | Root Title (document title, course name) |
| 1 | Major sections (chapters, modules, or study topics) |
| 2 | `Concept Deep Dive`, `Worked Example`, `Demo Walkthrough`, `Advanced Scenario`, `Trade-offs` |
| 3 | Content nodes — elaborative, audience-friendly explanations and examples |
| 4+ | Sub-details, sub-steps (use sparingly) |

## Validation
```bash
xmllint --noout <file>.mm && echo "Valid XML"
```

