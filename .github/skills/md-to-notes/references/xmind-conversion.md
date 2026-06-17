# Freemind → XMind Conversion Reference

## Why .mm Fails in XMind
XMind's XML parser is strict:
- Bare `&` in node TEXT → "Invalid character in entity name"
- Non-UTF-8 bytes → silent corruption
- Missing `META-INF/manifest.xml` or `meta.xml` → "not a valid XMind File"

## Generating a Valid .xmind (Recommended Approach)
Use `generate_valid_xmind.py` (create from template below) rather than the `xmind-sdk` saver,
because the SDK's `xmind.load(path)` creates only `content.xml` — XMind 25.x requires all three files.

### Required Archive Structure
```
<file>.xmind (ZIP)
├── content.xml          ← main mindmap XML
├── meta.xml             ← creator metadata
└── META-INF/
    └── manifest.xml     ← file entry index
```

### Script Template (save as `scripts/generate_valid_xmind.py`)
```python
import xml.etree.ElementTree as ET
import uuid, zipfile
from xml.dom import minidom

def make_id(): return uuid.uuid4().hex

def build_xmind(mm_path, out_path):
    mm_tree = ET.parse(mm_path)
    mm_root = mm_tree.getroot()
    mm_node = mm_root.find('node')
    if mm_node is None: mm_node = mm_root

    xmap = ET.Element('xmap-content', {
        'xmlns': 'urn:xmind:xmap:xmlns:content:2.0',
        'xmlns:fo': 'http://www.w3.org/1999/XSL/Format',
        'xmlns:xhtml': 'http://www.w3.org/1999/xhtml',
        'xmlns:xlink': 'http://www.w3.org/1999/xlink',
        'xmlns:svg': 'http://www.w3.org/2000/svg',
        'timestamp': '0', 'version': '2.0'
    })
    sheet = ET.SubElement(xmap, 'sheet', {'id': make_id()})
    root_topic = ET.SubElement(sheet, 'topic', {'id': make_id()})
    ET.SubElement(root_topic, 'title').text = mm_node.get('TEXT') or 'Mindmap'

    def add_children(parent, node):
        children = list(node.findall('node'))
        if not children: return
        topics_el = ET.SubElement(ET.SubElement(parent, 'children'), 'topics', {'type': 'attached'})
        for c in children:
            t = ET.SubElement(topics_el, 'topic', {'id': make_id()})
            ET.SubElement(t, 'title').text = c.get('TEXT') or ''
            add_children(t, c)

    add_children(root_topic, mm_node)

    content_xml = minidom.parseString(ET.tostring(xmap, 'utf-8')).toxml(encoding='utf-8')
    meta_xml = b'<?xml version="1.0" encoding="UTF-8"?>\n<xmap-meta xmlns="urn:xmind:xmap:xmlns:meta:2.0"><creator>md-to-notes</creator></xmap-meta>'
    manifest_xml = b'<?xml version="1.0" encoding="UTF-8"?>\n<manifest>\n  <file-entry full-path="content.xml" media-type="text/xml"/>\n  <file-entry full-path="meta.xml" media-type="text/xml"/>\n</manifest>'

    with zipfile.ZipFile(out_path, 'w', zipfile.ZIP_DEFLATED) as zf:
        zf.writestr('content.xml', content_xml)
        zf.writestr('meta.xml', meta_xml)
        zf.writestr('META-INF/manifest.xml', manifest_xml)
    print('Wrote', out_path)

if __name__ == '__main__':
    import sys
    build_xmind(sys.argv[1], sys.argv[2])
```

### Usage
```bash
cd /Users/arya/my-space/smart-study-notes
.venv/bin/python scripts/generate_valid_xmind.py \
  <FileName>_StudyNotes/<file>_clean.mm \
  <FileName>_StudyNotes/<file>_fixed.xmind
```

## Sanitising .mm XML
Before converting, ensure the `.mm` is valid XML:
```bash
# Check for bare ampersands
grep -n '&[^a;]' <file>.mm

# Fix with Python
python3 -c "
import re, sys
text = open(sys.argv[1]).read()
text = re.sub(r'&(?!(amp|lt|gt|quot|apos);)', '&amp;', text)
open(sys.argv[2], 'w').write(text)
" input.mm output_clean.mm
```
