---
title: "Cory Learnings Changelog"
description: "Track how preferences and standards evolve over time"
version: "2.1"
last_updated: "2025-10-30"
type: "changelog"
---

# Changelog

All notable changes to Cory's learnings and preferences will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.1.0] - 2025-10-30

### Added
- **EXAMPLES.md**: Real conversation patterns showing good vs bad interactions
- **When to Ask for Help**: Comprehensive guidance on when AI should ask vs decide
  - ALWAYS Ask When: High stakes, ambiguity, destructive operations
  - NEVER Ask When: Documented patterns, standard operations
  - Smart questions framework with examples
- **Decision-Making Framework**: 5-step process for autonomous decisions
- **Claude Code Slash Commands**: `/cory-context`, `/load-learnings`, `/project-context`
- **CHANGELOG.md**: This file to track preference evolution
- **Communication Anti-Patterns**: Examples in Common Pitfalls section
- **"When to Ask vs When to Decide"**: Detailed section in Communication Style

### Changed
- Enhanced Common Pitfalls with categorized anti-patterns
- Updated AI Quick Reference with asking guidance
- Clarified autonomous execution expectations

### Philosophy Evolution
- Balance autonomy with verification
- "Default to action when low-stakes, default to verification when high-stakes"
- Smart questions with context and options, not vague asks

---

## [2.0.0] - 2025-10-30

### Added
- **AI_QUICKSTART.md**: Ultra-concise 200-line reference for AI agents
- **AI Quick Reference Section**: Added to top of MASTER_LEARNINGS.md for instant parsing
- **Structured YAML Frontmatter**: Machine-readable metadata in all key files
- **"For AI Agents" Section**: Dedicated usage guide in README.md
- **Core Directives**: Clear MUST DO / NEVER DO lists
- **Communication Protocol Table**: Quick reference for interpreting Cory's phrases
- **Todo List Requirements**: Comprehensive with good vs bad examples
- **Quality Standards**: Testing, TypeScript, versioning, logging
- **When Blocked Workflow**: 5-step process

### Changed
- Repository structure documentation updated
- README reorganized with AI agent workflow prominent
- Navigation improved throughout

### Infrastructure
- Created `~/scripts/` directory for utilities
- Created `~/data/` directory for data files
- Organized home directory (moved 9 Python scripts, 12 data files)
- Added README files to scripts and data directories

### Version Bump
- Version 1.0 → 2.0 (major overhaul for AI consumption)

---

## [1.0.0] - 2025-10-29

### Added - Initial Release
- **MASTER_LEARNINGS.md**: Central aggregated learnings file (447 lines)
- **Core Working Principles**:
  - "Do This Yourself": Complete implementations, no TODOs
  - "Be Critical and Continue": Autonomous quality mindset
  - "Test All and Make Sure OK": Zero tolerance for failures
  - "Do Next Todo": Keep momentum, handle blockers gracefully
- **Communication Style**: How Cory works, key phrases, what works/avoid
- **Task Management**: Todo list standards and workflow
- **Code Quality Standards**: Versioning, logging, documentation, testing
- **Technical Preferences**: Architecture, tools, git practices
- **Project Contexts**: calm-couples, ios-automation, calm-ai-project-manager
- **Patterns That Work**: Development flow, problem solving, when blocked
- **Quality Bars**: Test coverage, TypeScript, performance, code quality
- **Lessons Learned**: Success patterns, common pitfalls

### Repository Structure
- Central repository at `~/cory-learnings/`
- Project-specific learnings in `projects/` subdirectory
- Symlinks from project directories to central repo
- Git version control initialized

### Projects Documented
- **calm-couples**: 541 lines of learnings
- **ios-automation**: 272 lines of learnings
- **calm-ai-project-manager**: 426 lines of learnings

### Automation
- **User Prompt Submit Hook**: Automatically injects reminder before every message
- Configured in `~/.claude/settings.local.json`
- Covers: todo lists, complete implementations, testing, autonomous execution

---

## [0.1.0] - Pre-2025-10-29

### Historical Context
- Learnings files scattered across individual projects
- No central repository
- No version control for preferences
- Difficult to maintain consistency

### Migration
- Consolidated scattered CORY_LEARNINGS.md files
- Created central repository structure
- Established symlink pattern
- Initialized git for history tracking

---

## Future Considerations

### Potential Additions
- TDD/Testing workflow preferences
- Performance optimization patterns
- Database migration strategies
- Deployment procedures
- Code review standards
- Team collaboration patterns

### Review Schedule
- **Weekly**: Check for new insights during sessions
- **Monthly**: Review and consolidate learnings
- **Quarterly**: Major review of patterns and preferences

---

## How to Update This File

When adding new learnings or changing preferences:

1. **Document the change** in this CHANGELOG
2. **Update affected files** (MASTER_LEARNINGS.md, AI_QUICKSTART.md, etc.)
3. **Use semantic versioning**:
   - MAJOR (X.0.0): Breaking changes to workflow or standards
   - MINOR (0.X.0): New sections, features, or preferences
   - PATCH (0.0.X): Clarifications, examples, fixes
4. **Commit with clear message**: `docs: update learnings - [what changed]`

---

## Version History Summary

| Version | Date | Key Changes |
|---------|------|-------------|
| 2.1.0 | 2025-10-30 | When to ask guidance, examples, slash commands |
| 2.0.0 | 2025-10-30 | AI optimization, quick reference, structured metadata |
| 1.0.0 | 2025-10-29 | Initial centralized repository |
| 0.1.0 | Pre-2025-10-29 | Scattered project-specific files |

---

**Maintained by**: Cory Weinstein
**Purpose**: Track evolution of preferences and working style
**Related**: [README.md](README.md) | [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) | [AI_QUICKSTART.md](AI_QUICKSTART.md)
