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
- **Spaced repetition locked in**: Built-in Days 1–3–7–14–30 review schedule (no "when should I study?" paralysis)
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
- **Core Idea (60 sec)**: Ultra-simple, concrete, one example included
- **Visual summary**: ASCII diagram, table, or flowchart (NOT paragraphs)
- **Real-world application FIRST**: Concrete scenarios (interest-dependent attention)
- **Quick facts**: Flashcard Q&A forcing active retrieval (minimal reading volume)
- **Try This Right Now**: ≤30 seconds + observable result + "why it matters"
- **Spaced repetition**: Days 1–3–7–14–30 with specific facts (locked schedule)
- **Checkpoint ✓**: Dopamine feedback boxes + progress message
- **Whitespace + icons**: Generous spacing + ⏱️📚⚡✓🗓️ for quick scanning

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

### Step 6 — Create Freemind Mindmap (`.mm`)
See [mindmap format reference](./references/mindmap-format.md).

Build a hierarchical XML Freemind file:
- Root node: book title
- Level 1: chapters or major sections
- Level 2: topics and key concepts
- Level 3: applications, examples, flashcards
- Level 4+: detailed facts or action items

**Critical**: Escape ALL `&` as `&amp;` in node TEXT attributes. No bare `&` allowed.

### Step 7 — Convert .mm → .xmind
Run the converter script (uses Python venv):
```bash
cd /Users/arya/my-space/smart-study-notes
.venv/bin/python scripts/generate_valid_xmind.py <BookName>/<file>.mm <BookName>/<file>.xmind
```

Or use the inline procedure in [xmind-conversion reference](./references/xmind-conversion.md).

### Step 8 — Export A4 PDF
```bash
cd /Users/arya/my-space/smart-study-notes
.venv/bin/python scripts/md_to_pdf_a4.py <BookName>/<file>.md <BookName>/<file_A4>.pdf
```

The PDF will use squared paper background for handwritten aesthetic in GoodNotes.

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
- [ ] Spaced-repetition schedule is explicit (Days 1, 3, 7, 14, 30 — no guessing)
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
- [ ] Spaced-repetition facts build conceptual understanding
- [ ] PDF and mindmap are generated without errors
- [ ] All outputs are in the `<BookName>/` folder
