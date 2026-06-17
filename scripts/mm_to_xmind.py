import xml.etree.ElementTree as ET
from xmind_sdk import xmind
from xmind_sdk.core.topic import TopicElement
from xmind_sdk.core.markerref import MarkerId

INPUT_MM = 'TOGAF_course_videos_clean.mm'
OUTPUT_XMIND = 'TOGAF_course_videos.xmind'

# Parse mm
tree = ET.parse(INPUT_MM)
root = tree.getroot()

# Create workbook and sheet
wb = xmind.load(OUTPUT_XMIND) if False else xmind.load(None)
sheet = wb.createSheet()
sheet.setTitle('TOGAF Course')
root_topic = sheet.getRootTopic()
root_topic.setTitle('TOGAF Course — Udemy transcript')

# recursive function
def add_nodes(parent_topic, xml_node):
    for node in xml_node.findall('node'):
        text = node.get('TEXT') or ''
        child = parent_topic.addSubTopic()
        child.setTitle(text)
        add_nodes(child, node)

# Find top-level node (first child under map)
map_node = root.find('node')
if map_node is None:
    # Fallback: use root
    map_node = root

# Add children of map_node to root_topic
add_nodes(root_topic, map_node)

# save workbook
xmind.save(wb, OUTPUT_XMIND)
print('Wrote', OUTPUT_XMIND)
