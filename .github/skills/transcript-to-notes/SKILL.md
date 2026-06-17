---
name: transcript-to-notes
description: >
  Transform a raw Udemy/course transcript (.txt) into GoodNotes-style handwritten study notes,
  an A4 PDF notebook, and an XMind-compatible mindmap.
  Use when: converting transcript to notes; creating study notes from transcript;
  generating mindmap from course; making PDF notebook from udemy transcript;
  "make notes from this transcript"; "create mindmap from course"; "study notes from video".
argument-hint: "path to transcript .txt file (relative to workspace root)"
user-invocable: true
---

# Transcript → GoodNotes Notes + XMind Mindmap

## What This Skill Does
Given a raw course transcript file, produce:
1. **`<CourseName>_GoodNotes_detailed.md`** — one Markdown page per video/lesson, study-first format
2. **`<CourseName>_GoodNotes_detailed_A4.pdf`** — A4 PDF for GoodNotes import
3. **`<CourseName>_course_videos_clean.mm`** — sanitized Freemind mindmap
4. **`<CourseName>_course_videos_fixed.xmind`** — XMind-ready mindmap

All outputs go into a `<CourseName>/` subfolder alongside the source transcript.

## Visual Style Default
- Use **squared background paper** style for GoodNotes-facing outputs.
- When generating PDFs via `scripts/md_to_pdf_a4.py`, keep the notebook background as squared grid paper.

## Workspace Layout

```
transcript-notes/
├── <CourseName>/
│   ├── <source_transcript>.txt       ← input
│   ├── <CourseName>_GoodNotes_detailed.md
│   ├── <CourseName>_GoodNotes_detailed_A4.pdf
│   ├── <CourseName>_course_videos.mm
│   ├── <CourseName>_course_videos_clean.mm
│   └── <CourseName>_course_videos_fixed.xmind
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

### Step 2 — Generate GoodNotes Notebook (`SKILL_notes.md` template)
See [notebook format reference](./references/notebook-format.md).

For each video/lesson, create one page with this exact structure:
```
-- Page N: <Video Title>

## Big Picture
(2-3 sentence summary of what this lesson covers and why it matters)

## Key Concepts
- **Term**: definition
- **Term**: definition

## Process Flow / Steps
1. Step one
2. Step two

## Visual Memory Hook (ASCII)
(ASCII diagram or table that visualises the concept)

## Worked Example
Scenario: ...
Steps: ...
Result: ...

## Common Mistakes
- Mistake 1
- Mistake 2

## Exam Tips / Practice Questions
Q: ...  A: ...
Q: ...  A: ...

## Flashcards
| Q | A |
|---|---|
| question | answer |

## One-Page Revision
(3-5 bullet summary for 30-second review)

## 30-Day Memory Bullets
(8 single-line facts to revisit across 30 days)
```

Separate pages with `--` on a line by itself (used as page delimiter by the PDF script).

### Step 3 — Create Freemind Mindmap (`.mm`)
See [mindmap format reference](./references/mindmap-format.md).

Build a hierarchical XML Freemind file:
- Root node: course name
- Level 1: page/lesson titles
- Level 2 per page: Big Picture, Key Concepts, Process Flow, Worked Example, Flashcards, Practice Questions, One-Page Revision, 30-Day Bullets
- Level 3+: subnodes from page content

**Critical**: escape ALL `&` as `&amp;` in node TEXT attributes. No bare `&` allowed.

### Step 4 — Convert .mm → .xmind
Run the converter script (uses Python venv):
```bash
source .venv/bin/activate
python scripts/generate_valid_xmind.py --input <CourseName>/<file>.mm --output <CourseName>/<file>.xmind
```
Or use the inline procedure in [xmind-conversion reference](./references/xmind-conversion.md).

### Step 5 — Export A4 PDF
```bash
source .venv/bin/activate
python scripts/md_to_pdf_a4.py <CourseName>/<file>.md <CourseName>/<file_A4>.pdf
```

### Step 6 — Move Files Into Course Folder
Ensure all outputs are inside `<CourseName>/` and scripts remain in `scripts/`.

## Python Environment
- Virtualenv: `.venv` at workspace root
- Required packages: `reportlab`, `markdown`, `xmind-sdk`
- Install once: `python3 -m venv .venv && .venv/bin/pip install -r requirements.txt`
- Use the venv Python at `.venv/bin/python` — **not** the system Python

## Quality Checklist
- [ ] One page per video (not per section)
- [ ] Every page has: Big Picture, Key Concepts, Worked Example, Flashcards, 30-Day Bullets
- [ ] ASCII diagrams on at least the core concept pages
- [ ] GoodNotes visual style uses squared paper background
- [ ] Mindmap `.mm` passes `xmllint --noout` without errors
- [ ] `.xmind` opens in XMind without "not a valid XMind File" error
- [ ] PDF page count matches Markdown page count
