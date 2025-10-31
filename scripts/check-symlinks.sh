#!/bin/bash
# Check all project symlinks are working correctly

LEARNINGS_DIR="$HOME/cory-learnings"
ERRORS=0

echo "==================================="
echo "Checking Project Symlinks"
echo "==================================="
echo ""

# Define expected symlinks
declare -A EXPECTED_LINKS=(
    ["$HOME/Desktop/calm/calm-couples/CORY_LEARNINGS.md"]="$LEARNINGS_DIR/projects/calm-couples.md"
    ["$HOME/Desktop/calm/ios-automation/CORY_LEARNINGS.md"]="$LEARNINGS_DIR/projects/ios-automation.md"
    ["$HOME/Desktop/calm/calm-ai-project-manager/Cory learnings.md"]="$LEARNINGS_DIR/projects/calm-ai-project-manager.md"
)

# Check each symlink
for LINK_PATH in "${!EXPECTED_LINKS[@]}"; do
    TARGET="${EXPECTED_LINKS[$LINK_PATH]}"

    echo "Checking: $LINK_PATH"

    # Check if link exists
    if [ ! -e "$LINK_PATH" ]; then
        echo "  ❌ MISSING - Link does not exist"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    # Check if it's a symlink
    if [ ! -L "$LINK_PATH" ]; then
        echo "  ⚠️  WARNING - Not a symlink (regular file)"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    # Check target
    ACTUAL_TARGET=$(readlink "$LINK_PATH")
    if [ "$ACTUAL_TARGET" != "$TARGET" ]; then
        echo "  ❌ WRONG TARGET"
        echo "     Expected: $TARGET"
        echo "     Actual:   $ACTUAL_TARGET"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    # Check if target exists
    if [ ! -f "$TARGET" ]; then
        echo "  ❌ BROKEN - Target file does not exist: $TARGET"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    echo "  ✅ OK"
done

echo ""
echo "==================================="
if [ $ERRORS -eq 0 ]; then
    echo "✅ All symlinks are valid!"
    exit 0
else
    echo "❌ Found $ERRORS issue(s)"
    exit 1
fi
