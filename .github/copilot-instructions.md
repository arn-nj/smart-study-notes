# Copilot Instructions — smart-study-notes workspace

## Purpose
This workspace converts raw course transcripts into study materials: GoodNotes notebooks, A4 PDFs, and XMind mindmaps.

## Visual Preference
- GoodNotes-facing notebook outputs should use a sepia-tone paper background with handwritten fonts (no grid).

## Folder Convention
Every course lives in its own subfolder:
```
smart-study-notes/
├── <CourseName>/           ← one folder per course
│   ├── <transcript>.txt    ← source transcript
│   ├── <CourseName>_GoodNotes_detailed.md
│   ├── <CourseName>_GoodNotes_detailed_A4.pdf
│   ├── <CourseName>_course_videos.mm
│   ├── <CourseName>_course_videos_clean.mm
│   └── <CourseName>_course_videos_fixed.xmind
└── scripts/                ← shared, reusable scripts
    ├── md_to_pdf_a4.py
    └── generate_valid_xmind.py
```

## Python Environment
- Virtualenv is at `.venv/` in the workspace root.
- Always run Python as `.venv/bin/python` — never the system Python.
- Required packages: `reportlab`, `markdown`, `xmind-sdk`
- Re-install if needed: `python3 -m venv .venv && .venv/bin/pip install -r requirements.txt`

## Quick Commands (run from workspace root)
```bash
# Markdown → A4 PDF
.venv/bin/python scripts/md_to_pdf_a4.py <CourseName>/<file>.md <CourseName>/<file_A4>.pdf

# Freemind .mm → valid XMind
.venv/bin/python scripts/generate_valid_xmind.py <CourseName>/<file>_clean.mm <CourseName>/<file>_fixed.xmind <CourseName>/<CourseName>_GoodNotes_detailed.md
```

## Linked Skills
- Reusable skills are linked through the `copilot-skills/` git submodule at the workspace root.
- Primary skill content lives under `copilot-skills/skills/`.

## When to Use the Skill
When a user drops a new transcript `.txt` file into a course folder and asks to generate notes or mindmap, invoke the **transcript-to-notes** skill (type `/transcript-to-notes` in chat or ask to "make notes from this transcript").

## XML Safety Rules
- All Freemind `.mm` files must have `&` escaped as `&amp;`
- Validate with: `xmllint --noout <file>.mm`
- XMind `.xmind` archives must contain `content.xml`, `meta.xml`, and `META-INF/manifest.xml`
