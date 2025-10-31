---
title: "Real Conversation Examples"
description: "Concrete examples of good and bad AI-Cory interactions"
version: "1.0"
last_updated: "2025-10-30"
type: "reference-examples"
audience: ["ai-agents"]
tags: ["examples", "patterns", "conversations"]
---

# Real Conversation Examples

**Purpose**: Concrete examples of effective vs ineffective conversations with Cory
**Audience**: AI agents working with Cory

---

## Table of Contents
- [Good Conversations](#good-conversations)
- [Bad Conversations](#bad-conversations)
- [Asking vs Not Asking](#asking-vs-not-asking)
- [Todo List Management](#todo-list-management)
- [Testing Scenarios](#testing-scenarios)

---

## Good Conversations

### Scenario 1: Multi-Step Bug Fix

**Context**: User reports login bug

```
User: "Fix the login bug"

Claude: [Creates todo list]
- Reproduce login bug
- Identify root cause
- Implement fix
- Add regression test
- Verify all tests pass

[Marks first item in_progress]

I'll start by reproducing the bug...

[Works through todos autonomously]

✅ Fixed login bug - race condition in auth token refresh
✅ Added regression test
✅ All 63 tests passing
✅ Committed: "fix: resolve race condition in auth token refresh"
```

**Why Good**:
- Created todo list immediately
- Worked autonomously
- Tested thoroughly
- Reported outcomes clearly
- No unnecessary questions

---

### Scenario 2: Ambiguous Request with Smart Question

**Context**: Performance improvement request

```
User: "Improve performance"

Claude: Analyzed performance bottlenecks:

| Area | Current | Opportunity | Impact |
|------|---------|-------------|--------|
| API calls | 200ms | 50ms | High |
| Bundle size | 600KB | 400KB | Medium |
| Initial render | 3s | 1s | High |

Recommend tackling API calls first (biggest impact, 75% improvement).
This involves implementing request batching and caching.
Proceed with this approach?

User: "do it"

Claude: [Creates todo list and executes]
```

**Why Good**:
- Analyzed thoroughly before asking
- Presented data and options
- Made recommendation with rationale
- Asked single smart question
- Executed immediately after approval

---

### Scenario 3: High-Stakes Verification

**Context**: Database migration

```
User: "Update the user schema"

Claude: Analyzed schema changes. This migration will:
1. Drop 'users' table and recreate with new structure
2. Affect 5,000+ user records
3. Break 3 existing API endpoints: /api/users, /api/profile, /api/settings

Two approaches:
1. Add migration + data backup + API updates (safer, 30min)
2. Fresh schema if dev environment (faster, 5min)

Which environment is this? Production or dev?

User: "dev"

Claude: ✅ Proceeding with fresh schema approach...
```

**Why Good**:
- Identified high-stakes operation
- Explained impact clearly
- Presented options with tradeoffs
- Asked specific question
- Executed after clarification

---

### Scenario 4: Autonomous Refactoring

**Context**: Code cleanup request

```
User: "do next todo"

Claude: [Checks existing todos]

Current todos:
✅ Completed: Fix race conditions (3/3)
🚧 In Progress: Refactor error handling
⏳ Pending: Add performance monitoring

Continuing with error handling refactor...

[Works autonomously]

✅ Refactored error handling:
- Replaced console.log with structured logger
- Added component, action, metadata to all errors
- 48 files updated
- All tests passing (63/63)

Moving to next todo: Add performance monitoring...
```

**Why Good**:
- Checked current state
- Continued autonomously
- Completed implementations fully
- No TODOs left in code
- Kept momentum going

---

## Bad Conversations

### Anti-Pattern 1: Over-Asking

```
User: "Fix the tests"

Claude: ❌ Should I check which tests are failing first?

User: "yes..."

Claude: ❌ Found 3 failing tests. Should I look at them one by one?

User: "just fix them"

Claude: ❌ Should I run the tests after fixing?

User: "obviously"
```

**Why Bad**:
- Asked permission for standard operations
- Tests should always be run (documented)
- Slow, frustrating interaction
- No autonomy

**Should Be**:
```
User: "Fix the tests"

Claude: [Runs tests]
Found 3 failing tests:
- login.test.ts: token refresh timeout
- profile.test.ts: mock data mismatch
- settings.test.ts: race condition

[Fixes all three]

✅ All 63 tests now passing
```

---

### Anti-Pattern 2: Not Asking When Should

```
User: "Update the database schema"

Claude: ❌ [Immediately drops production tables without asking]

[Loses all user data]
```

**Why Bad**:
- Destructive operation without verification
- Didn't ask about environment
- Didn't present impact
- Catastrophic outcome

**Should Be**:
```
User: "Update the database schema"

Claude: This will drop 5 tables with production data.
Is this a dev environment, or should I create a backup first?
```

---

### Anti-Pattern 3: Leaving TODOs

```
User: "Add authentication"

Claude: ❌ Added authentication:
```typescript
// TODO: Implement password hashing
// TODO: Add JWT token validation
// TODO: Create logout endpoint
```
```

**Why Bad**:
- Left TODOs instead of implementing
- Violates "do this yourself" principle
- Incomplete implementation

**Should Be**:
```
User: "Add authentication"

Claude: [Creates todo list]
- Implement password hashing with bcrypt
- Add JWT token validation
- Create login endpoint
- Create logout endpoint
- Add authentication tests

[Completes all items fully with zero TODOs]
```

---

### Anti-Pattern 4: Analysis Paralysis

```
User: "Improve the login flow"

Claude: ❌ Let me analyze the login flow...
[2000 words analyzing every possible improvement]

There are 15 potential improvements. Which one should we prioritize?
Should I create a decision matrix? Would you like me to research
best practices? Should I...
```

**Why Bad**:
- Overthinking before acting
- Too many options, no recommendation
- Waiting for permission
- Slow progress

**Should Be**:
```
User: "Improve the login flow"

Claude: Analyzed login flow. Top 3 improvements:
1. Add remember me (high value, 2hr)
2. Social auth (medium value, 4hr)
3. 2FA (high security, 6hr)

Recommend #1 - biggest UX win, shortest time. Proceed?
```

---

## Asking vs Not Asking

### ✅ Good: Ask Smart Questions

**Architecture Decision**:
```
Two state management options:
1. Zustand (lighter, matches calm-couples, easier migration)
2. Redux (more structure, better DevTools, team familiarity)

Recommend Zustand for consistency with calm-couples. Proceed?
```

**Destructive Operation**:
```
This will force push to main branch, overwriting 3 commits by other devs.
This is generally not recommended. Should I:
1. Create new branch instead
2. Merge instead of rebase
3. Different approach?
```

**Conflicting Requirements**:
```
Your request asks for real-time updates (WebSockets) but learnings
document REST-only architecture for calm-couples. Which takes priority?
```

---

### ❌ Bad: Ask Documented Questions

**Already Documented**:
```
❌ "Should I create a todo list?"
→ Yes, always if 2+ steps (documented in learnings)

❌ "Should I use console.log?"
→ No, use structured logger (documented)

❌ "Do I need to run tests?"
→ Yes, always (documented - zero tolerance for failures)

❌ "Should I mark this todo complete?"
→ Yes, immediately (documented)
```

---

## Todo List Management

### ✅ Good: Immediate Updates

```
User: "Implement feature X, Y, and Z"

Claude: [Creates todo list]
1. Implement feature X [pending]
2. Implement feature Y [pending]
3. Implement feature Z [pending]

[Marks first in_progress]
1. Implement feature X [in_progress]

[Completes feature X]
1. Implement feature X [completed] ✅
2. Implement feature Y [in_progress]

[Completes feature Y]
1. Implement feature X [completed] ✅
2. Implement feature Y [completed] ✅
3. Implement feature Z [in_progress]
```

**Why Good**:
- Only ONE in_progress at a time
- Marks completed IMMEDIATELY
- Clear progress tracking

---

### ❌ Bad: Batched Updates

```
Claude: ❌ [Completes all 3 features]

[Then marks all complete at once]
1. Implement feature X [completed] ✅
2. Implement feature Y [completed] ✅
3. Implement feature Z [completed] ✅
```

**Why Bad**:
- No visibility during work
- Can't track progress
- Violates "mark immediately" rule

---

## Testing Scenarios

### ✅ Good: Zero Tolerance

```
Claude: [Runs tests]

Found 2 failing tests:
- auth.test.ts: Expected 200, got 401
- profile.test.ts: Mock data mismatch

[Fixes both issues]

[Runs tests again]
✅ All 63 tests passing

Feature complete.
```

**Why Good**:
- Ran tests proactively
- Fixed all failures
- Verified success
- Zero tolerance enforced

---

### ❌ Bad: Ignoring Failures

```
Claude: ❌ [Completes feature]

Ran tests - 2 failures but they're flaky.
Feature is done!
```

**Why Bad**:
- Left failing tests
- Made excuses
- Didn't enforce zero tolerance
- Incomplete work

---

## Communication Style

### ✅ Good: Concise Updates

```
Claude:
✅ Fixed race condition in petal increment
✅ Added optimistic locking with version field
✅ Created 8 unit tests for concurrent operations
✅ All 71 tests passing (63 existing + 8 new)
✅ Committed: "fix: resolve race condition in petal system"

Ready for next task.
```

**Why Good**:
- Brief, scannable
- Progress indicators
- Key outcomes only
- Action-ready

---

### ❌ Bad: Over-Explanation

```
Claude: ❌ So I started by analyzing the race condition, and I thought
about several approaches. First, I considered using locks, but then I
realized that might cause performance issues. Then I thought about
optimistic locking, which is actually a pattern where you use version
numbers to detect conflicts. I researched this pattern extensively and
found that it's commonly used in distributed systems. Here's a detailed
explanation of how optimistic locking works... [500 more words]
```

**Why Bad**:
- Way too verbose
- Explaining every decision
- No clear outcomes
- Hard to scan

---

## Key Takeaways

**Do This**:
- ✅ Create todo lists for multi-step work
- ✅ Work autonomously on standard operations
- ✅ Ask smart questions for high-stakes decisions
- ✅ Mark todos completed immediately
- ✅ Run tests and fix all failures
- ✅ Report outcomes concisely

**Don't Do This**:
- ❌ Ask permission repeatedly
- ❌ Leave TODOs in code
- ❌ Ignore failing tests
- ❌ Over-explain trivial decisions
- ❌ Batch todo updates
- ❌ Skip asking on destructive operations

---

**Remember**: "be critical and continue" + "do this yourself" + "test all and make sure ok"

---

**Last Updated**: 2025-10-30
**Version**: 1.0
**Related**: [AI_QUICKSTART.md](AI_QUICKSTART.md) | [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md)
