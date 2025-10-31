# Test Suite Documentation

Comprehensive test suite for validating repository structure and AI agent compliance with documented principles.

## Quick Start

```bash
# Run all tests
./run-all-tests.sh

# Run specific test suite
./ai-agent-compliance.test.sh
./code-quality.test.sh ~/path/to/project
./todo-patterns.test.sh
```

---

## Test Suites

### Repository Validation Tests

#### structure.test.sh
Validates repository file structure and organization.

**What it tests:**
- Required files exist (README.md, AI_QUICKSTART.md, etc.)
- Directory structure is correct (projects/, scripts/, tests/)
- Project files follow naming conventions
- Symlinks are valid and not broken

**When to run:** After adding new files or reorganizing structure

```bash
./structure.test.sh
```

#### frontmatter.test.sh
Validates YAML frontmatter in markdown files.

**What it tests:**
- All markdown files have valid YAML frontmatter
- Required fields are present (title, version, last_updated, etc.)
- Frontmatter syntax is correct
- Field values are properly formatted

**When to run:** After editing markdown files

```bash
./frontmatter.test.sh
```

#### markdown.test.sh
Validates markdown syntax and formatting.

**What it tests:**
- Markdown syntax is valid
- Links are not broken
- Code blocks are properly formatted
- Headers follow proper hierarchy

**When to run:** After editing content

```bash
./markdown.test.sh
```

#### versions.test.sh
Validates version consistency across files.

**What it tests:**
- Version numbers are consistent (README.md, AI_QUICKSTART.md, MASTER_LEARNINGS.md)
- Versions follow semantic versioning (X.Y.Z)
- CHANGELOG.md matches current version
- last_updated dates are recent

**When to run:** Before releasing a new version

```bash
./versions.test.sh
```

---

### AI Agent Compliance Tests

#### ai-agent-compliance.test.sh
**Purpose:** Validates that AI agents are following documented principles from AI_QUICKSTART.md

**What it tests:**

1. **Code Quality Standards**
   - No TODO/FIXME comments in code (violates "Zero TODOs in code" rule)
   - No console.log statements (must use structured logger)
   - TypeScript strict mode enabled in tsconfig.json

2. **Documentation Standards**
   - ACTIVE_TODOS.md properly formatted
   - AI_QUICKSTART.md has all critical sections
   - TERM_DICTIONARY.md exists with sufficient entries

3. **Testing Standards**
   - Test coverage meets 98% threshold
   - No skipped or disabled tests (.skip, .only, xit)

4. **Workflow Patterns**
   - Git commits follow conventional format (feat:, fix:, docs:, etc.)
   - Commits include Claude Code attribution
   - Projects use semantic versioning

5. **Repository Integrity**
   - All required files exist
   - Projects directory has entries
   - Version numbers are consistent

**When to run:**
- After AI agent completes a task
- Before committing changes
- As part of CI/CD pipeline
- During code review

**Output:**
- Green ✓ for passing tests
- Red ✗ for failing tests
- Yellow ⚠ for warnings

```bash
./ai-agent-compliance.test.sh
```

**Example Output:**
```
========================================
AI Agent Compliance Test Suite
========================================

Test Group 1: Code Quality Standards
------------------------------------
✓ No TODO comments in code
✓ No console.log in code (use structured logger)
✓ TypeScript strict mode enabled

...

✓ All AI agent compliance tests passed!
```

---

#### code-quality.test.sh
**Purpose:** Real-time code quality validation during development

**What it tests:**

1. **Critical Violations** (must fix before commit)
   - TODO/FIXME comments in source code
   - console.log statements in non-test files
   - Skipped or focused tests
   - TypeScript strict mode not enabled
   - Environment files not gitignored

2. **Warnings** (should fix to maintain quality)
   - TypeScript 'any' usage
   - Missing test scripts in package.json
   - Missing version in package.json
   - No pre-commit hooks configured

3. **Info Messages** (recommendations)
   - Consider adding lint scripts
   - Consider using pre-commit hooks (husky)

**When to run:**
- During development (frequently)
- Before committing changes
- As a pre-commit hook
- In CI/CD pipeline

**Usage:**

```bash
# Test current directory
./code-quality.test.sh

# Test specific project
./code-quality.test.sh ~/Desktop/calm/calm-couples

# Verbose output (shows specific violations)
VERBOSE=true ./code-quality.test.sh ~/Desktop/calm/calm-couples
```

**Example Output:**
```
========================================
Code Quality Validation
========================================
Project: /Users/cory/Desktop/calm/calm-couples

Checking for TODO/FIXME comments...
✓ No TODO/FIXME comments found

Checking for console.log statements...
✗ CRITICAL Found console.log statements (use structured logger instead)
    ❌ src/utils/logger.ts (3 occurrences)

...

✗ Found 1 critical violation(s)
⚠ Found 2 warning(s)

Critical violations MUST be fixed before committing.
```

**Exit Codes:**
- 0: All checks passed
- 1: Critical violations found (must fix)

**As Pre-Commit Hook:**
```bash
# Add to .husky/pre-commit or .git/hooks/pre-commit
#!/bin/bash
~/cory-learnings/tests/code-quality.test.sh $(pwd)
```

---

#### todo-patterns.test.sh
**Purpose:** Validates todo list management patterns

**What it tests:**

1. **ACTIVE_TODOS.md Structure**
   - File exists
   - Has proper YAML frontmatter
   - Required sections present (# Active Todos, ## Current Todos, ## Template)
   - Template includes proper format examples

2. **Todo Content Validation**
   - Todos use proper markdown checkbox format (- [ ])
   - Todos are descriptive, not vague ("fix stuff" → "Fix race condition in petal increment")
   - Multi-window coordination includes branch info

3. **Todo List Best Practices**
   - Todo sections include context/description
   - last_updated date is recent (within 30 days)
   - No stale in_progress todos without context

4. **Documentation Consistency**
   - Template format matches AI_QUICKSTART.md guidelines
   - Usage notes reference TodoWrite tool appropriately

**When to run:**
- After updating ACTIVE_TODOS.md
- At end of work session
- Before starting new conversation with AI agent

**Usage:**
```bash
./todo-patterns.test.sh
```

**Example Output:**
```
========================================
Todo List Pattern Validation
========================================

Test Group 1: ACTIVE_TODOS.md Structure
----------------------------------------
✓ ACTIVE_TODOS.md file exists
✓ ACTIVE_TODOS.md has proper YAML frontmatter
✓ ACTIVE_TODOS.md has required sections
✓ Template section includes proper todo format

...

✓ All todo pattern tests passed!

Your ACTIVE_TODOS.md follows best practices:
  • Proper structure and formatting
  • Descriptive, actionable todos
  • Includes context and coordination info
  • Consistent with AI_QUICKSTART.md guidelines
```

---

## Running All Tests

### run-all-tests.sh

Runs all test suites in sequence and reports overall status.

**Usage:**
```bash
./run-all-tests.sh
```

**Output:**
```
==========================================
🧪 cory-learnings Test Suite
==========================================

Running structure.test.sh...
✓ All structure tests passed!

Running frontmatter.test.sh...
✓ All frontmatter tests passed!

...

==========================================
📊 Final Test Summary
==========================================
Test Suites Passed: 7
Test Suites Failed: 0

✓ All test suites passed!
```

**Exit Codes:**
- 0: All test suites passed
- 1: One or more test suites failed

---

## Integration with Workflow

### During Development

```bash
# Before starting work
./tests/ai-agent-compliance.test.sh

# While working (check specific project)
VERBOSE=true ./tests/code-quality.test.sh ~/Desktop/calm/calm-couples

# Before committing
./tests/run-all-tests.sh
```

### As Pre-Commit Hook

```bash
# .husky/pre-commit or .git/hooks/pre-commit
#!/bin/bash

echo "Running code quality checks..."
~/cory-learnings/tests/code-quality.test.sh $(pwd)

if [ $? -ne 0 ]; then
    echo "❌ Code quality checks failed. Fix violations before committing."
    exit 1
fi
```

### In CI/CD

```yaml
# .github/workflows/test.yml
name: Test
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run tests
        run: ./tests/run-all-tests.sh
```

---

## Understanding Test Results

### Status Indicators

- ✓ **Green checkmark**: Test passed
- ✗ **Red X**: Test failed (must fix)
- ⚠ **Yellow warning**: Warning (should address)
- ℹ **Blue info**: Informational message

### Exit Codes

- **0**: All tests passed
- **1**: Tests failed

### Verbose Mode

Add `VERBOSE=true` before command for detailed output:

```bash
VERBOSE=true ./code-quality.test.sh ~/Desktop/calm/calm-couples
```

Shows:
- Specific file locations of violations
- Line numbers
- Actual code snippets

---

## Maintaining Tests

### Adding New Tests

1. Create new test file: `tests/new-test.test.sh`
2. Make it executable: `chmod +x tests/new-test.test.sh`
3. Follow existing pattern:
   - Use set -e for early exit on errors
   - Use color codes for output
   - Return 0 for success, 1 for failure
4. Update this README

### Updating Tests

When updating documented principles:
1. Update AI_QUICKSTART.md or MASTER_LEARNINGS.md
2. Update corresponding test in tests/
3. Run ./tests/run-all-tests.sh to verify
4. Update this README if test behavior changed

---

## Troubleshooting

### Test fails but code looks correct

1. Check if test is too strict
2. Verify test matches documented principles
3. Update test if principles have evolved
4. Document exception if needed

### Tests pass but violations exist

1. Test may not be comprehensive enough
2. Add new test case for the violation
3. Update existing test to be more thorough

### Test execution fails

```bash
# Ensure tests are executable
chmod +x tests/*.test.sh

# Run individual test to isolate issue
./tests/specific-test.test.sh

# Check for syntax errors
bash -n tests/specific-test.test.sh
```

---

## Resources

- [AI_QUICKSTART.md](../AI_QUICKSTART.md) - Principles being tested
- [MASTER_LEARNINGS.md](../MASTER_LEARNINGS.md) - Complete preferences guide
- [EXAMPLES.md](../EXAMPLES.md) - Good vs bad patterns

---

**Last Updated**: 2025-10-31
