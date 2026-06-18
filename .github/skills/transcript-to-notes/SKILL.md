---
name: transcript-to-notes
description: "Transform a raw Udemy/course transcript (.txt) into ADHD-friendly GoodNotes-style handwritten study notes, an A4 PDF notebook, and an XMind-compatible mindmap. Use when: converting transcript to notes; creating study notes from transcript; generating mindmap from course; making PDF notebook from udemy transcript; 'make notes from this transcript'; 'create mindmap from course'; 'study notes from video'."
argument-hint: "path to transcript .txt file (relative to workspace root)"
user-invocable: true
---

# Transcript → GoodNotes Notes + XMind Mindmap

## What This Skill Does
Given a raw course transcript file, produce:
1. **`<CourseName>_GoodNotes_detailed.md`** — ADHD-friendly handwritten study notes, chunked by video/lesson or micro-lesson when needed
2. **`<CourseName>_GoodNotes_detailed_A4.pdf`** — A4 PDF for GoodNotes import
3. **`<CourseName>_course_videos_clean.mm`** — sanitized Freemind mindmap
4. **`<CourseName>_course_videos_fixed.xmind`** — XMind-ready mindmap
5. **`svg/` folder** — Hand-drawn SVG sketches for key concepts (auto-generated via content-to-sketch)
6. **`svg/INDEX.md`** — Visual reference guide with sketch metadata

All outputs go into a `<CourseName>/` subfolder alongside the source transcript.

## ADHD-Friendly Handwritten GoodNotes Design

### What's Included for ADHD Brains
- **Micro-chunking**: Keep each page to a 3-5 minute read; split long lessons into multiple micro-pages
- **Handwritten aesthetic**: GoodNotes-style notes that feel personal and approachable
- **Squared paper background**: Graph-paper visual anchoring for GoodNotes import
- **Frequent visual breaks**: ASCII diagrams, tables, icons, and sketches instead of dense prose
- **Time estimates**: Show how long each page should take to read
- **Difficulty ratings**: Mark pages as Easy, Medium, or Hard to reduce overwhelm
- **Action-first structure**: Put practical use before abstract explanation
- **Active recall built in**: Flashcards, quick questions, and checkpoints on every lesson
- **Spaced repetition schedule**: Explicit Day 1, 3, 7, 14, and 30 review cues
- **Whitespace heavy formatting**: Keep pages breathable and scannable
- **Concrete examples first**: Use real scenarios before theory
- **Progress signals**: Checkboxes and small completion markers for momentum

### What's Avoided
- Long paragraphs or lecture-style dumps
- Multiple new ideas packed into one bullet
- Abstract wording without examples
- Open-ended review advice like "revise later"
- Large blocks of uninterrupted text
- Passive explanations that hide the point

## Visual Style Default
- Use **squared background paper** style for GoodNotes-facing outputs.
- When generating PDFs via `scripts/md_to_pdf_a4.py`, keep the notebook background as squared grid paper.

## Workspace Layout

```
smart-study-notes/
├── <CourseName>/
│   ├── <source_transcript>.txt       ← input
│   ├── <CourseName>_GoodNotes_detailed.md
│   ├── <CourseName>_GoodNotes_detailed_A4.pdf
│   ├── <CourseName>_course_videos.mm
│   ├── <CourseName>_course_videos_clean.mm
│   ├── <CourseName>_course_videos_fixed.xmind
│   └── svg/                          ← auto-generated sketches
│       ├── <CourseName>_ProcessFlow_sketch.svg
│       ├── <CourseName>_KeyConcept1_sketch.svg
│       ├── <CourseName>_KeyConcept2_sketch.svg
│       ├── INDEX.md                  ← visual reference guide
│       ├── validate_svgs.sh          ← validation script
│       └── validation_report.txt     ← quality report
├── scripts/
│   ├── md_to_pdf_a4.py               ← reusable: Markdown → A4 PDF
│   └── mm_to_xmind.py                ← reusable: .mm → .xmind (legacy, replaced by generate_valid_xmind)
└── .github/skills/transcript-to-notes/
```

## Procedure

### Step 1 — Read the Transcript
- Read the `.txt` file in full
- Identify video/lesson boundaries (look for "Video N:", timestamps, or heading markers)
- Note course name, module structure, and key themes
- Flag dense lessons that should be split into multiple micro-pages instead of one long page
- Identify practical examples, repeated terms, and likely memory bottlenecks

### Step 2 — Generate ADHD-Friendly GoodNotes Notebook
See [handwritten-notebook-format-adhd](../pdf-to-notes/references/handwritten-notebook-format-adhd.md).

For each short video/lesson, create one page. If a lesson is dense, split it into 2-3 micro-pages. Use this exact structure:
```
-- Page N: <Video Title or Micro-Lesson>

## Header
⏱️ ~3 min | 📚 Video N | ⚡ Easy/Medium/Hard

## What You'll Learn
(1 sentence on why this matters to the learner right now)

## Core Idea (60 sec)
- One plain-language idea
- One concrete example

## Visual Summary
(ASCII diagram, compact table, or flowchart)

## Real-World Use First
Scenario: ...
Why it matters: ...

## Process Flow / Steps
1. Step one
2. Step two

## Key Concepts
- **Term**: definition in simple words
- **Term**: definition in simple words

## Quick Facts
Q: ...  A: ...
Q: ...  A: ...

## Try This Right Now
- 30-second action
- Observable result

## Common Mistakes
- Mistake 1
- Mistake 2

## Flashcards
| Q | A |
|---|---|
| question | answer |

## Spaced Repetition
- Day 1: ...
- Day 3: ...
- Day 7: ...
- Day 14: ...
- Day 30: ...

## One-Page Revision
- 3-5 bullets for a 30-second review

## Checkpoint
- [ ] I can explain this lesson in one sentence

## 30-Day Memory Bullets
- 8 single-line facts to revisit across 30 days
```

Separate pages with `--` on a line by itself (used as page delimiter by the PDF script).

Formatting rules for every page:
- Keep bullets short and concrete
- Put the real-world example before deeper explanation
- Use icons and whitespace for quick scanning
- Keep jargon paired with plain-English meaning
- Prefer one idea per bullet

### Step 3 — Create Freemind Mindmap (`.mm`)
See [mindmap format reference](./references/mindmap-format.md).

Build a hierarchical XML Freemind file:
- Root node: course name
- Level 1: page/lesson titles
- Level 2 per page: What You'll Learn, Core Idea, Visual Summary, Real-World Use, Key Concepts, Flashcards, Spaced Repetition, One-Page Revision
- Level 3+: subnodes from page content

**Critical**: escape ALL `&` as `&amp;` in node TEXT attributes. No bare `&` allowed.

### Step 4 — Convert .mm → .xmind
Run the converter script (uses Python venv):
```bash
source .venv/bin/activate
python scripts/generate_valid_xmind.py --input <CourseName>/<file>.mm --output <CourseName>/<file>.xmind
```
Or use the inline procedure in [xmind-conversion reference](./references/xmind-conversion.md).

### Step 5 — Generate SVG Sketches (content-to-sketch integration)
Use the **content-to-sketch** skill to create hand-drawn visuals for key concepts:

1. **Identify lesson topics and key concepts** from the transcript:
   - Core process flows (how the system works)
   - Architectural diagrams (component relationships)
   - Decision trees (if/then logic)
   - Comparison charts (before/after, with/without)
   - Multi-step workflows (build cycles, iteration loops)

   SVG count rules:
   - Minimum: `1 SVG per topic/lesson`
   - Default: derive SVG count from detected topics
   - Optional: user can request a higher fixed count
   - Never generate fewer SVGs than the number of selected topics

   Example requests:
   - `Generate one SVG for every lesson topic in this transcript.`
   - `Generate 14 SVGs total, but make sure each topic gets at least one.`
   - `Use topic-density mode so dense lessons can receive extra SVGs.`

2. **Create svg/ subfolder**:
```bash
mkdir -p <CourseName>/svg
```

3. **Generate SVG sketches** for each topic/concept:
   - Use squared paper background (GoodNotes compatible)
   - Include 15+ text labels per sketch (accessibility)
   - Keep file size under 10KB (3-6KB optimal)
   - Use high contrast colors (WCAG compliant)
   - Add arrows/markers for visual flow
   - Ensure every topic gets at least one SVG

4. **Validate all SVGs**:
```bash
cd <CourseName>/svg
for f in *.svg; do xmllint --noout "$f" && echo "✓ $f valid"; done
```

5. **Create validation script** (`validate_svgs.sh`):
```bash
#!/bin/bash
for f in *.svg; do
  xmllint --noout "$f" 2>&1 && echo "✓ $f" || echo "✗ $f"
done
```

6. **Create INDEX.md** with sketch metadata:
   - File names and descriptions
   - Which transcript sections they visualize
   - Quality metrics (labels, colors, size)

7. **Embed in markdown notes**:
```markdown
![Process Flow](./svg/<CourseName>_ProcessFlow_sketch.svg)
```

**Common SVG issues to fix:**
- Escape `&` as `&amp;` in text
- Use XML entities for special characters
- Ensure all tags are properly closed

### Step 6 — Export A4 PDF
```bash
source .venv/bin/activate
python scripts/md_to_pdf_a4.py <CourseName>/<file>.md <CourseName>/<file_A4>.pdf
```

The PDF will include embedded SVG sketches from the markdown.

### Step 7 — Move Files Into Course Folder
Ensure all outputs are inside `<CourseName>/` and scripts remain in `scripts/`.

## Python Environment
- Virtualenv: `.venv` at workspace root
- Required packages: `reportlab`, `markdown`, `xmind-sdk`
- Install once: `python3 -m venv .venv && .venv/bin/pip install -r requirements.txt`
- Use the venv Python at `.venv/bin/python` — **not** the system Python

## Quality Checklist
- [ ] Each page starts with time estimate and difficulty flag
- [ ] Each short lesson is 1 page; long lessons are split into 2-3 micro-pages
- [ ] Every page has: What You'll Learn, Core Idea, Visual Summary, Real-World Use, Flashcards, Spaced Repetition
- [ ] Bullets are short, concrete, and one idea each
- [ ] Real-world example appears before abstract explanation
- [ ] ASCII diagrams or tables appear on the core concept pages
- [ ] GoodNotes visual style uses squared paper background
- [ ] Mindmap `.mm` passes `xmllint --noout` without errors
- [ ] `.xmind` opens in XMind without "not a valid XMind File" error
- [ ] PDF page count matches Markdown page count
- [ ] Checkpoints and review prompts appear throughout the notes
- [ ] No page exceeds roughly 5 minutes of reading time

### SVG Sketch Quality (content-to-sketch integration)
- [ ] SVG count is explicit or derived from topic count
- [ ] Every topic/lesson has at least one SVG
- [ ] All SVGs in `svg/` subfolder with INDEX.md
- [ ] All SVGs pass XML validation (`xmllint --noout`)
- [ ] All ampersands escaped as `&amp;`
- [ ] Each sketch has 15+ text labels (accessibility)
- [ ] File sizes under 10KB (3-6KB optimal)
- [ ] High contrast colors (8-21 unique colors)
- [ ] Arrows/markers for visual flow
- [ ] Sketches embedded in markdown using image references from the local svg folder
- [ ] validation_report.txt shows 0 errors, 0 warnings

## Related Skills
- **content-to-sketch** — Generates the SVG sketches (auto-invoked in Step 5)
- **md-to-notes** — Alternative for markdown input
- **pdf-to-notes** — Alternative for PDF/book input
