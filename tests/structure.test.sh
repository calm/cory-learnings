#!/usr/bin/env bash
# Structure validation tests for cory-learnings repository

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TESTS_PASSED=0
TESTS_FAILED=0

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test result function
assert_file_exists() {
    local file="$1"
    local description="$2"

    if [[ -f "$REPO_ROOT/$file" ]]; then
        echo -e "${GREEN}✓${NC} $description"
        ((TESTS_PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $description - File not found: $file"
        ((TESTS_FAILED++))
        return 1
    fi
}

assert_dir_exists() {
    local dir="$1"
    local description="$2"

    if [[ -d "$REPO_ROOT/$dir" ]]; then
        echo -e "${GREEN}✓${NC} $description"
        ((TESTS_PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $description - Directory not found: $dir"
        ((TESTS_FAILED++))
        return 1
    fi
}

echo "=========================================="
echo "Structure Validation Tests"
echo "=========================================="
echo ""

echo "Core Files:"
assert_file_exists "README.md" "README.md exists"
assert_file_exists "CHANGELOG.md" "CHANGELOG.md exists"
assert_file_exists "MASTER_LEARNINGS.md" "MASTER_LEARNINGS.md exists"
assert_file_exists "AI_QUICKSTART.md" "AI_QUICKSTART.md exists"
assert_file_exists "ACTIVE_TODOS.md" "ACTIVE_TODOS.md exists"
assert_file_exists "TERM_DICTIONARY.md" "TERM_DICTIONARY.md exists"

echo ""
echo "Documentation Files:"
assert_file_exists "README_BEST_PRACTICES.md" "README best practices exists"
assert_file_exists "TEMPLATE_README.md" "README template exists"

echo ""
echo "Directories:"
assert_dir_exists "projects" "projects/ directory exists"
assert_dir_exists "scripts" "scripts/ directory exists"
assert_dir_exists "tests" "tests/ directory exists"

echo ""
echo "Project Files:"
assert_file_exists "projects/README.md" "projects/README.md exists"
assert_file_exists "projects/calm-couples.md" "calm-couples.md exists"
assert_file_exists "projects/ios-automation.md" "ios-automation.md exists"
assert_file_exists "projects/calm-ai-project-manager.md" "calm-ai-project-manager.md exists"

echo ""
echo "Scripts:"
assert_file_exists "scripts/check-symlinks.sh" "check-symlinks.sh exists"
assert_file_exists "scripts/validate-structure.sh" "validate-structure.sh exists"
assert_file_exists "scripts/find-broken-links.sh" "find-broken-links.sh exists"
assert_file_exists "scripts/search-learnings.sh" "search-learnings.sh exists"
assert_file_exists "scripts/quick-find.sh" "quick-find.sh exists"

echo ""
echo "=========================================="
echo "Test Results"
echo "=========================================="
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Failed: $TESTS_FAILED${NC}"
echo ""

if [[ $TESTS_FAILED -eq 0 ]]; then
    echo -e "${GREEN}✓ All structure tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed${NC}"
    exit 1
fi
