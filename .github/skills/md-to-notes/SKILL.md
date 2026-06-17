---
name: md-to-notes
description: >
  Transform markdown files into GoodNotes-style handwritten study notes with ADHD-friendly chunking,
  active recall, and spaced repetition. Perfect for converting notes, documentation, or research
  into optimized study materials. Use when: converting markdown to study notes; organizing documentation
  into study guides; creating handwritten notebooks from .md files; "make study notes from this markdown";
  "convert markdown to study format"; "organize markdown into learning materials".
argument-hint: "path to .md file (relative to workspace root)"
user-invocable: true
---

# Markdown → GoodNotes Handwritten Study Notes

## What This Skill Does
Given a markdown file, produce:
1. **`<FileName>_GoodNotes_detailed.md`** — ADHD-chunked markdown with handwritten-style formatting
2. **`<FileName>_GoodNotes_detailed_A4.pdf`** — A4 PDF with squared paper background (ready for GoodNotes import)
3. **`<FileName>_Quick_Reference.md`** — 1-page visual summaries per major section
4. **`<FileName>_Study_Guide.md`** — Executable takeaways, real-world applications, and study prompts
5. **`<FileName>_Study_Mindmap.xmind`** — XMind mindmap showing content structure and relationships

All outputs go into a `<FileName>_StudyNotes/` subfolder.

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

### Step 1 — Assess the Markdown File
- Review the .md file structure (headings, sections, complexity)
- Identify natural boundaries (chapters, topics, learning outcomes)
- Note content length and density
- Plan chunking strategy (see [md-organization-strategy](./references/md-organization-strategy.md))

### Step 2 — Extract and Organize Content
- Identify major sections (##, ###, #### headings)
- Group related content into learning outcomes
- Plan micro-chunks (aim for 3–5 min reads per chunk)
- Create logical study progression

### Step 3 — Generate ADHD-Friendly GoodNotes Markdown
See [handwritten-notebook-format-adhd](../pdf-to-notes/references/handwritten-notebook-format-adhd.md).

For each micro-chunk, create one page with ADHD support built-in:
- **Header with time + difficulty**: ⏱️ ~3 min | 📚 Section X | ⚡ Easy/Medium/Hard (executive scaffolding)
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
- Section title + 3 key takeaways
- 1 main diagram or table
- 3 action items or study prompts
- Link back to full study notes

### Step 5 — Extract Study Guide
- All "Try This Right Now" steps compiled
- Real-world applications highlighted
- Common mistakes and edge cases
- Study prompts for active recall
- Difficulty-based progression (Easy first, then Medium, then Hard)

### Step 6 — Create Freemind Mindmap (`.mm`)
See [mindmap format reference](./references/mindmap-format.md).

Build a hierarchical XML Freemind file:
- Root node: document/file title
- Level 1: major sections or chapters
- Level 2: subsections and key concepts
- Level 3: applications, examples, study prompts
- Level 4+: detailed facts or flashcards

**Critical**: Escape ALL `&` as `&amp;` in node TEXT attributes. No bare `&` allowed.

### Step 7 — Convert .mm → .xmind
Run the converter script (uses Python venv):
```bash
cd /Users/arya/my-space/transcript-notes
.venv/bin/python scripts/generate_valid_xmind.py <FileName>_StudyNotes/<file>.mm <FileName>_StudyNotes/<file>.xmind
```

Or use the inline procedure in [xmind-conversion reference](./references/xmind-conversion.md).

### Step 8 — Export A4 PDF
```bash
cd /Users/arya/my-space/transcript-notes
.venv/bin/python scripts/md_to_pdf_a4.py <FileName>_StudyNotes/<file>.md <FileName>_StudyNotes/<file_A4>.pdf
```

The PDF will use squared paper background for handwritten aesthetic in GoodNotes.

## Strategic Content Organization

### For Technical Documentation
- Split by feature or concept (1 chunk per feature)
- Include code examples → study format → real-world use
- Difficulty: Easy (basic usage) → Medium (advanced features) → Hard (edge cases)

### For Research Notes
- Organize by research question or thesis
- 1 chunk = 1 argument or finding
- Include: evidence → implication → personal takeaway

### For Reference Material
- Chunk by topic or module independently
- Allow non-linear navigation (hyperlinks important)
- Prioritize learner's goals (don't force sequential reading)

### For Study Materials
- Respect original structure but re-chunk for ADHD
- Add spaced-rep schedules to existing content
- Convert dense sections into visual summaries
- Extract key concepts into flashcards

## Python Environment
- Virtualenv: `.venv` at workspace root
- Required packages: `reportlab`, `markdown`, `xmind-sdk`
- Install: `python3 -m venv .venv && .venv/bin/pip install -r requirements.txt`
- Use: `.venv/bin/python` — **not** the system Python

## ADHD-Optimized Study Notes Quality Checklist
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
- [ ] Original markdown structure is preserved but optimized (not lost information)

## Quality Checklist
- [ ] Chunking respects markdown's natural section boundaries
- [ ] All terminology is explained in simple vocabulary
- [ ] Every chunk includes actionable application or study prompt
- [ ] No page exceeds 5 minutes of reading
- [ ] Quick reference pages are scannable in <1 minute
- [ ] Study guide is organized by difficulty (Easy → Medium → Hard)
- [ ] Spaced-repetition facts build conceptual understanding
- [ ] PDF and mindmap are generated without errors
- [ ] All outputs are in the `<FileName>_StudyNotes/` folder
- [ ] Original markdown meaning is preserved (not oversimplified)
