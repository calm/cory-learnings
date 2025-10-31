#!/usr/bin/env bash
# YAML frontmatter validation tests

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TESTS_PASSED=0
TESTS_FAILED=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Check if file has valid YAML frontmatter
check_frontmatter() {
    local file="$1"
    local filename=$(basename "$file")

    # Check if file starts with ---
    if ! head -n 1 "$file" | grep -q "^---$"; then
        echo -e "${RED}✗${NC} $filename - Missing frontmatter opening (---)"
        ((TESTS_FAILED++))
        return 1
    fi

    # Check if frontmatter closes with ---
    if ! sed -n '2,20p' "$file" | grep -q "^---$"; then
        echo -e "${RED}✗${NC} $filename - Missing frontmatter closing (---)"
        ((TESTS_FAILED++))
        return 1
    fi

    # Check for required fields
    local has_title=$(sed -n '1,20p' "$file" | grep -c "^title:" || true)
    local has_description=$(sed -n '1,20p' "$file" | grep -c "^description:" || true)

    if [[ $has_title -eq 0 ]]; then
        echo -e "${RED}✗${NC} $filename - Missing 'title' field"
        ((TESTS_FAILED++))
        return 1
    fi

    if [[ $has_description -eq 0 ]]; then
        echo -e "${RED}✗${NC} $filename - Missing 'description' field"
        ((TESTS_FAILED++))
        return 1
    fi

    echo -e "${GREEN}✓${NC} $filename - Valid frontmatter"
    ((TESTS_PASSED++))
    return 0
}

echo "=========================================="
echo "YAML Frontmatter Validation Tests"
echo "=========================================="
echo ""

# Test all markdown files in root
for file in "$REPO_ROOT"/*.md; do
    if [[ -f "$file" ]]; then
        check_frontmatter "$file"
    fi
done

# Test project files
for file in "$REPO_ROOT"/projects/*.md; do
    if [[ -f "$file" ]]; then
        check_frontmatter "$file"
    fi
done

echo ""
echo "=========================================="
echo "Test Results"
echo "=========================================="
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Failed: $TESTS_FAILED${NC}"
echo ""

if [[ $TESTS_FAILED -eq 0 ]]; then
    echo -e "${GREEN}✓ All frontmatter tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed${NC}"
    exit 1
fi
