---
title: "Bug Fix Database"
description: "Searchable collection of real bugs from all projects with solutions"
version: "1.0"
last_updated: "2025-11-01"
type: "reference"
---

# Bug Fix Database

**Quick search**: Use `./scripts/find-bug.sh "error message"` to search this database.

---

## Template for New Bugs

```
## Bug: [BUG_TITLE]

**Project**: calm-couples | ios-automation | calm-ai-project-manager
**Severity**: Critical | High | Medium | Low
**Status**: Fixed | Known | In Progress
**Date Found**: YYYY-MM-DD

### Symptoms
What the user/test sees

### Root Cause Analysis
Why it happens

### Solution
Step-by-step fix

### Code Example
Before/after if applicable

### Related Issues
Links to related bugs or PRs

### Lessons Learned
What we can do to prevent similar bugs
```

---

## Bug Database

### Bug 1: Race Condition in Plant Sync

**Project**: calm-couples
**Severity**: High
**Status**: Fixed
**Date Found**: 2025-10-15

### Symptoms
- Plant health values inconsistent across clients
- Updates from one user overwrite another's
- Sync conflicts appear randomly

### Root Cause Analysis
- Concurrent writes from multiple clients without locking
- No version tracking on plant records
- Last-write-wins conflict resolution insufficient for collaborative edits

### Solution
1. Added `version` integer field to plants table
2. Implemented optimistic locking check before update
3. Return current version with conflict error
4. Client must refetch and retry with new version

**Code Change**:
```sql
-- Before
UPDATE plants SET health = $1 WHERE id = $2

-- After
UPDATE plants
SET health = $1, version = version + 1
WHERE id = $2 AND version = $3
```

### Related Issues
- Race conditions common in collaborative apps
- Similar pattern fixed in relationships table
- Supabase RLS alone insufficient

### Lessons Learned
- Always add version/timestamp to mutable records
- Test with concurrent operations
- Don't assume single user per resource

---

### Bug 2: Modal Not Dismissing in E2E Tests

**Project**: ios-automation
**Severity**: Medium
**Status**: Fixed
**Date Found**: 2025-10-20

### Symptoms
- Random test failures
- Modal stays visible after test
- Next test starts with modal blocking screen
- Works locally, fails in CI

### Root Cause Analysis
- Modal dismiss animation timing varies
- Gesture coordinates sometimes miss close button
- No explicit wait for modal dismissal

### Solution
1. Added explicit wait for modal to disappear
2. Used larger tap target for close button
3. Added retry logic if first tap fails
4. Clear state between tests in beforeEach hook

**Code Fix**:
```javascript
// Before
await driver.findElement(By.id('close')).click()

// After
async function dismissModal(driver) {
  const closeBtn = await driver.findElement(By.id('close'))
  await closeBtn.click()
  await driver.wait(
    until.invisibilityOf(closeBtn),
    3000
  )
}
```

### Related Issues
- Modal management critical for test isolation
- Similar issue in multiple test suites

### Lessons Learned
- Always wait for UI state changes
- Don't assume taps succeed immediately
- Test isolation requires explicit cleanup

---

### Bug 3: Circular Task Dependencies

**Project**: calm-ai-project-manager
**Severity**: High
**Status**: Fixed
**Date Found**: 2025-11-01

### Symptoms
- RCI calculation returns NaN
- Database queries hang
- Topology sort fails

### Root Cause Analysis
- User created: Task A → B → C → A
- No validation on dependency creation
- Circular reference breaks graph algorithms

### Solution
1. Added cycle detection before saving dependency
2. Implement topological sort validation
3. Return clear error to user
4. Prevent UI from allowing circular dependencies

**Algorithm**:
```
Check if new dependency creates cycle:
1. Start from destination task
2. Follow dependency chain backward
3. If we reach source task → CYCLE
4. Reject with error message
```

### Related Issues
- Validate all graph relationships
- Similar pattern in dependency management tools

### Lessons Learned
- Graph validation must happen at insert time
- Can't rely on UI validation alone
- Document invariants clearly

---

## How to Use This Database

### Search by Error
```bash
./scripts/find-bug.sh "race condition"
./scripts/find-bug.sh "modal"
./scripts/find-bug.sh "circular"
```

### Search Manually
1. Use Ctrl+F to search file
2. Look for "## Bug:" entries
3. Read symptoms to identify your issue

### Add New Bug
1. Copy template above
2. Fill in all sections
3. Commit with clear message
4. Update last_updated date

---

## Statistics

**Total Bugs Tracked**: 3
**By Project**:
- calm-couples: 1
- ios-automation: 1
- calm-ai-project-manager: 1

**By Severity**:
- Critical: 0
- High: 2
- Medium: 1
- Low: 0

**Fixed**: 3
**In Progress**: 0

---

## Prevention Patterns

Based on bugs found:

1. **Always add versioning to mutable records**
2. **Test with concurrent operations**
3. **Validate graph invariants at insert time**
4. **Make UI tests wait for state changes**
5. **Test isolation requires explicit cleanup**

---

**Remember**: Every bug teaches us something. Document it for the team!

