#!/bin/bash
# Pre-flight check before demo
# Run this before presenting to ensure everything works

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}🚀 Pre-Flight Check for Demo${NC}"
echo "=================================="
echo ""

ERRORS=0

# Check 1: In correct directory
if [ ! -f "README.md" ] || [ ! -d "projects" ]; then
    echo -e "${RED}✗${NC} Not in cory-learnings directory"
    echo "  Run: cd ~/cory-learnings"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✓${NC} In correct directory"
fi

# Check 2: Scripts are executable
for script in demo.sh tests/run-all-tests.sh scripts/*.sh; do
    if [ -f "$script" ] && [ ! -x "$script" ]; then
        echo -e "${RED}✗${NC} $script not executable"
        chmod +x "$script"
        echo "  Fixed: Made executable"
    fi
done
echo -e "${GREEN}✓${NC} All scripts executable"

# Check 3: Required files exist
REQUIRED_FILES=(
    "AI_QUICKSTART.md"
    "MASTER_LEARNINGS.md"
    "TERM_DICTIONARY.md"
    "projects/calm-couples.md"
    "tests/run-all-tests.sh"
    "scripts/search-learnings.sh"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo -e "${RED}✗${NC} Missing: $file"
        ERRORS=$((ERRORS + 1))
    fi
done
echo -e "${GREEN}✓${NC} All required files present"

# Check 4: Git repo is clean enough to demo
if ! git status &>/dev/null; then
    echo -e "${YELLOW}⚠${NC} Not a git repo (optional for demo)"
else
    echo -e "${GREEN}✓${NC} Git repository detected"
fi

# Check 5: Test quick commands
echo ""
echo "Testing demo commands..."

# Test search
if ./scripts/search-learnings.sh "testing" &>/dev/null; then
    echo -e "${GREEN}✓${NC} Search script works"
else
    echo -e "${RED}✗${NC} Search script failed"
    ERRORS=$((ERRORS + 1))
fi

# Test project listing
if ls projects/*.md | grep -v README &>/dev/null; then
    echo -e "${GREEN}✓${NC} Project files accessible"
else
    echo -e "${RED}✗${NC} Cannot list project files"
    ERRORS=$((ERRORS + 1))
fi

# Test git log (optional)
if git log --oneline -1 &>/dev/null; then
    echo -e "${GREEN}✓${NC} Git history available"
else
    echo -e "${YELLOW}⚠${NC} Git history not available (optional)"
fi

# Summary
echo ""
echo "=================================="
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ PRE-FLIGHT CHECK PASSED${NC}"
    echo ""
    echo "You're ready to present!"
    echo ""
    echo "Quick commands to remember:"
    echo "  ./demo.sh              - Run automated demo"
    echo "  cat DEMO.md            - View script"
    echo "  cat DEMO_QUICK.md      - View 5-min version"
    echo ""
    exit 0
else
    echo -e "${RED}✗ FOUND $ERRORS ISSUE(S)${NC}"
    echo ""
    echo "Fix the issues above before presenting."
    exit 1
fi
