---
title: "Cory's Master Learnings"
description: "Central knowledge base aggregating preferences, working style, and learnings"
version: "2.0"
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
