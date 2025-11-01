---
title: "Cory's Centralized Learnings Repository"
description: "Single source of truth for preferences and learnings"
version: "2.9"
last_updated: "2025-11-01"
type: "repository-readme"
audience: ["ai-agents", "developers", "teams"]
tags: ["documentation", "learnings", "repository-structure"]
---

# Cory's Centralized Learnings Repository

**Single source of truth for development preferences, working style, and project-specific learnings across all Calm projects.**

**Version**: 2.9 | **Last Updated**: 2025-11-01

---

## Quick Start

### 🚀 Start Here: [INDEX.md](INDEX.md)
Fast navigation guide with links to all documentation and resources.

### For AI Agents
**Recommended reading order**:
1. [MASTER_LEARNINGS_SUMMARY.md](MASTER_LEARNINGS_SUMMARY.md) (380 lines, 5 min) - Essential rules
2. [AI_QUICKSTART.md](AI_QUICKSTART.md) (605 lines, 8 min) - Complete workflow
3. Reference [.claude/EFFICIENT_SEARCH.md](.claude/EFFICIENT_SEARCH.md) for fast lookups

**Critical rules**: Todo lists for 2+ step tasks • Zero TODOs in code • Zero tolerance for failing tests • Work autonomously

### For Humans
- [INDEX.md](INDEX.md) - Complete navigation
- [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) - Comprehensive reference
- [TERM_DICTIONARY.md](TERM_DICTIONARY.md) - Terminology

### For Project Work
- **[AGENTS.md](projects/AGENTS.md.template)** in each project (calm-couples, qa-automation, calm-ai-project-manager)
  - Quick entry points, common tasks, code patterns
- **[Decision Trees](docs/DECISION_TREES.md)** - 10 systematic frameworks for consistent decisions
- **[Tools Selection Guide](docs/TOOLS_SELECTION_GUIDE.md)** - How to evaluate and choose technologies
- **[CI/CD Cost Tracking](docs/CI_CD_COST_TRACKING.md)** - GitHub Actions workflow for commit tracking
- **[Pattern Library](docs/patterns/)** - Copy-paste templates for logging, testing, error handling
- **[Integration Map](docs/INTEGRATION_MAP.md)** - How projects connect and share data

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
├── docs/                            # Comprehensive guides and analysis
│   ├── DECISION_TREES.md            # 10 frameworks for consistent decisions
│   ├── TOOLS_SELECTION_GUIDE.md     # Tech evaluation and selection
│   ├── CI_CD_COST_TRACKING.md       # GitHub Actions commit tracking
│   ├── INTEGRATION_MAP.md           # Project connections and data flow
│   ├── PROJECT_PAIN_POINTS.md       # Cross-project known issues
│   └── cost-optimization/           # Token efficiency resources
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
    ├── qa-automation.md             # QA automation testing framework
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

This repository includes comprehensive cost analysis and optimization guides.

### 💰 Current Costs (as of 2025-10-31)

| Metric | Amount |
|--------|--------|
| **Current Monthly** | $277 - $1,925 |
| **Optimized Monthly** | $130 - $900 |
| **Potential Savings** | $147 - $1,025/month |
| **Savings %** | 47-53% |

### Project Breakdown
- **calm-couples**: $42-316/month → $25-190/month (40% savings)
- **qa-automation**: $175-415/month → $45-110/month (60-70% savings)
- **calm-ai-project-manager**: $60-1,194/month → $60-600/month (50% savings)

**Primary Cost Drivers**: Supabase (calm-couples), Claude API (qa-automation), Claude API (calm-ai-project-manager)

### 💻 Cost Tracking & Dashboard

**Start the Cost Dashboard**:
```bash
node cost-tracking-dashboard.js
# Opens: http://localhost:5000
```

**Log Token Usage**:
```bash
# After completing work
token-tracker.sh log <project> <task> <tokens>

# Examples
token-tracker.sh log calm-ai-pm "Add AGENTS.md" 3500
token-tracker.sh log qa-automation "Fix flaky test" 2800
```

**Cost Tracking Guide**:
1. **Start dashboard**: `node cost-tracking-dashboard.js` (http://localhost:5000)
2. **Log work**: `token-tracker.sh log <project> <task> <tokens>`
3. **Review analytics**: View by project, date, task type in dashboard
4. **Optimize**: Use [TOKEN_EFFICIENCY.md](docs/cost-optimization/TOKEN_EFFICIENCY.md) to reduce costs
5. **Plan budget**: Check trends in [COMPREHENSIVE_COST_ANALYSIS.md](docs/cost-optimization/COMPREHENSIVE_COST_ANALYSIS.md)

**Resources**:
- 📊 [COST_DASHBOARD_GUIDE.md](docs/COST_DASHBOARD_GUIDE.md) - Full dashboard documentation
- 📈 [TOKEN_EFFICIENCY.md](docs/cost-optimization/TOKEN_EFFICIENCY.md) - Optimization guidelines
- 💰 [COMPREHENSIVE_COST_ANALYSIS.md](docs/cost-optimization/COMPREHENSIVE_COST_ANALYSIS.md) - Current costs analysis
- 🎯 [COST_SAVINGS_GUIDE.md](docs/cost-optimization/COST_SAVINGS_GUIDE.md) - Reduction strategies

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

### Core Files (Root)
| File | Purpose |
|------|---------|
| [AI_QUICKSTART.md](AI_QUICKSTART.md) | Quick reference for AI agents |
| [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) | Comprehensive preferences guide |
| [MASTER_LEARNINGS_SUMMARY.md](MASTER_LEARNINGS_SUMMARY.md) | Executive summary of key learnings |
| [TERM_DICTIONARY.md](TERM_DICTIONARY.md) | Terminology reference |
| [CHANGELOG.md](CHANGELOG.md) | Version history |
| [INDEX.md](INDEX.md) | Navigation index for all documentation |
| [AI_AGENT_IMPROVEMENTS.md](AI_AGENT_IMPROVEMENTS.md) | Tools and patterns for AI agent optimization |

### Cost Optimization (docs/cost-optimization/)
| File | Purpose |
|------|---------|
| [COMPREHENSIVE_COST_ANALYSIS.md](docs/cost-optimization/COMPREHENSIVE_COST_ANALYSIS.md) | Complete analysis across all projects |
| [TOKEN_EFFICIENCY.md](docs/cost-optimization/TOKEN_EFFICIENCY.md) | Token usage optimization guidelines |
| [COST_SAVINGS_GUIDE.md](docs/cost-optimization/COST_SAVINGS_GUIDE.md) | Dependency sync cost reduction strategies |
| [COST_TIERS.md](docs/cost-optimization/COST_TIERS.md) | Cost optimization roadmap |

---

## Project Symlinks

Each project directory maintains a symlink to its central learnings file:

```bash
~/Desktop/calm/calm-couples/CORY_LEARNINGS.md
  → ~/cory-learnings/projects/calm-couples.md

~/Desktop/calm/qa-automation/CORY_LEARNINGS.md
  → ~/cory-learnings/projects/qa-automation.md

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
- **Review infrastructure costs quarterly**

### Quarterly Review
- Identify patterns to elevate to MASTER_LEARNINGS.md
- Remove outdated information
- Update version in CHANGELOG.md

### Quarterly Cost Review
1. **Check actual vs projected costs** in each project's billing dashboard
2. **Update [COMPREHENSIVE_COST_ANALYSIS.md](docs/cost-optimization/COMPREHENSIVE_COST_ANALYSIS.md)** with new figures
3. **Verify optimization savings** from implemented strategies
4. **Identify new cost drivers** or changes in usage patterns
5. **Update the "Current Costs" table** in this README with date and amounts

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
