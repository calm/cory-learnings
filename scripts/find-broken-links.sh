#!/bin/bash
# Find broken markdown references in learnings files

LEARNINGS_DIR="$HOME/cory-learnings"
ERRORS=0

echo "==================================="
echo "Checking Markdown References"
echo "==================================="
echo ""

cd "$LEARNINGS_DIR"

# Find all markdown files
MD_FILES=$(find . -name "*.md" -not -path "./.git/*" -type f)

echo "Scanning markdown files for broken links..."
echo ""

# Check for broken relative links [text](path)
for FILE in $MD_FILES; do
    # Extract markdown links
    LINKS=$(grep -oE '\[([^\]]+)\]\(([^)]+)\)' "$FILE" | grep -oE '\(([^)]+)\)' | tr -d '()')

    if [ -n "$LINKS" ]; then
        while IFS= read -r LINK; do
            # Skip URLs (http, https, #anchors)
            if [[ "$LINK" =~ ^https?:// ]] || [[ "$LINK" =~ ^# ]]; then
                continue
            fi

            # Handle relative paths
            DIR=$(dirname "$FILE")
            TARGET="$DIR/$LINK"

            # Resolve path
            if [[ "$LINK" = /* ]]; then
                # Absolute path
                TARGET="$LINK"
            fi

            # Check if target exists
            if [ ! -e "$TARGET" ]; then
                echo "  ❌ BROKEN in $FILE:"
                echo "     Link: $LINK"
                echo "     Target: $TARGET"
                ERRORS=$((ERRORS + 1))
            fi
        done <<< "$LINKS"
    fi
done

echo ""
echo "Checking for TODO markers in files..."
cd "$LEARNINGS_DIR"
TODO_COUNT=$(grep -r "TODO\|FIXME\|XXX" --include="*.md" . 2>/dev/null | wc -l | tr -d ' ')
if [ "$TODO_COUNT" -gt 0 ]; then
    echo "  ⚠️  Found $TODO_COUNT TODO/FIXME markers"
    grep -n "TODO\|FIXME\|XXX" --include="*.md" -r . 2>/dev/null | head -5
    if [ "$TODO_COUNT" -gt 5 ]; then
        echo "  ... and $((TODO_COUNT - 5)) more"
    fi
else
    echo "  ✅ No TODO markers found"
fi

echo ""
echo "==================================="
if [ $ERRORS -eq 0 ]; then
    echo "✅ All markdown references are valid!"
    exit 0
else
    echo "❌ Found $ERRORS broken reference(s)"
    exit 1
fi
