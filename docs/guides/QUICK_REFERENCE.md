---
title: "cory-learnings Quick Reference Cheat Sheet"
description: "One-page reference for the most critical information"
version: "2.4.0"
last_updated: "2025-10-31"
type: "reference"
audience: ["developers", "ai-agents"]
tags: ["quick-reference", "cheat-sheet", "commands"]
---

# cory-learnings Quick Reference Cheat Sheet

## Essential Files (Priority Order)

| File | Purpose | Lines | When to Read |
|------|---------|-------|--------------|
| [AI_QUICKSTART.md](AI_QUICKSTART.md) | Ultra-concise AI reference | 540 | ALWAYS read first |
| [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) | Comprehensive guide | 1,154 | For detailed context |
| [TERM_DICTIONARY.md](TERM_DICTIONARY.md) | Terminology reference | 600+ | When unfamiliar term appears |
| [EXAMPLES.md](EXAMPLES.md) | Good/bad patterns | 513 | When unsure about approach |
| [projects/README.md](projects/README.md) | Project quick access | 372 | When switching projects |

## Critical Rules (MUST FOLLOW)

### 1. Todo Lists
```
When: ANY task with 2+ steps
Tool: TodoWrite (before starting work)
Rules:
  - Only ONE in_progress at a time
  - Mark completed IMMEDIATELY (no batching)
  - Save pending to ACTIVE_TODOS.md at session end
```

### 2. Complete Implementations
```
"Do this yourself" = Zero TODOs in code
Complete everything fully, no placeholders
```

### 3. Zero Test Failures
```
"Test all and make sure ok" = Zero tolerance
Tests MUST pass before committing
Target: 98% coverage
```

### 4. Autonomous Quality
```
"Be critical and continue" = Work autonomously
Identify all issues, fix them, keep going
No hand-holding needed
```

### 5. Interface Verification (v2.4.0)
```
When starting server:
  1. Start server (npm run dev)
  2. Verify URL responds (curl)
  3. Check expected behavior (page loads, no errors)
  4. Report detailed status (not just "started")
```

## Communication Decoder

| Phrase | Meaning |
|--------|---------|
| "do it" | Full approval, implement completely |
| "be critical" | Honest assessment, identify ALL issues |
| "continue" / "c" | Keep working autonomously |
| "do next todo" | Work through list, use judgment |
| "keep localhost running" | Don't interrupt server |
| "test all and make sure ok" | Run tests, verify they pass, zero tolerance |
| "do this yourself" | Complete implementation, no TODOs |

## When to Ask vs Decide

### ALWAYS Ask
- Destructive operations (delete data, drop tables, force push)
- Breaking changes affecting other systems
- Multiple valid approaches with significant tradeoffs
- Requirements ambiguous/contradictory

### NEVER Ask
- Standard operations (running tests, creating commits)
- Documented patterns (todo lists, logging style)
- Following established code patterns
- Questions already answered in learnings

## Common Commands

### Project Ports
```bash
# calm-couples
http://localhost:3000

# ios-automation
http://localhost:4000

# calm-ai-project-manager
http://localhost:3001
```

### Repository Maintenance
```bash
# Validate repository structure
./tests/run-all-tests.sh

# Check symlinks
./scripts/check-symlinks.sh

# Search across all files
./scripts/search-learnings.sh "search term"

# Interactive search
./scripts/quick-find.sh

# Add new project
./add-project.sh project-name ~/path/to/project
```

### Git Workflow
```bash
# Conventional commits
git commit -m "feat: add feature"
git commit -m "fix: resolve bug"
git commit -m "docs: update documentation"
git commit -m "test: add tests"
git commit -m "refactor: restructure code"

# Include attribution
git commit -m "$(cat <<'EOF'
feat: add feature

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

## Project Tech Stacks

### calm-couples
```
Stack: React 19, TypeScript, Tailwind CSS, Supabase
State: Zustand
Testing: Vitest
Database: PostgreSQL (via Supabase)
Port: localhost:3000
Key Files: src/, supabase/
```

### ios-automation
```
Stack: TypeScript, Node.js, IDB, Appium
Testing: Jest (648 tests)
Tools: Tesseract OCR, Vision AI
Port: localhost:4000
Key Files: src/, tests/
```

### calm-ai-project-manager
```
Stack: Node.js, Express, Prisma ORM
Database: SQLite (dev) → PostgreSQL (prod)
AI: Claude 3.5 Sonnet API
Port: localhost:3001
Key Files: src/, prisma/
```

## File Structure

```
~/cory-learnings/
├── Core Docs
│   ├── README.md
│   ├── AI_QUICKSTART.md         ← Read first
│   ├── MASTER_LEARNINGS.md      ← Complete guide
│   ├── TERM_DICTIONARY.md       ← Terminology
│   ├── EXAMPLES.md              ← Patterns
│   ├── CHANGELOG.md
│   ├── SETUP_GUIDE.md
│   └── ACTIVE_TODOS.md          ← Session persistence
│
├── Templates
│   ├── TEMPLATE_NEW_PROJECT.md
│   ├── README_BEST_PRACTICES.md
│   └── TEMPLATE_README.md
│
├── projects/
│   ├── README.md                ← Project quick access
│   ├── calm-couples.md
│   ├── ios-automation.md
│   └── calm-ai-project-manager.md
│
├── scripts/
│   ├── check-symlinks.sh
│   ├── validate-structure.sh
│   ├── find-broken-links.sh
│   ├── search-learnings.sh
│   └── quick-find.sh
│
├── tests/
│   ├── run-all-tests.sh         ← Run this
│   ├── structure.test.sh
│   ├── frontmatter.test.sh
│   ├── markdown.test.sh
│   └── versions.test.sh
│
└── add-project.sh               ← Add new project
```

## Quality Standards

### Testing
```
Coverage: 98% target
Tolerance: ZERO failing tests
Types: Unit (mocked) + Integration (real) + E2E (full)
Before commit: All tests must pass
```

### TypeScript
```
Mode: Strict enabled
'any': Avoid unless necessary
Interfaces: Properly defined everywhere
```

### Code Standards
```
Linting: ESLint zero warnings
Formatting: Prettier auto-format
Logging: Structured logger (no console.log)
Implementation: Complete (no TODOs)
```

## Version History

| Version | Date | Key Changes |
|---------|------|-------------|
| v2.4.0 | 2025-10-30 | Interface verification, port management, README guidelines |
| v2.3.0 | 2025-10-30 | Validation scripts, search tools, TOC |
| v2.2.0 | 2025-10-30 | FAQ, glossary, Mermaid diagrams, auto-load |
| v2.1.0 | 2025-10-30 | EXAMPLES.md, decision framework, CHANGELOG |
| v2.0.0 | 2025-10-30 | AI_QUICKSTART.md, YAML frontmatter, core directives |
| v1.0.0 | 2025-10-29 | Initial release, MASTER_LEARNINGS, symlinks |

## Maintenance Schedule

| Frequency | Tasks |
|-----------|-------|
| **Daily** | Update project files, add terms |
| **Weekly** | Review/consolidate learnings, commit changes |
| **Monthly** | Update AI_QUICKSTART, clean outdated info, bump version |
| **Quarterly** | Verify symlinks, elevate patterns, major review |

## Auto-Load Hook

**Location**: `~/.claude/settings.local.json`

```json
{
  "hooks": {
    "user-prompt-submit": "echo '\n---\n🤖 AUTOMATIC REMINDER:\n- If 2+ steps: Create optimized todo list using TodoWrite BEFORE starting work\n- \"Do this yourself\": NEVER leave TODOs in code - complete implementations fully\n- \"Test all and make sure ok\": Run tests, verify they pass - zero tolerance for failures\n- \"Be critical and continue\": Work autonomously, be brutally honest about issues\n- Use structured logger (not console.log) for all error/info messages\n- Review ~/cory-learnings/MASTER_LEARNINGS.md for Cory'\''s preferences\n---'"
  }
}
```

**Effect**: Automatically injects critical rules into EVERY Claude Code conversation.

## Symlink Pattern

```bash
# Central repository
~/cory-learnings/projects/calm-couples.md

# Symlinked to project
~/Desktop/calm/calm-couples/CORY_LEARNINGS.md → ~/cory-learnings/projects/calm-couples.md

# Effect: Edit once, available everywhere
```

## TodoWrite Format

```json
{
  "content": "Action verb + specific task",
  "status": "pending|in_progress|completed",
  "activeForm": "Present continuous form"
}
```

**Example**:
```json
{
  "content": "Run test suite and verify all tests pass",
  "status": "in_progress",
  "activeForm": "Running test suite and verifying all tests pass"
}
```

## Decision Framework Flowchart

```
Question or Decision
        ↓
Is it documented? → YES → Follow documented approach
        ↓ NO
Is it reversible? → YES → Decide and proceed
        ↓ NO
Is it high-stakes? → YES → Ask user
        ↓ NO
Significant tradeoffs? → YES → Present options
        ↓ NO
Intent clear? → YES → Decide and proceed
        ↓ NO
Ask for clarification
```

## Troubleshooting

### Symlinks Broken?
```bash
./scripts/check-symlinks.sh
# Shows which symlinks are broken and where they point
```

### Can't Find Information?
```bash
./scripts/search-learnings.sh "search term"
# Or use interactive:
./scripts/quick-find.sh
```

### Tests Failing?
```bash
./tests/run-all-tests.sh
# Shows which validation tests fail and why
```

### Version Inconsistent?
```bash
./tests/versions.test.sh
# Checks all files have matching version numbers
```

## Key Metrics

- **6,800+ lines** of documentation
- **19 files** across repository
- **3 active projects** integrated
- **v2.4.0** current version
- **0 seconds** context loading (automatic)
- **98%** test coverage target
- **100%** symlink integrity

## Philosophy

> "AI assistants should understand how I work once and apply it consistently everywhere."

## Core Innovations

1. **Auto-Load System** - Zero manual context loading
2. **Three-Tier Docs** - Quick/Comprehensive/Project-specific
3. **Symlink Pattern** - Edit once, available everywhere
4. **Version Control** - Track preference evolution
5. **Mermaid Diagrams** - Visual workflows
6. **Test Suite** - Validate integrity
7. **ACTIVE_TODOS.md** - Session persistence
8. **Multi-Window Support** - Parallel work coordination
9. **TERM_DICTIONARY** - Consistent terminology
10. **Interface Verification** - Expected behavior checks

---

## Most Important Takeaways

### For AI Agents
1. Read [AI_QUICKSTART.md](AI_QUICKSTART.md) FIRST (always)
2. Use TodoWrite for 2+ step tasks (before starting)
3. Complete implementations fully (zero TODOs)
4. Zero tolerance for test failures
5. Work autonomously when "be critical and continue"

### For Developers
1. Read [README.md](README.md) for overview
2. Use [SETUP_GUIDE.md](SETUP_GUIDE.md) to create your own
3. Check [EXAMPLES.md](EXAMPLES.md) for conversation patterns
4. Run `./tests/run-all-tests.sh` to validate
5. Use `./add-project.sh` to add projects

### For Maintenance
1. Update daily (project files, terms)
2. Review weekly (consolidate learnings)
3. Bump monthly (AI_QUICKSTART, version)
4. Verify quarterly (symlinks, patterns)
5. Commit frequently (track evolution)

---

**Quick Access Links**

- [AI_QUICKSTART.md](AI_QUICKSTART.md) - Start here
- [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) - Complete guide
- [TERM_DICTIONARY.md](TERM_DICTIONARY.md) - Terminology
- [EXAMPLES.md](EXAMPLES.md) - Patterns
- [ARCHITECTURE.md](ARCHITECTURE.md) - System design
- [projects/README.md](projects/README.md) - Project access

---

**End of Quick Reference**
