---
title: "Project Quick Reference"
description: "Quick-access cards for all Cory's projects"
version: "1.0"
last_updated: "2025-10-30"
type: "project-index"
---

# Project Quick Reference

**Purpose**: Fast access to project context and key information
**Usage**: Scan this before diving into project-specific learnings

---

## Project Overview Table

| Project | Status | Type | Stack | Tests | Location |
|---------|--------|------|-------|-------|----------|
| **calm-couples** | 🟢 Production | Web App | React + Supabase | 63/63 ✅ | [Details](#calm-couples) |
| **ios-automation** | 🟡 In Progress | Test Framework | IDB + Appium | 648/648 ✅ | [Details](#ios-automation) |
| **calm-ai-pm** | 🟢 v1.1.0 | Backend API | Node + Prisma | TBD | [Details](#calm-ai-project-manager) |

---

## calm-couples

### Quick Facts
```yaml
Type: Relationship wellness platform with gamification
Status: MVP complete, production-ready
Version: Latest
Stack: React 19 + TypeScript + Supabase + Tailwind CSS
Database: PostgreSQL (via Supabase)
Deployment: Vercel
```

### Key Metrics
- **Tests**: 63 tests passing
- **Coverage**: 98% target
- **Performance**: FCP <1.5s, TTI <3s
- **Bundle Size**: <500KB target

### Key Features
- 3D isometric plant system (petals gamification)
- Real-time relationship activities
- GDPR compliance (data export/deletion)
- Race condition fixes with optimistic locking
- Atomic RPC operations for data consistency

### Important Files
- **Learnings**: [calm-couples.md](calm-couples.md) (541 lines)
- **AGENTS.md**: `~/Desktop/calm/calm-couples/AGENTS.md`
- **Supabase**: `~/Desktop/calm/calm-couples/src/lib/supabase/`

### Tech Stack Details
```yaml
Frontend:
  - React 19 (latest features)
  - TypeScript (strict mode)
  - Tailwind CSS (utility-first)
  - Zustand (state management)
  - Three.js (3D visualization)

Backend:
  - Supabase (BaaS)
  - PostgreSQL (database)
  - Row Level Security (RLS)
  - Edge Functions (serverless)
  - Realtime subscriptions

Testing:
  - Vitest (unit tests)
  - 63 tests passing
  - 98% coverage target
```

### Common Tasks
- Add features → Follow component patterns
- Fix race conditions → Use RPC + optimistic locking
- Database changes → Use Supabase SQL Editor
- Deploy → Vercel automatic on push

### Quick Commands
```bash
# Navigate to project
cd ~/Desktop/calm/calm-couples

# Development
npm run dev              # Start dev server (localhost:3000)
npm test                 # Run all tests
npm run build            # Production build
npm run lint             # Lint check

# Git workflow
git status               # Check changes
git add . && git commit  # Commit changes
git push                 # Deploy via Vercel

# Supabase
npx supabase status      # Check Supabase connection
npx supabase db reset    # Reset local database
```

### Key Challenges Solved
- ✅ Race conditions in petal increment
- ✅ Optimistic locking with version fields
- ✅ GDPR compliance implementation
- ✅ 3D plant system performance
- ✅ Real-time state synchronization

---

## ios-automation

### Quick Facts
```yaml
Type: E2E testing framework for Calm iOS app
Status: Framework validated (8/10), Test suite in progress (2/10)
Stack: IDB + Appium + Tesseract OCR + Vision AI
Platform: iOS (simulators and devices)
Language: Node.js + TypeScript
```

### Key Metrics
- **Framework Status**: 8/10 (validated)
- **Test Suite**: 2/10 (in progress)
- **Unit Tests**: 648 passing
- **E2E Tests**: 3 implemented
- **Target**: 100+ E2E tests

### Key Features
- Custom test framework (IDB + Appium + OCR + Vision AI)
- iOS simulator control via IDB
- Screenshot-based verification with OCR
- AI-powered visual validation
- Test isolation and state management

### Important Files
- **Learnings**: [ios-automation.md](ios-automation.md) (272 lines)
- **AGENTS.md**: `~/Desktop/calm/ios-automation/AGENTS.md`
- **Tests**: `~/Desktop/calm/ios-automation/src/`
- **Unit Tests**: `~/Desktop/calm/ios-automation/tests/`

### Tech Stack Details
```yaml
Core Framework:
  - IDB (iOS Development Bridge)
  - Appium (mobile automation)
  - Tesseract OCR (text recognition)
  - Vision AI (visual verification)
  - XCTest (native iOS testing)

Testing:
  - Jest (unit tests)
  - 648 unit tests passing
  - Custom E2E framework
  - 3 E2E tests implemented

Tools:
  - xcrun simctl (simulator control)
  - xcodebuild (build automation)
  - idb_companion (device bridge)
```

### Common Tasks
- Write E2E tests → Follow test patterns in src/
- Handle modals → Use modal dismissal utilities
- Debug tests → Check screenshots + logs
- Run tests → npm test (unit) or custom E2E runner

### Quick Commands
```bash
# Navigate to project
cd ~/Desktop/calm/ios-automation

# Development
npm test                           # Run unit tests (648 tests)
node src/e2e-runner.js            # Run E2E tests
npm run lint                       # Lint check

# iOS Simulator Management
xcrun simctl list devices          # List available simulators
idb list-targets                   # List IDB targets
idb boot <udid>                    # Boot simulator
idb launch com.calm.Calm           # Launch Calm app

# Debugging
ls screenshots/                    # Check test screenshots
tail -f logs/test-run.log         # View test logs
idb ui describe                    # Get UI hierarchy

# Git workflow
git status && git diff             # Review changes
git add . && git commit            # Commit changes
```

### Key Challenges
- ⚠️ Test isolation (in progress)
- ⚠️ Modal dismissal (partially solved)
- ⚠️ State management between tests
- ✅ Screenshot verification
- ✅ OCR text reading

---

## calm-ai-project-manager

### Quick Facts
```yaml
Type: AI-powered project management tool
Status: v1.1.0 released
Stack: Node.js + Express + Prisma + SQLite + Claude 3.5
Philosophy: AI enhances, never blocks functionality
Deployment: Local/Self-hosted
```

### Key Metrics
- **Version**: v1.1.0
- **Database**: SQLite (dev) → PostgreSQL (prod ready)
- **AI Model**: Claude 3.5 Sonnet
- **Test Status**: TBD

### Key Features
- Task and project management
- RCI matrix (Responsible, Consulted, Informed)
- Knowledge base (AI tools directory, FAQs)
- Team wellness (mood, kudos, celebrations, 1-on-1s)
- PTL checklists (pre-launch requirements)
- AI-powered insights (optional, graceful degradation)

### Important Files
- **Learnings**: [calm-ai-project-manager.md](calm-ai-project-manager.md) (426 lines)
- **AGENTS.md**: `~/Desktop/calm/calm-ai-project-manager/AGENTS.md`
- **Source**: `~/Desktop/calm/calm-ai-project-manager/src/`
- **Migrations**: `~/Desktop/calm/calm-ai-project-manager/migrations/`

### Tech Stack Details
```yaml
Backend:
  - Node.js (runtime)
  - Express (web framework)
  - Prisma ORM (database)
  - SQLite (dev database)
  - PostgreSQL ready (prod)

AI Integration:
  - Anthropic Claude 3.5 Sonnet
  - Optional (graceful degradation)
  - Enhances but never blocks

Features:
  - Task management
  - Project tracking
  - RCI decision matrix
  - Knowledge base
  - Team wellness tools
  - PTL checklists
```

### Common Tasks
- Add features → Ensure AI is optional
- Database changes → Prisma migrations
- AI features → Graceful degradation required
- Deploy → Self-hosted instructions in docs

### Quick Commands
```bash
# Navigate to project
cd ~/Desktop/calm/calm-ai-project-manager

# Development
npm run dev                        # Start dev server
npm test                           # Run tests
npm run build                      # Build for production
npm start                          # Run production build

# Database
npx prisma migrate dev             # Create migration
npx prisma studio                  # Open DB GUI
npx prisma generate                # Generate Prisma client
npx prisma db push                 # Push schema changes

# Testing
npm test -- --watch                # Watch mode
npm run test:coverage              # Coverage report

# Git workflow
git status                         # Check changes
git add . && git commit            # Commit changes
git push                           # Push to remote
```

### Key Philosophy
- **AI Optional**: Core features work without AI
- **Graceful Degradation**: AI enhances but never blocks
- **Team First**: Culture and wellness matter
- **Comprehensive**: Launch checklists ensure nothing forgotten

---

## Quick Access Commands

```bash
# Navigate to projects
cd ~/Desktop/calm/calm-couples
cd ~/Desktop/calm/ios-automation
cd ~/Desktop/calm/calm-ai-project-manager

# Read learnings
cat ~/cory-learnings/projects/calm-couples.md
cat ~/cory-learnings/projects/ios-automation.md
cat ~/cory-learnings/projects/calm-ai-project-manager.md

# Load project context in Claude Code
/project-context

# View AGENTS.md
cd ~/Desktop/calm/calm-couples && cat AGENTS.md
```

---

## Status Legend

- 🟢 **Production/Stable**: Ready for use, actively maintained
- 🟡 **In Progress**: Under active development
- 🔴 **Blocked**: Waiting on dependencies or decisions
- ⚠️ **Challenge**: Known issues being addressed
- ✅ **Solved**: Challenge successfully resolved

---

## Common Patterns Across Projects

### Code Quality
- **Testing**: Zero tolerance for failing tests
- **TypeScript**: Strict mode, zero 'any'
- **Logging**: Structured logger (not console.log)
- **TODOs**: None allowed in code (complete implementations)

### Development Workflow
- **Todo Lists**: Always for 2+ steps
- **Autonomous**: Work without permission
- **Testing**: Run and verify after changes
- **Commits**: Semantic versioning, conventional format

### When to Ask
- **High Stakes**: Destructive operations, breaking changes
- **Ambiguity**: Multiple valid approaches with tradeoffs
- **Production**: Changes affecting production systems
- **Never**: Standard operations, documented patterns

---

## Next Steps

**When starting work on a project**:
1. Read this quick reference
2. Review project-specific learnings file
3. Check AGENTS.md for current architecture
4. Run git status to see current state
5. Create todo list if 2+ steps
6. Execute autonomously

---

**Last Updated**: 2025-10-30
**Maintained by**: Cory Weinstein
**Related**: [MASTER_LEARNINGS.md](../MASTER_LEARNINGS.md) | [AI_QUICKSTART.md](../AI_QUICKSTART.md)
