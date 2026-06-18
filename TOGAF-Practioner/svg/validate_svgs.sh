#!/bin/bash
errors=0
warnings=0
for f in *.svg; do
  if xmllint --noout "$f" 2>/dev/null; then
    echo "OK $f"
  else
    echo "ERR $f"
    errors=$((errors + 1))
  fi
done
echo "errors=$errors warnings=$warnings"