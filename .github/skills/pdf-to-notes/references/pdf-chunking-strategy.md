# PDF Chunking Strategy for Large Books

## Assessment Phase

### 1. Analyze the Source Material
Before chunking, answer:
- **Total length**: How many pages/words?
- **Complexity**: Academic, practical, narrative, reference?
- **Goal**: What does the learner want to do with this knowledge?
- **Density**: High technical density or conversational?

### 2. Identify Natural Boundaries
- **Chapter breaks**: Obvious start/stop points
- **Section headings**: Often mark thematic shifts
- **Learning outcomes**: If listed, use these as chunk boundaries
- **Topic transitions**: Where the author moves to a new idea

### 3. Plan Micro-Chunk Depth
- **Micro-chunk = 3–5 minutes of reading** = ~500–750 words
- **If chapter is 20 pages**: Split into 4–5 micro-chunks
- **If chapter is 50+ pages**: Split into 10–15 micro-chunks
- **If section is 3 pages**: Could be 1–2 micro-chunks

---

## Chunking Strategies by Book Type

### Strategy 1: Textbooks (100–300 pages, high density)

**Approach**: Chunk by learning outcome or concept, not page count

**Example for "Statistics 101":**
- Chapter 1: Distributions (30 pages) → 6 chunks
  - Chunk 1.1: What is a distribution? (normal, skewed, bimodal)
  - Chunk 1.2: Reading distribution graphs (interpreting shape and spread)
  - Chunk 1.3: Mean vs median (when each one matters)
  - Chunk 1.4: Standard deviation (what it measures)
  - Chunk 1.5: Real-world example (applying to student test scores)
  - Chunk 1.6: Common mistakes (misinterpreting spread)

**Decision rule**: Each chunk = 1 core concept or procedure, not 1 page

---

### Strategy 2: Non-Fiction / Self-Help (200–400 pages, narrative)

**Approach**: Chunk by argument arc or theme, respecting natural section breaks

**Example for "Atomic Habits":**
- Part 1: Foundations (50 pages) → 3–4 chunks
  - Chunk 1: Why tiny changes matter (the 1% rule)
  - Chunk 2: How habits are formed (cue, routine, reward)
  - Chunk 3: Small wins compound (tracking progress)
  - Chunk 4: Identity vs outcome (why you start, why you stick)

- Part 2: Building Better Habits (100 pages) → 5–6 chunks
  - (one per strategy)

**Decision rule**: Follow the author's chapter breaks; split chapters > 30 pages further

---

### Strategy 3: Reference Books (500+ pages, modular)

**Approach**: Chunk independently by section; prioritize learner's goals

**Example for "The Complete Cookbook":**
- Ignore page count; chunk by recipe type or technique
- Learner interested in "bread"? → extract bread section → chunk by technique (yeast, sourdough, baking)
- Skip unrelated sections entirely

**Decision rule**: Only chunk sections the learner plans to use

---

### Strategy 4: Dense Technical Books (400+ pages, high jargon)

**Approach**: Chunk by prerequisite dependencies; build up from fundamentals

**Example for "Deep Learning" textbook:**
- Identify foundational concepts (linear algebra, calculus, basic ML)
- Chunk in dependency order: basics → prerequisites → core concepts → applications
- Learner can't understand deep networks without understanding layers

**Decision rule**: Chunk in learning sequence, not book sequence

---

## Practical Chunking Workflow

### Step 1: Skim and Outline (15 min)
1. Read table of contents
2. Skim chapter introductions and summaries
3. Create bullet list of all sections/subsections
4. Mark section lengths (short, medium, long)

### Step 2: Identify Chunk Boundaries (10–15 min)
1. Mark where you'd naturally pause if teaching this to someone
2. Look for concept shifts, not just page counts
3. Aim for 3–5 minute chunks, but prefer concept integrity over time
4. List all chunks sequentially with estimated word count

### Step 3: Prioritize (5 min, if content is large)
- **If 500+ pages**: Ask "What are the 3 most critical sections?"
- Chunk those fully; create quick reference for the rest
- Learner can dive deeper later if needed

### Step 4: Extract Text (10–60 min, depending on PDF)
- Copy/paste section text into markdown file
- Or use PDF extraction tool (e.g., `pdfplumber`, `pypdf`)
- Clean up OCR errors if scanning a physical book
- Remove headers, footers, page numbers

---

## Example: Breaking Down "Atomic Habits" (416 pages)

### Raw Assessment
- **Total**: 416 pages, ~110,000 words
- **Density**: Low; narrative + practical advice
- **Type**: Self-help / behavior science
- **Learner goal**: "I want to build a morning routine"

### Chapter Outline
- Intro (8 pages)
- Ch 1: The power of tiny changes (16 pages) → Chunk into 3
- Ch 2: How your habits actually work (24 pages) → Chunk into 4
- Ch 3: Identity-based habits (18 pages) → Chunk into 3
- Part 2: Four laws (150 pages) → Chunk into 9–10
- Part 3: Advanced tactics (120 pages) → Chunk into 8–10
- Conclusion (10 pages)

### Chunking Decision
```
Introduction (Chunk 1) → ~3 min
├─ Why habits matter for ADHD brains
├─ Real story: the British cycling example

Chapter 1 (Chunks 2–4) → ~9 min total
├─ Chunk 2: The 1% rule (how small changes compound)
├─ Chunk 3: Tracking progress (why it matters)
└─ Chunk 4: Identity vs outcome (the real secret)

Chapter 2 (Chunks 5–8) → ~12 min total
├─ Chunk 5: Cue → Routine → Reward (the habit loop)
├─ Chunk 6: Why cravings drive habits
├─ Chunk 7: Spotting your habit cues
└─ Chunk 8: Designing your reward system

[... continue for full book ...]
```

### Prioritization for Busy Learner
User only interested in "morning routine," so:
1. Fully chunk: Intro + Ch 1–3 + Relevant laws from Part 2
2. Quick reference: Other advanced tactics (summaries only)
3. Create: "Morning Routine Template" in Action Items

---

## Red Flags: When to Re-Chunk

- **Chunk feels too long**: If you lose focus halfway through, split it
- **Chunk feels too short**: If one idea spans 2 chunks, combine them
- **Chunk has no hook**: If you can't write "What You'll Learn" in one sentence, re-scope the chunk
- **Chunk has multiple concepts**: If you need multiple "Core Idea" sections, split it
- **Chunk has no action**: If you can't think of a "Try This Right Now," reconsider if it's ADHD-relevant

---

## Tools for PDF Extraction

### Free / Python-based
- **pdfplumber** (Python): Extract text reliably from PDFs
- **pypdf** (Python): Read and manipulate PDF metadata
- **command line**: `pdftotext input.pdf output.txt` (requires Poppler)

### Web-based
- **ilovepdf.com** or **smallpdf.com**: Split/merge PDFs
- **extract.me**: Simple OCR if scanning physical books

### Recommended Flow for Large PDFs
1. Split multi-chapter PDF into chapter PDFs (if needed)
2. Use `pdftotext` or `pdfplumber` to extract text cleanly
3. Paste extracted text into markdown file
4. Clean up OCR artifacts (common with scanned books)
5. Apply chunking strategy (section-by-section)
6. Generate ADHD-friendly notes per chunk

---

## Estimating Chunk Count

Use this formula as a rough guide:
```
Estimated Chunks = (Total Pages / Pages Per Chunk) × Complexity Factor

Pages Per Chunk:
- Narrative non-fiction: ~15–20 pages per chunk
- Textbook: ~8–12 pages per chunk
- Reference: ~10–15 pages per chunk

Complexity Factor:
- Easy (self-help, memoir): × 1.0
- Medium (business, practical): × 1.2–1.5
- Hard (technical, academic): × 2.0–3.0

Example:
- 416-page self-help, narrative style
- 416 pages ÷ 20 pages per chunk × 1.0 = ~21 chunks
- (Reality: Atomic Habits is 25 chunks; close!)
```

---

## Checklist: Before You Start Chunking

- [ ] I have the full PDF or clean text extract
- [ ] I've skimmed the table of contents
- [ ] I know the learner's primary goal
- [ ] I've identified major section/chapter boundaries
- [ ] I have a rough sketch of chunk sizes
- [ ] I know the book's complexity level
- [ ] I'm ready to extract text or copy/paste sections
