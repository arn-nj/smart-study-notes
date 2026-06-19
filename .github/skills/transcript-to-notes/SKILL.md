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
7. **`<CourseName>_INDEX.md`** — Master topic index with all pages, key concepts, and flashcard questions
8. **`<CourseName>_AI_Elaboration.json` or `<CourseName>_AI_Elaboration.md`** — optional external AI synthesis for page-level elaboration used by the XMind enrichment step

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
- **Active recall built in**: Flashcards and quick questions on every lesson
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
│   ├── <CourseName>_INDEX.md         ← master topic index
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

## Deep Dive Explanation
- Explain the mechanism in 2-4 concrete bullets
- Add at least one cause-and-effect relationship
- Include one concrete example tied to the lesson

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

## Try This Right Now
- 30-second action
- Observable result

## Flashcards
| Q | A |
|---|---|
| question | answer |

## One-Page Revision
- 3-5 bullets for a 30-second review
```

Separate pages with `--` on a line by itself (used as page delimiter by the PDF script).

Formatting rules for every page:
- Keep bullets short and concrete
- Put the real-world example before deeper explanation
- Use icons and whitespace for quick scanning
- Keep jargon paired with plain-English meaning
- Prefer one idea per bullet
- Make remaining sections elaborative with mechanism, rationale, and impact details
- Do not create sections titled `Intro`, `Introduction`, `Core Idea`, `Quick Facts`, or `Common Mistakes`

### Step 3 — Create Freemind Mindmap (`.mm`)
See [mindmap format reference](./references/mindmap-format.md).

Build a hierarchical XML Freemind file:
- Root node: course name
- Level 1: page/lesson titles
- Level 2: use this exact schema in this exact order for every lesson:
   1. `Concept Deep Dive`
   2. `Worked Example`
   3. `Demo Walkthrough`
   4. `Advanced Scenario`
   5. `Trade-offs`
- Level 3+: elaborative subnodes from page content

Schema requirements:
- `Concept Deep Dive`: explain the mechanism and core model in plain language.
- `Worked Example`: include scenario, inputs, execution, and result.
- `Demo Walkthrough`: children must be `Goal`, `Setup`, `Steps`, `Expected Result`, `Why this works`.
- `Advanced Scenario`: include scenario setup, constraints, recommended decision, and concept-backed answer.
- `Trade-offs`: include options, benefits, costs, and decision guidance.

Do not include Flashcards as mindmap nodes; keep Flashcards only in the markdown notes.
Never include nodes titled or themed as Flashcards, Q/A, Questions & Answers, Interesting Talking Points, Pitfalls & Clarifications, Narrative Flow, In This Section, or What You'll Learn.
Never include instructional/meta coaching text as node content (for example: "What you'll learn", "Why it matters", "In summary, you'll learn", presenter instructions, or audience prompts).
Do not add `One-Page Revision` nodes to the mindmap.
Make Level 3+ child nodes complete, context-rich phrases (not terse labels).

**Critical**: escape ALL `&` as `&amp;` in node TEXT attributes. No bare `&` allowed.

### Step 4 — Convert .mm → .xmind
Run the converter script (uses Python venv):
```bash
source .venv/bin/activate
python scripts/generate_valid_xmind.py --input <CourseName>/<file>.mm --output <CourseName>/<file>.xmind
```
Or use the inline procedure in [xmind-conversion reference](./references/xmind-conversion.md).

### Step 4.5 - Generate Pitch Deck from XMind
Run the XMind deck skill pipeline after `.xmind` is produced:
```bash
cd .github/skills/xmind-to-pitch-deck
npm run build
npm run deck -- --input "<CourseName>/<CourseName>_course_videos_fixed.xmind" --out "<CourseName>/<CourseName>_pitch_deck.html" --auto-scroll false
```

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

### Step 5.5 — Generate External AI Elaboration Artifact
Create a separate AI synthesis file when you want richer XMind elaboration that is not limited to the GoodNotes markdown text.

This can be done for all notes in the course, not just a subset. The goal is to produce a page-by-page elaboration layer that complements every lesson page.

Suggested AI prompt to use:
```text
You are generating highly targeted, page-level AI elaboration for a student course notes package.

Input Sources:
- GoodNotes markdown pages (containing handwritten/typed course notes)
- SVG/index metadata when available
- Optional chapter/page index

Task:
For every page in the course, analyze the core academic concept and synthesize 1 to 10 highly specific elaboration lines. Your objective is to deepen the user's understanding of the concept without echoing what is already written.

Strict Formatting Rules:
1. JSON Output (Default): Output a single valid MINIFIED JSON object (no extra whitespace/newlines beyond what JSON requires) following this exact structural taxonomy per page:
{
   "pages": {
      "1": {
         "Concept Focus": ["Define the core underlying theory or mechanism in 1 sentence"],
         "Connecting Dots": ["Cross-reference this concept to a prior page or related course theme"],
         "Same Idea, Applied Elsewhere": ["Provide a concrete, real-world industry or academic application"],
         "Implications": ["Explain the downstream effect, practical outcome, or why this matters"],
         "Edge Case": ["Detail a specific scenario where this concept breaks down or behaves differently"]
      }
   }
}
2. Markdown Output (Only if explicitly requested): Keep the same structural taxonomy using a heading per page (e.g., "## Page 1") followed by prefix-led bullets that map to the same dimensions.
3. Universal Scope: Include every single page from the input source in the output. If a page contains low information density or simple diagrams, output exactly one line using the "Concept Focus:" prefix.

Strict Content Constraints:
- Zero Verbatim Repetition: Never reuse strings, phrases, or explicit definitions from the source notes.
- Ban Meta-Headings: Never restate or mirror structural headings from the input (e.g., "Scenario", "Why it matters", "In summary").
- Anchor to Evidence: Every elaboration line must be heavily anchored in the specific page content. Do not use generic filler, broad definitions, or introductory phrases.
- Zero Schema Deviation: Do not invent new prefixes. Stick exclusively to the five specified structural anchors: Concept Focus, Connecting Dots, Same Idea (Applied Elsewhere/Different Layer), Implications, and Edge Case.
- Do NOT include empty arrays for dimensions that have no insights on a given page; omit the dimension key entirely to keep the payload clean.

Synthesis Criteria and Labels:
- Every dimension key must map to an array of strings.
- If a specific dimension has multiple distinct points, include each point as its own array item under that same dimension.

Example Dimension Formatting:
- "Implications": ["Main downstream impact point"]
- "Implications": ["First distinct downstream impact", "Second distinct downstream impact"]

Output Format:
```json
{
   "pages": {
     "1": {
        "Concept Focus": ["Core technical anchor of the page"],
        "Implications": [
           "Increased memory usage during high-concurrency states",
           "Higher CPU overhead due to constant cache misses"
        ],
        "Edge Case": ["Fails silently when system clock drifts by >50ms"]
     },
     "2": {
        "Concept Focus": ["Core technical anchor of the page"],
        "Connecting Dots": ["Links local variables to global state mutations"]
     }
   }
}
```
```

Recommended format:
- **JSON**: `<CourseName>_AI_Elaboration.json`
- **Markdown**: `<CourseName>_AI_Elaboration.md`

Recommended page-scoped structure:
```json
{
   "pages": {
      "1": {
         "Concept Focus": ["..."],
         "Connecting Dots": ["..."],
         "Same Idea, Applied Elsewhere": ["..."],
         "Implications": ["...", "..."],
         "Edge Case": ["..."]
      },
      "2": {
         "Concept Focus": ["..."],
         "Same Idea, Different Layer": ["..."],
         "Implications": ["..."]
      }
   }
}
```

Rules:
- Keep the elaboration separate from the main GoodNotes markdown.
- Use concise, page-specific synthesis instead of repeating the note text.
- Prefer JSON if the content is generated by another tool or model.
- The XMind converter will auto-detect this file when it sits beside the course files.
- If you generate it for the whole course, include an entry for every page, even if some pages only need a short `Concept Focus` line.

**Common SVG issues to fix:**
- Escape `&` as `&amp;` in text
- Use XML entities for special characters
- Ensure all tags are properly closed

### Step 6 — Generate Topic Index
Create `<CourseName>_INDEX.md` inside the course folder. This file is a master index of everything in the notebook.

**Structure:**
```markdown
# <CourseName> — Topic Index

> Quick-navigation index for all pages, concepts, and review items.

## Table of Contents
| # | Page Title | Difficulty | Topics Covered |
|---|-----------|-----------|----------------|
| 1 | Page 1 title | Easy | topic A, topic B |
| 2 | Page 2 title | Medium | topic C |
...

## All Key Concepts (A–Z)
Alphabetically sorted master glossary:
- **ConceptName** — one-line plain-English definition *(Page N)*
- **ConceptName** — ... *(Page N)*

## All Flashcard Questions
Flat list of every Q&A from every page — ideal for bulk review:
| Q | A | Page |
|---|---|------|
| question | answer | N |

## Quick-Find by Topic
Group-by-theme cross-reference (manually assigned to broad themes):
### <Theme 1>
- Page N: page title — key concept
- Page N: page title — key concept
### <Theme 2>
- ...

```

**Rules:**
- Table of Contents must list every page (1 row per page)
- Key Concepts A–Z: collect all bolded terms from all pages, de-duplicate, sort alphabetically
- Flashcard table: copy all `| Q | A |` rows from all pages, add a Page column
- Quick-Find groups: assign pages to 3-6 broad themes based on content

### Step 7 — Export A4 PDF
```bash
source .venv/bin/activate
python scripts/md_to_pdf_a4.py <CourseName>/<file>.md <CourseName>/<file_A4>.pdf
```

The PDF will include embedded SVG sketches from the markdown.

### Step 8 — Move Files Into Course Folder
Ensure all outputs are inside `<CourseName>/` and scripts remain in `scripts/`.

## Python Environment
- Virtualenv: `.venv` at workspace root
- Required packages: `reportlab`, `markdown`, `xmind-sdk`
- Install once: `python3 -m venv .venv && .venv/bin/pip install -r requirements.txt`
- Use the venv Python at `.venv/bin/python` — **not** the system Python

## Quality Checklist
- [ ] Each page starts with time estimate and difficulty flag
- [ ] Each short lesson is 1 page; long lessons are split into 2-3 micro-pages
- [ ] Every page has: What You'll Learn, Deep Dive Explanation, Visual Summary, Real-World Use, Flashcards
- [ ] Bullets are short, concrete, and one idea each
- [ ] Real-world example appears before abstract explanation
- [ ] ASCII diagrams or tables appear on the core concept pages
- [ ] GoodNotes visual style uses squared paper background
- [ ] Mindmap `.mm` passes `xmllint --noout` without errors
- [ ] `.xmind` opens in XMind without "not a valid XMind File" error
- [ ] PDF page count matches Markdown page count
- [ ] No page exceeds roughly 5 minutes of reading time
- [ ] `<CourseName>_INDEX.md` exists in course folder
- [ ] Index Table of Contents has one row per note page
- [ ] Key Concepts A–Z covers all bolded terms from all pages
- [ ] Flashcard table includes every Q&A row with page reference

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

