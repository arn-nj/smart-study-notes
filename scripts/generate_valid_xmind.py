#!/usr/bin/env python3
"""
generate_valid_xmind.py
Convert a Freemind .mm file to a valid XMind .xmind archive.

Enhancement mode (default):
- Reads course notes markdown when available
- Prepends "In this section" to each page topic
- Adds "Process Flow / Steps" section when present in notes
- Adds SVG links under each page topic

Usage:
    python generate_valid_xmind.py <input.mm> <output.xmind> [notes.md]
"""

import argparse
import xml.etree.ElementTree as ET
import uuid
import zipfile
import sys
import re
from pathlib import Path
from xml.dom import minidom


SCRIPT_VERSION = "1.2.4"


def make_id():
    return uuid.uuid4().hex


PAGE_HEADER_RE = re.compile(r'^--\s*Page\s+(\d+)\s*:\s*(.+?)\s*$', re.IGNORECASE)


def _clean_md_line(line):
    value = line.strip()
    value = re.sub(r'`([^`]+)`', r'\1', value)
    value = re.sub(r'\*\*([^*]+)\*\*', r'\1', value)
    value = re.sub(r'\*([^*]+)\*', r'\1', value)
    return value.strip()


def parse_notes_markdown(notes_path):
    """Parse markdown notes into page-indexed structured content."""
    if not notes_path or not notes_path.exists():
        return {}

    lines = notes_path.read_text(encoding='utf-8', errors='ignore').splitlines()
    pages = {}
    current_page = None
    current_section = None

    for raw in lines:
        line = raw.rstrip('\n')
        page_match = PAGE_HEADER_RE.match(line.strip())
        if page_match:
            page_num = int(page_match.group(1))
            title = page_match.group(2).strip()
            current_page = {
                'title': title,
                'what_youll_learn': '',
                'scenario': '',
                'why_it_matters': '',
                'steps': [],
                'core_idea': [],
                'key_concepts': [],
                'svg_files': []
            }
            pages[page_num] = current_page
            current_section = None
            continue

        if current_page is None:
            continue

        stripped = line.strip()
        if not stripped:
            continue

        h2 = re.match(r'^##\s+(.+)$', stripped)
        if h2:
            current_section = h2.group(1).strip().lower()
            continue

        # Extract SVG references from markdown image syntax
        image_match = re.search(r'!\[[^\]]*\]\(([^)]+\.svg)\)', stripped, flags=re.IGNORECASE)
        if image_match:
            svg_ref = image_match.group(1).strip()
            svg_name = Path(svg_ref).name
            if svg_name and svg_name not in current_page['svg_files']:
                current_page['svg_files'].append(svg_name)

        if current_section == 'what you\'ll learn':
            if not current_page['what_youll_learn']:
                current_page['what_youll_learn'] = _clean_md_line(stripped)
            continue

        if current_section == 'real-world use first':
            scenario_match = re.search(r'Scenario\s*:\s*(.+)', stripped, flags=re.IGNORECASE)
            why_match = re.search(r'Why\s+it\s+matters\s*:\s*(.+)', stripped, flags=re.IGNORECASE)
            if scenario_match and not current_page['scenario']:
                current_page['scenario'] = _clean_md_line(scenario_match.group(1))
            if why_match and not current_page['why_it_matters']:
                current_page['why_it_matters'] = _clean_md_line(why_match.group(1))
            continue

        if current_section == 'process flow / steps':
            step_match = re.match(r'^\d+\.\s+(.+)$', stripped)
            if step_match:
                current_page['steps'].append(_clean_md_line(step_match.group(1)))
            continue

        if current_section == 'core idea (60 sec)' and stripped.startswith('- '):
            current_page['core_idea'].append(_clean_md_line(stripped[2:]))
            continue

        if current_section == 'key concepts' and stripped.startswith('- '):
            current_page['key_concepts'].append(_clean_md_line(stripped[2:]))
            continue

    return pages


def _ensure_page_bucket(pages, page_num):
    bucket = pages.get(page_num)
    if bucket is None:
        bucket = []
        pages[page_num] = bucket
    return bucket


def parse_ai_elaboration_markdown(elaboration_path):
    """Parse optional AI elaboration markdown into page-indexed bullet text."""
    if not elaboration_path or not elaboration_path.exists():
        return {}

    lines = elaboration_path.read_text(encoding='utf-8', errors='ignore').splitlines()
    pages = {}
    current_page = None
    current_section = None

    for raw in lines:
        line = raw.rstrip('\n')
        page_match = PAGE_HEADER_RE.match(line.strip())
        if page_match:
            current_page = int(page_match.group(1))
            current_section = None
            continue

        if current_page is None:
            continue

        stripped = line.strip()
        if not stripped:
            continue

        h2 = re.match(r'^##\s+(.+)$', stripped)
        if h2:
            current_section = h2.group(1).strip().lower()
            continue

        if current_section and 'elaboration' not in current_section and 'insight' not in current_section and 'synthesis' not in current_section:
            continue

        text = _clean_md_line(stripped.lstrip('-*0123456789. '))
        if text:
            _ensure_page_bucket(pages, current_page).append(text)

    return {page: unique_lines(items) for page, items in pages.items()}


def parse_ai_elaboration_json(elaboration_path):
    """Parse optional AI elaboration JSON into page-indexed bullet text."""
    if not elaboration_path or not elaboration_path.exists():
        return {}

    import json

    payload = json.loads(elaboration_path.read_text(encoding='utf-8', errors='ignore'))
    pages = {}

    def add_items(page_num, items, label=None):
        if page_num is None:
            return
        bucket = _ensure_page_bucket(pages, int(page_num))
        for item in items or []:
            text = _clean_md_line(str(item))
            if text:
                if label and not text.lower().startswith(f"{label.lower()}:"):
                    text = f"{label}: {text}"
                bucket.append(text)

    def add_page_value(page_num, value):
        if isinstance(value, dict):
            for key, nested in value.items():
                if isinstance(nested, list):
                    add_items(page_num, nested, key)
                else:
                    add_items(page_num, [nested], key)
            return

        if isinstance(value, list):
            add_items(page_num, value)
            return

        add_items(page_num, [value])

    if isinstance(payload, dict):
        if 'pages' in payload and isinstance(payload['pages'], dict):
            for key, value in payload['pages'].items():
                add_page_value(key, value)
        else:
            for key, value in payload.items():
                if str(key).isdigit():
                    add_page_value(key, value)
    elif isinstance(payload, list):
        for entry in payload:
            if not isinstance(entry, dict):
                continue
            page_num = entry.get('page') or entry.get('page_num') or entry.get('pageNumber')
            items = entry.get('items') or entry.get('points') or entry.get('lines') or entry.get('content') or []
            if isinstance(items, str):
                items = [items]
            add_items(page_num, items)

    return {page: unique_lines(items) for page, items in pages.items()}


def find_ai_elaboration_path(course_dir, mm_path):
    base_name = Path(mm_path).stem
    course_slug = course_dir.name
    candidates = [
        course_dir / 'ai_elaboration.json',
        course_dir / 'AI_Elaboration.json',
        course_dir / 'ai_elaboration.md',
        course_dir / 'AI_Elaboration.md',
        course_dir / f'{base_name}_AI_Elaboration.json',
        course_dir / f'{base_name}_AI_Elaboration.md',
        course_dir / f'{course_slug}_AI_Elaboration.json',
        course_dir / f'{course_slug}_AI_Elaboration.md',
    ]

    for candidate in candidates:
        if candidate.exists():
            return candidate

    for candidate in sorted(course_dir.glob('*AI*Elaboration*.json')):
        return candidate
    for candidate in sorted(course_dir.glob('*AI*Elaboration*.md')):
        return candidate

    return None


def parse_ai_elaboration_source(elaboration_path):
    if not elaboration_path or not elaboration_path.exists():
        return {}

    suffix = elaboration_path.suffix.lower()
    if suffix == '.json':
        return parse_ai_elaboration_json(elaboration_path)
    return parse_ai_elaboration_markdown(elaboration_path)


def parse_svg_index(index_path):
    """Parse svg/INDEX.md table rows into page-mapped references."""
    entries = []
    if not index_path.exists():
        return entries

    for raw_line in index_path.read_text(encoding='utf-8').splitlines():
        line = raw_line.strip()
        if not line.startswith('|'):
            continue

        cols = [c.strip() for c in line.split('|') if c.strip()]
        if len(cols) < 2:
            continue
        if cols[0].lower() == 'file' or set(cols[0].replace(' ', '')) == {'-'}:
            continue

        m_link = re.search(r'\((?:\./)?([^()]+\.svg)\)', cols[0], flags=re.IGNORECASE)
        m_file = re.search(r'([A-Za-z0-9_.\- ]+\.svg)', cols[0], flags=re.IGNORECASE)
        file_name = (m_link.group(1) if m_link else (m_file.group(1) if m_file else '')).strip()
        if not file_name:
            continue

        concept = re.sub(r'[`*]', '', cols[1]).strip() or 'Concept visual'
        pages_col = next((c for c in cols if 'page' in c.lower()), '')
        pages = [int(v) for v in re.findall(r'\d+', pages_col)]

        entries.append({
            'file': file_name,
            'concept': concept,
            'pages': pages,
        })

    return entries


def build_svg_map(index_entries, page_count):
    by_page = {}

    for entry in index_entries:
        for page in entry['pages']:
            if page < 1 or page > page_count:
                continue
            by_page.setdefault(page, []).append(entry)

    fallback_page = 1
    for entry in index_entries:
        if entry['pages']:
            continue
        page = min(fallback_page, page_count)
        by_page.setdefault(page, []).append(entry)
        fallback_page += 1

    return by_page


def unique_lines(lines):
    seen = set()
    out = []
    for raw in lines:
        line = (raw or '').strip()
        if not line:
            continue
        key = line.lower()
        if key in seen:
            continue
        seen.add(key)
        out.append(line)
    return out


def normalize_text(text):
    text = (text or '').lower()
    text = re.sub(r'[^a-z0-9]+', ' ', text)
    return ' '.join(text.split())


def token_set(text):
    return {t for t in re.split(r'\W+', (text or '').lower()) if len(t) > 3}


def is_duplicate_like(candidate, existing_texts):
    candidate_norm = normalize_text(candidate)
    if not candidate_norm:
        return True

    candidate_tokens = token_set(candidate)
    if not candidate_tokens:
      return True

    for existing in existing_texts:
        existing_norm = normalize_text(existing)
        if not existing_norm:
            continue
        if candidate_norm == existing_norm:
            return True
        if candidate_norm in existing_norm or existing_norm in candidate_norm:
            return True
        existing_tokens = token_set(existing)
        if not existing_tokens:
            continue
        overlap = len(candidate_tokens & existing_tokens)
        if overlap >= 3 and overlap / max(len(candidate_tokens), len(existing_tokens)) >= 0.7:
            return True

    return False


def load_svg_asset_bytes(course_dir, svg_name):
    svg_path = course_dir / 'svg' / svg_name
    if not svg_path.exists():
        return None
    return svg_path.read_bytes()


def remove_existing_child_topics(topic_element, titles):
    """Remove attached child topics with any title in titles."""
    target_titles = {t.strip().lower() for t in titles}
    children_el = topic_element.find('children')
    if children_el is None:
        return

    for topics_el in list(children_el.findall('topics')):
        attached = topics_el.get('type', '').lower() == 'attached'
        if not attached:
            continue

        for child_topic in list(topics_el.findall('topic')):
            title_el = child_topic.find('title')
            title_text = (title_el.text or '').strip().lower() if title_el is not None else ''
            if title_text in target_titles:
                topics_el.remove(child_topic)


def ensure_attached_topics(topic_element):
    children_el = topic_element.find('children')
    if children_el is None:
        children_el = ET.SubElement(topic_element, 'children')

    for topics_el in children_el.findall('topics'):
        if topics_el.get('type') == 'attached':
            return topics_el

    return ET.SubElement(children_el, 'topics', {'type': 'attached'})


def add_topic_with_bullets(parent_attached_topics, title, bullets=None, href=None):
    topic_el = ET.SubElement(parent_attached_topics, 'topic', {'id': make_id()})
    if href:
        topic_el.set('{http://www.w3.org/1999/xlink}href', href)
    ET.SubElement(topic_el, 'title').text = title
    bullets = bullets or []
    if bullets:
        children_el = ET.SubElement(topic_el, 'children')
        topics_el = ET.SubElement(children_el, 'topics', {'type': 'attached'})
        for bullet in bullets:
            b = ET.SubElement(topics_el, 'topic', {'id': make_id()})
            ET.SubElement(b, 'title').text = bullet
    return topic_el


def extract_concepts(page_note):
    values = []
    for item in page_note.get('core_idea', []) + page_note.get('key_concepts', []) + page_note.get('steps', []):
        cleaned = item.strip()
        if cleaned:
            values.append(cleaned)
    return values


def collect_page_text(page_note):
    texts = []
    for key in ['title', 'what_youll_learn', 'scenario', 'why_it_matters']:
        value = page_note.get(key)
        if value:
            texts.append(value)
    texts.extend(page_note.get('steps', []))
    texts.extend(page_note.get('core_idea', []))
    texts.extend(page_note.get('key_concepts', []))
    return unique_lines(texts)


def build_page_focus(page_note, page_title):
    scenario = (page_note.get('scenario') or '').strip()
    why = (page_note.get('why_it_matters') or '').strip()
    what = (page_note.get('what_youll_learn') or '').strip()
    core = (page_note.get('core_idea') or [''])[0].strip()
    step = (page_note.get('steps') or [''])[0].strip()

    candidates = [scenario, why, what, core, step, page_title]
    for candidate in candidates:
        if candidate:
            return candidate
    return page_title


def normalize_concept_key(text):
    text = text.lower()
    text = re.sub(r'[^a-z0-9]+', ' ', text)
    return ' '.join(text.split())


def build_concept_index(notes_map):
    concept_index = {}
    for page_num, note in notes_map.items():
        for phrase in extract_concepts(note):
            key = normalize_concept_key(phrase)
            if len(key) < 4:
                continue
            concept_index.setdefault(key, []).append((page_num, phrase))
    return concept_index


def pick_cross_page_connections(page_num, page_note, notes_map):
    current_terms = []
    for phrase in extract_concepts(page_note):
        tokens = [t for t in re.split(r'\W+', phrase.lower()) if len(t) > 4]
        current_terms.extend(tokens[:3])

    current_terms = list(dict.fromkeys(current_terms))
    if not current_terms:
        return []

    connections = []
    current_text = ' '.join(collect_page_text(page_note))
    for other_page, other_note in notes_map.items():
        if other_page == page_num:
            continue
        haystack = ' '.join(collect_page_text(other_note)).lower()
        matched = [term for term in current_terms if term in haystack]
        if matched:
            candidate_text = f"{other_note.get('title', f'Page {other_page}')} {' '.join(matched)}"
            if is_duplicate_like(candidate_text, [current_text, haystack]):
                continue
            connections.append((other_page, other_note.get('title', f'Page {other_page}'), matched[:2]))
    return connections[:3]


def ai_style_elaboration(page_num, page_title, page_note, notes_map, elaboration_map=None):
    """AI-style elaboration from an external artifact, with safe fallback synthesis."""
    page_texts = collect_page_text(page_note)
    page_focus = build_page_focus(page_note, page_title)

    if elaboration_map:
        external = []
        for item in elaboration_map.get(page_num, []):
            if not is_duplicate_like(item, page_texts):
                external.append(item)
        if external:
            return unique_lines(external)

    elaboration = []

    connections = pick_cross_page_connections(page_num, page_note, notes_map)
    if connections:
        other_page, other_title, matched = connections[0]
        matched_text = ', '.join(matched)
        candidate = f"{page_title} {other_title} {matched_text} {page_focus}"
        if not is_duplicate_like(candidate, page_texts + [page_title, other_title]):
            elaboration.append(
                f"Connecting Dots: {page_title} shares {matched_text} with Page {other_page} ({other_title}), but this page frames it around {page_focus}"
            )

    steps = page_note.get('steps', [])
    core_idea = page_note.get('core_idea', [])
    if steps and core_idea:
        candidate = f"{core_idea[0]} {steps[0]} {page_focus}"
        if not is_duplicate_like(candidate, page_texts):
            elaboration.append(
                f"Same Idea, Different Layer: the concept becomes actionable when {steps[0]} turns the idea into a concrete workflow"
            )

    scenario = page_note.get('scenario')
    why = page_note.get('why_it_matters')
    if scenario and why:
        candidate = f"{scenario} {why} {page_focus}"
        if not is_duplicate_like(candidate, page_texts):
            elaboration.append(
                f"Connecting the Dots: the scenario explains the pressure, and the why explains the payoff for {page_focus}"
            )

    return unique_lines(elaboration)


def augment_topic_with_notes(topic_el, page_num, page_note, svg_refs, notes_map, elaboration_map=None):
    if not page_note and not svg_refs:
        return

    remove_existing_child_topics(topic_el, ['In this section', 'Process Flow / Steps', 'AI Elaboration', 'SVG References'])
    attached = ensure_attached_topics(topic_el)

    if page_note:
        scenario = page_note.get('scenario') or (page_note.get('core_idea') or [''])[0]
        why = page_note.get('why_it_matters') or (page_note.get('key_concepts') or [''])[0]
        summary = page_note.get('what_youll_learn') or (page_note.get('core_idea') or [''])[0]

        in_this_section_bullets = []
        if scenario:
            in_this_section_bullets.append(f"Scenario: {scenario}")
        if why:
            in_this_section_bullets.append(f"Why it matters: {why}")
        if summary:
            in_this_section_bullets.append(f"In summary: {summary}")

        if in_this_section_bullets:
            in_section_topic = add_topic_with_bullets(attached, 'In this section', in_this_section_bullets)
            attached.remove(in_section_topic)
            attached.insert(0, in_section_topic)

        if page_note.get('steps'):
            add_topic_with_bullets(attached, 'Process Flow / Steps', page_note['steps'])

        elaboration = ai_style_elaboration(page_num, page_note.get('title', ''), page_note, notes_map, elaboration_map)
        if elaboration:
            add_topic_with_bullets(attached, 'AI Elaboration', elaboration)

    svg_names = []
    if page_note:
        svg_names.extend(page_note.get('svg_files', []))
    for ref in svg_refs:
        svg_names.append(ref['file'])

    ordered_svg_names = []
    for name in svg_names:
        if name not in ordered_svg_names:
            ordered_svg_names.append(name)

    if ordered_svg_names:
        svg_topic = add_topic_with_bullets(attached, 'SVG References', [])
        svg_attached = ensure_attached_topics(svg_topic)
        for svg_name in ordered_svg_names:
            add_topic_with_bullets(svg_attached, f"SVG: {svg_name}", [], href=f"./svg/{svg_name}")


def build_xmind(mm_path, out_path, notes_path=None):
    mm_tree = ET.parse(mm_path)
    mm_root = mm_tree.getroot()

    mm_node = mm_root.find('node')
    if mm_node is None:
        mm_node = mm_root

    xmap = ET.Element('xmap-content', {
        'xmlns': 'urn:xmind:xmap:xmlns:content:2.0',
        'xmlns:fo': 'http://www.w3.org/1999/XSL/Format',
        'xmlns:xhtml': 'http://www.w3.org/1999/xhtml',
        'xmlns:xlink': 'http://www.w3.org/1999/xlink',
        'xmlns:svg': 'http://www.w3.org/2000/svg',
        'timestamp': '0',
        'version': '2.0'
    })
    sheet = ET.SubElement(xmap, 'sheet', {'id': make_id()})
    root_topic = ET.SubElement(sheet, 'topic', {'id': make_id()})
    ET.SubElement(root_topic, 'title').text = mm_node.get('TEXT') or 'Mindmap'

    svg_entries = parse_svg_index(Path(mm_path).parent / 'svg' / 'INDEX.md')
    notes_map = parse_notes_markdown(Path(notes_path) if notes_path else None)
    elaboration_path = find_ai_elaboration_path(Path(mm_path).parent, mm_path)
    elaboration_map = parse_ai_elaboration_source(elaboration_path)
    def add_children(parent, node):
        children = list(node.findall('node'))
        if not children:
            return
        children_el = ET.SubElement(parent, 'children')
        topics_el = ET.SubElement(children_el, 'topics', {'type': 'attached'})
        for c in children:
            t = ET.SubElement(topics_el, 'topic', {'id': make_id()})
            ET.SubElement(t, 'title').text = c.get('TEXT') or ''
            add_children(t, c)

    level1_children = list(mm_node.findall('node'))
    svg_by_page = build_svg_map(svg_entries, len(level1_children))

    if level1_children:
        children_el = ET.SubElement(root_topic, 'children')
        topics_el = ET.SubElement(children_el, 'topics', {'type': 'attached'})

        for idx, c in enumerate(level1_children, start=1):
            t = ET.SubElement(topics_el, 'topic', {'id': make_id()})
            ET.SubElement(t, 'title').text = c.get('TEXT') or ''
            add_children(t, c)

            refs = svg_by_page.get(idx, [])
            page_note = notes_map.get(idx)
            augment_topic_with_notes(t, idx, page_note, refs, notes_map, elaboration_map)
    else:
        add_children(root_topic, mm_node)

    content_xml = minidom.parseString(
        ET.tostring(xmap, 'utf-8')
    ).toxml(encoding='utf-8')

    meta_xml = (
        b'<?xml version="1.0" encoding="UTF-8"?>\n'
        b'<xmap-meta xmlns="urn:xmind:xmap:xmlns:meta:2.0">'
        b'<creator>transcript-to-notes</creator>'
        b'</xmap-meta>'
    )

    manifest_xml = (
        b'<?xml version="1.0" encoding="UTF-8"?>\n'
        b'<manifest>\n'
        b'  <file-entry full-path="content.xml" media-type="text/xml"/>\n'
        b'  <file-entry full-path="meta.xml" media-type="text/xml"/>\n'
        b'</manifest>'
    )

    with zipfile.ZipFile(out_path, 'w', zipfile.ZIP_DEFLATED) as zf:
        zf.writestr('content.xml', content_xml)
        zf.writestr('meta.xml', meta_xml)
        zf.writestr('META-INF/manifest.xml', manifest_xml)

        # Package SVG assets so xlink:href targets resolve to actual images instead of bare file names.
        svg_names = []
        for entry in svg_entries:
            if entry['file'] not in svg_names:
                svg_names.append(entry['file'])
        for note in notes_map.values():
            for svg_name in note.get('svg_files', []):
                if svg_name not in svg_names:
                    svg_names.append(svg_name)

        for svg_name in svg_names:
            svg_bytes = load_svg_asset_bytes(Path(mm_path).parent, svg_name)
            if svg_bytes is None:
                continue
            zf.writestr(f'svg/{svg_name}', svg_bytes)

    print(f'Wrote {out_path} (generate_valid_xmind.py v{SCRIPT_VERSION})')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Convert .mm to valid .xmind with optional notes-driven enrichment.')
    parser.add_argument('input_mm', help='Input Freemind .mm path')
    parser.add_argument('output_xmind', help='Output .xmind path')
    parser.add_argument('notes_md', nargs='?', default=None, help='Optional GoodNotes markdown path for enrichment')
    args = parser.parse_args()

    notes_path = args.notes_md
    if notes_path is None:
        mm_base = Path(args.input_mm).stem
        course_dir = Path(args.input_mm).parent
        auto_candidates = [
            course_dir / f"{mm_base.replace('_course_videos_clean', '')}_GoodNotes_detailed.md",
            course_dir / f"{mm_base.replace('_course_videos', '')}_GoodNotes_detailed.md",
            course_dir / f"{course_dir.name.replace(' ', '')}_GoodNotes_detailed.md"
        ]
        for candidate in auto_candidates:
            if candidate.exists():
                notes_path = str(candidate)
                break

    build_xmind(args.input_mm, args.output_xmind, notes_path)
