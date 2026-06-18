---
name: content-to-sketch
description: 'Generate hand-drawn concept images from content chunks. Create SVG sketches, Mermaid diagrams, or image generation prompts for sections, concepts, modules, chapters, or videos. Use when: converting transcript concepts to visuals; adding diagrams to study notes; generating illustrations for each learning chunk; "make a sketch of this concept"; "draw the architecture"; "visualize this section"; integrating with study notes pipelines.'
argument-hint: 'A concept/section description, key idea, or reference to a markdown file section'
user-invocable: true
---

# Content to Sketch

Generate hand-drawn, sketch-style visual representations of learning concepts and content chunks to enhance study materials.

## When to Use

- **During transcript-to-notes generation**: Add visual aids for each major section or concept
- **Standalone concept visualization**: Request a sketch of a specific idea from any transcript or document  
- **Batch generation**: Auto-generate images for entire course outlines or module breakdowns
- **Markdown integration**: Extract key concepts from existing study notes and create visuals
- **Study material enhancement**: Convert dense text explanations into memorable visual summaries

## Input Modes

### Mode 1: Direct Concept Description (Quick Single Image)
```
"I have a concept: Dependency Injection in software design. 
Create a hand-drawn sketch showing a class with dependencies 
being injected, vs tightly coupled classes."
```

**Triggers**: 
- Type `/content-to-sketch` and describe the concept or architecture
- Provide a short textual description of what to visualize
- Best for: Single concepts, quick diagrams, architectural patterns

### Mode 2: Extract from Markdown File (Batch Generation)
```
"Generate images for each major section in 
BuildRealWorldAgents_BeginnerToPro/BuildRealWorldAgents_BeginnerToPro_GoodNotes_detailed.md"
```

**Triggers**:
- Reference a markdown file (course notes, transcript summary, chapter outline)
- Skill parses headers (## Section Name, ### Subsection) as visual chunks
- Generates at least one image per topic/section with concept-relevant styling
- Best for: Full course visualization, multi-chapter coverage, consistent output

### Mode 3: JSON Config with Multiple Concepts (Advanced Batch)
```json
{
  "course": "BuildRealWorldAgents_BeginnerToPro",
  "svg_count_mode": "per-topic",
  "svg_count": 8,
  "concepts": [
    {
      "title": "Agent Planning",
      "description": "Agent breaks down goals into steps before execution",
      "style": "flow-diagram"
    },
    {
      "title": "Tool Integration",
      "description": "Agent uses external APIs and code interpreters",
      "style": "architecture"
    }
  ]
}
```

**Triggers**:
- Pass structured data for fine-grained control
- Assign visual styles per concept (flow-diagram, architecture, mindmap, conceptual-sketch)
- Control whether SVG count is explicit or derived from topic count
- Best for: Curated collections, specific styling per concept, production output

## SVG Count Rules

- **Default behavior**: Generate `1 SVG minimum per topic`.
- **Auto mode**: Count is derived from detected topics/sections/headings.
- **Explicit mode**: User can request a fixed count, for example `svg_count: 12`.
- **Floor rule**: Never produce fewer SVGs than the number of core topics selected.
- **Expansion rule**: If a topic has multiple distinct ideas, it can receive more than one SVG.

Supported count controls:

```json
{
  "svg_count_mode": "per-topic",
  "svg_count": 12,
  "min_one_svg_per_topic": true
}
```

Count modes:
- `per-topic` → one SVG minimum for every detected or supplied topic
- `fixed` → generate exactly the requested number, but never below topic count
- `topic-density` → generate more SVGs for dense topics with multiple sub-concepts

## Output Formats

The skill generates images using **one of three techniques**, selectable per request:

### 1. **SVG with Sketch/Doodle Effect** (Default)
- **Tool**: Built-in `mcp_goodnotes_draw_svg_image`
- **Style**: Hand-drawn, sketch-like SVG illustrations
- **Best for**: Quick conceptual diagrams, architectural sketches, memory aids
- **Output**: `.svg` file saved to course folder
- **Example use case**: Class diagrams, system architecture, process flows with hand-drawn aesthetic

### 2. **Mermaid Diagrams** (Flowcharts, Mindmaps, Timelines)
- **Tool**: Built-in `mcp_goodnotes_generate_mermaid_diagram`
- **Styles**: Flowchart, mindmap, timeline
- **Best for**: Complex relationships, hierarchical concepts, sequential processes
- **Output**: Embedded diagram or `.mm` file
- **Example use case**: Decision trees, course progression, concept relationships, project timelines

### 3. **Image Generation Prompts** (For External APIs)
- **Method**: Generate detailed visual prompts optimized for DALL-E, Midjourney, or similar
- **Style**: "Hand-drawn notebook sketch" instructions for consistent aesthetic
- **Best for**: High-fidelity illustrations, stylized visuals, polished course materials
- **Output**: Markdown with prompt + link to generated image (requires external API call)
- **Example use case**: Detailed concept illustrations, professional course materials, cover art

## Procedure

### Step 1: Prepare Your Input
Choose one of the three input modes above and provide:
- **Mode 1 (Quick)**: A clear, 1-2 sentence concept description
- **Mode 2 (File)**: Path to markdown file (e.g., `BuildRealWorldAgents_BeginnerToPro/BuildRealWorldAgents_BeginnerToPro_GoodNotes_detailed.md`)
- **Mode 3 (JSON)**: Structured config with concepts and styling preferences
- Optional count control: `svg_count_mode`, `svg_count`, or `min_one_svg_per_topic`

### Step 2: Specify Output Format
Indicate which technique to use:
- **"SVG sketch"** → Hand-drawn aesthetic, quick turnaround
- **"Mermaid diagram"** → Structured relationships, multiple styles
- **"Image generation prompt"** → External API-ready, high-fidelity

If not specified, defaults to **SVG sketch** for best integration with GoodNotes workflow.

### Step 3: Set Course Context
Specify the target course folder:
```
Course: BuildRealWorldAgents_BeginnerToPro
Module: Section 3 - Agent Tool Integration
Concept: How tools are registered and called
```

The skill saves images to the course folder with naming convention: `<CourseName>_<ModuleName>_sketch_<ConceptName>.svg`

### Step 4: Request Generation
Invoke with:
```
/content-to-sketch
Input: [concept description OR file path OR JSON config]
Format: [svg-sketch | mermaid | image-prompt]
Course: [CourseName]
Optional—Module: [ModuleName]
Optional—Style: [style preference]
Optional—SVG Count Mode: [per-topic | fixed | topic-density]
Optional—SVG Count: [number]
```

Examples:
```text
Generate SVGs for each topic in this file. Minimum one SVG per topic.
```

```text
Generate 12 SVGs total, but ensure every topic gets at least one.
```

```text
Generate SVGs for all topics in this markdown. Use topic-density mode and create extra SVGs only for dense sections.
```

### Step 5: Review & Integrate
- **SVG/Mermaid**: Image files auto-saved to course folder
- **Image Prompts**: Use prompts with DALL-E or your preferred tool; embed results manually
- Add image references to `<CourseName>_GoodNotes_detailed.md`:
  ```markdown
  ### Tool Integration Concept
  ![Tool Integration Sketch](./svg/BuildRealWorldAgents_BeginnerToPro_Section3_Tool_Integration_sketch.svg)
  
  Agents use external tools by:
  1. Registering available APIs
  2. Selecting tools based on goals
  3. Executing and processing results
  ```

## Integration with Notes Pipelines

This skill is **automatically invoked** by all to-notes skills:

### With `transcript-to-notes` Skill (Step 5)
When generating study notes from a transcript, content-to-sketch is automatically called to:
- Generate one SVG minimum for every detected lesson topic
- Increase SVG count automatically for dense modules when needed
- Create `svg/` subfolder with validation tools
- Embed sketches in markdown with image references
- Include sketches in final PDF output

### With `md-to-notes` Skill (Step 6)
When converting markdown documentation to study notes:
- Identify major sections and concepts for visualization
- Generate architectural diagrams and process flows
- Create visual glossary for technical terms
- Embed in ADHD-friendly chunked notes

### With `pdf-to-notes` Skill (Step 6)
When transforming PDF books to study materials:
- Create chapter summary visualizations
- Generate concept relationship diagrams
- Visualize key frameworks and models
- Embed in action-oriented study notes

### Manual Invocation
After any to-notes skill completes, you can also request additional visuals:
```
I've just created BuildRealWorldAgents_BeginnerToPro_GoodNotes_detailed.md
from the transcript. Generate hand-drawn SVG sketches for 
each ## section in this file.
```

## Best Practices

1. **Concept Clarity**: Provide clear, specific concept descriptions (2-3 sentences ideal)
2. **Naming Consistency**: Use course folder conventions for saved images
3. **Batch Efficiency**: Use Mode 2 (markdown file) for entire course visualization and let topic count drive the minimum SVG count
4. **Style Cohesion**: Choose one dominant format (SVG or Mermaid) per course for visual consistency
5. **Markdown Integration**: Always embed generated images in study notes for context
6. **Styling Options**: For squared-paper background (GoodNotes default), use `background: {color: white, pattern: squared}`
7. **Coverage Rule**: For study-note workflows, every topic should receive at least one SVG unless the user explicitly excludes it

## Supported Style Presets

| Style | Best For | Example Technique |
|-------|----------|-------------------|
| `flow-diagram` | Process flows, decision trees | SVG with arrows and boxes |
| `architecture` | System design, component relationships | Mermaid diagram or SVG |
| `mindmap` | Concept hierarchies, brainstorming | Mermaid mindmap |
| `timeline` | Sequential learning, project phases | Mermaid timeline |
| `conceptual-sketch` | Abstract ideas, metaphors | SVG freeform doodle |
| `entity-relationship` | Data models, relationships | Mermaid flowchart or SVG |

## Troubleshooting

**Problem**: SVG looks too clean, not hand-drawn enough  
**Solution**: Use Mermaid diagrams instead (built-in doodle aesthetic) or request image generation prompt

**Problem**: Mermaid feels too structured for a free-form concept  
**Solution**: Use SVG sketch mode for artistic freedom

**Problem**: Want external image generation but no API yet  
**Solution**: Request image generation **prompts** (Markdown file); manually submit to DALL-E/Midjourney later

**Problem**: Batch generation created too many images  
**Solution**: Switch to `svg_count_mode: fixed`, exclude minor subsections, or define the exact topic list in Mode 3 JSON

**Problem**: Not enough images were generated  
**Solution**: Use `svg_count_mode: per-topic` and set `min_one_svg_per_topic: true`, or request a higher explicit `svg_count`

## ✅ Verified Working Workflow

**Tested with Copilot Studio course notes:**
- ✓ 7 hand-drawn SVG sketches generated successfully
- ✓ All sketches embedded in markdown file with image references
- ✓ PDF notebook generated with all embedded sketches (121 pages)
- ✓ SVG files validated with xmllint (XML-valid)
- ✓ Sketches use squared paper background (GoodNotes compatible)
- ✓ Mindmap structure aligns with sketch concepts

**Output Files Created:**
- `BuildRealWorldAgents_BeginnerToPro_GoodNotes_detailed.md` (with 6+ image references)
- `BuildRealWorldAgents_BeginnerToPro_GoodNotes_with_sketches.pdf` (121 pages)
- `SKETCHES_VISUAL_INDEX.md` (visual reference guide)
- 7x SVG sketches (self-contained, no dependencies)

## File Organization

All sketches are saved in organized folder structure:

```
<CourseName>/
└── svg/
    ├── CopilotStudio_ProcessFlow_sketch.svg
    ├── CopilotStudio_BuildIterateCycle_sketch.svg
    ├── CopilotStudio_FoundationsPillars_sketch.svg
    ├── CopilotStudio_Grounding_Accuracy.svg
    ├── CopilotStudio_IntentRouting_Topics.svg
    ├── CopilotStudio_ToolIntegration.svg
    ├── CopilotStudio_MultiAgentOrchestration.svg
    ├── INDEX.md (visual reference guide)
    ├── validate_svgs.sh (validation script)
    └── validation_report.txt (quality report)
```

## SVG Validation & Quality Assurance

The skill includes comprehensive SVG validation to ensure content quality:

### Automatic Validation Checks
- ✅ **XML Well-Formedness**: All SVG files pass `xmllint` validation
- ✅ **Proper Entity Encoding**: Ampersands escaped as `&amp;`, special characters as entities
- ✅ **Accessibility**: Minimum 15 text labels per sketch for clarity
- ✅ **File Optimization**: All files under 10KB (typically 3-6KB)
- ✅ **Visual Quality**: 8-21 unique colors, high contrast WCAG compliant
- ✅ **Markers & Arrows**: Flow diagrams include directional indicators

### Manual Validation Script
Run anytime to validate all sketches:
```bash
cd <CourseName>/svg
bash validate_svgs.sh
```

**Validation Report includes:**
- XML parsing errors
- SVG element verification
- Accessibility metrics (text labels count)
- File size optimization
- Color usage analysis
- Visual marker presence

### Common Issues & Fixes
- **Ampersand errors** → Escape as `&amp;` in text
- **Special characters** → Use XML entities (&lt;, &gt;, &quot;, etc.)
- **Size warnings** → SVGs auto-optimized, acceptable if <10KB
- **Accessibility warnings** → Ensure 15+ text labels for clarity

## Embedding Sketches in Study Materials

### Method 1: Image References (Default)
```markdown
![Process Flow](./svg/CopilotStudio_ProcessFlow_sketch.svg)
```

### Method 2: Direct SVG Embedding (Full Content)
```markdown
<svg xmlns="http://www.w3.org/2000/svg" width="800" height="400" viewBox="0 0 800 400">
  <!-- Full SVG content here -->
</svg>
```

### Method 3: HTML Embed
```html
<object data="./svg/CopilotStudio_ProcessFlow_sketch.svg" type="image/svg+xml" width="100%"></object>
```

### Method 4: PDF Integration
All sketches are automatically embedded when generating PDF from markdown:
```bash
.venv/bin/python scripts/md_to_pdf_a4.py notes.md output.pdf
```

### Method 5: Mindmap Integration
Add sketch references to mindmap nodes:
```
<node TEXT="Process Flow">
  <node TEXT="📊 Visual: svg/CopilotStudio_ProcessFlow_sketch.svg" />
</node>
```

## ✅ Verified Working Workflow

**Tested with Copilot Studio course notes:**
- ✓ 7 hand-drawn SVG sketches generated successfully
- ✓ All sketches organized in `svg/` subfolder
- ✓ All SVG files pass XML validation (0 errors)
- ✓ Validation script included for quality assurance
- ✓ SVG index created with full metadata
- ✓ Sketches use squared paper background (GoodNotes compatible)
- ✓ Sketches embedded in markdown with references
- ✓ PDF notebook generated with all embedded sketches (121 pages)
- ✓ Mindmap structure aligns with sketch concepts

**Quality Metrics (All Passing):**
- ✓ Valid XML: 7/7 sketches
- ✓ Accessibility: 197 total text labels (avg 28 per sketch)
- ✓ File size: All optimized (3-6KB each)
- ✓ Color usage: 8-21 unique colors per sketch
- ✓ Visual markers: All have arrows/directional elements

**Output Files Structure:**
```
Copilot Studio -Build Real-World Agents-Beginner to Pro/
├── svg/
│   ├── CopilotStudio_ProcessFlow_sketch.svg ✓
│   ├── CopilotStudio_BuildIterateCycle_sketch.svg ✓
│   ├── CopilotStudio_FoundationsPillars_sketch.svg ✓
│   ├── CopilotStudio_Grounding_Accuracy.svg ✓
│   ├── CopilotStudio_IntentRouting_Topics.svg ✓
│   ├── CopilotStudio_ToolIntegration.svg ✓
│   ├── CopilotStudio_MultiAgentOrchestration.svg ✓
│   ├── INDEX.md (quality report)
│   ├── validate_svgs.sh (validation tool)
│   └── validation_report.txt (latest report)
├── BuildRealWorldAgents_BeginnerToPro_GoodNotes_detailed.md (with embedded refs)
├── BuildRealWorldAgents_BeginnerToPro_GoodNotes_with_sketches.pdf (121 pages)
└── SKETCHES_VISUAL_INDEX.md (reference guide)
```

## File References

- [SVG Index](./svg/INDEX.md) — Full metadata for all sketches
- [Validation Script](./svg/validate_svgs.sh) — Quality assurance tool
- [SVG Sketch Generation](../../copilot-instructions.md#visual-preference) — Workspace color/pattern preferences
- Related Skills: `transcript-to-notes`, `md-to-notes`, `pdf-to-notes`
