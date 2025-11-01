#!/usr/bin/env bash
# Fast test runner - parallel execution for quick feedback

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

echo ""
echo "=========================================="
echo "⚡ Fast Test Suite (Parallel)"
echo "=========================================="
echo -e "${GRAY}Started at $(date '+%H:%M:%S')${NC}"
echo ""

# Make test scripts executable
chmod +x "$TEST_DIR"/*.test.sh

# Create temp directory for tracking
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Run tests in parallel (2 at a time for safety)
PARALLEL_JOBS=2
ACTIVE_JOBS=0

for test_file in "$TEST_DIR"/*.test.sh; do
    if [[ "$test_file" != */run-* ]]; then
        # Wait if we've hit max parallel jobs
        while [[ $(jobs -r | wc -l) -ge $PARALLEL_JOBS ]]; do
            sleep 0.1
        done

        test_name=$(basename "$test_file")
        result_file="$TEMP_DIR/$test_name.result"

        # Run test in background
        (
            if "$test_file" > /dev/null 2>&1; then
                echo "pass" > "$result_file"
            else
                echo "fail" > "$result_file"
            fi
        ) &
    fi
done

# Wait for all background jobs
wait

# Collect results
PASSED=0
FAILED=0

for result_file in "$TEMP_DIR"/*.result; do
    test_name=$(basename "$result_file" .result)
    result=$(cat "$result_file")

    if [[ "$result" == "pass" ]]; then
        echo -e "${GREEN}✓ $test_name${NC}"
        ((PASSED++))
    else
        echo -e "${RED}✗ $test_name${NC}"
        ((FAILED++))
    fi
done

echo ""
echo "=========================================="
echo "📊 Summary"
echo "=========================================="
echo -e "Passed: ${GREEN}$PASSED${NC}"
echo -e "Failed: ${RED}$FAILED${NC}"

if [[ $FAILED -eq 0 ]]; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed${NC}"
    exit 1
fi
