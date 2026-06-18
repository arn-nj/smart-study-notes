#!/bin/bash

# SVG Validation Script for Course Sketches
# Validates: XML structure, content quality, accessibility, and file size

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VALIDATION_LOG="${SCRIPT_DIR}/validation_report.txt"

echo "🔍 SVG Validation Report" > "$VALIDATION_LOG"
echo "Generated: $(date)" >> "$VALIDATION_LOG"
echo "=====================================" >> "$VALIDATION_LOG"
echo "" >> "$VALIDATION_LOG"

ERRORS=0
WARNINGS=0
VALID=0

for svg_file in "$SCRIPT_DIR"/*.svg; do
    filename=$(basename "$svg_file")
    echo "Validating: $filename" >> "$VALIDATION_LOG"
    
    # 1. XML Validation
    if xmllint --noout "$svg_file" 2>&1 | grep -q "error"; then
        echo "  ❌ XML Error" >> "$VALIDATION_LOG"
        ((ERRORS++))
    else
        echo "  ✓ Valid XML" >> "$VALIDATION_LOG"
        ((VALID++))
    fi
    
    # 2. Check for required SVG elements
    if grep -q '<svg' "$svg_file"; then
        echo "  ✓ SVG root element present" >> "$VALIDATION_LOG"
    else
        echo "  ❌ Missing SVG root element" >> "$VALIDATION_LOG"
        ((ERRORS++))
    fi
    
    # 3. Check for accessibility (text labels)
    text_count=$(grep -c '<text' "$svg_file" || true)
    if [ "$text_count" -gt 5 ]; then
        echo "  ✓ Accessibility: $text_count text labels" >> "$VALIDATION_LOG"
    else
        echo "  ⚠ Warning: Only $text_count text labels (recommended: 5+)" >> "$VALIDATION_LOG"
        ((WARNINGS++))
    fi
    
    # 4. Check file size
    filesize=$(stat -f%z "$svg_file" 2>/dev/null || stat -c%s "$svg_file" 2>/dev/null)
    filesize_kb=$((filesize / 1024))
    if [ "$filesize_kb" -lt 20 ]; then
        echo "  ✓ File size: ${filesize_kb}K (optimized)" >> "$VALIDATION_LOG"
    else
        echo "  ⚠ Warning: File size ${filesize_kb}K (consider optimizing)" >> "$VALIDATION_LOG"
        ((WARNINGS++))
    fi
    
    # 5. Check for colors (visual quality)
    color_count=$(grep -o 'fill="#[0-9a-fA-F]*"' "$svg_file" | sort -u | wc -l)
    echo "  ✓ Colors used: $color_count unique colors" >> "$VALIDATION_LOG"
    
    # 6. Check for markers/arrows (visual completeness)
    if grep -q '<marker' "$svg_file"; then
        echo "  ✓ Markers/arrows defined" >> "$VALIDATION_LOG"
    fi
    
    echo "" >> "$VALIDATION_LOG"
done

echo "=====================================" >> "$VALIDATION_LOG"
echo "Summary:" >> "$VALIDATION_LOG"
echo "  ✓ Valid: $VALID" >> "$VALIDATION_LOG"
echo "  ❌ Errors: $ERRORS" >> "$VALIDATION_LOG"
echo "  ⚠ Warnings: $WARNINGS" >> "$VALIDATION_LOG"
echo "=====================================" >> "$VALIDATION_LOG"

# Display summary
cat "$VALIDATION_LOG"

# Exit with error code if there are errors
if [ "$ERRORS" -gt 0 ]; then
    exit 1
fi
