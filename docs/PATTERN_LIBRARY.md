---
title: "Shared Pattern Library"
description: "Real-world Decision Trees usage examples across calm-couples, qa-automation, and calm-ai-project-manager"
version: "1.0"
last_updated: "2025-11-01"
---

# Shared Pattern Library

Real-world examples of applying Decision Trees to solve recurring problems across all Calm projects.

---

## Table of Contents

1. [Pattern Overview](#pattern-overview)
2. [Tree #1: Feature Development](#tree-1-feature-development)
3. [Tree #2: Bug Prioritization](#tree-2-bug-prioritization)
4. [Tree #3: Performance Investigation](#tree-3-performance-investigation)
5. [Tree #4: Tech Stack Decision](#tree-4-tech-stack-decision)
6. [Tree #5: Test Strategy](#tree-5-test-strategy)
7. [Tree #6: Cost Optimization](#tree-6-cost-optimization)
8. [Common Anti-Patterns](#common-anti-patterns)
9. [Quick Lookup](#quick-lookup)

---

## Pattern Overview

### What This Guide Does

- Shows REAL scenarios from Calm projects
- Maps Decision Tree to actual decisions made
- Includes cost implications
- Highlights mistakes avoided
- Provides copy-paste patterns for new situations

### How to Use

1. **Identify your decision type** (see Quick Lookup)
2. **Find matching pattern below**
3. **Compare to your situation**
4. **Follow Decision Tree path**
5. **Reference cost implications**

---

## Tree #1: Feature Development

**Use when**: Deciding whether to build a requested feature.

### Pattern: dark-mode-toggle

**Scenario**: User requests dark mode toggle for calm-couples

**Decision Path**:
```
START: Dark Mode Toggle Request
│
├─ Is it blocking? NO
│  └─ Continue
├─ Aligns with mission? YES (UX improvement)
│  └─ Continue
├─ < 5K tokens? YES (~2K estimated)
│  └─ Continue
├─ Can users work around it? YES (browser dark mode)
│  └─ Continue
├─ Would create tech debt? NO
│  └─ DECISION: SKIP (document reason)
```

**Cost Analysis**:
- Implementation: 2K tokens ($0.006)
- Maintenance: Low (30 min/quarter)
- Workaround available: YES
- **Decision**: Not worth it (ROI < 0.5)

**What was learned**: Users can already achieve dark mode via browser settings. Implementation cost not justified.

---

### Pattern: gdpr-export-feature

**Scenario**: GDPR requirement to export user data in calm-couples

**Decision Path**:
```
START: User Data Export Feature
│
├─ Is it blocking? YES (legal requirement)
│  └─ BUILD (priority)
├─ Aligns with mission? YES (required compliance)
│  └─ Confirm
├─ Would create tech debt? YES (complex cascade deletes)
│  └─ Plan cleanup → BUILD anyway
└─ DECISION: BUILD (legal requirement overrides cost)
```

**Cost Analysis**:
- Implementation: 8K tokens ($0.024)
- Cleanup tasks: 3K tokens ($0.009)
- Total: 11K tokens ($0.033)
- Mandatory: YES
- **Decision**: BUILD (non-negotiable)

**What was learned**: Legal requirements always BUILD. Plan cleanup separately if creating tech debt.

---

### Pattern: task-prioritization-qa-automation

**Scenario**: Should we add support for multiple browser types?

**Decision Path**:
```
START: Multi-Browser Support
│
├─ Is it blocking? YES (qa-automation needs Chrome + Safari)
│  └─ BUILD (priority)
├─ Aligns with mission? YES (core requirement)
│  └─ Confirm
├─ Can break into smaller pieces? YES
│  │ ├─ Phase 1: Chrome + Firefox (2K)
│  │ └─ Phase 2: Safari + Edge (2K)
│  └─ Build in phases
└─ DECISION: BUILD in phases
```

**Cost Analysis**:
- Phase 1 (Chrome/Firefox): 2K tokens
- Phase 2 (Safari/Edge): 2K tokens
- Total: 4K tokens ($0.012)
- Blocked without: YES
- **Decision**: Phase-based implementation

**Key insight**: Breaking into <5K phases keeps costs manageable while unblocking users.

---

## Tree #2: Bug Prioritization

**Use when**: Deciding which bugs to fix first.

### Pattern: plant-not-updating-race-condition

**Scenario**: calm-couples - Plant visual doesn't update after watering

**Decision Path**:
```
START: Plant Update Bug
│
├─ Is it production blocker? YES (user can't water plants)
│  └─ CRITICAL (fix today)
├─ Affects multiple users? YES (all users with 10+ plants)
│  └─ HIGH priority
├─ Simple workaround? NO (user perceives broken)
│  └─ Continue
├─ Will worsen if ignored? YES (data consistency risk)
│  └─ HIGH priority (fix soon)
├─ Fix cost < 3K? YES (known pattern, 2K)
│  └─ MEDIUM cost (acceptable)
└─ DECISION: CRITICAL → Fix immediately
```

**Cost Analysis**:
- Investigation: 1K tokens
- Implementation: 2K tokens
- Testing: 1K tokens
- Total: 4K tokens ($0.012)
- Impact if not fixed: HIGH (users frustrated)
- **Decision**: Priority 1

**Root cause**: Supabase realtime subscription conflicts with Zustand state updates

**Solution**: Debounce realtime updates 500ms, use optimistic updates

**Prevention**: Document in pain points, add to AGENTS.md checklist

---

### Pattern: test-flakiness-intermittent

**Scenario**: qa-automation - Test passes locally but fails in CI 20% of time

**Decision Path**:
```
START: Flaky Test
│
├─ Production blocker? NO
│  └─ Continue
├─ Affects multiple users? NO (CI only)
│  └─ Continue
├─ Simple workaround? YES (retry in CI)
│  └─ MEDIUM priority (document workaround)
├─ Will worsen if ignored? YES (erosion of trust)
│  └─ HIGH priority (fix soon)
├─ Fix cost < 3K? NO (isolation issue, 5K)
│  └─ LOW priority (defer to next sprint)
└─ DECISION: MEDIUM → Documented workaround, scheduled cleanup
```

**Cost Analysis**:
- Quick fix (retry logic): 1K tokens
- Root cause investigation: 3K tokens
- Full fix: 5-7K tokens
- Deferred cost: 5K tokens (next sprint)
- **Decision**: Implement workaround now, schedule investigation

**Common cause**: Timing-dependent tests, missing state resets, race conditions

**Prevention**: Add timeout values, verify test isolation

---

### Pattern: typo-in-ui-label

**Scenario**: Button says "Sumbmit" instead of "Submit"

**Decision Path**:
```
START: UI Text Typo
│
├─ Blocking? NO (user understands)
│  └─ Continue
├─ Multiple users affected? YES (all see typo)
│  └─ HIGH visibility
├─ Simple workaround? YES (user gets it anyway)
│  └─ MEDIUM (cosmetic issue)
├─ Worse if ignored? NO (not progressive)
│  └─ MEDIUM
├─ Fix cost < 3K? YES (30 min, 0.5K)
│  └─ MEDIUM (quick fix)
└─ DECISION: MEDIUM → Fix in next PR
```

**Cost Analysis**:
- Investigation: 0.2K tokens
- Implementation: 0.3K tokens
- Total: 0.5K tokens ($0.0015)
- Impact: LOW
- **Decision**: Add to next feature PR, batch with other changes

**Lesson**: Don't context-switch for 30-min fixes. Batch with related work.

---

## Tree #3: Performance Investigation

**Use when**: Investigating slow operations or janky animations.

### Pattern: plant-animation-janky-on-mobile

**Scenario**: calm-couples - 3D plant animation drops to 30fps with 10+ plants

**Decision Path**:
```
START: Animation Janky
│
├─ Symptom? 3D CSS transforms, multiple objects
│  └─ Go to "Animation Performance" sub-tree
├─ Affects UX? YES (noticeable on mobile)
│  └─ Worth investigating
├─ Reproducible? YES (consistent at 10+ plants)
│  └─ Continue
├─ How many items? 20+ → Virtualization needed
│  └─ SOLUTION: Implement memoization + will-change
└─ DECISION: CREATE PERF_ISSUE task
```

**Cost Analysis**:
- Investigation (DevTools profile): 1K tokens
- Memoization implementation: 1K tokens
- Testing on device: 1K tokens
- Total: 3K tokens ($0.009)
- Expected improvement: 30fps → 55fps
- **Decision**: Worth fixing

**Solution Code Pattern**:
```typescript
// Memoize expensive plant component
const Plant3D = React.memo(({ id, stage, animation }) => {
  return (
    <div style={{ willChange: animation ? 'transform' : 'auto' }}>
      {/* 3D rendering */}
    </div>
  );
}, (prev, next) => {
  return prev.id === next.id && prev.stage === next.stage;
});
```

**Prevention**: Profile before building animations, memo React components by default

---

### Pattern: api-call-slow-network

**Scenario**: calm-ai-project-manager - Task list takes 3.5s to load on 3G

**Decision Path**:
```
START: Slow API Call
│
├─ Symptom? > 2s network request
│  └─ Go to "API Performance" sub-tree
├─ Network latency? YES (3G = 300ms baseline)
│  ├─ Check Supabase RLS policies
│  └─ Continue
├─ Database query? YES (N+1 queries?)
│  ├─ Check indexes → Add if missing
│  └─ Continue
├─ Can cache? YES (task list doesn't change often)
│  └─ SOLUTION: Add caching + loading state
└─ DECISION: Implement caching
```

**Cost Analysis**:
- RLS policy review: 0.5K tokens
- Index analysis: 0.5K tokens
- Caching implementation: 1.5K tokens
- Testing: 1K tokens
- Total: 3.5K tokens ($0.01)
- Expected improvement: 3.5s → 800ms
- **Decision**: Worth fixing

**Solution Pattern**:
```typescript
// Add React Query caching
const { data, isLoading } = useQuery({
  queryKey: ['tasks'],
  queryFn: () => api.getTasks(),
  staleTime: 5 * 60 * 1000, // 5 min cache
});
```

**Prevention**: Profile in realistic network conditions, add staleTime to queries

---

## Tree #4: Tech Stack Decision

**Use when**: Choosing which library/tool to use.

### Pattern: state-management-library

**Scenario**: Calm-couples needed state management. Should we use Redux or Zustand?

**Decision Path**:
```
START: Need State Management
│
├─ Does Calm use similar tool? YES (Zustand in other projects)
│  └─ USE EXISTING (consistency)
├─ Learning curve: Zustand 30min vs Redux 4 hours
│  ├─ Zustand ratio: 4x
│  ├─ Redux ratio: 1.5x
│  └─ Pick highest ratio
├─ Bundle size? Zustand ~5KB, Redux ~10KB
│  └─ Both acceptable
└─ DECISION: Zustand (consistency + lighter)
```

**Implementation Pattern**:
```typescript
// Zustand pattern used across all projects
const useGardenStore = create((set) => ({
  plants: [],
  addPlant: (plant) => set((state) => ({
    plants: [...state.plants, plant]
  }))
}));
```

**Why Zustand Across All Projects?**
- Consistency (same API everywhere)
- Lighter bundle (5KB vs 10KB+)
- Learning curve 30min vs 4 hours
- DevTools available but simple

**Decision**: Standardize on Zustand for all new projects

---

### Pattern: testing-framework-choice

**Scenario**: qa-automation needed E2E testing framework

**Decision Path**:
```
START: E2E Testing Framework
│
├─ Does Calm use similar? NO (first qa-automation project)
│  └─ Check Calm standards
├─ Calm standard? YES (Jest + React Testing Library for React)
│  └─ Continue to E2E
├─ For E2E? Playwright (common in qa-automation)
│  └─ USE PLAYWRIGHT
├─ Bundle size? ~100MB (acceptable for test tool)
│  └─ Continue
└─ DECISION: Playwright + Jest (hybrid)
```

**Result**: Playwright for E2E, Jest for unit tests (consistency with calm-couples unit tests)

---

## Tree #5: Test Strategy

**Use when**: Deciding how much to test and at what level.

### Pattern: plant-growth-logic-testing

**Scenario**: Calm-couples - Plant growth calculation logic (complex business logic)

**Decision Path**:
```
START: Writing Tests
│
├─ What's being tested? Critical business logic
│  └─ Write: Unit + Integration (90%+ coverage)
├─ Is this known issue area? YES (plant rendering race conditions)
│  └─ Add regression test
├─ Would test save time? Catches > 5 bugs in 6 months?
│  ├─ YES (plant bugs are expensive)
│  └─ Worth testing
├─ Can be flaky? NO (pure calculation)
│  └─ Safe for test automation
└─ DECISION: Write comprehensive tests
```

**Cost Analysis**:
- Unit tests (logic): 2K tokens
- Integration tests (API): 1.5K tokens
- Coverage: 95%+
- Total: 3.5K tokens ($0.01)
- ROI: Very high (prevent regression bugs)

**Test Pattern**:
```typescript
describe('Plant Growth', () => {
  it('should calculate correct stage for age', () => {
    const stage = calculateGrowthStage(30); // 30 days
    expect(stage).toBe('flowering');
  });

  it('should prevent invalid water values', () => {
    expect(() => updateWater(-1)).toThrow();
  });
});
```

---

### Pattern: ui-component-snapshot-test

**Scenario**: Calm-couples - Button component variations

**Decision Path**:
```
START: Writing Tests
│
├─ What's being tested? UI component rendering
│  └─ Write: Unit + Snapshot (70%+ coverage)
├─ Is this known issue? NO
│  └─ Continue
├─ Would test save time? Catches regression > 5x?
│  ├─ Probably (UI changes frequent)
│  └─ Worth snapshot testing
├─ Can be flaky? Possible (layout, fonts)
│  └─ Use snapshot carefully
└─ DECISION: Snapshot test + unit test
```

**Cost Analysis**:
- Snapshot tests: 1K tokens
- Unit tests: 1K tokens
- Total: 2K tokens ($0.006)
- ROI: Medium (catches regressions)

---

### Pattern: e2e-critical-flow-only

**Scenario**: qa-automation - Test user signup flow

**Decision Path**:
```
START: Writing Tests
│
├─ What's being tested? Critical user flow
│  └─ Write: E2E for happy path only
├─ Is this known issue? NO
│  └─ Continue
├─ Would test save time? YES (signup is critical)
│  └─ Worth testing
├─ Can be flaky? YES (browser timing)
│  └─ Test happy path only, skip edge cases
└─ DECISION: E2E happy path + manual edge case testing
```

**Cost Analysis**:
- E2E happy path: 2K tokens
- Manual edge case testing: 1K tokens
- Total: 3K tokens ($0.009)
- Coverage: ~70% (good for critical flow)
- ROI: High (catches broken signup)

**Pattern**:
```typescript
// E2E happy path only
test('User can sign up and see dashboard', async ({ page }) => {
  await page.goto('/signup');
  await page.fill('input[name="email"]', 'test@example.com');
  await page.fill('input[name="password"]', 'SecurePassword123');
  await page.click('button:has-text("Sign Up")');
  await expect(page).toHaveURL('/dashboard');
});
```

---

## Tree #6: Cost Optimization

**Use when**: Trying to reduce token usage for a task.

### Pattern: documentation-writing-expensive

**Scenario**: Writing feature documentation is taking 15K tokens

**Decision Path**:
```
START: Want to Lower Cost
│
├─ Is cost > 10K? YES (15K)
│  └─ Can break into 2+ tasks? YES
│      ├─ Task 1: Quick start (3K)
│      ├─ Task 2: Architecture (4K)
│      └─ Task 3: API reference (3K)
├─ Will task repeat? YES (document other features)
│  └─ Invest in templates
│  └─ Future tasks: 8K (save 40%)
├─ Are you exploring or implementing?
│  └─ IMPLEMENTING → Use full context
└─ DECISION: Split + create template
```

**Cost Analysis**:
- Initial task broken into 3 × 5K: 15K (same)
- Benefit: Can tackle one section at a time
- With template: Future docs ~8K (save 7K per doc)
- ROI: Breaks even after 2 docs

**Template Pattern** (speeds up future docs by 40%):
```markdown
# [Feature Name]

## Overview
[1-2 sentences about what this does]

## Quick Start
[Copy-paste code to use immediately]

## Architecture
[How it works internally]

## Common Issues
[Frequent problems + solutions]

## Cost
[Token usage estimate]
```

---

### Pattern: exploration-reading-too-much

**Scenario**: Reading 8 full files to understand component structure (12K tokens)

**Decision Path**:
```
START: Want to Lower Cost
│
├─ Are you exploring or implementing?
│  └─ EXPLORING → Use aggressive limiting
├─ Read strategy:
│  ├─ Use grep first (find relevant files): 0.5K
│  ├─ Sample only (head -30): 1K
│  ├─ Read full only if necessary: 5K
│  └─ Total: 6.5K (vs 12K unguided)
└─ DECISION: Apply limiting
```

**Cost Reduction Pattern**:
```bash
# EXPENSIVE: Read all files (12K tokens)
❌ Read component1.ts (full)
❌ Read component2.ts (full)
❌ Read component3.ts (full)

# EFFICIENT: Guided search (6.5K tokens)
✅ Grep for "export" to find exports: 0.3K
✅ Head -30 on 3 files to understand structure: 1K
✅ Full read on critical file only: 2K
✅ Write needed file: 3.2K
Total: 6.5K (46% savings)
```

**Lesson**: Ask specifically → Use grep → Sample → Read full only if needed

---

## Common Anti-Patterns

### Anti-Pattern: Skipping Decision Trees

**Problem**: "This seems simple, I'll just decide"

**Result**:
- Same decision made multiple ways in different projects
- Inconsistency causes bugs
- Tech debt accumulates

**Fix**: Follow Decision Tree even for "obvious" choices

---

### Anti-Pattern: Over-Testing

**Problem**: "I'll test every edge case"

**Result**:
- Tests take 20K tokens for 2K feature
- Tests become brittle and flaky
- Maintenance burden increases

**Fix**: Use Test Strategy tree. Test critical paths only.

---

### Anti-Pattern: Ignoring Cost

**Problem**: "We'll build it, then optimize"

**Result**:
- Task takes 15K tokens instead of 6K
- Technical debt accumulates
- Harder to refactor later

**Fix**: Use Cost Optimization tree BEFORE building

---

### Anti-Pattern: Wrong Database Indexes

**Problem**: "Database is slow, must be RLS policy"

**Result**:
- Waste 5K tokens debugging wrong thing
- Real issue: missing index
- Fix is 0.5K tokens

**Fix**: Use Performance tree. Check indexes first.

---

## Quick Lookup

### By Decision Type

| Decision | Tree # | When to Use | Cost |
|----------|--------|-----------|------|
| Build feature? | #1 | Feature request comes in | 2-5K |
| Fix bug priority? | #2 | Bug report comes in | 1-3K |
| Slow operation? | #3 | Performance complaint | 2-5K |
| Library choice? | #4 | Need new tool/lib | 1-2K |
| How much testing? | #5 | Writing tests | 1-5K |
| Save tokens? | #6 | Cost is too high | 0-3K |

### By Project

**calm-couples:**
- Feature decisions (dark mode skip, GDPR build)
- Performance (plant animation, render optimization)
- Testing (plant logic unit tests, UI snapshots)

**qa-automation:**
- Test strategy (E2E vs unit, happy path only)
- Multi-browser support decision
- Flaky test handling

**calm-ai-project-manager:**
- API performance optimization
- Task prioritization
- Cache strategy

### By Cost Target

**Ultra-low cost (<3K tokens)**:
- Use Tree #6 aggressively
- Grep before read
- Sample only
- Example: Quick bug fix + test

**Medium cost (5-8K tokens)**:
- Split large tasks (Tree #1, #6)
- Thorough testing (Tree #5)
- Example: Feature implementation + tests

**High cost (10K+ tokens)**:
- Reconsider scope (Tree #1)
- Break into phases (Tree #6)
- Use templates (Tree #6)
- Example: Large feature + documentation

---

## Contributing New Patterns

When you discover a recurring decision:

1. **Document the scenario** (project + situation)
2. **Map to Decision Tree** (which tree applies?)
3. **Record the decision path** (questions answered)
4. **Include cost analysis** (actual tokens spent)
5. **Note lessons learned** (what prevented mistakes)
6. **Add to this guide** (update Pattern Library)

---

## See Also

- [DECISION_TREES.md](DECISION_TREES.md) - Detailed decision frameworks
- [AI_QUICKSTART.md](../AI_QUICKSTART.md) - Quick reference for AI agents
- [TOKEN_EFFICIENCY.md](../TOKEN_EFFICIENCY.md) - Deep cost optimization
- Project AGENTS.md files - Project-specific patterns

---

**Version**: 1.0 | **Last Updated**: 2025-11-01 | **Review**: Quarterly
