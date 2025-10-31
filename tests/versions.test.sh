#!/usr/bin/env bash
# Version consistency validation tests

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TESTS_PASSED=0
TESTS_FAILED=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=========================================="
echo "Version Consistency Tests"
echo "=========================================="
echo ""

# Extract version from README
README_VERSION=$(grep "^version:" "$REPO_ROOT/README.md" | head -1 | cut -d'"' -f2)
echo "README.md version: $README_VERSION"

# Extract version from CHANGELOG
CHANGELOG_VERSION=$(grep "^version:" "$REPO_ROOT/CHANGELOG.md" | head -1 | cut -d'"' -f2)
echo "CHANGELOG.md version: $CHANGELOG_VERSION"

# Extract version from MASTER_LEARNINGS
MASTER_VERSION=$(grep "^version:" "$REPO_ROOT/MASTER_LEARNINGS.md" | head -1 | cut -d'"' -f2)
echo "MASTER_LEARNINGS.md version: $MASTER_VERSION"

# Extract version from AI_QUICKSTART
QUICKSTART_VERSION=$(grep "^version:" "$REPO_ROOT/AI_QUICKSTART.md" | head -1 | cut -d'"' -f2)
echo "AI_QUICKSTART.md version: $QUICKSTART_VERSION"

echo ""

# Check if all versions match
if [[ "$README_VERSION" == "$CHANGELOG_VERSION" ]] && \
   [[ "$README_VERSION" == "$MASTER_VERSION" ]] && \
   [[ "$README_VERSION" == "$QUICKSTART_VERSION" ]]; then
    echo -e "${GREEN}✓${NC} All versions are consistent: $README_VERSION"
    ((TESTS_PASSED++))
else
    echo -e "${RED}✗${NC} Version mismatch detected!"
    echo "  README: $README_VERSION"
    echo "  CHANGELOG: $CHANGELOG_VERSION"
    echo "  MASTER_LEARNINGS: $MASTER_VERSION"
    echo "  AI_QUICKSTART: $QUICKSTART_VERSION"
    ((TESTS_FAILED++))
fi

echo ""

# Check last_updated dates
README_DATE=$(grep "^last_updated:" "$REPO_ROOT/README.md" | head -1 | cut -d'"' -f2)
CHANGELOG_DATE=$(grep "^last_updated:" "$REPO_ROOT/CHANGELOG.md" | head -1 | cut -d'"' -f2)

echo "Last updated dates:"
echo "  README: $README_DATE"
echo "  CHANGELOG: $CHANGELOG_DATE"

if [[ "$README_DATE" == "$CHANGELOG_DATE" ]]; then
    echo -e "${GREEN}✓${NC} Last updated dates are consistent"
    ((TESTS_PASSED++))
else
    echo -e "${YELLOW}⚠${NC} Last updated dates differ (may be intentional)"
    # Not counting as failure since files can be updated independently
    ((TESTS_PASSED++))
fi

echo ""
echo "=========================================="
echo "Test Results"
echo "=========================================="
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Failed: $TESTS_FAILED${NC}"
echo ""

if [[ $TESTS_FAILED -eq 0 ]]; then
    echo -e "${GREEN}✓ All version tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed${NC}"
    exit 1
fi
