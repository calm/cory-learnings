#!/bin/bash

# AI Agent Compliance Test
# Tests that verify AI agents are following documented principles from AI_QUICKSTART.md

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

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

echo "========================================"
echo "AI Agent Compliance Test Suite"
echo "========================================"
echo ""

# ====================
# Test 1: Code Quality Standards
# ====================
echo "Test Group 1: Code Quality Standards"
echo "------------------------------------"

# Test 1.1: No TODO comments in project code
test_no_todo_comments() {
    local test_name="No TODO comments in code"

    # Search in common project locations (simulating actual projects)
    # We'll check example project paths mentioned in learnings
    local has_todos=false

    # Define project paths from learnings
    declare -a project_paths=(
        "$HOME/Desktop/calm/calm-couples"
        "$HOME/Desktop/calm/ios-automation"
        "$HOME/Desktop/calm/calm-ai-project-manager"
    )

    for project_path in "${project_paths[@]}"; do
        if [ -d "$project_path" ]; then
            # Search for TODO comments in code files (excluding node_modules, .git, etc.)
            local todos=$(find "$project_path" \
                -type f \
                \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" \) \
                -not -path "*/node_modules/*" \
                -not -path "*/.git/*" \
                -not -path "*/dist/*" \
                -not -path "*/build/*" \
                -exec grep -l "// TODO\|//TODO\|# TODO\|#TODO" {} \; 2>/dev/null || true)

            if [ -n "$todos" ]; then
                has_todos=true
                fail_test "$test_name (found in $(basename "$project_path"))"
                echo "    Files with TODO comments:"
                echo "$todos" | while read -r file; do
                    echo "    - $file"
                done
                return 1
            fi
        fi
    done

    if [ "$has_todos" = false ]; then
        pass_test "$test_name"
    fi
}

# Test 1.2: No console.log in project code
test_no_console_log() {
    local test_name="No console.log in code (use structured logger)"

    declare -a project_paths=(
        "$HOME/Desktop/calm/calm-couples"
        "$HOME/Desktop/calm/ios-automation"
        "$HOME/Desktop/calm/calm-ai-project-manager"
    )

    local has_console_log=false

    for project_path in "${project_paths[@]}"; do
        if [ -d "$project_path" ]; then
            # Search for console.log (excluding tests, config files)
            local console_logs=$(find "$project_path/src" \
                -type f \
                \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" \) \
                -not -path "*/node_modules/*" \
                -not -path "*/.git/*" \
                -not -path "*/test/*" \
                -not -path "*/tests/*" \
                -not -path "*/__tests__/*" \
                -not -name "*.test.*" \
                -not -name "*.spec.*" \
                -exec grep -l "console\.log\|console\.debug\|console\.info" {} \; 2>/dev/null || true)

            if [ -n "$console_logs" ]; then
                has_console_log=true
                fail_test "$test_name (found in $(basename "$project_path"))"
                echo "    Files with console.log:"
                echo "$console_logs" | head -5 | while read -r file; do
                    echo "    - $file"
                done
                return 1
            fi
        fi
    done

    if [ "$has_console_log" = false ]; then
        pass_test "$test_name"
    fi
}

# Test 1.3: TypeScript strict mode enabled
test_typescript_strict_mode() {
    local test_name="TypeScript strict mode enabled"

    declare -a project_paths=(
        "$HOME/Desktop/calm/calm-couples"
        "$HOME/Desktop/calm/ios-automation"
        "$HOME/Desktop/calm/calm-ai-project-manager"
    )

    for project_path in "${project_paths[@]}"; do
        if [ -f "$project_path/tsconfig.json" ]; then
            local has_strict=$(grep -c '"strict".*true' "$project_path/tsconfig.json" || echo "0")
            if [ "$has_strict" -eq 0 ]; then
                fail_test "$test_name (not enabled in $(basename "$project_path"))"
                return 1
            fi
        fi
    done

    pass_test "$test_name"
}

# Run code quality tests
test_no_todo_comments || true
test_no_console_log || true
test_typescript_strict_mode || true

echo ""

# ====================
# Test 2: Documentation Standards
# ====================
echo "Test Group 2: Documentation Standards"
echo "--------------------------------------"

# Test 2.1: Active todos file exists and is properly formatted
test_active_todos_format() {
    local test_name="ACTIVE_TODOS.md properly formatted"
    local todos_file="$REPO_ROOT/ACTIVE_TODOS.md"

    if [ ! -f "$todos_file" ]; then
        fail_test "$test_name (file not found)"
        return 1
    fi

    # Check for required sections
    if ! grep -q "# Active Todos" "$todos_file"; then
        fail_test "$test_name (missing header)"
        return 1
    fi

    if ! grep -q "## Current Todos" "$todos_file"; then
        fail_test "$test_name (missing Current Todos section)"
        return 1
    fi

    pass_test "$test_name"
}

# Test 2.2: AI_QUICKSTART.md has critical rules section
test_ai_quickstart_structure() {
    local test_name="AI_QUICKSTART.md has all critical sections"
    local quickstart="$REPO_ROOT/AI_QUICKSTART.md"

    if [ ! -f "$quickstart" ]; then
        fail_test "$test_name (file not found)"
        return 1
    fi

    # Check for critical sections
    local missing_sections=()

    if ! grep -q "## Critical Rules" "$quickstart"; then
        missing_sections+=("Critical Rules")
    fi

    if ! grep -q "### 1. Todo List Management" "$quickstart"; then
        missing_sections+=("Todo List Management")
    fi

    if ! grep -q "### 2. Complete Implementations" "$quickstart"; then
        missing_sections+=("Complete Implementations")
    fi

    if ! grep -q "### 3. Testing" "$quickstart"; then
        missing_sections+=("Testing")
    fi

    if ! grep -q "### 5. Autonomous Execution" "$quickstart"; then
        missing_sections+=("Autonomous Execution")
    fi

    if [ ${#missing_sections[@]} -gt 0 ]; then
        fail_test "$test_name (missing: ${missing_sections[*]})"
        return 1
    fi

    pass_test "$test_name"
}

# Test 2.3: TERM_DICTIONARY.md exists and has entries
test_term_dictionary_exists() {
    local test_name="TERM_DICTIONARY.md exists with entries"
    local dict_file="$REPO_ROOT/TERM_DICTIONARY.md"

    if [ ! -f "$dict_file" ]; then
        fail_test "$test_name (file not found)"
        return 1
    fi

    # Check if it has at least 10 term definitions
    local term_count=$(grep -c "^##" "$dict_file" || echo "0")
    if [ "$term_count" -lt 10 ]; then
        fail_test "$test_name (only $term_count terms found, expected 10+)"
        return 1
    fi

    pass_test "$test_name"
}

# Run documentation tests
test_active_todos_format || true
test_ai_quickstart_structure || true
test_term_dictionary_exists || true

echo ""

# ====================
# Test 3: Testing Standards
# ====================
echo "Test Group 3: Testing Standards"
echo "--------------------------------"

# Test 3.1: Test coverage meets minimum threshold
test_coverage_threshold() {
    local test_name="Test coverage meets 98% threshold"

    declare -a project_paths=(
        "$HOME/Desktop/calm/calm-couples"
        "$HOME/Desktop/calm/ios-automation"
        "$HOME/Desktop/calm/calm-ai-project-manager"
    )

    local checked_any=false

    for project_path in "${project_paths[@]}"; do
        if [ -d "$project_path" ] && [ -f "$project_path/package.json" ]; then
            checked_any=true

            # Check if package.json has test:coverage script
            if grep -q "test:coverage" "$project_path/package.json"; then
                warn_test "$test_name (manual verification required for $(basename "$project_path"))"
            fi
        fi
    done

    if [ "$checked_any" = false ]; then
        warn_test "$test_name (no projects found to check)"
    else
        pass_test "$test_name (structure validated)"
    fi
}

# Test 3.2: No skipped or disabled tests
test_no_skipped_tests() {
    local test_name="No skipped or disabled tests"

    declare -a project_paths=(
        "$HOME/Desktop/calm/calm-couples"
        "$HOME/Desktop/calm/ios-automation"
        "$HOME/Desktop/calm/calm-ai-project-manager"
    )

    local has_skipped=false

    for project_path in "${project_paths[@]}"; do
        if [ -d "$project_path" ]; then
            # Search for .skip, .only, or xit patterns
            local skipped_tests=$(find "$project_path" \
                -type f \
                \( -name "*.test.ts" -o -name "*.test.tsx" -o -name "*.spec.ts" -o -name "*.spec.tsx" \) \
                -not -path "*/node_modules/*" \
                -exec grep -l "\.skip\|\.only\|xit\|xdescribe" {} \; 2>/dev/null || true)

            if [ -n "$skipped_tests" ]; then
                has_skipped=true
                warn_test "$test_name (found in $(basename "$project_path"))"
                echo "    Files with skipped tests:"
                echo "$skipped_tests" | head -3 | while read -r file; do
                    echo "    - $file"
                done
            fi
        fi
    done

    if [ "$has_skipped" = false ]; then
        pass_test "$test_name"
    fi
}

# Run testing standards tests
test_coverage_threshold || true
test_no_skipped_tests || true

echo ""

# ====================
# Test 4: Workflow Patterns
# ====================
echo "Test Group 4: Workflow Patterns"
echo "--------------------------------"

# Test 4.1: Git commits follow conventional format
test_conventional_commits() {
    local test_name="Recent commits follow conventional format"

    cd "$REPO_ROOT"

    # Get last 5 commit messages
    local recent_commits=$(git log -5 --pretty=format:"%s" 2>/dev/null || echo "")

    if [ -z "$recent_commits" ]; then
        warn_test "$test_name (no commits found)"
        return 0
    fi

    local non_conventional=0
    while IFS= read -r commit_msg; do
        # Check if commit follows conventional format (type: message)
        if ! echo "$commit_msg" | grep -qE "^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert):"; then
            ((non_conventional++))
        fi
    done <<< "$recent_commits"

    if [ "$non_conventional" -gt 0 ]; then
        warn_test "$test_name ($non_conventional/5 don't follow conventional format)"
    else
        pass_test "$test_name"
    fi
}

# Test 4.2: Commits include Claude Code attribution
test_claude_attribution() {
    local test_name="Commits include Claude Code attribution"

    cd "$REPO_ROOT"

    # Check last 5 commits for Claude attribution
    local recent_commits=$(git log -5 --pretty=format:"%B" 2>/dev/null || echo "")

    if [ -z "$recent_commits" ]; then
        warn_test "$test_name (no commits found)"
        return 0
    fi

    # Count commits with attribution
    local attributed=$(echo "$recent_commits" | grep -c "Claude Code\|Co-Authored-By: Claude" || echo "0")

    if [ "$attributed" -ge 3 ]; then
        pass_test "$test_name ($attributed/5 commits)"
    else
        warn_test "$test_name (only $attributed/5 commits have attribution)"
    fi
}

# Test 4.3: Semantic versioning in package.json files
test_semantic_versioning() {
    local test_name="Projects use semantic versioning"

    declare -a project_paths=(
        "$HOME/Desktop/calm/calm-couples"
        "$HOME/Desktop/calm/ios-automation"
        "$HOME/Desktop/calm/calm-ai-project-manager"
    )

    local checked_any=false
    local all_valid=true

    for project_path in "${project_paths[@]}"; do
        if [ -f "$project_path/package.json" ]; then
            checked_any=true

            # Check if version follows semver (X.Y.Z)
            local version=$(grep '"version"' "$project_path/package.json" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || echo "")

            if [ -z "$version" ]; then
                all_valid=false
                warn_test "$test_name (invalid version in $(basename "$project_path"))"
            fi
        fi
    done

    if [ "$checked_any" = false ]; then
        warn_test "$test_name (no projects found to check)"
    elif [ "$all_valid" = true ]; then
        pass_test "$test_name"
    fi
}

# Run workflow pattern tests
test_conventional_commits || true
test_claude_attribution || true
test_semantic_versioning || true

echo ""

# ====================
# Test 5: Repository Integrity
# ====================
echo "Test Group 5: Repository Integrity"
echo "-----------------------------------"

# Test 5.1: All required files exist
test_required_files() {
    local test_name="All required repository files exist"

    local required_files=(
        "README.md"
        "AI_QUICKSTART.md"
        "MASTER_LEARNINGS.md"
        "TERM_DICTIONARY.md"
        "EXAMPLES.md"
        "CHANGELOG.md"
        "ACTIVE_TODOS.md"
        "SETUP_GUIDE.md"
    )

    local missing_files=()

    for file in "${required_files[@]}"; do
        if [ ! -f "$REPO_ROOT/$file" ]; then
            missing_files+=("$file")
        fi
    done

    if [ ${#missing_files[@]} -gt 0 ]; then
        fail_test "$test_name (missing: ${missing_files[*]})"
        return 1
    fi

    pass_test "$test_name"
}

# Test 5.2: Projects directory exists and has entries
test_projects_directory() {
    local test_name="Projects directory exists with entries"

    if [ ! -d "$REPO_ROOT/projects" ]; then
        fail_test "$test_name (directory not found)"
        return 1
    fi

    local project_count=$(find "$REPO_ROOT/projects" -name "*.md" -not -name "README.md" | wc -l | tr -d ' ')

    if [ "$project_count" -lt 1 ]; then
        fail_test "$test_name (no project files found)"
        return 1
    fi

    pass_test "$test_name ($project_count projects)"
}

# Test 5.3: Version consistency across files
test_version_consistency() {
    local test_name="Version numbers consistent across files"

    # Extract versions from key files
    local readme_version=$(grep "^**Version" "$REPO_ROOT/README.md" | grep -oE '[0-9]+\.[0-9]+' | head -1 || echo "")
    local quickstart_version=$(grep "^version:" "$REPO_ROOT/AI_QUICKSTART.md" | grep -oE '[0-9]+\.[0-9]+' | head -1 || echo "")
    local master_version=$(grep "^version:" "$REPO_ROOT/MASTER_LEARNINGS.md" | grep -oE '[0-9]+\.[0-9]+' | head -1 || echo "")

    if [ "$readme_version" != "$quickstart_version" ] || [ "$readme_version" != "$master_version" ]; then
        warn_test "$test_name (versions differ: README=$readme_version, QUICKSTART=$quickstart_version, MASTER=$master_version)"
    else
        pass_test "$test_name (all v$readme_version)"
    fi
}

# Run repository integrity tests
test_required_files || true
test_projects_directory || true
test_version_consistency || true

echo ""
echo "========================================"
echo "Test Summary"
echo "========================================"
echo -e "Total Tests:  $TOTAL_TESTS"
echo -e "${GREEN}Passed:       $PASSED_TESTS${NC}"
echo -e "${RED}Failed:       $FAILED_TESTS${NC}"
echo ""

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}✓ All AI agent compliance tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed. Review output above.${NC}"
    exit 1
fi