---
title: "Cory's Master Learnings - Quick Summary"
description: "Essential knowledge in 5-min read (380 lines)"
version: "1.0"
last_updated: "2025-11-01"
type: "reference"
audience: ["ai-agents"]
---

# Cory's Master Learnings - Summary Edition

**Read this for 80% of what you need. See [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) for full details.**

---

## ⚡ TL;DR - The 5 Rules

1. **Todo Lists** → For 2+ steps, use TodoWrite BEFORE starting
2. **Complete Code** → Zero TODOs left in implementation
3. **Test Always** → Zero failing tests, run and verify
4. **Work Alone** → Don't ask permission for standard tasks
5. **Structured Logs** → No console.log, use logger

---

## 🚨 CRITICAL: Must/Never Do

### MUST DO
- Create todo list for any 2+ step task (BEFORE starting)
- Complete implementations - NO TODOs in code
- Run tests - verify they pass (zero failures tolerated)
- Work autonomously (no permission per step)
- Be honest about broken things
- Use structured logger (not console.log)
- Mark exactly ONE todo in_progress
- Mark todos completed IMMEDIATELY (no batching)

### NEVER DO
- Leave TODOs or placeholders in code
- Ask "should I start?" or "should I run tests?"
- Over-explain decisions
- Hide broken tests or failures
- Use console.log for logging
- Have multiple todos in_progress
- Batch todo completions

### ✅ BUT: Templates are OK if TODOs are obvious
**Smart approach to starting features**:
- Start with clear template + visible TODOs
- Mark incomplete sections: `// TODO: [feature-name] - [what's missing]`
- List TODOs in commit message or PR
- Each completed piece must be finished (not partial)
- Don't hide what's pending - make it obvious

---

## 🤔 When to Ask (Smart Balance)

### ALWAYS Ask When
- Destructive operations (delete, drop, force push)
- Breaking changes to other systems
- Requirements are ambiguous
- Multiple valid approaches with tradeoffs
- About production code changes
- Request conflicts with documented patterns

### DON'T Ask When
- Following documented patterns
- Running tests and fixing failures
- Standard refactoring in scope
- Following established workflows
- Answers are in the learnings

---

## 💬 Communication Decoder

| Cory Says | You Do |
|-----------|--------|
| "do it" | Implement fully, complete solution |
| "be critical" | Honest assessment, find all issues |
| "continue"/"keep going" | Keep working autonomously |
| "do next todo" | Use judgment, work through list |
| "keep localhost running" | Don't interrupt dev server |
| "be thorough" | Add extra validation/checks |
| "think about..." | Analyze, provide perspective |

---

## 📋 Todo List Pattern

```yaml
When:      ANY 2+ step task
Tool:      TodoWrite (not markdown)
Timing:    BEFORE starting work
Status:    Only ONE in_progress at a time
Updates:   Mark completed IMMEDIATELY
Batching:  Never (one at a time)
Ordering:  Priority order (important first)
Cleanup:   Save pending to ACTIVE_TODOS.md at session end
```

**Example**:
```
1. [in_progress] Implement user auth
2. [pending] Add password reset
3. [pending] Write tests
4. [pending] Deploy to staging
```

---

## ✅ Quality Standards

| Metric | Standard | Action |
|--------|----------|--------|
| Test Coverage | 98% | Run tests, verify before committing |
| Failing Tests | 0 | Must pass all before submitting |
| TypeScript | Strict mode, no `any` | Enable strict, fix all errors |
| Code TODOs | 0 | Complete implementations only |
| Git Commits | Meaningful messages | Use present tense, explain why |
| Logging | Structured logger | NO console.log |

---

## 🎯 Code Quality - The Trio

### 1. Do This Yourself
- Complete implementations → NO "do this" TODOs
- When Cory says "do it", provide full solution
- Don't leave partial implementations
- Include all edge cases

### 2. Be Critical and Continue
- Identify issues → fix them
- Don't hide problems
- When blocked → find workaround, report issue
- Autonomous problem-solving (then report)

### 3. Test All and Make Sure OK
- Run test suite before every commit
- Verify all pass (zero tolerance)
- Add tests for new features
- Document why tests matter

---

## 🛠️ Technical Preferences

### Stack
- **Frontend**: React 19 + TypeScript + Tailwind
- **Backend**: Node.js + Express + Prisma
- **Database**: Supabase / SQLite
- **Language**: TypeScript (strict mode)
- **Testing**: Jest + E2E (Appium/IDB)
- **AI**: Claude 3.5 for generation

### Tools & Repos
- **Projects**: ~/Desktop/calm/ (calm-couples, ios-automation, calm-ai-project-manager)
- **Learnings**: ~/cory-learnings
- **Git**: Main branch is primary, feature branches for work
- **Scripts**: Use bash with proper error handling

---

## 📁 Projects (Quick Reference)

### calm-couples
- **Type**: React SaaS + Supabase
- **Stack**: React 19, TypeScript, Tailwind, Supabase
- **Focus**: Relationship wellness platform, 3D plants
- **Status**: MVP complete, production-ready
- **Tests**: 63 tests, 98% coverage

### ios-automation
- **Type**: E2E Testing Framework
- **Stack**: IDB, Appium, Tesseract, Vision AI
- **Focus**: Calm iOS app test automation
- **Status**: Framework validated (8/10), tests in progress
- **Tests**: 648 unit tests passing

### calm-ai-project-manager
- **Type**: Internal Tool
- **Stack**: Node.js, Express, Prisma, SQLite, Claude 3.5
- **Focus**: AI-powered task management
- **Status**: v1.1.0 production
- **Features**: Task management, RCI matrix, knowledge base

---

## 💡 Patterns That Work

### For Features
1. Plan with Todo list (if 2+ steps)
2. Implement with complete code (no placeholders)
3. Test thoroughly (run full suite)
4. Commit with clear message
5. Report status

### For Bugs
1. Create todo list for investigation
2. Understand root cause
3. Fix (not workaround)
4. Test fix
5. Document why it broke

### For Refactoring
1. Verify tests pass first
2. Small, focused changes
3. Run tests after each change
4. Commit per logical change
5. Verify impact

---

## 🎓 What Works Best

- **Autonomous** decisions with clear reasoning
- **Complete** implementations (not templates)
- **Tests** running and verified
- **Honest** assessment of problems
- **Focused** todo lists with priority order
- **Structured** logging and error handling
- **Clear** git history and commit messages

---

## 🧠 Key Principles

**Context is everything** → Understand project state before starting
**Complete > Partial** → Full implementation better than template
**Tests first** → Verify before each commit
**Automate thinking** → Use todo lists, not mental tracking
**Be direct** → Honest about problems, no hiding issues
**Document decisions** → Why, not just what
**Quick wins when smart** → Don't over-engineer; ship value early, iterate later
**Real-time visibility** → Show status at each step; blockers/wins immediately visible
**More text = less cost** → Upfront documentation saves tokens/money on every future task

---

### More Text = Less Cost (Counterintuitive but True)

**Principle**: Don't minimize documentation. Maximize usefulness.

**Example from today**:
- **18,000 lines added** to cory-learnings
- **230K tokens spent** building it
- **60-80% token savings** on every future task
- **Payback**: 1-2 sessions
- **Annual savings**: $1.44+ vs one-time cost of $0.52

**Why it works**:
- Error catalogs prevent 30 min diagnosis → save 85% tokens
- Prompts save 200-500t per task
- Decision trees prevent bad decisions → save rework tokens
- Fixtures eliminate setup → save 300-400t per test
- Patterns eliminate bikeshedding → save 200t per implementation

**The math**:
- 10 sessions × 5K token savings = 50K tokens saved
- vs 230K tokens invested
- Breakeven in 5 sessions, then profit forever

**When to add more text**:
- Reusable across multiple projects ✅
- Solves repetitive problems ✅
- Saves significant tokens per use ✅
- Maintainable (not outdated docs) ✅

**When NOT to add more text**:
- One-time problem ❌
- Outdated before next use ❌
- Adds noise without value ❌

---

## ❓ FAQ

**Q: Should I create a todo list?**
A: YES if 2+ steps. Use TodoWrite, not markdown.

**Q: Should I run tests?**
A: YES, always. Before every commit.

**Q: Should I ask permission?**
A: NO if it's a standard operation. YES if destructive/ambiguous.

**Q: What if tests fail?**
A: Fix them. Zero tolerance. Don't move on.

**Q: How detailed should commits be?**
A: Clear, present tense, explain WHY it matters.

**Q: Complete implementations mean what?**
A: No TODOs, all edge cases, ready to production.

---

## 🔗 Navigation

- **Full Details**: [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md)
- **Quick Start**: [AI_QUICKSTART.md](AI_QUICKSTART.md)
- **Dictionary**: [TERM_DICTIONARY.md](TERM_DICTIONARY.md)
- **Index**: [INDEX.md](INDEX.md)

---

## 📊 Version Info

- **Format**: Optimized summary for AI agents (380 lines)
- **Goal**: 80% value in 5-min read
- **Full**: See MASTER_LEARNINGS.md for complete details
- **Updated**: 2025-11-01

