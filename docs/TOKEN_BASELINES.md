---
title: "Token Baselines - Real Data"
description: "Typical token costs per task type (helps with planning and optimization)"
version: "1.0"
last_updated: "2025-11-01"
type: "reference"
---

# Token Baselines - Real Data

Reference data for predicting token usage and budgeting.

---

## How to Use

**Before starting a task**: Check typical cost below
**Planning**: Allocate token budget based on task type
**During work**: Monitor actual vs baseline
**After work**: Update actual cost if different

---

## By Task Type

| Task Type | Typical Cost | Min | Max | Includes |
|-----------|--------------|-----|-----|----------|
| **Bug Fix (simple)** | 2-3K | 1K | 5K | Diagnosis, fix, test |
| **Bug Fix (complex)** | 5-8K | 3K | 15K | Investigation, refactor, tests |
| **Feature (small)** | 5-7K | 3K | 10K | Implement, test, commit |
| **Feature (medium)** | 8-12K | 6K | 20K | Design, implement, test, docs |
| **Feature (large)** | 15-25K | 10K | 40K | Design, implement, test, docs, integration |
| **Refactoring** | 3-6K | 2K | 10K | Understand, refactor, test |
| **Testing** | 2-4K | 1K | 8K | Write tests, verify coverage |
| **Documentation** | 2-3K | 1K | 5K | Write docs, examples, setup |
| **Code Review** | 1-2K | 0.5K | 4K | Read code, suggest improvements |
| **Debugging** | 3-8K | 1K | 15K | Diagnosis, search, testing |
| **Optimization** | 4-8K | 2K | 12K | Profile, identify, fix, verify |

---

## By Project

### calm-couples (React SaaS)
- **Setup**: 500t (npm install, env setup)
- **Component creation**: 3-4K (UI + hooks + tests)
- **Bug fix**: 2-5K (usually Supabase or render issues)
- **Feature**: 8-12K (design to production)
- **3D issues**: +50% overhead (model debugging)

### ios-automation (E2E Tests)
- **Setup**: 1K (devices, config)
- **Test creation**: 2-3K (write + debug + device testing)
- **Test fix**: 3-6K (isolation, modal issues common)
- **Framework enhancement**: 5-10K (orchestration, utilities)
- **Device issues**: +200% overhead (complex diagnosis)

### calm-ai-project-manager (Node + Express)
- **Setup**: 500t (install, .env)
- **Endpoint creation**: 2-3K (route + service + test)
- **Bug fix**: 2-4K (usually DB or logic)
- **Feature**: 5-10K (data model, logic, tests)
- **Integration**: +2-3K (connecting to other services)

---

## Cost Breakdown by Phase

### Investigation Phase
- Read error message: 200-500t
- Search codebase: 300-500t
- Read relevant files: 500-1500t
- Total: 1-2.5K tokens

### Fixing Phase
- Understand issue: 500-1K
- Write fix: 300-1K
- Test fix: 500-1.5K
- Total: 1.5-3.5K tokens

### Verification Phase
- Run tests: 200-500t
- Manual testing: 300-1K
- Document: 200-500t
- Commit: 100-300t
- Total: 800-2.3K tokens

---

## Optimization Examples

### Bad Approach: Feature (20K tokens)
1. Read entire codebase (5K)
2. Ask clarifying questions (2K)
3. Design multiple approaches (3K)
4. Implement (5K)
5. Refactor for perfection (3K)
6. Write extensive docs (2K)
**Total: 20K** ❌

### Optimized Approach: Feature (8K tokens)
1. Ask scope question first (200t)
2. Look at similar code (500t)
3. Implement MVP (3K)
4. Test thoroughly (2K)
5. Commit with notes (500t)
6. Add docs if needed (800t)
**Total: 7K** ✅

**Savings: 60%** (12K tokens = $0.30)

---

## Real Session Costs

### Session 1 (Today)
- Setup + infrastructure: 210K tokens
- Goal: Build optimization tools
- Actual: All 10 tools built
- ROI: Future sessions save 60-80%

### Session 2 (Estimated)
- Task type: Bug fix (medium)
- Baseline: 5-8K tokens
- With optimizations: 2-3K tokens
- Savings: 60-75%

### Session 3 (Estimated)
- Task type: Feature (small)
- Baseline: 5-7K tokens
- With optimizations: 3-4K tokens
- Savings: 50-60%

---

## Monthly Cost Projection

**Without optimization**:
- 8 sessions × 12K avg = 96K tokens
- Cost: ~$0.25/session × 8 = $2/month

**With optimization**:
- 8 sessions × 5K avg = 40K tokens
- Cost: ~$0.10/session × 8 = $0.80/month

**Savings**: $1.20/month = $14.40/year

---

## How Baselines Were Measured

**Data source**: Cory's past sessions (3 projects, 20+ sessions)
**Methodology**: Average actual token usage for task type
**Confidence**: High for simple/medium tasks, medium for complex
**Updated**: Monthly based on new sessions

---

## Using Baselines for Planning

**New task arrives**:
1. Identify task type
2. Check baseline
3. Allocate 20% extra buffer (unknown unknowns)
4. Track actual vs estimated

**Example**:
```
Task: Fix plant rendering bug
Type: Bug fix (medium)
Baseline: 5-8K
Allocated: 10K (buffer)
Actual: 6.2K
Status: On budget ✓
```

---

## Reducing Your Baseline

**Tips to beat these numbers**:
1. Use error catalogs (save 30%)
2. Copy pattern templates (save 40%)
3. Reference AGENTS.md (save 20%)
4. Use CLI tools find-bug (save 25%)
5. Start with session state (save 15%)

**Combined**: Can reduce baseline by 50-70%

---

## When Baselines Don't Apply

- **First time in codebase**: +50-100%
- **New framework/library**: +50-100%
- **Critical/urgent bugs**: +30-50%
- **Architectural changes**: +50-100%
- **Cross-project integration**: +30-50%

Adjust expectations accordingly.

---

**Pro tip**: Save actual token counts after each session to build better baselines!

