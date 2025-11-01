---
title: "Shared Decision Trees"
description: "Systematic decision-making frameworks for Calm projects"
version: "1.0"
last_updated: "2025-11-01"
---

# Shared Decision Trees

Systematic frameworks for consistent decision-making across calm-couples, calm-ai-project-manager, and qa-automation.

---

## 1. Feature Development: Build or Skip?

**Use when**: Deciding whether to implement a requested feature.

```
START: Feature Request
│
├─ Is it a user-blocking issue?
│  ├─ YES → BUILD (priority)
│  └─ NO → Continue
│
├─ Does it align with core product mission?
│  ├─ YES → Continue
│  └─ NO → SKIP (document reason)
│
├─ Token cost estimate < 5K?
│  ├─ YES → Continue
│  └─ NO → Break into smaller features
│
├─ Can existing users do 80% of this with current features?
│  ├─ YES → SKIP (consider UX improvement instead)
│  └─ NO → Continue
│
├─ Would this create technical debt?
│  ├─ YES → Plan cleanup task → BUILD
│  └─ NO → Continue
│
└─ DECISION: BUILD → Create task → Track costs
```

**Example**:
- Feature: "Dark mode toggle"
  - Blocking? No
  - Aligns with mission? Yes (UX improvement)
  - < 5K tokens? Yes (2K estimated)
  - Can users work around it? Yes (use browser dark mode)
  - Tech debt? No
  - **Decision**: SKIP (low priority, high user workaround)

---

## 2. Bug Priority: Critical vs Nice-to-Have?

**Use when**: Triaging bugs to determine what to fix first.

```
START: Bug Report
│
├─ Is it a production blocker? (user can't use app)
│  ├─ YES → CRITICAL (fix today)
│  └─ NO → Continue
│
├─ Does it affect multiple users?
│  ├─ YES → HIGH
│  └─ NO → Continue
│
├─ Is there a simple workaround?
│  ├─ YES → MEDIUM (document workaround)
│  └─ NO → Continue
│
├─ Will this get worse if ignored? (e.g., data corruption)
│  ├─ YES → HIGH (fix soon)
│  └─ NO → Continue
│
├─ Fix cost < 3K tokens?
│  ├─ YES → MEDIUM (acceptable cost)
│  └─ NO → LOW (defer until next sprint)
│
└─ DECISION: Log priority + create task
```

**Priority Levels**:
- 🔴 CRITICAL: Production down, data at risk, multi-user impact
- 🟠 HIGH: Affects specific user group, no workaround
- 🟡 MEDIUM: Workaround exists, ~3K token fix cost
- 🟢 LOW: Edge case, high fix cost, defer to later

---

## 3. Performance Issue: Debug or Accept?

**Use when**: Investigating slow operations or janky animations.

```
START: Performance Complaint
│
├─ What's the symptom?
│  ├─ Slow API call (>2s)?
│  │  ├─ YES → Go to "API Performance" tree
│  │  └─ NO → Continue
│  ├─ Janky animation?
│  │  ├─ YES → Go to "Animation Performance" tree
│  │  └─ NO → Continue
│  └─ Other?
│     └─ Go to "Generic Perf" tree
│
├─ Does it affect user experience?
│  ├─ YES → Continue (worth investigating)
│  └─ NO → ACCEPT (not critical)
│
├─ Is this a known pain point?
│  ├─ YES → Reference PROJECT_PAIN_POINTS.md
│  └─ NO → Continue
│
├─ Can you reproduce it?
│  ├─ YES → Continue
│  └─ NO → ACCEPT (intermittent, low priority)
│
└─ DECISION: CREATE PERF_ISSUE task → Investigate
```

### API Performance Sub-tree

```
API Call > 2 seconds?
│
├─ Is it network latency?
│  ├─ YES → Can't optimize locally
│  │       Check Supabase status/RLS policies
│  └─ NO → Continue
│
├─ Is it a database query?
│  ├─ YES → N+1 query? Check indexes
│  └─ NO → Continue
│
├─ Is it external API (Stripe, etc)?
│  ├─ YES → Contact vendor support
│  └─ NO → Continue
│
└─ SOLUTION: Add caching + loading state
```

### Animation Performance Sub-tree

```
Animation janky (< 60fps)?
│
├─ How many items?
│  ├─ 1-5? → Use React.memo
│  ├─ 5-20? → Add will-change CSS
│  └─ 20+? → Virtualization required
│
├─ CSS 3D transforms?
│  ├─ YES → Reduce transforms + memoize
│  └─ NO → Check state updates
│
└─ SOLUTION: Implement optimization → Measure (DevTools)
```

---

## 4. Tech Stack Decision: Library X vs Library Y?

**Use when**: Deciding which tool/library to use for a task.

```
START: Need Library for Task
│
├─ Does Calm already use similar tool?
│  ├─ YES → USE EXISTING (consistency)
│  └─ NO → Continue
│
├─ Is there a "Calm standard"?
│  ├─ YES → USE STANDARD
│  │       (React Query for data, Zustand for state, etc)
│  └─ NO → Continue
│
├─ Check TOKEN_EFFICIENCY for recommendations?
│  ├─ YES, documented? → USE RECOMMENDED
│  └─ NO → Continue
│
├─ Compare: Learning curve vs time saved
│  ├─ Library A: 30 min learn, 2 hours save → RATIO 4:1
│  ├─ Library B: 2 hours learn, 3 hours save → RATIO 1.5:1
│  └─ Pick highest ratio (usually existing tool)
│
├─ Check bundle size impact?
│  ├─ < 5KB gzip? → Continue
│  ├─ 5-20KB gzip? → Acceptable for heavy lifting
│  └─ > 20KB gzip? → REJECT (too large)
│
├─ Does it have good DevTools/debugging?
│  ├─ YES → Continue
│  └─ NO → CONSIDER ALTERNATIVE
│
└─ DECISION: Document choice + add to standards doc
```

**Calm Standards** (use these first):
- **State**: Zustand (all projects)
- **Data Fetching**: React Query (React projects)
- **API Client**: TBD (calm-ai-pm uses custom)
- **Styling**: Tailwind CSS (React SaaS)
- **Testing**: Jest + React Testing Library (React)

---

## 5. Test Strategy: How Much Testing?

**Use when**: Deciding what level of test coverage to implement.

```
START: Writing Tests
│
├─ What's being tested?
│  ├─ Critical business logic?
│  │  └─ Write: Unit + Integration (90%+ coverage)
│  ├─ UI component?
│  │  └─ Write: Unit + Snapshot (70%+ coverage)
│  └─ E2E user flow?
│     └─ Write: E2E for happy path only
│
├─ Is this a known issue area?
│  ├─ YES → Add regression test + docs
│  └─ NO → Continue
│
├─ Would test save time in future?
│  ├─ Catch: > 5 bugs over 6 months?
│  │  └─ YES → Worth testing
│  ├─ Maintenance: Low (< 1 hour/month)?
│  │  └─ Continue
│  └─ NO → SKIP (high maintenance cost)
│
├─ Can test be flaky? (timing, device-specific)
│  ├─ YES → Don't E2E test
│  │       Use unit test instead
│  └─ NO → Continue
│
└─ DECISION: Write test at appropriate level
```

**Test Levels** (cost vs confidence):

| Level | Cost | Confidence | Use For |
|-------|------|-----------|---------|
| Unit | 50 tokens | 60% | Logic, utilities, edge cases |
| Integration | 150 tokens | 80% | API calls, store updates |
| E2E | 300+ tokens | 95% | Critical user flows |
| Manual | 100 tokens | 70% | Edge cases, UI feel |

---

## 6. Cost Optimization: Where to Save Tokens?

**Use when**: Trying to reduce token usage for a task.

```
START: Want to Lower Cost
│
├─ Is cost > 10K tokens?
│  ├─ YES → Can you break into 2 smaller tasks?
│  │       Often YES → Split it up
│  └─ NO → Continue
│
├─ Will the task repeat?
│  ├─ YES → Invest in patterns/templates (one-time cost)
│  │       These save 30-50% on future similar work
│  └─ NO → Continue
│
├─ Are you exploring or implementing?
│  ├─ EXPLORING → Use aggressive limiting:
│  │             grep before read, sample first
│  ├─ IMPLEMENTING → Use full context:
│  │                 builds, tests, detailed output
│  └─ Continue
│
├─ Check TOKEN_EFFICIENCY.md for your task type?
│  ├─ YES → Apply recommended strategies
│  └─ NO → Use generic optimization
│
├─ Could you use async tools?
│  ├─ YES (webhook, queue) → Implement → Save 20-30%
│  └─ NO → Continue
│
└─ DECISION: Apply optimization → Measure cost
```

**Quick Wins** (usually save 30-50%):
1. 🎯 Ask specific questions before reading
2. 🎯 Use grep before read
3. 🎯 Sample first, read specific sections
4. 🎯 Suppress verbose output
5. 🎯 Use existing patterns/templates

---

## 7. Device Debugging: Test Local or Device?

**Use when**: Need to debug issue that might be device-specific (qa-automation).

```
START: Have Debugging Task
│
├─ Is it a web app issue? (HTML/CSS/JS)
│  ├─ YES → Test on local browser first
│  │       Use DevTools (faster, cheaper)
│  └─ NO → Continue
│
├─ Is it mobile-specific?
│  ├─ Touch gestures?
│  │  └─ YES → Device required
│  ├─ Viewport size?
│  │  └─ Maybe (can test with browser responsive mode)
│  └─ Continue
│
├─ Is it a native feature? (camera, geolocation, etc)
│  ├─ YES → Device required
│  └─ NO → Continue
│
├─ Can you mock the issue?
│  ├─ YES → Mock it → Test locally → Save 200% cost
│  └─ NO → Continue
│
├─ Device debugging cost > 5K?
│  ├─ YES → Plan it carefully
│  │       Minimize back-and-forth
│  └─ Continue
│
└─ DECISION: Local first → Device only if needed
```

**Cost Breakdown** (qa-automation):
- Local debugging: 1-2K tokens
- Device debugging: +200% overhead (4-6K+ tokens)
- **Implication**: Test locally first, device as last resort

---

## 8. GDPR / Data Handling: How to Handle User Data?

**Use when**: Working with user data (calm-couples, calm-ai-pm).

```
START: Working with User Data
│
├─ Could this expose PII?
│  ├─ YES → Use RLS policies (Supabase)
│  │       Log all access
│  │       Document why you need access
│  └─ NO → Continue
│
├─ Could user request deletion?
│  ├─ YES → Implement cascade delete
│  │       Test deletion flow
│  │       Document in GDPR section
│  └─ NO → Continue
│
├─ Are you storing auth tokens?
│  ├─ YES → NEVER log tokens
│  │       Use .env or secrets manager
│  │       Rotate periodically
│  └─ NO → Continue
│
├─ Is this a database migration?
│  ├─ YES → Backup first
│  │       Test on staging
│  │       Have rollback plan
│  └─ NO → Continue
│
└─ DECISION: Implement safely → Document → Review with team
```

---

## 9. Refactoring: When to Refactor vs Keep Going?

**Use when**: Tempted to refactor code.

```
START: Found Code to Refactor
│
├─ Is it blocking current work?
│  ├─ YES → Refactor as part of task
│  └─ NO → Continue
│
├─ Is it a known pain point?
│  ├─ YES → Schedule refactor task
│  └─ NO → Continue
│
├─ Would refactor reduce future token cost?
│  ├─ > 20% savings? → Refactor (invest time)
│  ├─ 10-20% savings? → Document + defer
│  └─ < 10% savings? → SKIP (not worth it)
│
├─ Is code actively being changed?
│  ├─ YES → Refactor (reduce future conflicts)
│  └─ NO → DEFER (no urgency)
│
├─ Refactor cost < 2K tokens?
│  ├─ YES → Do it
│  └─ NO → HIGH COST (skip for now)
│
└─ DECISION: Refactor or Document + Defer
```

---

## 10. Documentation: When to Document?

**Use when**: Deciding how much to document.

```
START: Should You Document This?
│
├─ Is it project setup? (new developer onboarding)
│  ├─ YES → Document thoroughly (saves hours)
│  └─ NO → Continue
│
├─ Is it a known pain point?
│  ├─ YES → Document solution (prevents future bugs)
│  └─ NO → Continue
│
├─ Would docs reduce future token costs?
│  ├─ YES → Document (see TOKEN_EFFICIENCY.md)
│  └─ NO → Continue
│
├─ Is this a common question?
│  ├─ Answered same question 2+ times?
│  │  └─ YES → Document it
│  └─ NO → Continue
│
├─ Does it take < 15 min to write?
│  ├─ YES → Document it
│  └─ NO → Document summary only
│
└─ DECISION: Document strategically
```

**Good Documentation Candidates**:
- Setup/onboarding
- Common errors + solutions
- Performance optimization techniques
- Architecture decisions
- Known issues + workarounds

---

## Using These Trees

### Workflow
1. **Identify the decision** being made
2. **Find matching tree** in this document
3. **Follow the path** answering each question
4. **Reach decision** at the end
5. **Document why** you chose this path

### Example
```
Decision: Should we add caching to API responses?

Tree: Performance Issue (Decision Tree #3)
├─ Symptom: Slow API call > 2s
├─ Affects UX: YES
├─ Reproduce it: YES
└─ Decision: CREATE PERF_ISSUE task

Then use Sub-tree: API Performance
├─ Is it network latency? YES (Supabase)
└─ Solution: Add caching + loading state

Implementation: Add Redis cache layer
Cost: 4K tokens
Expected savings: 200-300ms per request
```

---

## Adding New Trees

To add a decision tree for recurring decisions:

1. **Identify pattern**: What decision do you keep making?
2. **Document path**: What questions lead to decision?
3. **Add to this file**: Include tree diagram
4. **Reference**: Link from relevant places (AGENTS.md, etc)
5. **Test it**: Use the tree on 3 actual decisions
6. **Refine**: Adjust based on feedback

---

## See Also

- [AGENTS.md](../projects/calm-couples/AGENTS.md) - Project-specific guidance
- [TOKEN_EFFICIENCY.md](../docs/cost-optimization/TOKEN_EFFICIENCY.md) - Cost optimization
- [PROJECT_PAIN_POINTS.md](PROJECT_PAIN_POINTS.md) - Known issues
- Project READMEs - Cost baselines per project

---

**Version**: 1.0 | **Last Updated**: 2025-11-01 | **Reviewed**: Every feature/month
