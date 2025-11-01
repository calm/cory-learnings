---
title: "Cory's Centralized Learnings Repository"
description: "Single source of truth for preferences and learnings"
version: "2.4"
last_updated: "2025-10-30"
type: "repository-readme"
audience: ["ai-agents", "developers", "teams"]
tags: ["documentation", "learnings", "repository-structure"]
---

# Cory's Centralized Learnings Repository

**Single source of truth for development preferences, working style, and project-specific learnings across all Calm projects.**

**Version**: 2.5 | **Last Updated**: 2025-10-31

---

## Quick Start

### For AI Agents
Read [AI_QUICKSTART.md](AI_QUICKSTART.md) first (481 lines) for essential working principles, then reference project-specific files as needed.

**Critical rules**: Todo lists for 2+ step tasks • Zero TODOs in code • Zero tolerance for failing tests • Work autonomously • Verify localhost before commits

### For Humans
View [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) (940 lines) for comprehensive preferences or browse [projects/](projects/) for project-specific context.

---

## Repository Structure

```
cory-learnings/
├── README.md                        # This file
├── AI_QUICKSTART.md                 # Quick reference for AI agents
├── MASTER_LEARNINGS.md              # Comprehensive preferences guide
├── TERM_DICTIONARY.md               # Comprehensive terminology reference (50+ terms)
├── EXAMPLES.md                      # Conversation patterns (good vs bad)
├── CHANGELOG.md                     # Version history
├── TEMPLATE_NEW_PROJECT.md          # New project template
├── README_BEST_PRACTICES.md         # README guidelines and standards
├── TEMPLATE_README.md               # Ready-to-use README template
├── ACTIVE_TODOS.md                  # Persistent todos across sessions
├── add-project.sh                   # Project addition script
├── scripts/                         # Validation and search tools
│   ├── check-symlinks.sh           # Verify project symlinks
│   ├── validate-structure.sh       # Check repository integrity
│   ├── find-broken-links.sh        # Find broken references
│   ├── search-learnings.sh         # Search across files
│   └── quick-find.sh               # Interactive search menu
├── tests/                           # Repository validation tests
│   ├── run-all-tests.sh            # Run full test suite
│   ├── structure.test.sh           # Validate file structure
│   ├── frontmatter.test.sh         # Validate YAML frontmatter
│   ├── markdown.test.sh            # Validate markdown syntax
│   └── versions.test.sh            # Validate version consistency
└── projects/                        # Project-specific learnings
    ├── README.md                    # Project quick reference
    ├── calm-couples.md              # React/Supabase wellness platform
    ├── ios-automation.md            # iOS E2E testing framework
    └── calm-ai-project-manager.md  # Node.js AI project manager
```

**Total Content**: 10,000+ lines across 27 markdown files

---

## Key Features

- **Centralized**: Single location for all learnings with git version control
- **Symlinked**: Project directories link to central files for seamless access
- **Searchable**: Grep across all projects simultaneously
- **Versioned**: Track preference evolution with semantic versioning (v2.3)
- **Automated**: Auto-loads into Claude Code sessions via hooks

---

## Cost Optimization Initiatives

This repository now includes comprehensive cost optimization guides for all projects:

**Total Potential Savings: $26,256/year**

- **ios-automation** ($15,949/year): Storage cleanup + test optimization + device matrix
- **calm-couples** ($4,080/year): Query optimization + caching + bundle reduction
- **calm-ai-project-manager** ($4,830/year): API caching + token optimization + service consolidation
- **Dependency Sync** ($639/year): Auto-update system already deployed
- **Repository Management** ($750/year): Token efficiency gains

**Quick Start:**
See [WEEK1_IMPLEMENTATION_SUMMARY.md](WEEK1_IMPLEMENTATION_SUMMARY.md) for ready-to-deploy code (3 hours = $2,670/year savings, 22:1 ROI) or [ALL_PROJECTS_COST_ANALYSIS.md](ALL_PROJECTS_COST_ANALYSIS.md) for full analysis.

---

## Usage

### Search Learnings
```bash
cd ~/cory-learnings
./scripts/search-learnings.sh "testing"          # Search main files
./scripts/search-learnings.sh "RLS" --all        # Search all files
./scripts/quick-find.sh                          # Interactive menu
```

### Run Tests
```bash
cd ~/cory-learnings
./tests/run-all-tests.sh              # Run all validation tests

# Repository validation tests
./tests/structure.test.sh             # Test repository structure
./tests/frontmatter.test.sh           # Test YAML frontmatter
./tests/markdown.test.sh              # Test markdown syntax
./tests/versions.test.sh              # Test version consistency

# AI agent compliance tests
./tests/ai-agent-compliance.test.sh   # Test AI agent behavior compliance
./tests/code-quality.test.sh          # Test code quality standards
./tests/todo-patterns.test.sh         # Test todo list patterns
```

**Test Coverage**:
- ✅ File structure validation
- ✅ YAML frontmatter validation
- ✅ Markdown syntax validation
- ✅ Version consistency checks
- ✅ AI agent behavior compliance
- ✅ Code quality standards (no TODOs, console.log, TypeScript strict)
- ✅ Todo list pattern validation

### Validate Repository
```bash
cd ~/cory-learnings/scripts
./validate-structure.sh      # Check file structure
./check-symlinks.sh          # Verify project symlinks
./find-broken-links.sh       # Find broken markdown links
```

### Update Learnings
```bash
# Edit files directly or via project symlinks
vim ~/cory-learnings/projects/calm-couples.md
vim ~/Desktop/calm/calm-couples/CORY_LEARNINGS.md  # Same file via symlink

# Commit changes
cd ~/cory-learnings
git add . && git commit -m "docs: update calm-couples testing requirements"
```

### Add New Project
```bash
cd ~/cory-learnings
./add-project.sh new-project-name
# Creates learnings file and symlink
```

### Test AI Agent Compliance
```bash
# Test that AI agents are following documented principles
cd ~/cory-learnings
./tests/ai-agent-compliance.test.sh

# Test code quality in a specific project
./tests/code-quality.test.sh ~/Desktop/calm/calm-couples

# Test with verbose output for detailed violations
VERBOSE=true ./tests/code-quality.test.sh ~/Desktop/calm/calm-couples

# Validate todo list patterns
./tests/todo-patterns.test.sh
```

**AI Agent Tests**:
- `ai-agent-compliance.test.sh` - Validates AI agents follow documented principles
  - Code quality standards (no TODO comments, no console.log)
  - Documentation structure (AI_QUICKSTART.md, TERM_DICTIONARY.md)
  - Testing standards (98% coverage, no skipped tests)
  - Workflow patterns (conventional commits, Claude attribution)
  - Repository integrity (required files, version consistency)

- `code-quality.test.sh` - Real-time code quality validation during development
  - Can be run as pre-commit hook
  - Checks specific project directories
  - Identifies critical violations vs warnings
  - Use VERBOSE=true for detailed output

- `todo-patterns.test.sh` - Validates todo list management
  - ACTIVE_TODOS.md structure and formatting
  - Descriptive todo content (not vague)
  - Multi-window coordination patterns
  - Documentation consistency

---

## Documentation Files

| File | Purpose | Lines |
|------|---------|-------|
| [AI_QUICKSTART.md](AI_QUICKSTART.md) | Quick reference for AI agents | 540 |
| [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) | Comprehensive preferences guide | 940 |
| [TOKEN_EFFICIENCY.md](TOKEN_EFFICIENCY.md) | Token optimization guidelines | 1190 |
| [EXECUTIVE_SUMMARY.md](EXECUTIVE_SUMMARY.md) | High-level system overview | 500+ |
| [ARCHITECTURE.md](ARCHITECTURE.md) | System design and technical details | 600+ |
| [LEARNING_PATH.md](LEARNING_PATH.md) | Structured learning guide | 650+ |
| [QUICK_REFERENCE.md](QUICK_REFERENCE.md) | One-page cheat sheet | 400+ |
| [LEARNINGS_COST_OPTIMIZATION.md](LEARNINGS_COST_OPTIMIZATION.md) | Institutional cost optimization knowledge | 650+ |
| [WEEK1_IMPLEMENTATION_SUMMARY.md](WEEK1_IMPLEMENTATION_SUMMARY.md) | Complete ready-to-deploy implementation guide | 450+ |
| [QUICK_COST_WINS.md](QUICK_COST_WINS.md) | Ready-to-implement week 1 savings | 350+ |
| [cache-implementation.js](cache-implementation.js) | Drop-in API caching layer ($1,560/year) | 250+ |
| [COMPREHENSIVE_COST_ANALYSIS.md](COMPREHENSIVE_COST_ANALYSIS.md) | Cost projections and analysis | 380+ |
| [ALL_PROJECTS_COST_ANALYSIS.md](ALL_PROJECTS_COST_ANALYSIS.md) | Complete cost analysis across all projects | 550+ |
| [COST_SAVINGS_GUIDE.md](COST_SAVINGS_GUIDE.md) | Dependency sync cost savings | 400+ |
| [COST_TIERS.md](COST_TIERS.md) | Cost optimization roadmap | 350+ |
| [IOS_AUTOMATION_COST_SAVINGS.md](IOS_AUTOMATION_COST_SAVINGS.md) | ios-automation storage & execution | 866 |
| [CALM_COUPLES_COST_SAVINGS.md](CALM_COUPLES_COST_SAVINGS.md) | calm-couples optimization | 427 |
| [CALM_AI_PM_COST_SAVINGS.md](CALM_AI_PM_COST_SAVINGS.md) | calm-ai-project-manager optimization | 439 |
| [TERM_DICTIONARY.md](TERM_DICTIONARY.md) | Terminology reference | 600+ |
| [EXAMPLES.md](EXAMPLES.md) | Conversation patterns | 513 |
| [CHANGELOG.md](CHANGELOG.md) | Version history | 169 |
| [projects/README.md](projects/README.md) | Project overview | 296 |

---

## Project Symlinks

Each project directory maintains a symlink to its central learnings file:

```bash
~/Desktop/calm/calm-couples/CORY_LEARNINGS.md
  → ~/cory-learnings/projects/calm-couples.md

~/Desktop/calm/ios-automation/CORY_LEARNINGS.md
  → ~/cory-learnings/projects/ios-automation.md

~/Desktop/calm/calm-ai-project-manager/Cory learnings.md
  → ~/cory-learnings/projects/calm-ai-project-manager.md
```

Changes made to either location are immediately reflected in both.

---

## Git Workflow

```bash
# View changes
git status && git diff

# Commit updates
git add . && git commit -m "docs: [description]"

# View history
git log --oneline
git log --follow projects/calm-couples.md    # File-specific history
```

---

## Maintenance

### Regular Tasks
- Update learnings after significant sessions
- Review and consolidate monthly
- Commit changes with semantic versioning
- Verify symlinks quarterly

### Quarterly Review
- Identify patterns to elevate to MASTER_LEARNINGS.md
- Remove outdated information
- Update version in CHANGELOG.md

---

## Version History

| Version | Date | Key Changes |
|---------|------|-------------|
| 2.4.0 | 2025-10-30 | Interface verification, port management, README guidelines |
| 2.3.0 | 2025-10-30 | Validation scripts, search helpers, TOC, optimized auto-load |
| 2.2.0 | 2025-10-30 | FAQ, Glossary, Session Checklist, Mermaid diagrams |
| 2.1.0 | 2025-10-30 | When to ask guidance, examples, slash commands |
| 2.0.0 | 2025-10-30 | AI optimization, structured metadata |
| 1.0.0 | 2025-10-29 | Initial centralized repository |

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

---

**Maintained by**: Cory Weinstein
**Related**: [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) | [AI_QUICKSTART.md](AI_QUICKSTART.md) | [EXAMPLES.md](EXAMPLES.md)
