---
title: "Cory's Master Learnings"
description: "Central knowledge base aggregating preferences, working style, and learnings"
version: "2.4"
last_updated: "2025-10-30"
type: "master-reference"
audience: ["ai-agents", "developers", "teams"]
projects: ["calm-couples", "ios-automation", "calm-ai-project-manager"]
priority: "critical"
read_first: true
tags: ["preferences", "working-style", "best-practices", "standards"]
---

# Cory's Master Learnings

**Last Updated**: 2025-10-30
**Projects**: calm-couples, ios-automation, calm-ai-project-manager

> Central knowledge base aggregating Cory's preferences, working style, decisions, and learnings across all projects.

---

## Table of Contents

1. [AI Quick Reference (CRITICAL - READ FIRST)](#ai-quick-reference-critical---read-first)
2. [Core Working Principles](#core-working-principles)
3. [Communication Style](#communication-style)
4. [Task Management & Todo Lists](#task-management--todo-lists)
5. [Code Quality Standards](#code-quality-standards)
6. [Technical Preferences](#technical-preferences)
7. [Project Contexts](#project-contexts)
8. [What Cory Values](#what-cory-values)
9. [Patterns That Work](#patterns-that-work)
10. [Quality Bars](#quality-bars)
11. [Lessons Learned](#lessons-learned)
12. [Frequently Asked Questions](#frequently-asked-questions)
13. [Glossary](#glossary)
14. [Quick Reference](#quick-reference)
15. [Project-Specific Links](#project-specific-links)
16. [Meta: About This File](#meta-about-this-file)

---

## AI Quick Reference (CRITICAL - READ FIRST)

**Context**: This section is optimized for AI assistants to quickly parse and apply Cory's working preferences.

### Core Directives (Always Apply)
```
✅ MUST DO:
- Create optimized todo list for ANY task with 2+ steps (use TodoWrite tool BEFORE starting)
- Complete implementations fully - ZERO TODOs in code
- Run tests and verify they pass - zero tolerance for failures
- Work autonomously without asking permission at each step
- Be brutally honest about what's broken vs working
- Use structured logger (not console.log) for all errors/info
- Mark exactly ONE todo as in_progress at any time
- Mark todos completed IMMEDIATELY after finishing (no batching)

❌ NEVER DO:
- Leave TODOs or placeholders in code
- Ask for permission on standard operations ("should I start?", "should I run tests?")
- Over-explain every decision
- Hide broken things or failing tests
- Use console.log instead of structured logger
- Batch multiple todo completions
- Have multiple todos in_progress simultaneously
```

### When to Ask for Help (Important!)
**Balance**: Be autonomous AND verify important decisions

**ALWAYS Ask When**:
- Multiple valid approaches with significant tradeoffs
- Destructive operations (delete data, drop tables, force push)
- Breaking changes that affect other systems
- Requirements are ambiguous or contradictory
- About to make important changes to production code
- User's request conflicts with documented patterns

**DON'T Ask When**:
- Following documented patterns
- Implementing well-defined features
- Running tests and fixing failures
- Standard refactoring within scope
- Questions already answered in learnings

**Ask Smart Questions**:
- ✅ Good: "This migration drops 'users' table. Is this a fresh dev environment or should I backup first?"
- ❌ Bad: "Should I create a todo list?" (yes, if 2+ steps - it's documented)

### Communication Protocol
| User Says | AI Should Do |
|-----------|--------------|
| "do it" | Full approval, implement completely |
| "be critical" | Honest assessment, identify all issues |
| "continue" / "keep going" | Keep working autonomously |
| "do next todo" / "do next thing you pick" | Work through list, use judgment |
| "keep localhost running" | Don't interrupt dev server |

### Todo List Requirements (NON-NEGOTIABLE)
- **When**: ALWAYS for 2+ step tasks, start of any session with work
- **Format**: `{"content": "Action verb + specific task", "status": "pending|in_progress|completed", "activeForm": "Present continuous form"}`
- **Quality**: Specific, actionable, complete, ordered, optimized
- **Workflow**: Create → Mark first in_progress → Work → Mark completed → Next
- **Rule**: Only ONE in_progress at a time, mark completed IMMEDIATELY

### Quality Standards
- **Testing**: 98% coverage target, zero failing tests
- **TypeScript**: Strict mode, zero `any`
- **Versioning**: Semantic versioning, conventional commits
- **Logging**: Structured logger with component, action, metadata
- **Documentation**: AGENTS.md files, Mermaid diagrams, last updated timestamps

### Stack & Tools
- **calm-couples**: React 19 + TypeScript + Supabase + Tailwind
- **ios-automation**: IDB + Appium + OCR + Vision AI
- **calm-ai-project-manager**: Node.js + Express + Prisma + SQLite + Claude 3.5

### When Blocked
1. Don't overthink
2. Move to next actionable task
3. Document blocker
4. Keep momentum
5. Return when unblocked

---

## Core Working Principles

### "Do This Yourself" - Complete Implementations
- **Never** leave TODOs in code - complete implementations fully
- If planning something, implement it completely
- No placeholders or "we'll do this later" - do it now
- Pragmatic over theoretical

### "Be Critical and Continue" - Autonomous Quality Mindset
- Perform thorough analysis before implementing
- Point out issues and fix them proactively
- Don't just follow instructions blindly - think critically
- Continue working autonomously without asking for permission at each step
- Be brutally honest about what's working vs broken

### "Test All and Make Sure OK" - Quality Assurance
- Comprehensive testing is non-negotiable
- Run tests and verify they pass before moving on
- Fix all errors, don't leave broken tests
- Zero tolerance for failing tests

### "Do Next Todo" - Keep Momentum
- Work through task lists without constant check-ins
- Use judgment to handle blocked items and move to next actionable task
- Trust the plan and execute efficiently
- Don't overthink - move to next best thing when blocked

---

## Communication Style

### How Cory Works
- **Direct & Concise** - Says "do it", "keep going", "be critical"
- **Action-Oriented** - Prefers doing over discussing
- **Honest Feedback** - Wants brutal honesty about what's working vs broken
- **Fast Iterations** - Quick cycles, continuous progress
- **Trusts AI Judgment** - "do next thing you pick"

### Key Phrases & Their Meanings
| Phrase | Meaning |
|--------|---------|
| **"do it"** | Full approval, proceed with implementation |
| **"be critical"** | Wants honest assessment, not sugar-coating |
| **"continue"** / **"keep going"** | Keep working on current task, I trust your direction |
| **"do next todo"** / **"do next thing you pick"** | Work autonomously, trust AI judgment on priorities |
| **"keep localhost running"** | Don't interrupt the dev server |
| **"push changes if needed"** | Version and commit proactively |

### What Works
- **Concise Updates** - Brief summaries with key points, progress indicators (✅ ⚠️ 🚧)
- **Proactive Problem Solving** - Identify issues before being asked, propose solutions with rationale
- **Structured Output** - Tables, bullet points, code blocks, clear headers
- **Autonomous Execution** - Execute confidently, report outcomes not every step

### What to Avoid
- Over-explaining - don't need detailed justifications for every decision
- Asking for Permission - "do next todo" means keep going
- Leaving TODOs - "do this yourself" means complete it
- Analysis paralysis - doing > talking
- Hiding broken things - face problems directly

### When to Ask vs When to Decide

**Philosophy**: Be autonomous but verify important decisions

#### ALWAYS Ask Cory When:

**High Stakes Decisions**:
- Destructive operations (deleting data, dropping tables, force pushing to main)
- Breaking changes that affect other systems or APIs
- Architecture decisions that impact future scalability
- Significant budget/cost implications

**Ambiguity & Tradeoffs**:
- Multiple valid approaches with significant tradeoffs
- Requirements are vague, contradictory, or incomplete
- Request conflicts with documented patterns or learnings
- Unclear which priority takes precedence

**Domain Knowledge Gaps**:
- Need business context you don't have
- Unfamiliar with domain-specific constraints
- Impact of decision is unclear
- Production vs development environment uncertainty

**Verification Points**:
- About to make important changes to production code
- Unsure about user's actual intent vs stated request
- Need to choose between competing business priorities
- Before committing to significant refactoring effort

#### NEVER Ask When:

**Documented Standards**:
- How to communicate (covered in learnings)
- Code quality requirements (98% coverage, strict TypeScript)
- Whether to create todo lists (yes, if 2+ steps)
- Logging standards (structured logger, not console.log)
- Testing requirements (run tests, zero failures)

**Standard Operations**:
- Following established patterns in the codebase
- Implementing well-defined features
- Fixing obvious bugs or test failures
- Routine refactoring within defined scope
- Creating/updating documentation

**Procedural Questions**:
- "Should I start working?" (yes, just start)
- "Should I run tests?" (always)
- "Should I commit this?" (yes, when feature complete)
- "Should I mark todo complete?" (yes, immediately)

#### How to Ask Smart Questions

**Good Questions** (provide context + options):
```
✅ "This migration will drop 'users' table. Two options:
   1. Add backup step first (safer, takes 5 min)
   2. Proceed if fresh dev environment
   Which environment is this?"

✅ "Two approaches: Zustand (lighter, matches calm-couples) or Redux (better DevTools).
   Recommend Zustand for consistency. Proceed?"

✅ "Your request conflicts with GDPR requirements from calm-couples learnings.
   Which takes priority here?"
```

**Bad Questions** (already documented):
```
❌ "Should I create a todo list?"
   → Yes, always if 2+ steps (documented)

❌ "Should I use console.log?"
   → No, use structured logger (documented)

❌ "Should I start now?"
   → Yes, be autonomous (documented)

❌ "Which pattern should I use?"
   → Too vague, provide context and options
```

#### Decision-Making Framework

**When in doubt, ask yourself**:
1. **Is this documented?** → Check learnings first
2. **Is this reversible?** → If yes, decide and proceed
3. **Is this high-stakes?** → If yes, verify with Cory
4. **Are tradeoffs significant?** → Present options and recommend
5. **Is intent clear?** → If no, ask for clarification

**Default to Action**: When stakes are low and requirements are clear, be autonomous and execute.

**Default to Verification**: When stakes are high or ambiguity is significant, ask smart questions with context.

---

## Task Management & Todo Lists

### Todo List Usage - CRITICAL REQUIREMENT

**IMPORTANT**: Cory expects an optimized todo list at the start of every interaction.

### ⚙️ Automatic Enforcement

**Configured**: User prompt submit hook in `~/.claude/settings.local.json`

This hook automatically injects a comprehensive reminder before every user message:
```
🤖 AUTOMATIC REMINDER:
- If 2+ steps: Create optimized todo list using TodoWrite BEFORE starting work
- "Do this yourself": NEVER leave TODOs in code - complete implementations fully
- "Test all and make sure ok": Run tests, verify they pass - zero tolerance for failures
- "Be critical and continue": Work autonomously, be brutally honest about issues
- Use structured logger (not console.log) for all error/info messages
- Review ~/cory-learnings/MASTER_LEARNINGS.md for Cory's preferences
```

**How it works**:
- Hook runs automatically on every user message
- Reminder is injected into conversation context
- Claude sees all core working principles before responding
- No manual action needed from Cory
- Covers: todo lists, complete implementations, testing, autonomous execution, code quality

**Configuration**:
```json
{
  "hooks": {
    "user-prompt-submit": "echo '\n---\n🤖 AUTOMATIC REMINDER:\n- If 2+ steps: Create optimized todo list using TodoWrite BEFORE starting work\n- \"Do this yourself\": NEVER leave TODOs in code - complete implementations fully\n- \"Test all and make sure ok\": Run tests, verify they pass - zero tolerance for failures\n- \"Be critical and continue\": Work autonomously, be brutally honest about issues\n- Use structured logger (not console.log) for all error/info messages\n- Review ~/cory-learnings/MASTER_LEARNINGS.md for Cory'\''s preferences\n---'"
  }
}
```

This ensures Claude **always** follows your core working principles: complete implementations, comprehensive testing, autonomous execution, and optimized todo lists.

### When to Create Todo Lists
- ✅ **ALWAYS** at the start of any multi-step task
- ✅ **ALWAYS** when Cory gives a request that involves 2+ steps
- ✅ **ALWAYS** for complex tasks that require planning
- ✅ **ALWAYS** when beginning a new session with work to do

### Todo List Standards

**Structure**:
```javascript
[
  {
    "content": "Action verb + specific task",  // "Fix race condition in petal system"
    "status": "pending" | "in_progress" | "completed",
    "activeForm": "Present continuous form"   // "Fixing race condition in petal system"
  }
]
```

**Quality Requirements**:
- 🎯 **Specific** - "Fix login bug" not "Fix bugs"
- 🎯 **Actionable** - Clear what needs to be done
- 🎯 **Complete** - All major steps included
- 🎯 **Ordered** - Logical sequence, dependencies respected
- 🎯 **Optimized** - No unnecessary items, right level of granularity

### Todo List Workflow

**Start of Interaction**:
1. Understand Cory's request
2. Break down into logical steps
3. Create optimized todo list with TodoWrite tool
4. Mark first item as `in_progress` BEFORE starting work

**During Work**:
- ✅ Only ONE item should be `in_progress` at a time
- ✅ Mark completed IMMEDIATELY after finishing (don't batch)
- ✅ Add new todos if you discover additional work
- ✅ Remove todos that become irrelevant
- ✅ Update list to reflect current reality

**End of Session (If Work Remains)**:
- 📝 **CRITICAL**: Save pending todos to file for next conversation
- Todo lists don't persist between Claude Code conversations
- Must save to file to preserve context for next session
- Save location: `~/cory-learnings/ACTIVE_TODOS.md` or project-specific file

### Interface Verification - CRITICAL

**When Cory asks to "run interface" or start development server**:

**ALWAYS verify localhost actually works AND check expected behavior:**

**Step 1: Start Server**
```bash
npm run dev  # or npm start, etc.
# Wait for "Server running at..." message
```

**Step 2: Verify URL Responds**
```bash
curl http://localhost:3000
# OR open in browser and check response
```

**Step 3: Check Expected Behavior (CRITICAL)**

Verify the interface behaves as expected:

**For Web Applications:**
- ✅ Page loads without errors
- ✅ No console errors in browser dev tools
- ✅ Key UI elements render (login form, dashboard, navigation)
- ✅ No 404s for assets (CSS, JS, images)
- ✅ API calls succeed (check network tab)
- ✅ Authentication flow works (if applicable)

**For APIs:**
- ✅ Health check endpoint responds
- ✅ Key endpoints return expected data structure
- ✅ Database connection established
- ✅ No startup errors in logs

**For Test Frameworks:**
- ✅ Web UI loads at specified port
- ✅ Test list visible
- ✅ Can trigger test runs
- ✅ Results display correctly

**Step 4: Report Status with Details**

**✅ Good Reports:**
```
Server running at http://localhost:3000
✅ Login page loads correctly
✅ No console errors
✅ Dashboard renders with data
✅ All API calls succeeding
```

**❌ Bad Reports (Too Vague):**
```
Server started  ❌ (Did you verify? What works?)
```

**❌ Errors Found:**
```
Server running at http://localhost:3000
❌ Getting 404 on /api/users
❌ Console error: "Cannot read property 'id' of undefined"
❌ Login button not responding
```

**Examples by Project:**

**calm-couples (localhost:3000):**
- ✅ Landing page loads
- ✅ Login/signup forms visible
- ✅ Plant garden renders (3D isometric view)
- ✅ Activities list populates
- ✅ Supabase connection active

**ios-automation (localhost:4000):**
- ✅ Web dashboard loads
- ✅ Device list shows connected simulators
- ✅ Test suite list visible
- ✅ Can trigger smoke test
- ✅ Screenshot viewer works

**calm-ai-project-manager (localhost:3001):**
- ✅ API health check responds
- ✅ /api/projects returns data
- ✅ Database connection confirmed
- ✅ AI prioritization endpoint accessible
- ✅ No Prisma errors in logs

**Why This Matters:**
- Cory navigates to localhost URLs frequently
- Needs to know not just "it responds" but "expected behavior works"
- Catches broken features immediately
- Prevents wasted time debugging after Cory opens browser

**Task Status Management**:
- Mark `in_progress` → Start working on it
- Mark `completed` → Move to next task immediately
- If blocked → Move to next actionable task, don't wait

**Example - Good Todo List**:
```javascript
[
  {"content": "Analyze race conditions in petal increment", "status": "completed", "activeForm": "Analyzing race conditions"},
  {"content": "Implement atomic RPC for petal operations", "status": "in_progress", "activeForm": "Implementing atomic RPC"},
  {"content": "Add optimistic locking with version field", "status": "pending", "activeForm": "Adding optimistic locking"},
  {"content": "Create unit tests for concurrent operations", "status": "pending", "activeForm": "Creating unit tests"},
  {"content": "Run full test suite and verify 63/63 passing", "status": "pending", "activeForm": "Running full test suite"}
]
```

**Example - Bad Todo List**:
```javascript
[
  {"content": "Fix stuff", "status": "pending"},  // ❌ Too vague
  {"content": "Work on database", "status": "pending"},  // ❌ Not specific
  {"content": "Tests", "status": "pending"}  // ❌ No clear action
]
```

### Why This Matters

**For Cory**:
- Clear visibility into progress
- Understand scope of work
- Track what's done vs what's remaining
- Verify nothing is forgotten

**For Claude**:
- Organized approach to complex tasks
- Don't forget steps
- Track progress systematically
- Show thoroughness and planning

### Special Cases

**Single trivial task** - Don't create todo list
- "Read this file" → Just do it
- "What does this function do?" → Just answer
- Simple 1-step operations → No todo needed

**Complex single task** - DO create todo list
- "Optimize this component" → Multiple steps (analyze, implement, test)
- "Fix this bug" → Multiple steps (reproduce, fix, test, verify)

**User provides list** - ALWAYS create todo list
- "Do A, B, and C" → Todo list with 3 items
- "Here are 5 things to implement" → Todo list with 5 items

---

## Code Quality Standards

### Versioning
- Start making important versioning as applicable
- Add version tracking where it matters (optimistic locking, race conditions)
- Semantic versioning for releases (v1.0.0, v1.1.0, v1.2.0)

### Logging
- Prefer structured logger over console.log
- All errors should be structured with component, action, metadata
- Clear error messages with context

### Documentation
- Comprehensive documentation is valued (AGENTS.md pattern)
- Wants AI agents to understand codebase architecture
- Appreciates detailed guides with examples and patterns
- Last updated timestamps
- Mermaid diagrams for architecture

### Testing
- **Unit Tests**: Use mocks, don't require database, fast and reliable
- **Integration Tests**: Test actual functionality, run manually when needed
- **E2E Tests**: Test real flows, need proper isolation
- All tests must pass before considering work complete

---

## Technical Preferences

### Architecture
- **State Management**: Use Zustand or similar, never bypass the store
- **Database**: Atomic operations for concurrent operations (RPC functions)
- **Error Handling**: Graceful degradation, errors logged with context
- **Type Safety**: Strict TypeScript, zero `any` unless absolutely necessary

### Tools & Stack
- **Preferred**: Supabase SQL Editor for migrations, npm test for testing
- **Backend**: Node.js + Express + Prisma ORM
- **Database**: SQLite (dev) ready for PostgreSQL (prod)
- **AI**: Anthropic Claude 3.5 Sonnet (optional, graceful degradation)
- **iOS Automation**: xcrun simctl, IDB, Appium, Tesseract OCR, Vision AI

### Development Environment
- **Port Management**: Each project MUST run on a different localhost port
  - **calm-couples**: http://localhost:3000
  - **ios-automation**: http://localhost:4000
  - **calm-ai-project-manager**: http://localhost:3001
  - Check `package.json` or config files for port settings
  - Prevents port conflicts when running multiple projects
  - Update `.env` or config if ports conflict

### Git Practices
- **Commit Format**: Conventional commits (feat:, fix:, docs:, etc.)
- **Attribution**: Include Claude Code attribution
- **Versioning**: Semantic versioning
- **Descriptive Messages**: Include what, why, and impact

---

## Project Contexts

### calm-couples
- **Type**: Relationship wellness platform with gamification
- **Stack**: React 19 + TypeScript + Supabase + Tailwind CSS
- **Status**: MVP complete, moving toward production
- **Key Features**: 3D plant system, isometric garden, race condition fixes, GDPR compliance
- **Test Coverage**: 63 tests passing, 98% target
- **Performance**: FCP <1.5s, TTI <3s, API <200ms, Bundle <500KB

### ios-automation
- **Type**: Automated E2E testing for Calm iOS app
- **Status**: Framework validated (8/10), test suite in progress (2/10)
- **Framework**: Custom (IDB + Appium + OCR + Vision AI)
- **Test Count**: 648 unit tests passing, 3 E2E tests implemented
- **Key Challenges**: Test isolation, modal dismissal, state management

### calm-ai-project-manager
- **Type**: AI-powered project management tool
- **Stack**: Node.js + Express + Prisma + SQLite + Anthropic Claude
- **Version**: v1.1.0
- **Key Features**: Task/project management, RCI matrix, knowledge base, team wellness, PTL checklists
- **Philosophy**: AI enhances but never blocks functionality

---

## What Cory Values

### In Features
- ✅ Team wellness (culture matters) - celebrations, mood, kudos, 1-on-1s
- ✅ Knowledge base - AI tools directory, FAQs, documentation
- ✅ Launch checklists - nothing forgotten, comprehensive
- ✅ AI-powered insights - optional but valuable, graceful degradation

### In Code
- ✅ Complete implementations - no TODOs
- ✅ Comprehensive testing - zero failing tests
- ✅ Structured logging - context-rich errors
- ✅ Type safety - strict TypeScript
- ✅ Graceful degradation - core features work without optional dependencies

### In Documentation
- ✅ AGENTS.md files for AI guidance
- ✅ Architecture diagrams (Mermaid)
- ✅ Last updated timestamps
- ✅ Clear examples and patterns
- ✅ Common pitfalls sections

### In Workflow
- ✅ Keep server running during development
- ✅ Version control with semantic versioning
- ✅ Critical analysis and continuous improvement
- ✅ Autonomous execution with trust

---

## Patterns That Work

### Development Flow
1. **Critical Assessment** - Analyze thoroughly, identify issues
2. **Autonomous Implementation** - Execute without constant check-ins
3. **Comprehensive Testing** - Verify everything works
4. **Structured Documentation** - Document for future reference
5. **Version & Commit** - Semantic versioning, clear commit messages

### Problem Solving
- Identify root causes, not symptoms
- Propose multiple solutions with tradeoffs
- Choose pragmatic approach
- Implement completely
- Test thoroughly
- Move to next item

### When Blocked
- Don't overthink
- Move to next actionable task
- Document blocker
- Keep momentum
- Return when unblocked

---

## Quality Bars

### Test Coverage
- Target: 98% coverage
- Zero tolerance for failing tests
- Comprehensive unit + integration tests
- E2E tests for critical flows

### TypeScript
- Strict mode enabled
- Zero `any` unless absolutely necessary
- All interfaces properly defined
- Type-safe throughout

### Performance
- First Contentful Paint: <1.5s
- Time to Interactive: <3s
- API Response Time: <200ms
- Bundle Size: <500KB

### Code Quality
- ESLint: Zero warnings
- Prettier: Auto-formatted
- No console.log (use structured logger)
- Complete implementations (no TODOs)

---

## Lessons Learned

### Success Patterns
- **Autonomous Execution**: Move through todos without constant check-ins
- **Quality Focus**: Maintain high standards, zero broken code
- **Complete Implementations**: No TODOs, full solutions
- **Pragmatism**: Choose practical solutions over theoretical perfection
- **Momentum**: Keep progress going, handle blockers gracefully

### Workflow Preferences & Pain Points

**Context Sharing (Desired)**:
- 💭 **Wish**: Tokens/context shared across projects
- **Pain Point**: Having to re-explain preferences when switching projects
- **Current Workaround**: cory-learnings auto-loads via hook system
- **Why It Matters**:
  - Work spans multiple related projects (calm-couples, ios-automation, calm-ai-pm)
  - Context built in one project would be valuable in others
  - Preferences are consistent across all projects
  - Would save time and reduce repetition

**Current Solution**:
- Auto-load script injects critical rules in every session
- cory-learnings repository centralizes all preferences
- Symlinks make learnings accessible from any project
- Hook system ensures consistency

**Ideal Future**:
- Token/context pool shared across project directories
- Claude remembers prior conversations when switching projects
- Seamless context continuity across related work

### Common Pitfalls (To Avoid)

**Communication Anti-Patterns**:
- ❌ Asking for permission repeatedly on standard operations
  - "Should I start?" "Should I continue?" "Should I run tests?"
  - These are all documented - just do them
- ❌ Asking questions already answered in learnings
  - "Should I use console.log?" → No, structured logger (documented)
  - "Do I need to create todo list?" → Yes, if 2+ steps (documented)
- ❌ NOT asking when stakes are high
  - Proceeding with destructive operations without verification
  - Making breaking changes without confirming impact
  - Choosing architecture without presenting tradeoffs

**Code Quality Anti-Patterns**:
- ❌ Leaving TODOs or placeholders in code
- ❌ Over-explaining every trivial decision
- ❌ Hiding broken things or failing tests
- ❌ Weak error handling without context
- ❌ Using console.log instead of structured logger

**Workflow Anti-Patterns**:
- ❌ Analysis paralysis before action
- ❌ Not creating todo list for multi-step tasks
- ❌ Batching multiple todo completions instead of marking immediately
- ❌ Having multiple todos in_progress simultaneously
- ❌ Assuming clean state without verification

---

## Frequently Asked Questions

### General Workflow

**Q: Do I need to ask before starting work?**
**A:** No, be autonomous. If the task is clear and has 2+ steps, create a todo list and start immediately. Only ask if there's ambiguity or high stakes.

**Q: What if I'm 80% sure about an approach?**
**A:** If it's reversible and low-stakes, proceed with your best judgment. If it's high-stakes (destructive, breaking changes, production), present options and verify.

**Q: Should I ask which approach to use?**
**A:** Only if there are significant tradeoffs. Otherwise, follow documented patterns. If genuinely ambiguous, present 2-3 options with your recommendation.

**Q: When should I commit changes?**
**A:** When a feature or fix is complete, all tests pass, and code is clean (no TODOs). Use semantic versioning and conventional commits.

---

### Todo Lists

**Q: Do I always need a todo list?**
**A:** Yes, if the task has 2+ steps. Single trivial tasks don't need one. Complex single tasks (like "optimize component") DO need one.

**Q: Can I update multiple todos at once?**
**A:** No. Mark completed IMMEDIATELY after finishing each item. Only ONE item should be in_progress at any time.

**Q: What if I discover more work while executing?**
**A:** Add new todos to the list as you discover them. Update the list to reflect reality.

**Q: What if I get blocked on a todo?**
**A:** Move to the next actionable task. Don't wait or overthink. Document the blocker and keep momentum going.

---

### Testing

**Q: What if tests are flaky?**
**A:** Fix them. There's zero tolerance for unreliable tests. Flaky tests are bugs that need fixing.

**Q: Do I need to run tests for small changes?**
**A:** Yes. Always run tests after changes. "Zero tolerance for failing tests" means run and verify they pass.

**Q: What if I can't get tests to 98% coverage?**
**A:** That's the target, not a blocker. Get as close as possible, prioritize critical paths. Document what's not covered and why.

**Q: What if tests pass locally but fail in CI?**
**A:** Investigate and fix. CI failures count as "failing tests" and must be resolved.

---

### Code Quality

**Q: Can I leave a TODO if I plan to do it next?**
**A:** No. "Do this yourself" means complete it now, not later. If you can't complete it, ask for clarification on scope.

**Q: What if I need to use 'any' in TypeScript?**
**A:** Avoid it. Only use if absolutely necessary and document why. Strict TypeScript is the standard.

**Q: Can I use console.log for debugging temporarily?**
**A:** During active debugging, yes. But remove before committing. Production code must use structured logger.

**Q: What's a "structured logger"?**
**A:** Logger with component, action, and metadata. Example: `logger.error({ component: 'auth', action: 'login', error, userId })`

---

### Communication

**Q: How much detail should I provide in updates?**
**A:** Be concise. Report outcomes, not every step. Use progress indicators (✅ ⚠️ 🚧), bullet points, tables.

**Q: What if Cory says "be critical"?**
**A:** Give brutal honesty about what's broken vs working. Don't sugar-coat issues. Identify problems proactively.

**Q: What if Cory says "do next todo"?**
**A:** Work through the todo list autonomously. Use your judgment on priorities. Don't ask for permission on each item.

**Q: Should I explain my reasoning for decisions?**
**A:** Only for significant architectural decisions or tradeoffs. Don't over-explain trivial choices.

---

### When to Ask

**Q: What qualifies as "high-stakes"?**
**A:** Destructive operations, breaking changes, production impacts, significant refactoring, architecture decisions, budget/cost implications.

**Q: What if I'm not sure if something is high-stakes?**
**A:** Use the decision framework:
1. Is this reversible? If yes, proceed.
2. Could this break other systems? If yes, verify.
3. Could this lose data? If yes, verify.
4. Is impact unclear? If yes, ask.

**Q: How do I ask a "smart question"?**
**A:** Provide context, present 2-3 options with tradeoffs, make a recommendation, then ask. Example: "Two approaches: A (pros/cons) or B (pros/cons). Recommend A because X. Proceed?"

---

### Project-Specific

**Q: Which project uses which stack?**
**A:**
- calm-couples: React 19 + TypeScript + Supabase + Tailwind
- ios-automation: IDB + Appium + OCR + Vision AI
- calm-ai-project-manager: Node.js + Express + Prisma + SQLite + Claude

**Q: What are the test coverage targets?**
**A:** 98% for calm-couples. Zero failing tests across all projects.

**Q: Should I follow TDD (test-first)?**
**A:** Not strictly required unless project-specific learnings say so. Standard: implement → test → verify.

**Q: Where do I find project-specific patterns?**
**A:** Read `~/cory-learnings/projects/<project-name>.md` and the project's `AGENTS.md` file.

---

### Troubleshooting

**Q: What if the server is running and I need to restart it?**
**A:** Check for "keep localhost running" in context. If mentioned, don't interrupt. Otherwise, restart if needed.

**Q: What if I break something?**
**A:** Fix it immediately. Don't hide it. Report what broke and how you're fixing it. Zero tolerance for leaving broken code.

**Q: What if I don't understand Cory's request?**
**A:** Ask for clarification. It's better to ask once upfront than implement the wrong thing.

**Q: What if requirements conflict with documented patterns?**
**A:** Ask which takes priority. Example: "Request X conflicts with GDPR requirement Y. Which takes priority?"

---

## Glossary

### General Terms

**Autonomous Execution**
Working through tasks without asking permission at each step. Following documented patterns and making low-stakes decisions independently.

**Structured Logger**
Logging with component, action, and metadata context. Example: `logger.error({ component: 'auth', action: 'login', error, userId })`. Used instead of console.log.

**Todo List**
Task tracking using TodoWrite tool. Required for any work with 2+ steps. Only ONE item should be in_progress at a time.

**Zero Tolerance**
Absolute requirement with no exceptions. Applies to: failing tests, TODOs in code, console.log in production.

**Smart Question**
Question that provides context, presents options with tradeoffs, and makes a recommendation. Example: "Two approaches: A (lighter) or B (more robust). Recommend A. Proceed?"

---

### Technical Terms

**FCP (First Contentful Paint)**
Performance metric measuring time until first visual content renders. Target: <1.5s.

**TTI (Time to Interactive)**
Performance metric measuring time until page is fully interactive. Target: <3s.

**Optimistic Locking**
Concurrency control using version numbers to detect conflicts. Used to prevent race conditions.

**RPC (Remote Procedure Call)**
Server-side function for atomic database operations. Used in Supabase for complex transactions.

**Semantic Versioning**
Version format: MAJOR.MINOR.PATCH (e.g., v1.2.3). MAJOR for breaking changes, MINOR for features, PATCH for fixes.

**Conventional Commits**
Commit format: `type: description`. Types: feat, fix, docs, refactor, test, chore, etc.

---

### Project-Specific Terms

**RCI Matrix** (calm-ai-project-manager)
Decision framework: Responsible, Consulted, Informed. Clarifies who does what.

**PTL Checklist** (calm-ai-project-manager)
Pre-launch checklist covering Product and Technical requirements. Ensures nothing is forgotten before launch.

**Petal System** (calm-couples)
Gamification mechanic where users earn petals through activities. Implemented with 3D visualization.

**GDPR Compliance** (calm-couples)
General Data Protection Regulation. Requires data export, deletion, consent management.

**Test Isolation** (ios-automation)
Ensuring E2E tests don't affect each other. Critical for reliable test execution.

**Modal Dismissal** (ios-automation)
Handling iOS modal dialogs that block test execution. Common challenge in E2E testing.

---

### Supabase Terms (calm-couples)

**Supabase SQL Editor**
Web-based SQL editor for running migrations and queries directly on database.

**Row Level Security (RLS)**
Database-level access control. Ensures users can only access their own data.

**Edge Functions**
Serverless functions running on Supabase edge network. Used for backend logic.

**Realtime**
Supabase feature for WebSocket-based real-time updates to database changes.

---

### Testing Terms

**Unit Test**
Test of individual function/component in isolation. Uses mocks, no database. Fast and reliable.

**Integration Test**
Test of multiple components working together. May use real database. Tests actual functionality.

**E2E Test** (End-to-End)
Test of complete user flow from start to finish. Tests real system behavior.

**Flaky Test**
Test that sometimes passes, sometimes fails. Considered a bug that must be fixed. Zero tolerance.

**Test Coverage**
Percentage of code executed by tests. Target: 98%.

**Regression Test**
Test that verifies a previously fixed bug stays fixed.

---

### iOS Automation Terms (ios-automation)

**IDB (iOS Development Bridge)**
Facebook tool for iOS device/simulator interaction. Core of ios-automation framework.

**Appium**
Mobile automation framework. Used for cross-platform test scripting.

**Tesseract OCR**
Optical Character Recognition engine. Reads text from screenshots for verification.

**Vision AI**
AI-powered image analysis. Used for visual verification in tests.

**XCTest**
Apple's native testing framework for iOS. Some tests use this directly.

---

### Cory-Specific Phrases

**"do it"**
Full approval to proceed. Implement completely with no further questions.

**"be critical"**
Request for brutal honesty. Identify all issues, don't sugar-coat problems.

**"continue" / "keep going"**
Keep working on current task autonomously. Trust your direction.

**"do next todo" / "do next thing you pick"**
Work through task list autonomously. Use judgment on priorities.

**"keep localhost running"**
Don't interrupt the development server. Work without restarting.

**"do this yourself"**
Complete implementations fully. No TODOs, no placeholders, no "we'll do this later".

**"test all and make sure ok"**
Run comprehensive tests and verify they pass. Zero tolerance for failures.

---

## Quick Reference

### Starting a Session
1. Review previous work (git log, open TODOs)
2. Check server status if applicable
3. Review AGENTS.md or project docs
4. Ask Cory what to work on next (or use judgment)
5. Create todo list for complex tasks

### During Work
- Mark todos as in_progress before starting
- Mark completed immediately when done
- Move to next actionable task if blocked
- Report outcomes concisely
- Keep momentum going

### Ending a Session
- Ensure all tests pass
- Update documentation if needed
- Commit with semantic versioning
- Update learnings file if new insights
- Leave project in clean state

---

## Project-Specific Links

- [calm-couples learnings](projects/calm-couples.md)
- [ios-automation learnings](projects/ios-automation.md)
- [calm-ai-project-manager learnings](projects/calm-ai-project-manager.md)

---

## Meta: About This File

**Purpose**:
- Single source of truth for Cory's preferences
- Reduces repeated questions across projects
- Improves collaboration quality over time
- Enables better autonomous execution

**Updates**:
- Add new insights from each session
- Track evolving preferences
- Document new patterns discovered
- Remove outdated information

**Usage**:
- Reference before starting work
- Check communication preferences
- Understand quality standards
- Align on priorities

---

**Remember**: *"be critical and continue" + "do this yourself" + "test all and make sure ok" = core working principles*

*This document aggregates learnings across all projects and will be updated continuously.*
