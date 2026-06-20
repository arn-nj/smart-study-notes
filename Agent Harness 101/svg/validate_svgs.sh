#!/usr/bin/env bash
set -euo pipefail

report_file="validation_report.txt"
: > "$report_file"

if command -v xmllint >/dev/null 2>&1; then
  for f in *.svg; do
    if xmllint --noout "$f" 2>>"$report_file"; then
      echo "✓ $f" | tee -a "$report_file"
    else
      echo "✗ $f" | tee -a "$report_file"
    fi
  done
else
  python - <<'PY' > "$report_file"
from pathlib import Path
import xml.etree.ElementTree as ET
errors = 0
for path in sorted(Path('.').glob('*.svg')):
    try:
        ET.parse(path)
        print(f"PASS {path.name}")
    except Exception as exc:
        errors += 1
        print(f"FAIL {path.name}: {exc}")
print(f"TOTAL_ERRORS={errors}")
print("TOTAL_WARNINGS=0")
PY
fi

grep -q "FAIL" "$report_file" && exit 1 || exit 0
