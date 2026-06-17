# transcript-notes

Convert raw course transcripts into study materials.

## Outputs per course
| File | Description |
|------|-------------|
| `<Course>_GoodNotes_detailed.md` | GoodNotes-style Markdown notebook, one page per video |
| `<Course>_GoodNotes_detailed_A4.pdf` | A4 PDF ready for GoodNotes import |
| `<Course>_course_videos_clean.mm` | Sanitised Freemind mindmap |
| `<Course>_course_videos_fixed.xmind` | XMind-ready mindmap |

## Workflow for a new transcript

1. Place the transcript `.txt` in a new `<CourseName>/` folder
2. Open GitHub Copilot chat and type `/transcript-to-notes` (or ask *"make notes from this transcript"*)
3. Follow the skill steps — Copilot will generate the notebook, mindmap, PDF, and `.xmind`

Or run the scripts manually:

```bash
# 1. Activate environment (install once if needed)
python3 -m venv .venv && .venv/bin/pip install -r requirements.txt

# 2. Markdown → A4 PDF
.venv/bin/python scripts/md_to_pdf_a4.py <CourseName>/<file>.md <CourseName>/<file>_A4.pdf

# 3. .mm → .xmind (after generating the .mm notebook)
.venv/bin/python scripts/generate_valid_xmind.py <CourseName>/<file>_clean.mm <CourseName>/<file>_fixed.xmind
```

## Folder structure
```
transcript-notes/
├── TOGAF/                          ← example course
│   ├── udemy_transcript_5689314.txt
│   ├── TOGAF_GoodNotes_detailed.md
│   ├── TOGAF_GoodNotes_detailed_A4.pdf
│   ├── TOGAF_course_videos_clean.mm
│   └── TOGAF_course_videos_fixed2.xmind
├── scripts/
│   ├── md_to_pdf_a4.py             ← Markdown → A4 PDF
│   ├── generate_valid_xmind.py     ← .mm → .xmind
│   └── mm_to_xmind.py              ← legacy converter
└── .github/
    ├── copilot-instructions.md
    └── skills/transcript-to-notes/ ← Copilot skill
```
