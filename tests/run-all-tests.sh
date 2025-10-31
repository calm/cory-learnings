#!/usr/bin/env bash
# Run all cory-learnings tests

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEST_DIR="$REPO_ROOT/tests"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GRAY='\033[0;90m'
NC='\033[0m'

TOTAL_PASSED=0
TOTAL_FAILED=0
OVERALL_START=$(date +%s)

# Helper function to format duration
format_duration() {
    local duration=$1
    if [ "$duration" -lt 1 ]; then
        echo "<1s"
    elif [ "$duration" -lt 60 ]; then
        echo "${duration}s"
    else
        local minutes=$((duration / 60))
        local seconds=$((duration % 60))
        echo "${minutes}m ${seconds}s"
    fi
}

echo ""
echo "=========================================="
echo "🧪 cory-learnings Test Suite"
echo "=========================================="
echo -e "${GRAY}Started at $(date '+%H:%M:%S')${NC}"
echo ""

# Make all test scripts executable
chmod +x "$TEST_DIR"/*.test.sh

# Run each test suite
for test_file in "$TEST_DIR"/*.test.sh; do
    if [[ "$test_file" != */run-all-tests.sh ]]; then
        test_name=$(basename "$test_file")
        echo -e "${BLUE}▶ Running $test_name...${NC}"

        test_start=$(date +%s)

        if "$test_file"; then
            test_end=$(date +%s)
            duration=$((test_end - test_start))
            echo -e "${GREEN}✓ $test_name passed${NC} ${GRAY}($(format_duration $duration))${NC}"
            ((TOTAL_PASSED++))
        else
            test_end=$(date +%s)
            duration=$((test_end - test_start))
            echo -e "${RED}✗ $test_name failed${NC} ${GRAY}($(format_duration $duration))${NC}"
            ((TOTAL_FAILED++))
        fi

        echo ""
    fi
done

# Final summary
OVERALL_END=$(date +%s)
OVERALL_DURATION=$((OVERALL_END - OVERALL_START))

echo "=========================================="
echo "📊 Final Test Summary"
echo "=========================================="
echo -e "Test Suites Passed: ${GREEN}$TOTAL_PASSED${NC}"
echo -e "Test Suites Failed: ${RED}$TOTAL_FAILED${NC}"
echo -e "Total Time: ${GRAY}$(format_duration $OVERALL_DURATION)${NC}"
echo -e "${GRAY}Finished at $(date '+%H:%M:%S')${NC}"
echo ""

if [[ $TOTAL_FAILED -eq 0 ]]; then
    echo -e "${GREEN}✓ All test suites passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some test suites failed${NC}"
    exit 1
fi
