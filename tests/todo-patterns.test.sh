#!/bin/bash

# Todo List Pattern Validation Test
# Validates that ACTIVE_TODOS.md follows documented patterns
# Can also validate todo list structure in conversation logs

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ACTIVE_TODOS="$REPO_ROOT/ACTIVE_TODOS.md"

# Test counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Helper functions
pass_test() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASSED_TESTS++))
    ((TOTAL_TESTS++))
}

fail_test() {
    echo -e "${RED}✗${NC} $1"
    ((FAILED_TESTS++))
    ((TOTAL_TESTS++))
}

warn_test() {
    echo -e "${YELLOW}⚠${NC} $1"
}

info_message() {
    echo -e "${BLUE}ℹ${NC} $1"
}

echo "========================================"
echo "Todo List Pattern Validation"
echo "========================================"
echo ""

# ====================
# Test 1: ACTIVE_TODOS.md Structure
# ====================
echo "Test Group 1: ACTIVE_TODOS.md Structure"
echo "----------------------------------------"

# Test 1.1: File exists
test_file_exists() {
    local test_name="ACTIVE_TODOS.md file exists"

    if [ ! -f "$ACTIVE_TODOS" ]; then
        fail_test "$test_name"
        return 1
    fi

    pass_test "$test_name"
}

# Test 1.2: Has proper frontmatter
test_frontmatter() {
    local test_name="ACTIVE_TODOS.md has proper YAML frontmatter"

    if ! grep -q "^---$" "$ACTIVE_TODOS"; then
        fail_test "$test_name (missing frontmatter)"
        return 1
    fi

    # Check for required fields
    local has_title=$(grep -c "^title:" "$ACTIVE_TODOS" || echo "0")
    local has_description=$(grep -c "^description:" "$ACTIVE_TODOS" || echo "0")
    local has_updated=$(grep -c "^last_updated:" "$ACTIVE_TODOS" || echo "0")

    if [ "$has_title" -eq 0 ] || [ "$has_description" -eq 0 ] || [ "$has_updated" -eq 0 ]; then
        fail_test "$test_name (missing required fields)"
        return 1
    fi

    pass_test "$test_name"
}

# Test 1.3: Has required sections
test_required_sections() {
    local test_name="ACTIVE_TODOS.md has required sections"

    local missing_sections=()

    if ! grep -q "# Active Todos" "$ACTIVE_TODOS"; then
        missing_sections+=("# Active Todos")
    fi

    if ! grep -q "## Current Todos" "$ACTIVE_TODOS"; then
        missing_sections+=("## Current Todos")
    fi

    if ! grep -q "## Template" "$ACTIVE_TODOS"; then
        missing_sections+=("## Template")
    fi

    if [ ${#missing_sections[@]} -gt 0 ]; then
        fail_test "$test_name (missing: ${missing_sections[*]})"
        return 1
    fi

    pass_test "$test_name"
}

# Test 1.4: Template includes proper format
test_template_format() {
    local test_name="Template section includes proper todo format"

    # Check if template section exists and has proper examples
    if ! grep -A 20 "## Template" "$ACTIVE_TODOS" | grep -q "\- \[ \]"; then
        fail_test "$test_name (missing markdown checkbox format)"
        return 1
    fi

    if ! grep -A 30 "## Template" "$ACTIVE_TODOS" | grep -q "status.*pending\|in_progress\|completed"; then
        warn_test "$test_name (should include status examples: pending, in_progress, completed)"
    else
        pass_test "$test_name"
    fi
}

# Run ACTIVE_TODOS.md structure tests
test_file_exists || true
test_frontmatter || true
test_required_sections || true
test_template_format || true

echo ""

# ====================
# Test 2: Todo List Content Validation
# ====================
echo "Test Group 2: Todo Content Validation"
echo "--------------------------------------"

# Test 2.1: Check for proper todo formatting
test_todo_formatting() {
    local test_name="Todos use proper markdown checkbox format"

    # Look for todos in Current Todos section
    local todos_section=$(sed -n '/## Current Todos/,/## /p' "$ACTIVE_TODOS")

    if [ -n "$todos_section" ]; then
        # Check for proper checkbox format
        local has_checkboxes=$(echo "$todos_section" | grep -c "- \[[ x]\]" || echo "0")

        if [ "$has_checkboxes" -gt 0 ]; then
            pass_test "$test_name (found $has_checkboxes todos)"
        else
            # No todos is also valid (clean state)
            if echo "$todos_section" | grep -q "No Pending Todos\|Session Complete"; then
                pass_test "$test_name (clean state - no pending todos)"
            else
                warn_test "$test_name (no todos found in Current Todos section)"
            fi
        fi
    else
        fail_test "$test_name (Current Todos section not found)"
    fi
}

# Test 2.2: Todos have descriptive content
test_descriptive_todos() {
    local test_name="Todos are descriptive (not vague)"

    # Extract todo items
    local vague_patterns=("do stuff" "fix things" "work on" "handle" "deal with" "check" "look at")
    local todos=$(grep "^- \[[ x]\]" "$ACTIVE_TODOS" || true)

    if [ -z "$todos" ]; then
        pass_test "$test_name (no todos to check)"
        return 0
    fi

    local vague_todos=()
    for pattern in "${vague_patterns[@]}"; do
        while IFS= read -r todo; do
            if echo "$todo" | grep -iq "$pattern"; then
                vague_todos+=("$todo")
            fi
        done <<< "$todos"
    done

    if [ ${#vague_todos[@]} -gt 0 ]; then
        fail_test "$test_name (found ${#vague_todos[@]} vague todo(s))"
        for vague_todo in "${vague_todos[@]}"; do
            echo "    ❌ $vague_todo"
        done
        return 1
    fi

    pass_test "$test_name"
}

# Test 2.3: Multi-window coordination format
test_multi_window_format() {
    local test_name="Multi-window todos include proper coordination markers"

    # Check if there are window markers
    if grep -q "### Window [0-9]" "$ACTIVE_TODOS"; then
        # Validate window markers have required info
        local windows=$(grep "### Window [0-9]" "$ACTIVE_TODOS")
        local has_branch_info=true

        while IFS= read -r window_line; do
            local window_section=$(sed -n "/$window_line/,/###/p" "$ACTIVE_TODOS" | head -20)

            if ! echo "$window_section" | grep -q "Branch:"; then
                has_branch_info=false
                break
            fi
        done <<< "$windows"

        if [ "$has_branch_info" = true ]; then
            pass_test "$test_name"
        else
            warn_test "$test_name (some windows missing branch info)"
        fi
    else
        pass_test "$test_name (single-window mode, no coordination needed)"
    fi
}

# Run todo content validation tests
test_todo_formatting || true
test_descriptive_todos || true
test_multi_window_format || true

echo ""

# ====================
# Test 3: Todo List Best Practices
# ====================
echo "Test Group 3: Todo List Best Practices"
echo "---------------------------------------"

# Test 3.1: Todos should include context
test_todo_context() {
    local test_name="Todo sections include context/description"

    # Check if Current Todos has a context paragraph
    local todos_section=$(sed -n '/## Current Todos/,/## /p' "$ACTIVE_TODOS")

    if echo "$todos_section" | grep -q "\*\*Context\*\*:\|\*\*Status as of"; then
        pass_test "$test_name"
    else
        warn_test "$test_name (consider adding context for pending todos)"
    fi
}

# Test 3.2: File has recent last_updated date
test_recent_update() {
    local test_name="ACTIVE_TODOS.md has recent last_updated date"

    local last_updated=$(grep "^last_updated:" "$ACTIVE_TODOS" | cut -d'"' -f2)

    if [ -n "$last_updated" ]; then
        # Convert to timestamp and check if within last 30 days
        local updated_timestamp=$(date -j -f "%Y-%m-%d" "$last_updated" "+%s" 2>/dev/null || echo "0")
        local current_timestamp=$(date "+%s")
        local days_old=$(( (current_timestamp - updated_timestamp) / 86400 ))

        if [ "$days_old" -le 30 ]; then
            pass_test "$test_name (updated $days_old days ago)"
        else
            warn_test "$test_name (last updated $days_old days ago - consider reviewing)"
        fi
    else
        fail_test "$test_name (no last_updated date found)"
    fi
}

# Test 3.3: Check for stale todos
test_stale_todos() {
    local test_name="No stale in_progress todos without context"

    local todos_section=$(sed -n '/## Current Todos/,/## /p' "$ACTIVE_TODOS")

    # Check for in_progress markers
    if echo "$todos_section" | grep -qi "\[IN PROGRESS\]"; then
        # Should have a recent date or context
        if echo "$todos_section" | grep -q "Status as of.*2025"; then
            pass_test "$test_name"
        else
            warn_test "$test_name (in_progress todos found without recent date)"
        fi
    else
        pass_test "$test_name (no in_progress todos)"
    fi
}

# Run best practices tests
test_todo_context || true
test_recent_update || true
test_stale_todos || true

echo ""

# ====================
# Test 4: Documentation Consistency
# ====================
echo "Test Group 4: Documentation Consistency"
echo "----------------------------------------"

# Test 4.1: Template matches AI_QUICKSTART.md guidelines
test_template_consistency() {
    local test_name="Template format matches AI_QUICKSTART.md guidelines"

    local quickstart="$REPO_ROOT/AI_QUICKSTART.md"

    if [ ! -f "$quickstart" ]; then
        warn_test "$test_name (AI_QUICKSTART.md not found)"
        return 0
    fi

    # Check if template mentions key concepts from AI_QUICKSTART
    local template_section=$(sed -n '/## Template/,/## /p' "$ACTIVE_TODOS")

    local mentions_window=false
    local mentions_status=false

    if echo "$template_section" | grep -q "Window"; then
        mentions_window=true
    fi

    if echo "$template_section" | grep -q "pending\|in_progress\|completed"; then
        mentions_status=true
    fi

    if [ "$mentions_window" = true ] && [ "$mentions_status" = true ]; then
        pass_test "$test_name"
    else
        warn_test "$test_name (template could include more guidance from AI_QUICKSTART.md)"
    fi
}

# Test 4.2: Usage notes reference TodoWrite tool
test_usage_notes() {
    local test_name="Usage notes reference TodoWrite tool appropriately"

    if grep -q "TodoWrite\|todo list" "$ACTIVE_TODOS"; then
        pass_test "$test_name"
    else
        warn_test "$test_name (consider mentioning TodoWrite tool in usage notes)"
    fi
}

# Run documentation consistency tests
test_template_consistency || true
test_usage_notes || true

echo ""

# ====================
# Summary
# ====================
echo "========================================"
echo "Summary"
echo "========================================"
echo ""
echo "Total Tests:  $TOTAL_TESTS"
echo -e "${GREEN}Passed:       $PASSED_TESTS${NC}"
echo -e "${RED}Failed:       $FAILED_TESTS${NC}"
echo ""

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}✓ All todo pattern tests passed!${NC}"
    echo ""
    echo "Your ACTIVE_TODOS.md follows best practices:"
    echo "  • Proper structure and formatting"
    echo "  • Descriptive, actionable todos"
    echo "  • Includes context and coordination info"
    echo "  • Consistent with AI_QUICKSTART.md guidelines"
    echo ""
    exit 0
else
    echo -e "${RED}✗ Some tests failed. Review output above.${NC}"
    echo ""
    echo "Common issues:"
    echo "  • Missing required sections or frontmatter"
    echo "  • Vague todo descriptions (use specific actions)"
    echo "  • Missing context for pending work"
    echo "  • Outdated last_updated date"
    echo ""
    exit 1
fi
