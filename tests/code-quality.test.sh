#!/bin/bash

# Code Quality Validation Test
# Validates that code follows Cory's documented quality standards
# Can be run as a pre-commit hook or CI check

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_PATH="${1:-.}"  # Allow passing project path as argument, default to current dir
VERBOSE="${VERBOSE:-false}"

# Test counters
TOTAL_VIOLATIONS=0
CRITICAL_VIOLATIONS=0

# Helper functions
critical_violation() {
    echo -e "${RED}✗ CRITICAL${NC} $1"
    ((CRITICAL_VIOLATIONS++))
    ((TOTAL_VIOLATIONS++))
}

warning_violation() {
    echo -e "${YELLOW}⚠ WARNING${NC} $1"
    ((TOTAL_VIOLATIONS++))
}

info_message() {
    echo -e "${BLUE}ℹ${NC} $1"
}

success_message() {
    echo -e "${GREEN}✓${NC} $1"
}

echo "========================================"
echo "Code Quality Validation"
echo "========================================"
echo "Project: $PROJECT_PATH"
echo ""

# ====================
# Check 1: No TODO/FIXME comments
# ====================
echo "Checking for TODO/FIXME comments..."

if [ -d "$PROJECT_PATH/src" ]; then
    TODO_FILES=$(find "$PROJECT_PATH/src" \
        -type f \
        \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" \) \
        -not -path "*/node_modules/*" \
        -not -path "*/.git/*" \
        -exec grep -l "// TODO\|//TODO\|# TODO\|#TODO\|// FIXME\|//FIXME" {} \; 2>/dev/null || true)

    if [ -n "$TODO_FILES" ]; then
        critical_violation "Found TODO/FIXME comments (violates 'Zero TODOs in code' rule)"
        echo "$TODO_FILES" | while read -r file; do
            echo "    ❌ $file"
            if [ "$VERBOSE" = "true" ]; then
                grep -n "TODO\|FIXME" "$file" 2>/dev/null | head -3 | while read -r line; do
                    echo "        → $line"
                done
            fi
        done
        echo ""
    else
        success_message "No TODO/FIXME comments found"
    fi
else
    info_message "No src/ directory found, skipping TODO check"
fi

# ====================
# Check 2: No console.log statements
# ====================
echo ""
echo "Checking for console.log statements..."

if [ -d "$PROJECT_PATH/src" ]; then
    CONSOLE_LOG_FILES=$(find "$PROJECT_PATH/src" \
        -type f \
        \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" \) \
        -not -path "*/node_modules/*" \
        -not -path "*/.git/*" \
        -not -path "*/test/*" \
        -not -path "*/tests/*" \
        -not -path "*/__tests__/*" \
        -not -name "*.test.*" \
        -not -name "*.spec.*" \
        -exec grep -l "console\.log\|console\.debug\|console\.info\|console\.warn" {} \; 2>/dev/null || true)

    if [ -n "$CONSOLE_LOG_FILES" ]; then
        critical_violation "Found console.log statements (use structured logger instead)"
        echo "$CONSOLE_LOG_FILES" | head -10 | while read -r file; do
            local count=$(grep -c "console\." "$file" 2>/dev/null || echo "0")
            echo "    ❌ $file ($count occurrences)"
            if [ "$VERBOSE" = "true" ]; then
                grep -n "console\." "$file" 2>/dev/null | head -3 | while read -r line; do
                    echo "        → $line"
                done
            fi
        done
        echo ""
    else
        success_message "No console.log statements found"
    fi
else
    info_message "No src/ directory found, skipping console.log check"
fi

# ====================
# Check 3: TypeScript 'any' usage
# ====================
echo ""
echo "Checking for TypeScript 'any' usage..."

if [ -d "$PROJECT_PATH/src" ]; then
    ANY_FILES=$(find "$PROJECT_PATH/src" \
        -type f \
        \( -name "*.ts" -o -name "*.tsx" \) \
        -not -path "*/node_modules/*" \
        -not -path "*/.git/*" \
        -exec grep -l ": any\|<any>\|as any" {} \; 2>/dev/null || true)

    if [ -n "$ANY_FILES" ]; then
        warning_violation "Found TypeScript 'any' usage (violates 'zero any' rule)"
        echo "$ANY_FILES" | head -10 | while read -r file; do
            local count=$(grep -c ": any\|<any>\|as any" "$file" 2>/dev/null || echo "0")
            echo "    ⚠️  $file ($count occurrences)"
            if [ "$VERBOSE" = "true" ]; then
                grep -n ": any\|<any>\|as any" "$file" 2>/dev/null | head -3 | while read -r line; do
                    echo "        → $line"
                done
            fi
        done
        echo ""
    else
        success_message "No 'any' type usage found"
    fi
else
    info_message "No src/ directory found, skipping 'any' check"
fi

# ====================
# Check 4: Skipped/disabled tests
# ====================
echo ""
echo "Checking for skipped or disabled tests..."

SKIPPED_TEST_FILES=$(find "$PROJECT_PATH" \
    -type f \
    \( -name "*.test.ts" -o -name "*.test.tsx" -o -name "*.spec.ts" -o -name "*.spec.tsx" \) \
    -not -path "*/node_modules/*" \
    -not -path "*/.git/*" \
    -exec grep -l "\.skip\|\.only\|xit\|xdescribe\|fdescribe\|fit" {} \; 2>/dev/null || true)

if [ -n "$SKIPPED_TEST_FILES" ]; then
    critical_violation "Found skipped or focused tests (violates 'zero tolerance for failing tests')"
    echo "$SKIPPED_TEST_FILES" | while read -r file; do
        echo "    ❌ $file"
        if [ "$VERBOSE" = "true" ]; then
            grep -n "\.skip\|\.only\|xit\|xdescribe\|fdescribe\|fit" "$file" 2>/dev/null | head -3 | while read -r line; do
                echo "        → $line"
            done
        fi
    done
    echo ""
else
    success_message "No skipped or focused tests found"
fi

# ====================
# Check 5: Package.json quality checks
# ====================
echo ""
echo "Checking package.json quality..."

if [ -f "$PROJECT_PATH/package.json" ]; then
    # Check for version
    if ! grep -q '"version"' "$PROJECT_PATH/package.json"; then
        warning_violation "package.json missing version field"
    else
        local version=$(grep '"version"' "$PROJECT_PATH/package.json" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || echo "")
        if [ -z "$version" ]; then
            warning_violation "package.json version doesn't follow semantic versioning (X.Y.Z)"
        else
            success_message "package.json has valid semantic version: $version"
        fi
    fi

    # Check for test scripts
    if ! grep -q '"test"' "$PROJECT_PATH/package.json"; then
        warning_violation "package.json missing test script"
    else
        success_message "package.json has test script"
    fi

    # Check for lint scripts
    if ! grep -q '"lint"' "$PROJECT_PATH/package.json"; then
        info_message "package.json missing lint script (recommended)"
    else
        success_message "package.json has lint script"
    fi
else
    info_message "No package.json found"
fi

# ====================
# Check 6: TypeScript configuration
# ====================
echo ""
echo "Checking TypeScript configuration..."

if [ -f "$PROJECT_PATH/tsconfig.json" ]; then
    # Check for strict mode
    if ! grep -q '"strict".*true' "$PROJECT_PATH/tsconfig.json"; then
        critical_violation "tsconfig.json missing strict mode (violates TypeScript strict mode rule)"
    else
        success_message "tsconfig.json has strict mode enabled"
    fi

    # Check for noImplicitAny
    if ! grep -q '"noImplicitAny".*true' "$PROJECT_PATH/tsconfig.json" && ! grep -q '"strict".*true' "$PROJECT_PATH/tsconfig.json"; then
        warning_violation "tsconfig.json missing noImplicitAny (implied by strict mode)"
    fi
else
    info_message "No tsconfig.json found (not a TypeScript project)"
fi

# ====================
# Check 7: Git hooks and pre-commit
# ====================
echo ""
echo "Checking for Git hooks..."

if [ -d "$PROJECT_PATH/.git/hooks" ]; then
    if [ -f "$PROJECT_PATH/.git/hooks/pre-commit" ] || [ -f "$PROJECT_PATH/.husky/pre-commit" ]; then
        success_message "Pre-commit hooks configured"
    else
        info_message "No pre-commit hooks found (recommended: husky + lint-staged)"
    fi
else
    info_message "Not a git repository"
fi

# ====================
# Check 8: Environment files
# ====================
echo ""
echo "Checking for environment file patterns..."

ENV_FILES=$(find "$PROJECT_PATH" \
    -maxdepth 1 \
    -type f \
    \( -name ".env" -o -name ".env.local" -o -name ".env.*.local" \) \
    2>/dev/null || true)

if [ -n "$ENV_FILES" ]; then
    # Check if they're properly gitignored
    if [ -f "$PROJECT_PATH/.gitignore" ]; then
        if ! grep -q "^\.env" "$PROJECT_PATH/.gitignore"; then
            critical_violation "Environment files found but not in .gitignore (security risk)"
            echo "$ENV_FILES" | while read -r file; do
                echo "    🔒 $(basename "$file")"
            done
        else
            success_message "Environment files properly gitignored"
        fi
    else
        warning_violation "Environment files found but no .gitignore exists"
    fi
fi

# ====================
# Summary
# ====================
echo ""
echo "========================================"
echo "Summary"
echo "========================================"
echo ""

if [ $CRITICAL_VIOLATIONS -eq 0 ] && [ $TOTAL_VIOLATIONS -eq 0 ]; then
    echo -e "${GREEN}✓ All code quality checks passed!${NC}"
    echo ""
    echo "Your code follows Cory's quality standards:"
    echo "  • Zero TODOs/placeholders"
    echo "  • Structured logging (no console.log)"
    echo "  • TypeScript strict mode"
    echo "  • Zero skipped tests"
    echo ""
    exit 0
elif [ $CRITICAL_VIOLATIONS -gt 0 ]; then
    echo -e "${RED}✗ Found $CRITICAL_VIOLATIONS critical violation(s)${NC}"
    echo -e "${YELLOW}⚠ Found $((TOTAL_VIOLATIONS - CRITICAL_VIOLATIONS)) warning(s)${NC}"
    echo ""
    echo "Critical violations MUST be fixed before committing."
    echo "Review the output above for details."
    echo ""
    echo "Run with VERBOSE=true for detailed output:"
    echo "  VERBOSE=true $0 $PROJECT_PATH"
    echo ""
    exit 1
else
    echo -e "${YELLOW}⚠ Found $TOTAL_VIOLATIONS warning(s)${NC}"
    echo ""
    echo "Consider addressing these warnings to maintain code quality."
    echo ""
    exit 0
fi
