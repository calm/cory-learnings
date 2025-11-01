#!/usr/bin/env bash
# Find code patterns from pattern library

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <pattern-name>"
  echo "Example: $0 'logging'"
  echo "Example: $0 'error-handling'"
  exit 1
fi

PATTERN="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PATTERNS_DIR="$SCRIPT_DIR/docs/patterns"

echo "📚 Searching for pattern: '$PATTERN'"
echo ""

# Find matching pattern files
if [ -d "$PATTERNS_DIR" ]; then
  matches=$(find "$PATTERNS_DIR" -name "*${PATTERN}*" -o -name "*PATTERNS.md" | head -5)

  if [ -z "$matches" ]; then
    echo "❌ No pattern files found"
    echo ""
    echo "Available patterns:"
    ls "$PATTERNS_DIR" | sed 's/^/  - /'
    exit 1
  fi

  for file in $matches; do
    PROJECT=$(basename "$file" | sed 's/_PATTERNS.md//' | tr '[:upper:]' '[:lower:]')
    echo "✓ Found: $PROJECT pattern"
    echo "  File: $file"
    echo ""

    # Show first pattern (Pattern 1)
    head -30 "$file" | tail -20
    echo ""
    echo "---"
    echo ""
  done
else
  echo "❌ Pattern library not found at $PATTERNS_DIR"
  exit 1
fi

echo "💡 View full file: cat $PATTERNS_DIR/$(ls $PATTERNS_DIR | grep -i $PATTERN | head -1)"
