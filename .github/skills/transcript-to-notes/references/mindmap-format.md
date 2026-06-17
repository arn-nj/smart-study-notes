# Freemind Mindmap Format

## File Structure
```xml
<map version="1.0.1">
  <node TEXT="Course Name">
    <node TEXT="Page 1 — Lesson Title">
      <node TEXT="Big Picture">
        <node TEXT="summary point 1"/>
        <node TEXT="summary point 2"/>
      </node>
      <node TEXT="Key Concepts">
        <node TEXT="Term: definition"/>
      </node>
      <node TEXT="Process Flow">
        <node TEXT="Step 1"/>
        <node TEXT="Step 2"/>
      </node>
      <node TEXT="Worked Example">
        <node TEXT="Scenario: ..."/>
        <node TEXT="Result: ..."/>
      </node>
      <node TEXT="Flashcards &amp; Practice">
        <node TEXT="Q: ... A: ..."/>
      </node>
      <node TEXT="One-Page Revision">
        <node TEXT="key takeaway"/>
      </node>
      <node TEXT="30-day bullets">
        <node TEXT="fact 1"/>
      </node>
    </node>
  </node>
</map>
```

## Mandatory Rules
1. **Escape ampersands**: `&` → `&amp;` in every TEXT attribute
2. **No control characters** (tabs, form feeds, non-printable bytes) in TEXT attributes
3. **UTF-8 encoding** declared in XML header: `<?xml version="1.0" encoding="UTF-8"?>`
4. Root `<map>` contains exactly **one** top-level `<node>` (the course name)

## Level Convention
| Level | Content |
|-------|---------|
| 0 | Course Name (root) |
| 1 | Page title e.g. "Page 3 — ADM Overview &amp; Phase A" |
| 2 | Section heading e.g. "Big Picture", "Key Concepts", "Worked Example" |
| 3 | Content nodes — definitions, steps, flashcard Q&amp;A |
| 4+ | Sub-details, sub-steps (use sparingly) |

## Validation
```bash
xmllint --noout <file>.mm && echo "Valid XML"
```
