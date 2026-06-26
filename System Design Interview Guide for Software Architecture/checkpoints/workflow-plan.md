# Workflow Plan — SystemDesignInterviewGuide regeneration

## Inputs
- Source transcript: `System Design Interview Guide for Software Architecture/udemy_transcript_4105414.txt`
- Workspace scripts:
  - `scripts/md_to_pdf_a4.py`
  - `scripts/generate_valid_xmind.py`
- Skill contracts:
  - `copilot-skills/skills/transcript-to-notes/SKILL.md`
  - `copilot-skills/skills/content-to-sketch/SKILL.md`
  - `copilot-skills/skills/transcript-to-notes/references/mindmap-format.md`
  - `copilot-skills/skills/transcript-to-notes/references/xmind-conversion.md`
  - `copilot-skills/skills/pdf-to-notes/references/handwritten-notebook-format-adhd.md`

## Outputs
- `SystemDesignInterviewGuide_transcript_normalized.txt`
- `SystemDesignInterviewGuide_concept_inventory.json`
- `SystemDesignInterviewGuide_Flashcards.csv`
- `SystemDesignInterviewGuide_GoodNotes_detailed.md`
- `SystemDesignInterviewGuide_GoodNotes_detailed_A4.pdf`
- `SystemDesignInterviewGuide_course_videos_clean.mm`
- `SystemDesignInterviewGuide_course_videos_fixed.xmind`
- `SystemDesignInterviewGuide_narrative_manifest.json`
- `SystemDesignInterviewGuide_AI_Elaboration.json`
- `SystemDesignInterviewGuide_INDEX.md`
- `assets/` with `.excalidraw`, `.png`, `INDEX.md`, `validation_report.txt`, `validate_pngs.ps1`
- `checkpoints/status.md`

## Dependencies
- Python virtualenv `.venv`
- Python packages: `reportlab`, `markdown`, `svglib`, `xmind-sdk`, `Pillow`
- Local transcript file available and readable

## Execution order
1. Cleanup legacy generated files while preserving source transcript.
2. Read transcript and build lesson inventory.
3. Create normalized transcript and concept inventory.
4. Generate sketch assets (`.excalidraw` + `.png`) and validate image integrity.
5. Generate ADHD-friendly markdown notebook with one page per lesson.
6. Generate Freemind `.mm` using archetype-specific node sets.
7. Generate `.xmind` from `.mm`.
8. Generate flashcards CSV, AI elaboration JSON, narrative manifest JSON, and index.
9. Export A4 PDF.
10. Run final validations and record checkpoint results.

## Checkpoint expectations
- **P** PASS: this file exists and covers inputs, outputs, dependencies, execution order, and retry strategy.
- **A** PASS: explicit lesson inventory exists with detected lessons > 0.
- **B** PASS: each lesson has mechanism, archetype, analogy, label fusion plan, and composition intent.
- **C** PASS: each lesson visual is concept-specific, not cloned boilerplate.
- **D** PASS: png count >= lesson count and all pngs pass integrity.
- **E** PASS: notes non-empty, required sections present, pages >= lesson count.
- **F** PASS: `.mm` parses and level-1 lesson nodes >= lesson count.
- **G** PASS: `.xmind` archive created and readable.
- **H** PASS: flashcards CSV header exact and every lesson has >= 3 cards.
- **I** PASS: index TOC rows >= page count.
- **J** PASS: PDF exists and is non-trivial.
- **K** PASS: all checkpoints pass.

## Rollback / retry strategy
- If cleanup removes too much, restore only the source transcript and rerun generation.
- If dependency validation fails, install missing packages in `.venv` and retry from the failed step.
- If a visual fails validation, regenerate that lesson’s `.excalidraw` and `.png`, then rerun image validation before continuing.
- If markdown/mm/xmind/pdf validation fails, stop, patch the source artifact, and rerun only downstream steps.
