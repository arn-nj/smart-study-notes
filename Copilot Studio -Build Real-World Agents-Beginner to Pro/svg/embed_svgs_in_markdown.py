#!/usr/bin/env python3
"""
SVG Embedder - Embeds SVG files directly into markdown
Usage: python embed_svgs_in_markdown.py <input.md> <output.md> <svg_folder>
"""

import os
import re
import sys
from pathlib import Path

def embed_svg_references(markdown_content, svg_folder):
    """Replace image references with inline SVG content"""
    
    # Pattern to match markdown image references like ![text](path/to/file.svg)
    pattern = r'!\[([^\]]*)\]\(([^)]*\.svg)\)'
    
    def replace_with_inline_svg(match):
        alt_text = match.group(1)
        svg_path = match.group(2)
        
        # Handle relative paths
        if not os.path.isabs(svg_path):
            full_path = os.path.join(svg_folder, os.path.basename(svg_path))
        else:
            full_path = svg_path
        
        # Read SVG file
        if os.path.exists(full_path):
            try:
                with open(full_path, 'r', encoding='utf-8') as f:
                    svg_content = f.read()
                
                # Wrap SVG with HTML comment for clarity
                wrapped = f"""<!-- SVG Diagram: {alt_text} -->
{svg_content}
<!-- End SVG -->"""
                return wrapped
            except Exception as e:
                print(f"Warning: Could not read {full_path}: {e}")
                return match.group(0)  # Return original if error
        else:
            print(f"Warning: SVG file not found: {full_path}")
            return match.group(0)  # Return original if not found
    
    # Replace all SVG image references with inline content
    result = re.sub(pattern, replace_with_inline_svg, markdown_content)
    return result

def main():
    if len(sys.argv) < 4:
        print("Usage: python embed_svgs_in_markdown.py <input.md> <output.md> <svg_folder>")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    svg_folder = sys.argv[3]
    
    if not os.path.exists(input_file):
        print(f"Error: Input file not found: {input_file}")
        sys.exit(1)
    
    if not os.path.exists(svg_folder):
        print(f"Error: SVG folder not found: {svg_folder}")
        sys.exit(1)
    
    # Read markdown
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Embed SVGs
    print(f"Reading markdown from: {input_file}")
    print(f"SVG folder: {svg_folder}")
    updated_content = embed_svg_references(content, svg_folder)
    
    # Write output
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(updated_content)
    
    print(f"✓ Embedded SVGs into: {output_file}")
    print(f"✓ File size: {len(updated_content) / 1024:.1f}KB")

if __name__ == '__main__':
    main()
