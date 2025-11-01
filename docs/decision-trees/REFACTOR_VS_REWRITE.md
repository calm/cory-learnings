---
title: "Decision Tree: Refactor vs Rewrite"
description: "When to refactor existing code vs rewriting from scratch"
version: "1.0"
last_updated: "2025-11-01"
---

# Refactor vs Rewrite Decision Tree

**Question**: Should I refactor this code or rewrite it?

---

## Quick Decision Matrix

| Factor | Refactor | Rewrite |
|--------|----------|---------|
| **Code size** | <500 lines | >2000 lines |
| **Tests exist** | Yes, good coverage | No/minimal |
| **Bugs are few** | <2 blockers | 5+ blockers |
| **Architecture sound** | Yes | Fundamentally flawed |
| **Time available** | Limited | Plenty |
| **Risk tolerance** | Low | High |

---

## Decision Flowchart

```
Do you understand the current code?
│
├─ NO → Ask questions / read code / run tests
│       Then come back to this decision
│
└─ YES → Is the current architecture sound?
         (Does it logically make sense?)
         │
         ├─ NO → REWRITE
         │       Architecture is broken
         │       (Estimate: 3-5x more time)
         │
         └─ YES → Does it have good test coverage?
                  (>80% tests passing)
                  │
                  ├─ NO → ADD TESTS FIRST
                  │       Then refactor with safety net
                  │
                  └─ YES → Are there <3 critical bugs?
                           │
                           ├─ NO (5+ bugs) → REWRITE
                           │                 Too broken to fix
                           │
                           └─ YES → REFACTOR
                                    Fix bugs + improve incrementally
```

---

## When to REFACTOR

**Conditions** (all must be true):
- Architecture makes sense
- Tests provide safety net
- Bugs are localized, not systemic
- Have time to refactor gradually
- Team understands current code

**Process**:
1. ✅ Run full test suite (establish baseline)
2. ✅ Fix one bug at a time
3. ✅ Run tests after each fix
4. ✅ Commit per logical fix
5. ✅ Gradually improve code quality
6. ✅ Never break existing functionality

**Time estimate**: 20-30% of original build time

---

## When to REWRITE

**Conditions** (any one is true):
- Architecture is fundamentally flawed
- >50% of code has bugs
- Trying to do something the current design doesn't support
- Have enough time to build properly
- Team agrees current approach is wrong

**Process**:
1. ✅ Understand what currently works
2. ✅ Design new architecture
3. ✅ Build skeleton with TODOs
4. ✅ Implement piece by piece
5. ✅ Test thoroughly
6. ✅ Gradually migrate from old to new
7. ✅ Remove old code once confident

**Time estimate**: 80-150% of original build time

---

## Examples

### Example 1: "This function is 200 lines and hard to understand"
→ **REFACTOR**
- Break into smaller functions
- Add tests
- Improve variable names
- Extract common patterns
- Time: 1-2 hours

### Example 2: "The entire database layer has race conditions, data loss bugs, and doesn't support the feature we need"
→ **REWRITE**
- Current design is broken
- Affecting multiple systems
- Time: 2-3 days

### Example 3: "This component has 1 layout bug and code style issues"
→ **REFACTOR**
- Bug is localized
- Fix in 30 minutes
- Run tests to verify

### Example 4: "We need to support 5 new data types but the schema doesn't allow it"
→ **EVALUATE**
- Can you extend schema? → REFACTOR
- Does schema design prevent it? → REWRITE

---

## Hybrid Approach

**Often the best option**:
1. Refactor working parts (keep what's good)
2. Rewrite broken parts (replace what's bad)
3. Test extensively between changes
4. Commit frequently with clear messages

---

## When in Doubt

**Ask yourself**:
- Can I fix it in <2 hours? → REFACTOR
- Will it take >1 day? → REWRITE
- Is the team confident in the fix? → REFACTOR
- Is the team concerned about the approach? → REWRITE

---

## Red Flags (Rewrite signal)

🚩 "It would be easier to rewrite than understand"
🚩 "Every fix causes 2 new bugs"
🚩 "The tests don't work with the architecture"
🚩 "Multiple people say it's broken"
🚩 "Performance degrades with scale"

---

**Time saved**: Choosing right approach → 2-3 days of wasted effort avoided

