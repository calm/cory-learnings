#!/usr/bin/env bash
# Run all cory-learnings tests

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEST_DIR="$REPO_ROOT/tests"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

TOTAL_PASSED=0
TOTAL_FAILED=0

echo ""
echo "=========================================="
echo "🧪 cory-learnings Test Suite"
echo "=========================================="
echo ""

# Make all test scripts executable
chmod +x "$TEST_DIR"/*.test.sh

# Run each test suite
for test_file in "$TEST_DIR"/*.test.sh; do
    if [[ "$test_file" != */run-all-tests.sh ]]; then
        echo -e "${BLUE}Running $(basename "$test_file")...${NC}"
        echo ""

        if "$test_file"; then
            ((TOTAL_PASSED++))
        else
            ((TOTAL_FAILED++))
        fi

        echo ""
    fi
done

# Final summary
echo "=========================================="
echo "📊 Final Test Summary"
echo "=========================================="
echo -e "Test Suites Passed: ${GREEN}$TOTAL_PASSED${NC}"
echo -e "Test Suites Failed: ${RED}$TOTAL_FAILED${NC}"
echo ""

if [[ $TOTAL_FAILED -eq 0 ]]; then
    echo -e "${GREEN}✓ All test suites passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some test suites failed${NC}"
    exit 1
fi
