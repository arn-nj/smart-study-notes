#!/usr/bin/env python3
"""
generate_valid_xmind.py
Convert a Freemind .mm file to a valid XMind .xmind archive.

Usage:
    python generate_valid_xmind.py <input.mm> <output.xmind>
"""

import xml.etree.ElementTree as ET
import uuid
import zipfile
import sys
from xml.dom import minidom


def make_id():
    return uuid.uuid4().hex


def build_xmind(mm_path, out_path):
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

    print(f'Wrote {out_path}')


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print('Usage: generate_valid_xmind.py <input.mm> <output.xmind>')
        sys.exit(1)
    build_xmind(sys.argv[1], sys.argv[2])
