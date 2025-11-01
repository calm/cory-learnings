#!/usr/bin/env bash
# Find bug solutions quickly from error catalogs

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <error-message>"
  echo "Example: $0 'RLS policy violation'"
  exit 1
fi

SEARCH="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ERROR_CATALOGS=(
  "$SCRIPT_DIR/docs/ERROR_CATALOG_CALM_COUPLES.md"
  "$SCRIPT_DIR/docs/ERROR_CATALOG_IOS_AUTOMATION.md"
  "$SCRIPT_DIR/docs/ERROR_CATALOG_CALM_AI_PM.md"
)

echo "🔍 Searching for: '$SEARCH'"
echo ""

FOUND=0

for catalog in "${ERROR_CATALOGS[@]}"; do
  if [ ! -f "$catalog" ]; then
    continue
  fi

  # Find matching errors
  matches=$(grep -n "## Error\|**$SEARCH**\|$SEARCH" "$catalog" 2>/dev/null || true)

  if [ -n "$matches" ]; then
    FOUND=1
    PROJECT=$(basename "$catalog" | sed 's/ERROR_CATALOG_//;s/\.md//')

    echo "📁 $PROJECT"
    echo "$matches" | grep -B1 -A10 "$SEARCH" | head -20
    echo ""
  fi
done

if [ $FOUND -eq 0 ]; then
  echo "❌ No matches found"
  echo ""
  echo "💡 Tip: Try searching with different keywords"
  echo "   Example: find-bug.sh 'timeout'"
  echo "   Example: find-bug.sh 'not found'"
  exit 1
fi

echo "✓ Done"
