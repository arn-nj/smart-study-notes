---
name: pdf-to-notes
description: >
  Transform a PDF book into GoodNotes-style handwritten study notes with strategic chunking,
  memory-retention techniques, and real-world applications. Optimized for large texts with
  ADHD-friendly features. Use when: converting book to notes; creating handwritten study materials;
  breaking down dense textbooks; "make notes from this PDF"; "create study notes from book";
  "organize book into notes".
argument-hint: "path to PDF file or book excerpt (relative to workspace root)"
user-invocable: true
---

# PDF Book → GoodNotes Handwritten Study Notes

## What This Skill Does
Given a PDF book or large text, produce:
1. **`<BookName>_GoodNotes_detailed.md`** — chunked by chapter/section with handwritten-style formatting
2. **`<BookName>_GoodNotes_detailed_A4.pdf`** — A4 PDF with squared paper background (ready for GoodNotes import)
3. **`<BookName>_Quick_Reference.md`** — 1-page visual summaries per major section
4. **`<BookName>_Action_Items.md`** — executable takeaways and real-world applications
5. **`<BookName>_book_mindmap.xmind`** — XMind mindmap showing chapter relationships and themes
6. **`svg/` folder** — Hand-drawn SVG sketches for key concepts (auto-generated via content-to-sketch)
7. **`svg/INDEX.md`** — Visual reference guide with sketch metadata
8. **`<BookName>_AI_Elaboration.json` or `<BookName>_AI_Elaboration.md`** — optional external AI synthesis for page-level elaboration used by downstream XMind enrichment

All outputs go into a `<BookName>/` subfolder.

## ADHD-Friendly Handwritten GoodNotes Design

### ✓ What's Included for ADHD Brains
- **Micro-chunking**: 3–5 min read per page (prevents hyperfocus derailment + working memory overload)
- **Handwritten aesthetic**: Warm, friendly fonts that feel personal and engaging
- **Squared paper background**: Tactile graph paper grid for kinesthetic learners + visual anchoring
- **Frequent visual breaks**: Icons, ASCII diagrams, color-coded sections prevent text fatigue
- **Time estimates**: Every section labeled with exact read time (reduces anxiety about "how long?")  
- **Difficulty ratings**: Easy/Medium/Hard flags prevent cognitive overwhelm (executive function support)
- **Progress checkboxes**: ✓ dopamine hits after each micro-section (engagement + completion feedback)
- **Action-first approach**: "Try This Right Now" before abstract explanation (executive scaffolding)
- **Quick facts**: Flashcard Q&A format forces active retrieval (combat working memory limits)
- **Real-world examples first**: Concrete scenarios before theory (interest-dependent attention)
- **Hyperlinks + anchor navigation**: Jump to topics non-linearly (supports scattered attention patterns)
- **Emoji + icons**: Visual cues for quick section identification (supports ADHD scanning)
- **Whitespace heavy**: Breathing room between concepts (reduces cognitive load)

### ✗ What's Avoided
- Long paragraphs (max 2–3 sentences per bullet)
- Abstract language without concrete examples
- Dense, wall-of-text sections that trigger avoidance
- Vague or open-ended learning goals
- Passive voice or hedging language ("might", "could")
- More than 1 idea per bullet point
- Review schedules that require memory ("study sometime next week")

## Procedure

### Step 1 — Extract and Assess the PDF
- Extract text or use PDF reader with copy support
- Identify chapter/section boundaries
- Note total page count and complexity level
- Plan chunking strategy (see [pdf-chunking-strategy](./references/pdf-chunking-strategy.md))

### Step 2 — Organize by Chapter/Section
- Split book into **major sections** (chapters, modules, parts)
- Each section → 1 note document with multiple 3–5 min micro-pages
- Label sections with time estimates and difficulty ratings

### Step 3 — Generate ADHD-Friendly GoodNotes Markdown
See [handwritten-notebook-format-adhd](./references/handwritten-notebook-format-adhd.md) for complete design rules.

For each micro-chunk (every 3–5 minutes of content), create one page with ADHD support built-in:
- **Header with time + difficulty**: ⏱️ ~3 min | 📚 Chapter X | ⚡ Easy/Medium/Hard (executive scaffolding)
- **Hook first**: "What You'll Learn" (personal benefit, not abstract topic)
- **Visual summary**: ASCII diagram, table, or flowchart (NOT paragraphs)
- **Real-world application FIRST**: Concrete scenarios (interest-dependent attention)
- **Deep explanation required**: expand each key concept with mechanism, rationale, and impact
- **Try This Right Now**: ≤30 seconds + observable result + "why it matters"
- **Whitespace + icons**: Generous spacing + ⏱️📚⚡✓🗓️ for quick scanning
- Do not create sections titled `Intro`, `Introduction`, `Core Idea`, `Quick Facts`, or `Common Mistakes`

### Step 4 — Create Quick Reference Pages
One visual 1-pager per major section:
- Chapter title + 3 key takeaways
- 1 main diagram or table
- 3 action items
- Link back to full notes

### Step 5 — Extract Action Items Document
- All "Try This Right Now" steps compiled
- Organized by priority (quick wins first)
- Include difficulty and time estimates
- Cross-reference back to source chapter

### Step 5.5 — Generate External AI Elaboration Artifact
Create a separate AI synthesis file when you want richer XMind elaboration that is not limited to the PDF/book text.

This can be done for all notes in the book, not just a subset. The goal is to produce a page-by-page elaboration layer that complements every chapter or micro-section.

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
- **JSON**: `<BookName>_AI_Elaboration.json`
- **Markdown**: `<BookName>_AI_Elaboration.md`

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
- The XMind converter will auto-detect this file when it sits beside the book files.
- If you generate it for the whole book, include an entry for every page, even if some pages only need a short `Concept Focus` line.

### Step 6 — Generate SVG Sketches (content-to-sketch integration)
Use the **content-to-sketch** skill to create hand-drawn visuals for key concepts:

1. **Identify topics and key concepts** from the PDF:
   - Core process flows (how the system works)
   - Architectural diagrams (component relationships)
   - Decision trees (if/then logic)
   - Comparison charts (before/after, with/without)
   - Chapter summary visuals (key takeaways)

   SVG count rules:
   - Minimum: `1 SVG per topic/chapter section`
   - Default: derive SVG count from detected topics or chapter sections
   - Optional: user can request a fixed total count
   - Never generate fewer SVGs than the number of selected topics

   Example requests:
   - `Generate one SVG for every chapter section in this book summary.`
   - `Generate 18 SVGs total, but keep one minimum per topic.`
   - `Use topic-density mode so heavier sections get more diagrams.`

2. **Create svg/ subfolder**:
```bash
mkdir -p <BookName>/svg
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
cd <BookName>/svg
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
   - Which chapters/sections they visualize
   - Quality metrics (labels, colors, size)

7. **Embed in markdown notes**:
```markdown
![Process Flow](./svg/<BookName>_ProcessFlow_sketch.svg)
```

**Common SVG issues to fix:**
- Escape `&` as `&amp;` in text
- Use XML entities for special characters
- Ensure all tags are properly closed

### Step 7 — Create Freemind Mindmap (`.mm`)
See [mindmap format reference](./references/mindmap-format.md).

Build a hierarchical XML Freemind file:
- Root node: book title
- Level 1: chapters or major sections
- Level 2: use this exact schema in this exact order for every chapter/section:
   1. `Concept Deep Dive`
   2. `Worked Example`
   3. `Demo Walkthrough`
   4. `Advanced Scenario`
   5. `Trade-offs`
- Level 3+: elaborative nodes derived from chapter content

Schema requirements:
- `Concept Deep Dive`: explain mechanism and conceptual model clearly.
- `Worked Example`: include scenario, inputs, execution, and result.
- `Demo Walkthrough`: children must be `Goal`, `Setup`, `Steps`, `Expected Result`, `Why this works`.
- `Advanced Scenario`: include scenario setup, constraints, recommended decision, and concept-backed answer.
- `Trade-offs`: include options, benefits, costs, and decision guidance.

Do not include Flashcards as mindmap nodes; keep Flashcards only in the markdown notes.
Never include nodes titled or themed as Flashcards, Q/A, Questions & Answers, Interesting Talking Points, Pitfalls & Clarifications, Narrative Flow, In This Section, or What You'll Learn.
Never include instructional/meta coaching text as node content (for example: "What you'll learn", "Why it matters", "In summary, you'll learn", presenter instructions, or audience prompts).
Do not add `One-Page Revision` nodes to the mindmap.
Make Level 3+ child nodes complete, context-rich phrases (not terse labels).

**Critical**: Escape ALL `&` as `&amp;` in node TEXT attributes. No bare `&` allowed.

### Step 8 — Convert .mm → .xmind
Run the converter script (uses Python venv):
```bash
cd /Users/arya/my-space/smart-study-notes
.venv/bin/python scripts/generate_valid_xmind.py <BookName>/<file>.mm <BookName>/<file>.xmind
```

Or use the inline procedure in [xmind-conversion reference](./references/xmind-conversion.md).

### Step 9 — Export A4 PDF
```bash
cd /Users/arya/my-space/smart-study-notes
.venv/bin/python scripts/md_to_pdf_a4.py <BookName>/<file>.md <BookName>/<file_A4>.pdf
```

The PDF will use squared paper background for handwritten aesthetic in GoodNotes and include embedded SVG sketches.

### Step 10 - Generate Pitch Deck from XMind
After `.xmind` is generated, run the XMind deck skill pipeline:
```bash
cd .github/skills/xmind-to-pitch-deck
npm run build
npm run deck -- --input "<BookName>/<file>.xmind" --out "<BookName>/<BookName>_pitch_deck.html" --auto-scroll false
```

## Strategic Chunking for Large Books

### For Textbooks (100–300 pages)
- Split by chapter (1 chunk per chapter)
- If chapter > 30 pages, further subdivide by learning outcome
- Max 2–3 pages of chunked notes per chapter

### For Non-Fiction (200–400 pages)
- Group by theme or argument arc
- 1 chunk = 1 idea cluster (20–40 page range)
- Avoid mid-sentence breaks; chunk at natural section boundaries

### For Reference Books (500+ pages)
- Chunk by section/module independently
- Prioritize user's stated learning goals first
- Create index of all chunks + full mindmap

## Python Environment
- Virtualenv: `.venv` at workspace root
- Required packages: `reportlab`, `markdown`, `xmind-sdk`, `pypdf`
- Install: `python3 -m venv .venv && .venv/bin/pip install -r requirements.txt`
- Use: `.venv/bin/python` — **not** the system Python

## ADHD-Optimized Notes Quality Checklist
- [ ] Each page starts with a 1-sentence hook explaining personal benefit ("Why should I care?")
- [ ] Read time ⏱️ is visible at top (anxiety reduction: "How long will this take?")
- [ ] Difficulty flag (Easy/Medium/Hard) is visible (prevents overwhelm)
- [ ] Text uses short bullets only (max 10 words per bullet)
- [ ] At least 1 visual per page: ASCII diagram, table, or flowchart (not just text)
- [ ] Real-world application comes BEFORE abstract explanation
- [ ] "Try This Right Now" action is concrete and ≤30 seconds (executive scaffolding)
- [ ] Flashcards force active recall (not just recognition)
- [ ] Progress checkboxes ✓ visible (dopamine feedback after each section)
- [ ] Whitespace is generous between concepts (breathing room)
- [ ] Hyperlinks + anchors allow non-linear navigation (scattered attention support)
- [ ] Emoji + icons used for quick visual scanning
- [ ] PDF has squared paper background (tactile, handwritten feel for GoodNotes)
- [ ] Mindmap `.mm` passes `xmllint --noout` without errors (XML validity)
- [ ] `.xmind` opens in XMind without "not a valid XMind File" error
- [ ] Mindmap is visual and interactive (big-picture understanding, not overwhelming)
- [ ] No jargon without explanation (working memory support)
- [ ] No multiple ideas per paragraph (one concept = one bullet)

## Quality Checklist
- [ ] Chunking respects book's natural section boundaries
- [ ] All terminology is explained in simple vocabulary
- [ ] Every page includes actionable application
- [ ] No page exceeds 5 minutes of reading
- [ ] Quick reference pages are scannable in <1 minute
- [ ] Action items are prioritized by ease and immediate impact
- [ ] PDF and mindmap are generated without errors
- [ ] All outputs are in the `<BookName>/` folder

### SVG Sketch Quality (content-to-sketch integration)
- [ ] SVG count is explicit or derived from topic count
- [ ] Every topic/chapter section has at least one SVG
- [ ] All SVGs in `svg/` subfolder with INDEX.md
- [ ] All SVGs pass XML validation (`xmllint --noout`)
- [ ] All ampersands escaped as `&amp;`
- [ ] Each sketch has 15+ text labels (accessibility)
- [ ] File sizes under 10KB (3-6KB optimal)
- [ ] High contrast colors (8-21 unique colors)
- [ ] Arrows/markers for visual flow
- [ ] Sketches embedded in markdown with `![](./svg/...)` references
- [ ] validation_report.txt shows 0 errors, 0 warnings

## Related Skills
- **content-to-sketch** — Generates the SVG sketches (auto-invoked in Step 6)
- **transcript-to-notes** — Alternative for transcript input
- **md-to-notes** — Alternative for markdown input

