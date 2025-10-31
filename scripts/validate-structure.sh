#!/bin/bash
# Validate cory-learnings repository structure

LEARNINGS_DIR="$HOME/cory-learnings"
ERRORS=0

echo "==================================="
echo "Validating Repository Structure"
echo "==================================="
echo ""

# Required files
REQUIRED_FILES=(
    "README.md"
    "AI_QUICKSTART.md"
    "MASTER_LEARNINGS.md"
    "EXAMPLES.md"
    "CHANGELOG.md"
    "TEMPLATE_NEW_PROJECT.md"
    "add-project.sh"
    "projects/calm-couples.md"
    "projects/ios-automation.md"
    "projects/calm-ai-project-manager.md"
    "projects/README.md"
)

echo "Checking required files..."
for FILE in "${REQUIRED_FILES[@]}"; do
    FULL_PATH="$LEARNINGS_DIR/$FILE"
    if [ -f "$FULL_PATH" ]; then
        echo "  ✅ $FILE"
    else
        echo "  ❌ MISSING: $FILE"
        ERRORS=$((ERRORS + 1))
    fi
done

echo ""
echo "Checking directory structure..."

# Required directories
REQUIRED_DIRS=(
    "projects"
    "scripts"
    ".git"
)

for DIR in "${REQUIRED_DIRS[@]}"; do
    FULL_PATH="$LEARNINGS_DIR/$DIR"
    if [ -d "$FULL_PATH" ]; then
        echo "  ✅ $DIR/"
    else
        echo "  ❌ MISSING: $DIR/"
        ERRORS=$((ERRORS + 1))
    fi
done

echo ""
echo "Checking file sizes..."

# Check for empty files (potential issues)
cd "$LEARNINGS_DIR"
for FILE in "${REQUIRED_FILES[@]}"; do
    if [ -f "$FILE" ]; then
        SIZE=$(wc -l < "$FILE" 2>/dev/null || echo "0")
        if [ "$SIZE" -lt 10 ]; then
            echo "  ⚠️  WARNING: $FILE is very small ($SIZE lines)"
        fi
    fi
done

echo ""
echo "Checking git repository..."
if [ -d "$LEARNINGS_DIR/.git" ]; then
    cd "$LEARNINGS_DIR"
    COMMITS=$(git rev-list --count HEAD 2>/dev/null || echo "0")
    echo "  ✅ Git initialized ($COMMITS commits)"
else
    echo "  ❌ Git not initialized"
    ERRORS=$((ERRORS + 1))
fi

echo ""
echo "==================================="
if [ $ERRORS -eq 0 ]; then
    echo "✅ Repository structure is valid!"
    exit 0
else
    echo "❌ Found $ERRORS structural issue(s)"
    exit 1
fi
