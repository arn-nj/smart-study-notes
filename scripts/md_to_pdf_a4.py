#!/usr/bin/env python3
"""
md_to_pdf_a4.py
Convert a GoodNotes-style Markdown notebook to a handwritten-look A4 PDF.

Usage:
    python md_to_pdf_a4.py <input.md> <output.pdf> [small|medium|large]
"""

from __future__ import annotations

import html
import os
import re
import sys
from dataclasses import dataclass
from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import mm
from reportlab.graphics import renderPDF
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.platypus import Image, PageBreak, Paragraph, Preformatted, SimpleDocTemplate, Spacer, Table, TableStyle

from svglib.svglib import svg2rlg


INPUT_MD = sys.argv[1] if len(sys.argv) > 1 else "TOGAF_GoodNotes_detailed.md"
OUTPUT_PDF = sys.argv[2] if len(sys.argv) > 2 else "TOGAF_GoodNotes_detailed_A4.pdf"
INPUT_DIR = Path(INPUT_MD).resolve().parent
IMAGE_SIZE_MODE = (sys.argv[3] if len(sys.argv) > 3 else os.environ.get("GOODNOTES_IMAGE_SIZE", "large")).lower()

IMAGE_PRESETS = {
    "small": {"width": 145 * mm, "height": 62 * mm, "caption_size": 7.5, "caption_leading": 9},
    "medium": {"width": 155 * mm, "height": 76 * mm, "caption_size": 8.0, "caption_leading": 10},
    "large": {"width": 165 * mm, "height": 95 * mm, "caption_size": 8.5, "caption_leading": 11},
}

if IMAGE_SIZE_MODE not in IMAGE_PRESETS:
    IMAGE_SIZE_MODE = "large"

IMAGE_MAX_WIDTH = IMAGE_PRESETS[IMAGE_SIZE_MODE]["width"]
IMAGE_MAX_HEIGHT = IMAGE_PRESETS[IMAGE_SIZE_MODE]["height"]
IMAGE_CAPTION_SIZE = IMAGE_PRESETS[IMAGE_SIZE_MODE]["caption_size"]
IMAGE_CAPTION_LEADING = IMAGE_PRESETS[IMAGE_SIZE_MODE]["caption_leading"]

FONT_HAND = "BradleyHand"
FONT_BODY = "ComicSans"
FONT_BOLD = "ComicSansBold"
FONT_MONO = "Courier"

pdfmetrics.registerFont(TTFont(FONT_HAND, "/System/Library/Fonts/Supplemental/Bradley Hand Bold.ttf"))
pdfmetrics.registerFont(TTFont(FONT_BODY, "/System/Library/Fonts/Supplemental/Comic Sans MS.ttf"))
pdfmetrics.registerFont(TTFont(FONT_BOLD, "/System/Library/Fonts/Supplemental/Comic Sans MS Bold.ttf"))

PAGE_BG = colors.HexColor("#FFFEF5")
RULE = colors.HexColor("#D6E4F7")
MARGIN_LINE = colors.HexColor("#F4A7A7")
HEADER_BG = colors.HexColor("#3A5FA0")
HEADER_FG = colors.white
BODY_FG = colors.HexColor("#2C2C2C")
SUB_FG = colors.HexColor("#1A3A6B")
CARD_YELLOW = colors.HexColor("#FFF9C4")
CARD_YELLOW_EDGE = colors.HexColor("#F5C518")
CARD_GREEN = colors.HexColor("#D4EDDA")
CARD_GREEN_EDGE = colors.HexColor("#2ECC71")
CARD_CODE = colors.HexColor("#EEF2E5")
CARD_CODE_FG = colors.HexColor("#274218")
CARD_LABEL = colors.HexColor("#FFF0C2")
FOOTER_FG = colors.HexColor("#888888")

SECTION_COLORS = {
    "normal": (colors.HexColor("#DFF0E2"), colors.HexColor("#23663A")),
    "flashcard": (CARD_YELLOW, colors.HexColor("#6D4C00")),
    "exam": (CARD_GREEN, colors.HexColor("#155724")),
    "warning": (colors.HexColor("#FFF3CD"), colors.HexColor("#856404")),
    "revision": (colors.HexColor("#EDE7F6"), colors.HexColor("#4A2A84")),
    "bullets": (colors.HexColor("#FCE4EC"), colors.HexColor("#880E4F")),
    "process": (colors.HexColor("#E0F7FA"), colors.HexColor("#006064")),
    "code": (colors.HexColor("#E6F3E6"), colors.HexColor("#255D2A")),
}

SECTION_KEYWORDS = {
    "flashcard": "flashcard",
    "practice": "exam",
    "exam": "exam",
    "one-page": "revision",
    "revision": "revision",
    "30-day": "bullets",
    "memory": "bullets",
    "process flow": "process",
    "common mistake": "warning",
    "ascii": "code",
    "visual": "code",
}


def sanitize_text(text: str) -> str:
    replacements = {
        "\u2011": "-",   # non-breaking hyphen
        "\u2012": "-",
        "\u2013": "-",   # en dash
        "\u2014": " - ", # em dash
        "\u2018": "'",
        "\u2019": "'",
        "\u201C": '"',
        "\u201D": '"',
        "\u2022": "*",   # bullet
        "\u2023": "*",
        "\u25E6": "o",   # white bullet
        "\u25AA": "-",   # small square
        "\u2192": "->",
        "\u2190": "<-",
        "\u2191": "^",
        "\u2193": "v",
        "\u21D2": "=>",
        "\u21D0": "<=",
        "\u2260": "!=",
        "\u2264": "<=",
        "\u2265": ">=",
    }
    for src, dst in replacements.items():
        text = text.replace(src, dst)
    text = re.sub(r"[\U00010000-\U0010ffff]", "", text)
    return text


def xml_text(text: str) -> str:
    safe = html.escape(sanitize_text(text), quote=False)
    safe = safe.replace("\n", "<br/>")
    return safe


def section_style(name: str) -> str:
    lowered = name.lower()
    for keyword, style_name in SECTION_KEYWORDS.items():
        if keyword in lowered:
            return style_name
    return "normal"


def split_label_prefix(text: str) -> tuple[str | None, str]:
    match = re.match(r"^([^:]{2,32}:)\s+(.*)$", text)
    if not match:
        return None, text
    prefix = match.group(1)
    if len(prefix.split()) > 5:
        return None, text
    return prefix, match.group(2)


def is_list_heading(line: str) -> bool:
    if is_ascii_marker(line):
        return False
    return bool(re.match(r"^\s*[-*+]\s+[^:]{2,40}:\s*$", line))


def is_plain_heading(line: str, next_line: str | None) -> bool:
    stripped = line.strip()
    if not stripped or len(stripped) > 70:
        return False
    if line != line.lstrip():
        return False
    if re.match(r"^(#|[-*+]|\d+[.)]|Q:|A:|\|)", stripped):
        return False
    if next_line is None:
        return False
    return bool(re.match(r"^(\s*[-*+]|\s*\d+[.)]|Q:|A:)", next_line.strip()))


def is_ascii_marker(line: str) -> bool:
    stripped = line.strip().lower()
    stripped = re.sub(r"^[-*+]\s+", "", stripped)
    return (
        stripped.startswith("ascii:")
        or "(ascii)" in stripped
        or stripped.startswith("quick ascii")
        or stripped.startswith("visual (ascii)")
        or stripped.startswith("visual sketch") and "ascii" in stripped
    )


def is_arrow_summary_line(line: str) -> bool:
    stripped = line.strip()
    if not stripped or line != line.lstrip():
        return False
    if "->" not in stripped and "<-" not in stripped:
        return False

    parts = [part.strip() for part in re.split(r"\s*(?:->|<-)\s*", stripped) if part.strip()]
    if len(parts) < 2:
        return False

    return all(re.fullmatch(r"[A-Za-z0-9&(),'/+ -]{1,40}", part) for part in parts)


def looks_like_diagram_line(line: str) -> bool:
    stripped = line.strip()
    if is_arrow_summary_line(line):
        return False
    return bool(
        re.search(r"[┌┐└┘├┤┬┴┼─│→←↑↓►◄▲▼]", stripped)
        or stripped.startswith("[")
        or "->" in stripped
        or "<-" in stripped
        or stripped.count("|") >= 1
        or re.search(r"[-=]{3,}", stripped)
    )


def clean_md(text: str) -> str:
    text = re.sub(r"\*\*(.*?)\*\*", r"\1", text)
    text = re.sub(r"`(.*?)`", r"\1", text)
    return text


def parse_markdown_image(line: str) -> tuple[str, str] | None:
    match = re.match(r"^!\[([^\]]*)\]\(([^)]+)\)\s*$", line.strip())
    if not match:
        return None
    return match.group(1).strip(), match.group(2).strip()


def resolve_image_path(raw_path: str) -> Path:
    candidate = Path(raw_path)
    if candidate.is_absolute() and candidate.exists():
        return candidate

    direct = (INPUT_DIR / raw_path).resolve()
    if direct.exists():
        return direct

    fallback_svg = (INPUT_DIR / "svg" / os.path.basename(raw_path)).resolve()
    if fallback_svg.exists():
        return fallback_svg

    return direct


def image_caption(text: str):
    style = ParagraphStyle(
        "ImageCaption",
        parent=BODY,
        fontName=FONT_BODY,
        fontSize=IMAGE_CAPTION_SIZE,
        leading=IMAGE_CAPTION_LEADING,
        alignment=TA_CENTER,
        textColor=FOOTER_FG,
        spaceAfter=0,
    )
    return Paragraph(xml_text(text), style)


def svg_flowable(path: Path, alt_text: str):
    drawing = svg2rlg(str(path))
    if drawing is None:
        raise ValueError(f"Could not parse SVG: {path}")

    x_scale = IMAGE_MAX_WIDTH / drawing.width if drawing.width else 1
    y_scale = IMAGE_MAX_HEIGHT / drawing.height if drawing.height else 1
    scale = min(x_scale, y_scale, 1.0)
    if scale != 1.0:
        drawing.width *= scale
        drawing.height *= scale
        drawing.scale(scale, scale)

    flowable = renderPDF.GraphicsFlowable(drawing)
    caption = image_caption(alt_text or path.name)
    return [flowable, Spacer(1, 1 * mm), caption, Spacer(1, 2 * mm)]


def raster_flowable(path: Path, alt_text: str):
    flowable = Image(str(path))
    flowable._restrictSize(IMAGE_MAX_WIDTH, IMAGE_MAX_HEIGHT)
    caption = image_caption(alt_text or path.name)
    return [flowable, Spacer(1, 1 * mm), caption, Spacer(1, 2 * mm)]


def markdown_image_flowables(line: str):
    parsed = parse_markdown_image(line)
    if not parsed:
        return None

    alt_text, raw_path = parsed
    path = resolve_image_path(raw_path)
    if not path.exists():
        return [card_block(f"Image missing: {raw_path}", "warning"), Spacer(1, 2.5 * mm)]

    suffix = path.suffix.lower()
    if suffix == ".svg":
        return svg_flowable(path, alt_text)
    if suffix in {".png", ".jpg", ".jpeg", ".gif", ".webp"}:
        return raster_flowable(path, alt_text)
    return [labeled_paragraph(f"Image asset not supported: {raw_path}"), Spacer(1, 2.5 * mm)]


@dataclass
class PageContent:
    title: str
    lines: list[str]


def parse_pages(raw: str) -> list[PageContent]:
    segments = re.split(r"(?m)^(?=--\s)", raw)
    pages = []
    for segment in segments:
        text = segment.strip()
        if not text:
            continue
        lines = text.splitlines()
        pages.append(PageContent(title=lines[0].strip(), lines=lines[1:]))
    if not pages:
        pages.append(PageContent(title="Study Notes", lines=raw.splitlines()))
    return pages


styles = getSampleStyleSheet()
BODY = ParagraphStyle(
    "Body",
    parent=styles["BodyText"],
    fontName=FONT_BODY,
    fontSize=10,
    leading=15,
    textColor=BODY_FG,
    spaceAfter=4,
)
LABEL_BODY = ParagraphStyle("LabelBody", parent=BODY)
BULLET = ParagraphStyle(
    "Bullet",
    parent=BODY,
    leftIndent=14,
    firstLineIndent=-8,
    bulletIndent=2,
    spaceAfter=6,
)
NUMBERED = ParagraphStyle(
    "Numbered",
    parent=BODY,
    leftIndent=18,
    firstLineIndent=-12,
    bulletIndent=4,
    spaceAfter=6,
)
TITLE = ParagraphStyle(
    "Title",
    parent=styles["Heading1"],
    fontName=FONT_HAND,
    fontSize=19,
    leading=22,
    textColor=HEADER_FG,
    alignment=TA_CENTER,
    spaceAfter=0,
)
SECTION = ParagraphStyle(
    "Section",
    parent=styles["Heading2"],
    fontName=FONT_BOLD,
    fontSize=12,
    leading=14,
    textColor=colors.HexColor("#255D2A"),
    spaceAfter=0,
)
SUBSECTION = ParagraphStyle(
    "Subsection",
    parent=styles["Heading3"],
    fontName=FONT_BOLD,
    fontSize=10.5,
    leading=13,
    textColor=SUB_FG,
    spaceAfter=3,
)
CARD_TEXT = ParagraphStyle(
    "CardText",
    parent=BODY,
    fontName=FONT_BODY,
    fontSize=10,
    leading=15,
    spaceAfter=0,
)
MONO = ParagraphStyle(
    "Mono",
    parent=BODY,
    fontName=FONT_MONO,
    fontSize=9,
    leading=13,
    textColor=CARD_CODE_FG,
    leftIndent=6,
    rightIndent=6,
)


def page_background(canvas, doc):
    width, height = A4
    grid = 7 * mm
    canvas.saveState()
    canvas.setFillColor(PAGE_BG)
    canvas.rect(0, 0, width, height, fill=1, stroke=0)

    # Draw squared paper grid across the writing area.
    canvas.setStrokeColor(RULE)
    canvas.setLineWidth(0.25)
    y = height - 22 * mm
    while y > 12 * mm:
        canvas.line(0, y, width, y)
        y -= grid
    x = 0
    while x <= width:
        canvas.line(x, 12 * mm, x, height - 22 * mm)
        x += grid

    canvas.setStrokeColor(MARGIN_LINE)
    canvas.setLineWidth(0.8)
    canvas.line(18 * mm, 0, 18 * mm, height)
    canvas.setLineWidth(0.4)
    canvas.line(20 * mm, 9 * mm, width - 15 * mm, 9 * mm)
    canvas.setFillColor(FOOTER_FG)
    canvas.setFont(FONT_BODY, 7)
    canvas.drawCentredString(width / 2, 5 * mm, f"Study Notes  .  GoodNotes A4  .  {canvas.getPageNumber()}")
    canvas.restoreState()


def title_block(title: str):
    clean = re.sub(r"^--\s*Page\s*\d+\s*[—–-]+\s*", "", title).strip() or title
    table = Table([[Paragraph(xml_text(clean), TITLE)]], colWidths=[165 * mm])
    table.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, -1), HEADER_BG),
        ("LEFTPADDING", (0, 0), (-1, -1), 10),
        ("RIGHTPADDING", (0, 0), (-1, -1), 10),
        ("TOPPADDING", (0, 0), (-1, -1), 8),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 8),
    ]))
    return table


def section_band(text: str, style_name: str):
    bg, fg = SECTION_COLORS[style_name]
    style = ParagraphStyle(f"section-{style_name}", parent=SECTION, textColor=fg)
    table = Table([["", Paragraph(xml_text(text), style)]], colWidths=[4 * mm, 161 * mm])
    table.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, -1), bg),
        ("BACKGROUND", (0, 0), (0, 0), fg),
        ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
        ("LEFTPADDING", (0, 0), (-1, -1), 8),
        ("RIGHTPADDING", (0, 0), (-1, -1), 8),
        ("TOPPADDING", (0, 0), (-1, -1), 7),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 7),
    ]))
    return table


def list_heading(text: str):
    label = re.sub(r"^\s*[-*+]\s+", "", text).strip()
    table = Table([[Paragraph(xml_text(label), SUBSECTION)]], colWidths=[55 * mm])
    table.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, -1), CARD_LABEL),
        ("LEFTPADDING", (0, 0), (-1, -1), 8),
        ("RIGHTPADDING", (0, 0), (-1, -1), 8),
        ("TOPPADDING", (0, 0), (-1, -1), 5),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 4),
    ]))
    return table


def labeled_paragraph(text: str):
    prefix, rest = split_label_prefix(text)
    if prefix:
        markup = f"<font name='{FONT_BOLD}' color='#1A3A6B'>{xml_text(prefix)}</font> {xml_text(rest)}"
        return Paragraph(markup, LABEL_BODY)
    return Paragraph(xml_text(text), BODY)


def bullet_paragraph(text: str, level: int = 0):
    style = ParagraphStyle(
        f"bullet-{level}",
        parent=BULLET,
        leftIndent=14 + level * 12,
        bulletIndent=2 + level * 12,
    )
    prefix, rest = split_label_prefix(text)
    if prefix:
        markup = f"<font name='{FONT_BOLD}' color='#1A3A6B'>{xml_text(prefix)}</font> {xml_text(rest)}"
    else:
        markup = xml_text(text)
    bullet_char = "•" if level == 0 else ("◦" if level == 1 else "▪")
    return Paragraph(markup, style, bulletText=bullet_char)


def numbered_paragraph(number: str, text: str):
    return Paragraph(xml_text(text), NUMBERED, bulletText=f"{number}.")


def card_block(text: str, kind: str):
    bg = CARD_YELLOW if kind == "flashcard" else CARD_GREEN
    edge = CARD_YELLOW_EDGE if kind == "flashcard" else CARD_GREEN_EDGE
    prefix, rest = split_label_prefix(text)
    if prefix:
        markup = f"<font name='{FONT_BOLD}' color='#1A3A6B'>{xml_text(prefix)}</font> {xml_text(rest)}"
    else:
        markup = xml_text(text)
    table = Table([["", Paragraph(markup, CARD_TEXT)]], colWidths=[3 * mm, 162 * mm])
    table.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, -1), bg),
        ("BACKGROUND", (0, 0), (0, 0), edge),
        ("VALIGN", (0, 0), (-1, -1), "TOP"),
        ("LEFTPADDING", (0, 0), (-1, -1), 8),
        ("RIGHTPADDING", (0, 0), (-1, -1), 10),
        ("TOPPADDING", (0, 0), (-1, -1), 7),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 7),
    ]))
    return table


def code_block(text: str):
    table = Table([[Preformatted(sanitize_text(text), MONO)]], colWidths=[165 * mm])
    table.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, -1), CARD_CODE),
        ("LEFTPADDING", (0, 0), (-1, -1), 8),
        ("RIGHTPADDING", (0, 0), (-1, -1), 8),
        ("TOPPADDING", (0, 0), (-1, -1), 6),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 6),
    ]))
    return table


def pipe_table(lines: list[str]):
    rows = []
    max_cols = 0
    for line in lines:
        parts = [Paragraph(xml_text(part.strip()), BODY) for part in line.split("|") if part.strip()]
        if parts:
            rows.append(parts)
            max_cols = max(max_cols, len(parts))
    if not rows:
        return None
    normalized = []
    for row in rows:
        row = row + [Paragraph("", BODY)] * (max_cols - len(row))
        normalized.append(row)
    widths = [165 * mm / max_cols] * max_cols
    table = Table(normalized, colWidths=widths, repeatRows=1 if len(rows) > 1 else 0)
    table.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#E7EEF8")),
        ("GRID", (0, 0), (-1, -1), 0.5, colors.HexColor("#C9D7EA")),
        ("BOX", (0, 0), (-1, -1), 0.5, colors.HexColor("#C9D7EA")),
        ("LEFTPADDING", (0, 0), (-1, -1), 6),
        ("RIGHTPADDING", (0, 0), (-1, -1), 6),
        ("TOPPADDING", (0, 0), (-1, -1), 6),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 6),
        ("VALIGN", (0, 0), (-1, -1), "TOP"),
    ]))
    return table


def build_story(pages: list[PageContent]):
    story = []
    for page_index, page in enumerate(pages):
        if page_index:
            story.append(PageBreak())
        story.append(title_block(page.title))
        story.append(Spacer(1, 6 * mm))

        current_section = "normal"
        i = 0
        while i < len(page.lines):
            raw = page.lines[i]
            stripped = raw.strip()
            next_line = None
            for later in page.lines[i + 1:]:
                if later.strip():
                    next_line = later
                    break

            if not stripped:
                story.append(Spacer(1, 2 * mm))
                i += 1
                continue

            if re.match(r"^={4,}$", stripped) or re.match(r"^--\s", stripped):
                i += 1
                continue

            if stripped.startswith("## "):
                current_section = section_style(stripped)
                story.append(section_band(stripped[3:].strip(), current_section))
                story.append(Spacer(1, 2.5 * mm))
                i += 1
                continue

            image_flowables = markdown_image_flowables(raw)
            if image_flowables is not None:
                story.extend(image_flowables)
                i += 1
                continue

            if stripped.startswith("# "):
                current_section = "normal"
                story.append(section_band(stripped[2:].strip(), current_section))
                story.append(Spacer(1, 2.5 * mm))
                i += 1
                continue

            if re.match(r"^#{3,}\s", stripped):
                story.append(Paragraph(xml_text(re.sub(r"^#{3,}\s*", "", stripped)), SUBSECTION))
                i += 1
                continue

            if is_plain_heading(raw, next_line):
                current_section = section_style(stripped)
                story.append(section_band(stripped, current_section))
                story.append(Spacer(1, 2.5 * mm))
                i += 1
                continue

            if is_ascii_marker(raw):
                marker = re.sub(r"^\s*[-*+]\s+", "", raw.rstrip())
                code_lines = [marker]
                j = i + 1
                blank_count = 0
                while j < len(page.lines):
                    nxt_raw = page.lines[j].rstrip()
                    nxt = nxt_raw.strip()
                    if not nxt:
                        blank_count += 1
                        if blank_count <= 1:
                            code_lines.append("")
                            j += 1
                            continue
                        break
                    blank_count = 0
                    if parse_markdown_image(nxt_raw):
                        break
                    if re.match(r"^(##|#|--|={3,})", nxt):
                        break
                    if is_list_heading(nxt_raw) and not is_ascii_marker(nxt_raw):
                        break
                    if re.match(r"^(\s*[-*+]\s+|\d+[.)]\s+|Q:|A:)", nxt) and not looks_like_diagram_line(nxt_raw):
                        break
                    if is_plain_heading(nxt_raw, None):
                        break
                    if is_ascii_marker(nxt_raw) or looks_like_diagram_line(nxt_raw) or nxt_raw.startswith("  "):
                        code_lines.append(nxt_raw)
                        j += 1
                        continue
                    break
                while code_lines and code_lines[-1] == "":
                    code_lines.pop()
                story.append(code_block("\n".join(code_lines)))
                story.append(Spacer(1, 2.5 * mm))
                i = j
                continue

            if is_list_heading(raw):
                story.append(list_heading(raw))
                story.append(Spacer(1, 1.5 * mm))
                i += 1
                continue

            if stripped.startswith("|"):
                table_lines = []
                while i < len(page.lines) and page.lines[i].strip().startswith("|"):
                    table_lines.append(page.lines[i].strip())
                    i += 1
                table = pipe_table(table_lines)
                if table is not None:
                    story.append(table)
                    story.append(Spacer(1, 3 * mm))
                continue

            if "|" in stripped and not re.match(r"^(\s*[-*+]|\d+[.)])", stripped):
                candidate_lines = []
                while i < len(page.lines):
                    candidate = page.lines[i].strip()
                    if "|" not in candidate or re.match(r"^(\s*[-*+]|\d+[.)])", candidate):
                        break
                    candidate_lines.append(candidate)
                    i += 1
                if len(candidate_lines) >= 2:
                    table = pipe_table(candidate_lines)
                    if table is not None:
                        story.append(table)
                        story.append(Spacer(1, 3 * mm))
                        continue
                for line in candidate_lines:
                    story.append(labeled_paragraph(clean_md(line)))
                continue

            if re.match(r"^[QqAa]:", stripped):
                story.append(card_block(clean_md(stripped), "exam" if current_section == "exam" else "flashcard"))
                story.append(Spacer(1, 2.5 * mm))
                i += 1
                continue

            match_number = re.match(r"^(\d+)[.)]\s+(.*)", stripped)
            if match_number:
                story.append(numbered_paragraph(match_number.group(1), clean_md(match_number.group(2))))
                i += 1
                continue

            match_bullet = re.match(r"^(\s*)([-*+])\s+(.*)", raw)
            if match_bullet:
                level = len(match_bullet.group(1)) // 2
                text = clean_md(match_bullet.group(3).strip())
                if current_section == "flashcard":
                    story.append(card_block(text, "flashcard"))
                    story.append(Spacer(1, 2.5 * mm))
                elif current_section == "exam":
                    story.append(card_block(text, "exam"))
                    story.append(Spacer(1, 2.5 * mm))
                else:
                    story.append(bullet_paragraph(text, level))
                i += 1
                continue

            if looks_like_diagram_line(stripped) or re.match(r"^\s*\[.*\]", stripped):
                code_lines = [raw.rstrip()]
                j = i + 1
                blank_count = 0
                while j < len(page.lines):
                    nxt = page.lines[j].rstrip()
                    if not nxt.strip():
                        blank_count += 1
                        if blank_count <= 1:
                            code_lines.append("")
                            j += 1
                            continue
                        break
                    blank_count = 0
                    if parse_markdown_image(nxt):
                        break
                    if re.match(r"^(#|[-*+]|\d+[.)]|Q:|A:)", nxt.strip()):
                        break
                    if nxt.count("|") >= 2 and not nxt.strip().startswith("["):
                        break
                    if is_ascii_marker(nxt):
                        break
                    code_lines.append(nxt)
                    j += 1
                while code_lines and code_lines[-1] == "":
                    code_lines.pop()
                story.append(code_block("\n".join(code_lines)))
                story.append(Spacer(1, 2.5 * mm))
                i = j
                continue

            text = clean_md(stripped)
            if current_section == "flashcard":
                story.append(card_block(text, "flashcard"))
                story.append(Spacer(1, 2.5 * mm))
            elif current_section == "exam":
                story.append(card_block(text, "exam"))
                story.append(Spacer(1, 2.5 * mm))
            else:
                story.append(labeled_paragraph(text))
            i += 1
    return story


with open(INPUT_MD, "r", encoding="utf-8") as handle:
    raw_content = handle.read()

pages = parse_pages(raw_content)
story = build_story(pages)

doc = SimpleDocTemplate(
    OUTPUT_PDF,
    pagesize=A4,
    leftMargin=24 * mm,
    rightMargin=18 * mm,
    topMargin=16 * mm,
    bottomMargin=14 * mm,
)
doc.build(story, onFirstPage=page_background, onLaterPages=page_background)
print(f"Wrote {OUTPUT_PDF}  ({len(pages)} source pages, image size: {IMAGE_SIZE_MODE})")
