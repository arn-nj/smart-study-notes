#!/bin/bash
set -u

errors=0
warnings=0
report_file="validation_report.txt"

echo "SVG Validation Report" > "$report_file"
echo "====================" >> "$report_file"

for file in *.svg; do
  echo "Checking $file"
  if xmllint --noout "$file" 2>>"$report_file"; then
    echo "✓ $file valid" | tee -a "$report_file"
  else
    echo "✗ $file invalid" | tee -a "$report_file"
    errors=$((errors + 1))
  fi

  text_count=$(grep -o "<text " "$file" | wc -l | tr -d ' ')
  if [ "$text_count" -lt 15 ]; then
    echo "! $file low text label count: $text_count" | tee -a "$report_file"
    warnings=$((warnings + 1))
  fi

  size_kb=$(du -k "$file" | awk '{print $1}')
  echo "  labels=$text_count size_kb=$size_kb" >> "$report_file"
done

echo "errors=$errors warnings=$warnings" | tee -a "$report_file"
exit 0