---
title: "Cory's Centralized Learnings Repository"
description: "Single source of truth for preferences and learnings"
version: "2.0"
last_updated: "2025-10-30"
type: "repository-readme"
audience: ["ai-agents", "developers", "teams"]
tags: ["documentation", "learnings", "repository-structure"]
---

# Cory's Centralized Learnings Repository

**Purpose**: Single source of truth for Cory's preferences, working style, decisions, and learnings across all projects.

**Last Updated**: 2025-10-30

---

## What This Is

This repository centralizes all "Cory learnings" files from various projects. Instead of scattered learnings files, everything is in one place with version control, search, and history.

### Benefits
- ✅ **Single Source of Truth** - One place for all learnings
- ✅ **Version Control** - Track how preferences evolve over time
- ✅ **Searchable** - Grep/search across all projects at once
- ✅ **Accessible** - Access from anywhere, not buried in project folders
- ✅ **Symlinked** - Each project still has its learnings file (via symlink)

---

## Repository Structure

```
cory-learnings/
├── README.md                           # This file - Repository guide
├── AI_QUICKSTART.md                    # ⚡ Quick reference for AI agents (READ FIRST)
├── MASTER_LEARNINGS.md                 # Comprehensive aggregated learnings
├── TEMPLATE_NEW_PROJECT.md             # Template for new project learnings
├── add-project.sh                      # Script to add new project
├── projects/                           # Individual project learnings
│   ├── calm-couples.md                # calm-couples project (541 lines)
│   ├── ios-automation.md              # ios-automation project (272 lines)
│   └── calm-ai-project-manager.md     # calm-ai-project-manager project (426 lines)
└── .git/                              # Version control
```

**Key Files**:
- **AI_QUICKSTART.md** - Ultra-concise reference for AI agents (200 lines)
- **MASTER_LEARNINGS.md** - Complete reference with all patterns (470 lines)
- **README.md** - Repository documentation and usage guide

---

## How It Works

### Symlinks
Each project directory has a **symlink** that points to this central repository:

```bash
# calm-couples
~/Desktop/calm/calm-couples/CORY_LEARNINGS.md
  -> ~/cory-learnings/projects/calm-couples.md

# ios-automation
~/Desktop/calm/ios-automation/CORY_LEARNINGS.md
  -> ~/cory-learnings/projects/ios-automation.md

# calm-ai-project-manager
~/Desktop/calm/calm-ai-project-manager/Cory learnings.md
  -> ~/cory-learnings/projects/calm-ai-project-manager.md
```

**What this means**:
- Edit the file in the project directory → edits the central repo version
- Changes are immediately visible in both places
- Commit from either location

---

## Usage

### For AI Agents (START HERE)

**Quick Start (Read First)**:
```bash
cat ~/cory-learnings/AI_QUICKSTART.md
```
This 200-line file contains everything you need to work effectively with Cory.

**Detailed Reference**:
```bash
cat ~/cory-learnings/MASTER_LEARNINGS.md
```
Comprehensive 470-line guide with all preferences, standards, and patterns.

**Project-Specific Context**:
```bash
cat ~/cory-learnings/projects/calm-couples.md
cat ~/cory-learnings/projects/ios-automation.md
cat ~/cory-learnings/projects/calm-ai-project-manager.md
```

**AI Agent Workflow**:
1. Read `AI_QUICKSTART.md` at session start
2. Review project-specific learnings for context
3. Follow critical rules (todo lists, complete implementations, testing)
4. Work autonomously using patterns documented
5. Update learnings if new insights emerge

**Key Principles for AI Agents**:
- ✅ Create optimized todo list BEFORE starting (if 2+ steps)
- ✅ Complete implementations - ZERO TODOs in code
- ✅ Run tests and verify they pass - zero tolerance for failures
- ✅ Work autonomously without asking permission repeatedly
- ✅ Be brutally honest about what's broken vs working
- ✅ Mark exactly ONE todo as in_progress at a time
- ✅ Mark todos completed IMMEDIATELY after finishing

### Reading Learnings (Humans)

**View master learnings (aggregated)**:
```bash
cd ~/cory-learnings
cat MASTER_LEARNINGS.md
```

**View project-specific learnings**:
```bash
cd ~/cory-learnings/projects
cat calm-couples.md
cat ios-automation.md
cat calm-ai-project-manager.md
```

**Search across all learnings**:
```bash
cd ~/cory-learnings
grep -r "be critical" .
grep -r "test" projects/
```

### Updating Learnings

**Option 1: Edit from project directory**:
```bash
cd ~/Desktop/calm/calm-couples
vim CORY_LEARNINGS.md  # Actually edits ~/cory-learnings/projects/calm-couples.md
```

**Option 2: Edit from central repo**:
```bash
cd ~/cory-learnings/projects
vim calm-couples.md
```

**After editing, commit changes**:
```bash
cd ~/cory-learnings
git add .
git commit -m "docs: update calm-couples learnings - add new testing preferences"
git push  # If you set up a remote
```

### Adding a New Project

When starting a new project that needs a learnings file:

1. **Create the learnings file in central repo**:
```bash
cd ~/cory-learnings/projects
touch new-project.md
# Add initial content
```

2. **Create symlink from project directory**:
```bash
cd ~/path/to/new-project
ln -s ~/cory-learnings/projects/new-project.md CORY_LEARNINGS.md
```

3. **Commit to central repo**:
```bash
cd ~/cory-learnings
git add projects/new-project.md
git commit -m "docs: add learnings file for new-project"
```

---

## Git Workflow

### Initial Setup (Already Done)
```bash
cd ~/cory-learnings
git init
git add .
git commit -m "feat: initialize centralized learnings repository"
```

### Optional: Add Remote (GitHub/GitLab)
```bash
cd ~/cory-learnings
git remote add origin https://github.com/coryweinstein/cory-learnings.git
git push -u origin main
```

### Regular Updates
```bash
cd ~/cory-learnings
git status                 # See what changed
git diff                   # Review changes
git add .                  # Stage changes
git commit -m "docs: update ios-automation learnings"
git push                   # Push to remote (if configured)
```

### View History
```bash
cd ~/cory-learnings
git log                           # See all commits
git log --oneline                 # Compact view
git log --follow projects/calm-couples.md  # History of specific file
```

---

## Master Learnings File

[MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) aggregates common patterns across all projects:

- **Core Working Principles** - "do this yourself", "be critical and continue", etc.
- **Communication Style** - How Cory works, key phrases, what works/what to avoid
- **Code Quality Standards** - Versioning, logging, documentation, testing
- **Technical Preferences** - Architecture, tools, git practices
- **Project Contexts** - Brief overview of each project
- **What Cory Values** - Features, code, documentation, workflow
- **Patterns That Work** - Development flow, problem solving, handling blockers
- **Quality Bars** - Test coverage, TypeScript, performance, code quality
- **Lessons Learned** - Success patterns, common pitfalls
- **Quick Reference** - Starting/during/ending sessions

**When to update**:
- After learning new preferences
- When discovering new patterns
- If priorities change
- Quarterly review recommended

---

## Project-Specific Files

Each project has its own detailed learnings file:

### [calm-couples.md](projects/calm-couples.md)
- React/Supabase relationship wellness platform
- Race condition fixes, testing standards
- 541 lines of detailed learnings

### [ios-automation.md](projects/ios-automation.md)
- iOS E2E testing framework
- Test automation insights, modal handling
- 272 lines of technical learnings

### [calm-ai-project-manager.md](projects/calm-ai-project-manager.md)
- Node.js AI-powered project manager
- Feature evolution, Calm engineering patterns
- 426 lines of project context

---

## Tips

### For AI Agents
Before starting work on any project:
1. Read `MASTER_LEARNINGS.md` for general preferences
2. Read project-specific learnings file for context
3. Follow the patterns documented
4. Update learnings file if new insights emerge

### For Cory
- Keep this repo up to date after significant sessions
- Review quarterly to identify evolving patterns
- Use git history to track preference changes over time
- Search across all files when you can't remember which project had a specific insight

### For Teams
- Share relevant sections with team members
- Use as onboarding material for new AI assistants
- Reference when questions arise about preferences
- Keep project-specific vs universal learnings separate

---

## Maintenance

### Regular Tasks
- ✅ Update learnings files after each significant session
- ✅ Review and update MASTER_LEARNINGS.md monthly
- ✅ Commit changes regularly with descriptive messages
- ✅ Keep symlinks functional (verify occasionally)

### Quarterly Review
- Review all project learnings
- Identify common patterns to add to master
- Remove outdated information
- Consolidate duplicate insights

### If Symlinks Break
```bash
# Verify symlink status
ls -la ~/Desktop/calm/*/CORY_LEARNINGS.md

# Recreate if needed
cd ~/cory-learnings
ln -sf "$(pwd)/projects/calm-couples.md" ~/Desktop/calm/calm-couples/CORY_LEARNINGS.md
```

---

## Quick Commands

```bash
# Navigate to central repo
cd ~/cory-learnings

# View master learnings
less MASTER_LEARNINGS.md

# Search for a pattern
grep -r "autonomous" .

# See recent changes
git log --oneline -10

# View specific file history
git log --follow projects/calm-couples.md

# Update and commit
git add . && git commit -m "docs: update learnings" && git push
```

---

## Future Enhancements

Potential improvements:
- 🔍 Web interface for searching/browsing
- 📊 Analytics on common patterns
- 🔗 Auto-sync to notion or confluence
- 📧 Weekly digest of changes
- 🤖 AI-powered insights extraction

---

## Contact & Support

**Repository Owner**: Cory Weinstein
**Created**: 2025-10-30
**Purpose**: Centralize learnings across all projects

---

*Remember: "be critical and continue" + "do this yourself" + "test all and make sure ok"*
