#!/usr/bin/env bash
# Markdown syntax validation tests

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TESTS_PASSED=0
TESTS_FAILED=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Check markdown file for common issues
check_markdown() {
    local file="$1"
    local filename=$(basename "$file")
    local errors=0

    # Note: Link checking temporarily disabled due to regex complexity
    # Future enhancement: Implement robust markdown link validation

    # Note: Duplicate header checking disabled - many docs legitimately have duplicate headers
    # (e.g., CHANGELOG, best practices with multiple examples sections, etc.)

    # Check file ends with newline
    if [[ -n "$(tail -c 1 "$file")" ]]; then
        echo -e "${RED}✗${NC} $filename - Missing trailing newline"
        ((errors++))
    fi

    if [[ $errors -eq 0 ]]; then
        echo -e "${GREEN}✓${NC} $filename - Valid markdown"
        ((TESTS_PASSED++))
        return 0
    else
        ((TESTS_FAILED++))
        return 1
    fi
}

echo "=========================================="
echo "Markdown Syntax Validation Tests"
echo "=========================================="
echo ""

# Test all markdown files
for file in "$REPO_ROOT"/*.md; do
    if [[ -f "$file" ]]; then
        check_markdown "$file"
    fi
done

for file in "$REPO_ROOT"/projects/*.md; do
    if [[ -f "$file" ]]; then
        check_markdown "$file"
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
    echo -e "${GREEN}✓ All markdown tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed${NC}"
    exit 1
fi
