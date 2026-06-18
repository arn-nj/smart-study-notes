# Pi Architecture — SVG Sketch Index

> Visual reference guide for all hand-drawn concept sketches  
> Course: Pi Architecture — Agent Loop, Tools, TUI and More  
> Generated: 2026-06-18

---

## SVG Files

| File | Concept | Pages | Labels | Size |
|------|---------|-------|--------|------|
| [PiArchitecture_AgentLoop_sketch.svg](./PiArchitecture_AgentLoop_sketch.svg) | 3-Phase Agentic Loop Process Flow | Pages 1, 2, 4, 5 | 22 | ~5KB |
| [PiArchitecture_ContextInitialization_sketch.svg](./PiArchitecture_ContextInitialization_sketch.svg) | 6 Context Layers Stack | Pages 3 | 18 | ~5KB |
| [PiArchitecture_SessionTree_sketch.svg](./PiArchitecture_SessionTree_sketch.svg) | JSONL Session Tree + parentId Forking | Pages 6, 7 | 20 | ~6KB |
| [PiArchitecture_CoreTools_sketch.svg](./PiArchitecture_CoreTools_sketch.svg) | 4 Core Tools Overview Diagram | Page 8 | 16 | ~4KB |
| [PiArchitecture_CompactionSystem_sketch.svg](./PiArchitecture_CompactionSystem_sketch.svg) | checkCompaction() Decision Flow | Page 4 | 19 | ~5KB |
| [PiArchitecture_SkillsSystem_sketch.svg](./PiArchitecture_SkillsSystem_sketch.svg) | Skills Lazy-Load + TUI Intercept Flow | Page 13 | 21 | ~6KB |

---

## Sketch Descriptions

### 1. Agent Loop Process Flow
**File**: `PiArchitecture_AgentLoop_sketch.svg`  
**Concept**: The complete 3-phase agentic loop that runs on every user message  
**Covers**: Phase 1 (Init Context) → Phase 2 (Transform/Compact) → Phase 3 (LLM Call + Tool Loop) → Response  
**Transcript sections**: Introduction, Agentic Loop, LLM Call & Tool Execution  
**Key labels**: Initialize Context, Transform Context, LLM Call, Tool Loop, tool call, final reply, loop repeats

---

### 2. Context Initialization (6 Layers)
**File**: `PiArchitecture_ContextInitialization_sketch.svg`  
**Concept**: The layered stack of items assembled into context before every LLM call  
**Covers**: System prompt, agents.md, skill descriptions, tool descriptions, message history, current message  
**Transcript sections**: Context Initialization (Phase 1), System Prompt  
**Key labels**: All 6 layer names, customization options, LLM provider destination

---

### 3. Session Tree Structure
**File**: `PiArchitecture_SessionTree_sketch.svg`  
**Concept**: How parentId in JSONL messages creates a tree structure enabling conversation forking  
**Covers**: JSONL file location, message fields (id, parentId, type, role), tree branching  
**Transcript sections**: Sessions & Memory, Session Tree Structure  
**Key labels**: parentId, msg_001 through msg_004b, Branch A, Branch B, /tree command

---

### 4. Core Tools Overview
**File**: `PiArchitecture_CoreTools_sketch.svg`  
**Concept**: Pi's 4 default tools arranged around the central agent, plus disabled tools  
**Covers**: read, bash, edit, write (active); grep, find (disabled); when to enable; how to extend  
**Transcript sections**: Core Tools  
**Key labels**: read, bash, edit, write, grep, find, disabled, --tools flag, web search extension

---

### 5. Compaction System
**File**: `PiArchitecture_CompactionSystem_sketch.svg`  
**Concept**: The checkCompaction() decision flow with token counting and summary output  
**Covers**: Two trigger points, token count formula (input+output+cache), decision branch, summary sections  
**Transcript sections**: Context Transformation & Compaction  
**Key labels**: Trigger 1/2, checkCompaction, usage.input, usage.output, cache.read, cache.write, 6 summary sections

---

### 6. Skills System (Lazy Loading)
**File**: `PiArchitecture_SkillsSystem_sketch.svg`  
**Concept**: How the TUI intercepts /skill: commands and enables LLM to lazy-load full skill content  
**Covers**: System prompt (description only), TUI intercept, transformed message with location, read tool, execution  
**Transcript sections**: Skills Management System  
**Key labels**: /skill:name, TUI intercepts, name+description+location, read tool, full SKILL.md, custom commands difference

---

## Quality Metrics

| Metric | Target | Status |
|--------|--------|--------|
| SVG count | ≥ 6 (one per major topic) | ✓ 6 |
| XML valid | 0 errors | ✓ All valid |
| Ampersands | Escaped as &amp; | ✓ |
| Labels per sketch | 15+ | ✓ 16-22 each |
| File size | Under 10KB | ✓ ~4-6KB each |
| Squared paper bg | Yes | ✓ All |
| Arrow markers | Yes | ✓ All |
| High contrast | Yes | ✓ |
| Embedded in notes | Yes | Embed with image refs below |

---

## Embed in Markdown

Copy these lines into `PiArchitecture_GoodNotes_detailed.md` where appropriate:

```markdown
![Agent Loop](./svg/PiArchitecture_AgentLoop_sketch.svg)
![Context Initialization](./svg/PiArchitecture_ContextInitialization_sketch.svg)
![Session Tree](./svg/PiArchitecture_SessionTree_sketch.svg)
![Core Tools](./svg/PiArchitecture_CoreTools_sketch.svg)
![Compaction System](./svg/PiArchitecture_CompactionSystem_sketch.svg)
![Skills System](./svg/PiArchitecture_SkillsSystem_sketch.svg)
```

---

## Validation

Run to validate all SVGs:
```bash
cd "Pi Architecture/svg"
for f in *.svg; do xmllint --noout "$f" && echo "✓ $f valid" || echo "✗ $f INVALID"; done
```
