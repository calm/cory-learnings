---
title: "Decision Tree: Add Tests vs Fix Bugs"
description: "Prioritization: When to write tests vs fix bugs"
version: "1.0"
last_updated: "2025-11-01"
---

# Tests vs Bugs Priority Decision

**Question**: Should I add tests or fix bugs?

---

## Quick Answer

| Situation | Priority |
|-----------|----------|
| **Blocking users** | FIX BUGS (production impact) |
| **All tests passing** | ADD TESTS (prevent regression) |
| **Some tests failing** | FIX BUGS (tests are signals) |
| **Feature untested** | ADD TESTS (new work) |
| **Old code, no tests** | FIX + TEST (safety net) |
| **Technical debt** | FIX FIRST (then test) |

---

## Decision Flowchart

```
Are any tests currently FAILING?
│
├─ YES → FIX BUGS FIRST
│        │
│        └─ Tests are signals
│           Fix what they tell you
│           Then write new tests
│
└─ NO (all passing) → Is your feature fully working?
                      │
                      ├─ NO (bugs exist) → FIX BUGS
                      │                     Use tests to verify fixes
                      │
                      └─ YES → Does the feature have good test coverage?
                               (>80% of code paths tested)
                               │
                               ├─ NO → ADD TESTS
                               │       Prevent regressions
                               │
                               └─ YES → Move to next feature
                                        Both tests + bugs handled
```

---

## When to FIX BUGS FIRST

**Priority signals** (any one):
- ❌ Users reporting issues
- ❌ Tests currently failing
- ❌ Production errors
- ❌ Data loss or corruption
- ❌ Security vulnerabilities
- ❌ Feature is broken/incomplete

**Process**:
1. Understand the bug (reproduce it)
2. Write test that fails (shows the bug)
3. Fix the code (test passes)
4. Verify fix with manual testing
5. Commit with clear message

**Time**: Until all tests pass + manual verification

---

## When to ADD TESTS FIRST

**Conditions** (all true):
- ✅ All current tests passing
- ✅ Feature is complete and working
- ✅ No critical bugs
- ✅ Code coverage <80%
- ✅ Testing new feature

**Types to add**:
- **Unit tests**: Individual functions/components
- **Integration tests**: Components working together
- **E2E tests**: Full user workflows

**Process**:
1. Identify untested code paths
2. Write test (should fail initially)
3. Implement just enough to pass test
4. Refactor while tests pass
5. Commit: "test: add coverage for X"

**Time**: <1 hour per feature area

---

## Hybrid: Fix + Test Together

**Best approach for bugs**:
1. Write test that fails (proves bug exists)
2. Fix the code (test passes)
3. Add edge case tests (prevent regression)
4. Commit: "fix: description + added tests"

**Example**:
```typescript
// 1. Test that fails (proves bug)
test('handles null user correctly', () => {
  expect(getUserName(null)).toBe('Anonymous')
})

// 2. Fix code
function getUserName(user) {
  return user?.name ?? 'Anonymous'  // Now test passes
}

// 3. Add edge case tests
test('handles user with empty name', () => {
  expect(getUserName({ name: '' })).toBe('Anonymous')
})
```

---

## Real Scenarios

### Scenario 1: "Some tests failing, feature is incomplete"
→ **FIX BUGS FIRST**
- Tests tell you what's broken
- Fix each failure
- Then add more tests for coverage

### Scenario 2: "All tests passing, users complaining about crashes"
→ **FIX BUGS FIRST**
- Tests don't catch production issue
- Reproduce and add test first
- Fix the bug
- Investigate why tests missed it

### Scenario 3: "New feature built, tests not written yet, feature seems to work"
→ **ADD TESTS FIRST**
- Document expected behavior
- Tests serve as safety net
- Prevents future regressions

### Scenario 4: "Old code, no tests, working fine"
→ **ADD TESTS FIRST** (if time allows)
- Create safety net before changes
- Tests document how code should work
- Easier to refactor safely

---

## Red Flags (Something is Wrong)

🚩 Tests passing but users report bugs → Tests don't cover real usage
🚩 "Tests are too slow" → Probably too many E2E, not enough unit
🚩 "Tests are flaky" → Usually timing issues, fix tests first
🚩 "Can't add tests because code is untestable" → Code design problem

---

## Rule of Thumb

**When unsure**: FIX BUGS FIRST
- Broken code is worse than untested code
- Failing tests are signals to fix
- Users > Test coverage (always)

---

## Time Investment

- **Fixing a bug**: 30 min - 2 hours
- **Adding tests**: 30 min - 1 hour per feature
- **Fixing + testing**: 1 - 3 hours (higher quality)

