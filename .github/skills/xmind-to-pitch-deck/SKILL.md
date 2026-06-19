---
name: xmind-to-pitch-deck
description: "Convert an XMind file (.xmind) or exported JSON into a premium, cinema-grade animated HTML/CSS pitch deck using Reveal.js, GSAP, and dynamic Tailwind themes. Use when: creating video-ready pitch decks from mindmaps, turning topic hierarchies into cinematic slide narratives, generating 16:9 widescreen decks for YouTube and screen recording."
argument-hint: "path to .xmind or exported .json input file and optional --out path"
user-invocable: true
---

# XMind to Cinema Pitch Deck (TypeScript/Node)

## What This Skill Does
Generates a premium animated pitch deck from:
- `.xmind` file (reads archive internals)
- exported XMind `.json`

Output:
- a single self-contained `HTML` deck using `Reveal.js + GSAP + Tailwind`
- strict `16:9` video layout
- high-contrast, recording-friendly typography
- staggered entrance animations for title, blocks, and bullet points

## Manifest Configuration
This Skill uses the frontmatter manifest above (`name`, `description`, `argument-hint`, `user-invocable`).
Runtime/config files:
- `package.json` (Node/TypeScript toolchain manifest)
- `templates/deck.manifest.json` (deck-generation defaults)

## Data Mapping Rules
1. Central topic => title slide
2. Main topics => one slide each
3. Subtopics => animated content blocks (with nested bullets from child nodes)

### Canonical Level-2 Schema
The deck pipeline expects these canonical Level-2 block titles on each slide:
1. `Concept Deep Dive`
2. `Worked Example`
3. `Demo Walkthrough`
4. `Advanced Scenario`
5. `Trade-offs`

Parser-side normalization is enabled in `src/parser.ts` so common aliases are mapped automatically.
Examples: `How It Works`/`Key Concepts` -> `Concept Deep Dive`, `Application`/`Use Case` -> `Worked Example`, `Process Flow`/`Step by Step` -> `Demo Walkthrough`, and `Pros and Cons` -> `Trade-offs`.

## Animation Rules (Video-First)
- Reveal fragments on every content block and point
- GSAP staggered fade-up animation per slide
- Smooth text reveal timings tuned for screen recording
- Preserves `In this section` with `Scenario`, `Why it matters`, and `In summary`

## Theme Rules
- Auto-detect industry from topic text (AI, SaaS, Finance, Healthcare, Education, Retail, Gaming)
- Apply matching Tailwind-style palette and gradient mood

## Commands
From this skill folder:
```bash
npm install
npm run build
npm run deck -- --input "<path-to-file.xmind-or-json>" --out "<output.html>"
```

Optional dynamic content flags:
```bash
npm run deck -- --input "<in.xmind>" --out "<out.html>" --dynamic-content true --dynamic-depth 2
```

Optional enriched mindmap JSON export:
```bash
npm run deck -- --input "<in.xmind>" --out "<out.html>" --out-mindmap-json "<enriched-mindmap.json>"
```

Dev mode:
```bash
npm run dev -- --input "<path-to-file.xmind-or-json>" --out "<output.html>"
```

## Deliverables
- parser: `src/parser.ts`
- deck generator: `src/deckGenerator.ts`
- theme selector: `src/themeSelector.ts`
- CLI entrypoint: `src/index.ts`
- boilerplate shell/template: `templates/deck.manifest.json`
