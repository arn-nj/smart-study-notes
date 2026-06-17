# GoodNotes Notebook Format

## Visual Style
- Default notebook style is **squared paper** (graph paper look), not lined paper.
- Keep markdown content optimized for this layout: concise bullets, compact tables, and short ASCII diagrams.

## Page Delimiter
Use a bare `--` line between pages. The PDF script (`md_to_pdf_a4.py`) splits on lines that are exactly `--`.

## Page Structure (repeat for every video/lesson)

```markdown
-- Page N: <Exact Video Title>

## Big Picture
2-3 sentences: what this lesson is about + why it matters for the exam/practice.

## Key Concepts
- **Term**: concise definition
- **Term**: concise definition (aim for 4–8 terms per page)

## Process Flow / Steps
Numbered list of the main process or ADM phase steps.

## Visual Memory Hook
ASCII art or table that makes the concept memorable at a glance.
Example:
```
Baseline ──► [GAP Analysis] ──► Target
                  │
           Candidate Solutions
```

## Worked Example
**Scenario**: realistic business scenario in 1-2 sentences
**Steps**: walk through applying the concept
**Result**: what output or decision emerges

## Common Mistakes
Bulleted list of exam traps or real-world pitfalls.

## Exam Tips / Practice Questions
Q: <scenario question>  →  A: <expected answer/approach>
Q: <scenario question>  →  A: <expected answer/approach>

## Flashcards
| Q | A |
|---|---|
| What triggers …? | … |
| Primary purpose of …? | … |

## One-Page Revision
- bullet 1 (key takeaway)
- bullet 2
- bullet 3 (max 5)

## 30-Day Memory Bullets
(8 atomic facts — review on days 1,3,7,14,21,30)
1. Fact one
2. Fact two
…
8. Fact eight
```

## Enrichment Notes
- Add worked examples with concrete numbers/names wherever possible
- ASCII tables are preferred over prose lists for comparison content
- Flashcard count: aim for 4–6 per page minimum
- Exam tip: always note how the concept appears in scenario-style questions
