# Freemind Mindmap Format

## File Structure
```xml
<map version="1.0.1">
  <node TEXT="Document Title">
    <node TEXT="Section 1">
      <node TEXT="Key Concept">
        <node TEXT="detail point 1"/>
        <node TEXT="detail point 2"/>
      </node>
      <node TEXT="Subsection">
        <node TEXT="item 1"/>
      </node>
      <node TEXT="Application">
        <node TEXT="real-world use"/>
      </node>
      <node TEXT="Flashcards &amp; Practice">
        <node TEXT="Q: ... A: ..."/>
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

## Level Convention
| Level | Content |
|-------|---------|
| 0 | Root Title (document title, course name) |
| 1 | Major sections (chapters, modules, or study topics) |
| 2 | Subsections or key concepts |
| 3 | Content nodes — definitions, steps, flashcard Q&A, applications |
| 4+ | Sub-details, sub-steps (use sparingly) |

## Validation
```bash
xmllint --noout <file>.mm && echo "Valid XML"
```
