---
title: "AI Agent Improvements Roadmap"
description: "Features that would help AI agents work smarter (token savings, speed, accuracy)"
version: "1.0"
last_updated: "2025-11-01"
status: "planning"
---

# AI Agent Improvements Roadmap

**Goal**: Reduce token usage per task from ~60K → ~10K (83% reduction)
**Focus**: Speed, searchability, accuracy, self-guided decision-making

---

## 🎯 Priority 1: Decision Trees (15-20 tokens saved per task)

**What**: "When to do X vs Y" flowcharts for common decisions

**Examples needed**:
- [ ] Refactor vs Rewrite (code quality matrix)
- [ ] Add tests vs Fix bugs (priority matrix)
- [ ] Optimize vs Ship (timeline vs quality tradeoff)
- [ ] Token optimization (when worth it vs not)
- [ ] PR strategy (squash vs keep commits)

**Format**: Markdown flowcharts or decision matrices
**Location**: `.claude/decision-trees/` directory
**Impact**: 100-200 tokens per decision avoided

---

## 🎯 Priority 2: AGENTS.md in All Projects (50+ tokens saved per project)

**What**: Quick guidance file in each project root

**Status**:
- [x] Template created: `projects/AGENTS.md.template`
- [x] Copy to calm-couples/AGENTS.md
- [x] Copy to qa-automation/AGENTS.md
- [x] Copy to calm-ai-project-manager/AGENTS.md
- [x] Customize for each project

**Each includes**:
- Entry points (where to start)
- Common tasks (bug fix, add feature, run tests)
- Code patterns (logging, testing, error handling)
- Directory structure
- Common issues & solutions

**Impact**: Eliminates 500+ tokens of exploration per project visit

---

## 🎯 Priority 3: Pattern Library (80-150 tokens saved per feature)

**What**: Copy-paste templates for common code patterns

**Templates needed**:
- [ ] Todo list structure (markdown template)
- [ ] Logging patterns (per language/framework)
- [ ] Test skeletons (unit, integration, E2E)
- [ ] Error handling (try/catch patterns)
- [ ] API endpoint patterns
- [ ] React component skeleton
- [ ] Database query patterns

**Location**: `docs/patterns/` directory
**Format**: Standalone `.md` files with code examples
**Impact**: 500-1000 tokens saved per feature creation

---

## 🎯 Priority 4: Decision Trees Expanded (Decision-making automation)

**Specific trees needed**:
- [ ] Code review checklist (what to look for)
- [ ] Debugging flowchart (how to diagnose issues)
- [ ] Performance optimization (when/where to optimize)
- [ ] Test strategy (unit vs integration vs E2E)
- [ ] Refactoring decision tree (when it's safe)

**Format**: Mermaid diagrams + markdown explanation
**Location**: `.claude/decision-trees/`
**Impact**: Prevents 500+ tokens of wrong decisions

---

## 🎯 Priority 5: Session State File (Reduces cold-start by 20-30%)

**What**: Track current work, blockers, latest context

**File**: `.claude/session-state.json` (gitignored, auto-updated)

**Tracks**:
- [ ] Current task/PR
- [ ] Blockers preventing progress
- [ ] Recent file changes
- [ ] Current test suite status
- [ ] Latest commit hash
- [ ] Known issues to watch for

**Format**: JSON with timestamps
**Impact**: Eliminates 1-2K tokens of "where were we?" context gathering

---

## 🎯 Priority 6: Token Cost Baseline Data (Enables smart optimization)

**What**: Real numbers on typical token costs per task type

**Baselines needed**:
- [ ] Feature creation: X tokens (with breakdown)
- [ ] Bug fix: X tokens (with breakdown)
- [ ] Refactoring: X tokens (with breakdown)
- [ ] Test writing: X tokens (with breakdown)
- [ ] Documentation: X tokens (with breakdown)

**Format**: `docs/TOKEN_BASELINES.md`
**Data**: Include min/max/average with examples
**Impact**: Enables predictive planning, prevents over-engineering

---

## 🎯 Priority 7: Integration Map (Saves debugging time)

**What**: How the 3 Calm projects connect to each other

**Map shows**:
- [x] calm-couples ←→ calm-ai-project-manager (data flow)
- [x] calm-ai-project-manager ←→ qa-automation (test data)
- [x] calm-couples ←→ qa-automation (what's tested)

**Format**: Mermaid diagram + CSV dependency list
**Location**: `docs/INTEGRATION_MAP.md`
**Impact**: 200-300 tokens saved on integration questions

---

## 🎯 Priority 8: Error Catalog (Diagnosis time reduction)

**What**: Common bugs in each project + solutions

**Structure per project**:
```
Problem: [Error message or symptom]
Root cause: [Why it happens]
Solution: [How to fix]
Prevention: [How to avoid]
File: [Where it usually occurs]
```

**Location**: `{PROJECT}/docs/ERROR_CATALOG.md`
**Examples**: 5-10 per project
**Impact**: 300-500 tokens saved per debugging session

---

## 🎯 Priority 9: Config Templates (Formatting time reduction)

**What**: Reference configs so new files are formatted correctly first time

**Configs needed**:
- [ ] `.eslintrc.json` (preferred rules)
- [ ] `tsconfig.json` (strict mode setup)
- [ ] `jest.config.js` (test configuration)
- [ ] `.prettierrc` (formatting)
- [ ] `vitest.config.ts` (if using Vitest)

**Location**: `.claude/config-templates/`
**Format**: JSON/JS with comments explaining each setting
**Impact**: Prevents 100-200 tokens of "why is linting failing?" fixes

---

## Implementation Order

**Phase 1 (This session)**: AGENTS.md templates
**Phase 2 (Next)**: Decision trees (quick wins, high impact)
**Phase 3**: Pattern library (copy-paste templates)
**Phase 4**: Integration map + error catalogs
**Phase 5**: Token baselines + session state + config templates

---

## Estimated Token Savings

| Feature | Per-Use Savings | Annual Impact |
|---------|-----------------|---------------|
| Decision trees | 100-200t | Massive |
| AGENTS.md | 50-100t | Per project visit |
| Pattern library | 500-1000t | Per feature |
| Session state | 1000-2000t | Per session cold-start |
| Token baselines | 200-500t | Planning decisions |
| Integration map | 200-300t | Per integration Q |
| Error catalog | 300-500t | Per bug hunt |
| Config templates | 100-200t | Per new file |

**Total potential**: 2000-5000 tokens saved per typical session = 67-83% reduction

---

## Current Status

✅ Done:
- AGENTS.md template created
- Quick-index.json updated with requirements

⏳ Planned:
- [ ] Decision trees (3-5 flowcharts)
- [ ] Pattern library templates
- [ ] Integration map
- [ ] Error catalogs

---

## Notes

- These are **force multipliers** - small effort, huge token savings
- Focus on **most common tasks** first (bug fixes, feature creation)
- Template-first approach (don't over-engineer)
- Each addition should be <500 tokens to document
- Update as patterns emerge

