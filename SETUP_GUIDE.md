---
title: "Setup Guide - Create Your Own Learnings Repository"
description: "Step-by-step guide to create a personalized learnings repository"
version: "1.0.0"
last_updated: "2025-10-31"
type: "guide"
audience: ["developers", "ai-users"]
tags: ["setup", "guide", "tutorial"]
---

# Setup Guide: Create Your Own Learnings Repository

**Purpose**: This guide helps you create your own centralized learnings repository similar to cory-learnings, customized for your development preferences and working style.

**Benefits**:
- Single source of truth for your preferences
- AI agents understand your working style
- Consistent behavior across projects
- Version-controlled preference evolution
- Reusable templates and patterns

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Initial Setup](#initial-setup)
3. [Core Files](#core-files)
4. [Project Integration](#project-integration)
5. [Claude Code Integration](#claude-code-integration)
6. [Optional Enhancements](#optional-enhancements)
7. [Maintenance](#maintenance)

---

## Prerequisites

- Git installed
- Basic command line knowledge
- Claude Code extension (for AI integration)
- Text editor (VS Code, Vim, etc.)

---

## Initial Setup

### 1. Create Repository

```bash
# Create the repository directory
mkdir ~/your-learnings
cd ~/your-learnings

# Initialize git repository
git init

# Create basic structure
mkdir -p projects scripts tests
```

### 2. Create .gitignore

```bash
cat > .gitignore <<'EOF'
# OS
.DS_Store
Thumbs.db

# Editor
.vscode/
.idea/
*.swp
*.swo

# Temp
*.tmp
.cache/
EOF
```

---

## Core Files

### 1. README.md

**Purpose**: Repository overview and usage guide

```markdown
---
title: "Your Name's Learnings Repository"
description: "Single source of truth for preferences and learnings"
version: "1.0.0"
last_updated: "2025-10-31"
type: "repository-readme"
---

# Your Name's Learnings Repository

**Single source of truth for development preferences, working style, and project-specific learnings.**

## Quick Start

### For AI Agents
Read [AI_QUICKSTART.md](AI_QUICKSTART.md) for essential working principles.

### For Humans
View [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) for comprehensive preferences.

## Repository Structure

\`\`\`
your-learnings/
├── README.md                    # This file
├── AI_QUICKSTART.md             # AI agent quick reference
├── MASTER_LEARNINGS.md          # Comprehensive preferences
├── TERM_DICTIONARY.md           # Terminology reference
├── projects/                    # Project-specific learnings
├── scripts/                     # Validation tools
└── tests/                       # Repository tests
\`\`\`
```

### 2. AI_QUICKSTART.md

**Purpose**: Quick reference for AI agents

```markdown
---
title: "AI Assistant Quick Start"
description: "Ultra-concise reference for AI agents"
version: "1.0.0"
last_updated: "2025-10-31"
type: "ai-guide"
---

# AI Assistant Quick Start

**Purpose**: Ultra-concise reference for AI agents working with [Your Name]

---

## Critical Rules

### 1. Todo List Management
- Use TodoWrite for ANY task with 2+ steps
- Only ONE in_progress at a time
- Mark completed IMMEDIATELY

### 2. Complete Implementations
- ZERO TODOs in code
- Implement fully, no placeholders

### 3. Testing
- Zero tolerance for failing tests
- [Your test coverage target]% coverage target

### 4. Communication Style
- [Your preferences: direct/detailed/etc.]
- [Your key phrases and meanings]

### 5. Code Quality
- [Your logging preference]
- [Your TypeScript/language preferences]
- [Your versioning approach]

---

## Communication Decoder

| You Say | Meaning | AI Action |
|---------|---------|-----------|
| "do it" | Full approval | Implement completely |
| [Add your phrases] | [Meaning] | [Expected action] |

---

## Project Quick Reference

### [Project Name]
- **Stack**: [Technologies]
- **Port**: http://localhost:[PORT]
- **Tests**: [Test command]
- **Key Commands**: [Common operations]
```

### 3. MASTER_LEARNINGS.md

**Purpose**: Comprehensive preferences and working style

```markdown
---
title: "Your Name's Master Learnings"
description: "Central knowledge base for preferences and working style"
version: "1.0.0"
last_updated: "2025-10-31"
type: "master-reference"
---

# Your Name's Master Learnings

**Last Updated**: 2025-10-31

> Central knowledge base for your preferences, working style, decisions, and learnings.

---

## Table of Contents

1. [Core Working Principles](#core-working-principles)
2. [Communication Style](#communication-style)
3. [Task Management](#task-management)
4. [Code Quality Standards](#code-quality-standards)
5. [Technical Preferences](#technical-preferences)
6. [Project Contexts](#project-contexts)

---

## Core Working Principles

### [Your Principle 1]
[Description and examples]

### [Your Principle 2]
[Description and examples]

---

## Communication Style

### How You Work
- [Your working style traits]
- [Your communication preferences]
- [Your feedback style]

### Key Phrases & Their Meanings
| Phrase | Meaning |
|--------|---------|
| [Your phrase] | [What it means] |

---

## Task Management

### Todo List Usage
- [When you want todo lists created]
- [How detailed they should be]
- [When to update them]

---

## Code Quality Standards

### Testing
- [Your testing philosophy]
- [Coverage requirements]
- [Testing patterns]

### Documentation
- [Documentation preferences]
- [Comment style]
- [README requirements]

---

## Technical Preferences

### Stack & Tools
- [Your preferred languages]
- [Your preferred frameworks]
- [Your preferred tools]

### Architecture
- [Your architectural preferences]
- [Design patterns you like]
- [Patterns to avoid]

---

## Project Contexts

### [Project Name]
- **Type**: [Description]
- **Stack**: [Technologies]
- **Port**: http://localhost:[PORT]
- **Key Learnings**: [Important notes]
```

### 4. TERM_DICTIONARY.md

**Purpose**: Comprehensive terminology reference

```markdown
---
title: "Term Dictionary"
description: "Comprehensive terminology reference"
version: "1.0.0"
last_updated: "2025-10-31"
type: "reference"
---

# Term Dictionary

**Purpose**: Single source of truth for technical terms and project-specific concepts.

---

## Development Workflow

### [Term Name]
**Definition**: [Clear, concise definition]

**Example**: [Real example from your projects]

**Related**: [Link to related terms]

---

## Project-Specific Terms

### [Your Project Term]
**Definition**: [What it means in your project]

**Usage**: [How it's used]

---

[Add your terminology as you work]
```

---

## Project Integration

### 1. Create Project Symlinks

Symlinks allow you to access central learnings from each project directory.

```bash
# For each project, create a symlink
cd ~/path/to/your-project
ln -s ~/your-learnings/projects/project-name.md YOUR_LEARNINGS.md

# Verify symlink
ls -la YOUR_LEARNINGS.md
```

### 2. Create Project-Specific Files

```bash
# Create a learnings file for each project
cat > ~/your-learnings/projects/project-name.md <<'EOF'
---
title: "Your Learnings - [Project Name]"
description: "Project-specific learnings"
version: "1.0.0"
last_updated: "2025-10-31"
project: "project-name"
type: "project-learnings"
---

# Your Learnings - [Project Name]

**Purpose**: Track project-specific preferences and learnings

---

## Project Context

### Project: [Project Name]
- **Type**: [Description]
- **Stack**: [Technologies]
- **Port**: http://localhost:[PORT]
- **Status**: [Development stage]

---

## Key Learnings

### [Session Date]
- [Important discovery or decision]
- [Pattern that worked well]
- [Issue encountered and solution]
EOF
```

---

## Claude Code Integration

### 1. Create Auto-Load Script

This script automatically injects your learnings into every Claude Code session.

```bash
# Create scripts directory if it doesn't exist
mkdir -p ~/.claude/scripts

# Create auto-load script
cat > ~/.claude/scripts/auto-load-learnings.sh <<'EOF'
#!/usr/bin/env bash

# Auto-load learnings into Claude Code sessions
LEARNINGS_DIR="$HOME/your-learnings"

cat <<EOF

---
🤖 YOUR LEARNINGS AUTO-LOADED:

✅ CRITICAL RULES:
  • TodoWrite for ANY 2+ step task
  • ZERO TODOs in code
  • Zero tolerance for failing tests
  • [Add your critical rules]

📖 Full docs: ~/your-learnings/AI_QUICKSTART.md
---

EOF
EOF

# Make executable
chmod +x ~/.claude/scripts/auto-load-learnings.sh
```

### 2. Configure Claude Code Hook

Add to VS Code settings (`settings.json`):

```json
{
  "claudeCode.hooks.userPromptSubmit": "~/.claude/scripts/auto-load-learnings.sh"
}
```

**Test it**:
1. Open Claude Code in VS Code
2. Send any message
3. You should see your learnings auto-loaded before each message

---

## Optional Enhancements

### 1. Add Validation Scripts

Create `scripts/validate-structure.sh`:

```bash
#!/usr/bin/env bash
# Validate repository structure

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Validating structure..."

# Check required files exist
REQUIRED_FILES=(
    "README.md"
    "AI_QUICKSTART.md"
    "MASTER_LEARNINGS.md"
    "TERM_DICTIONARY.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [[ -f "$REPO_ROOT/$file" ]]; then
        echo "✓ $file exists"
    else
        echo "✗ $file missing"
        exit 1
    fi
done

echo "✓ All required files present"
```

### 2. Add Test Suite

Copy the test suite from cory-learnings/tests/ and adapt for your needs:

```bash
# Copy test framework
cp -r ~/cory-learnings/tests ~/your-learnings/

# Customize for your structure
# Edit tests/*.sh files to match your requirements
```

### 3. Add Search Tools

Create `scripts/search-learnings.sh`:

```bash
#!/usr/bin/env bash
# Search across all learnings files

LEARNINGS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SEARCH_TERM="$1"

if [[ -z "$SEARCH_TERM" ]]; then
    echo "Usage: $0 <search-term>"
    exit 1
fi

echo "Searching for: $SEARCH_TERM"
echo ""

grep -n -i -C 2 "$SEARCH_TERM" \
    "$LEARNINGS_DIR"/*.md \
    "$LEARNINGS_DIR"/projects/*.md
```

### 4. Create CHANGELOG.md

Track your learnings evolution:

```markdown
---
title: "Changelog"
description: "Version history and evolution"
version: "1.0.0"
last_updated: "2025-10-31"
---

# Changelog

## [1.0.0] - 2025-10-31

### Added
- Initial repository structure
- Core documentation files
- Claude Code integration
- Project symlinks

### Changed
- [Future changes]

### Fixed
- [Future fixes]
```

---

## Maintenance

### Daily
- Update project-specific files as you work
- Add new terms to TERM_DICTIONARY.md as they arise

### Weekly
- Review and consolidate learnings
- Update MASTER_LEARNINGS.md with patterns
- Commit and push changes

### Monthly
- Review version history
- Update AI_QUICKSTART.md with evolved preferences
- Clean up outdated information
- Bump version if significant changes

### Git Workflow

```bash
# Regular updates
cd ~/your-learnings
git add .
git commit -m "docs: update project learnings from this week"
git push

# Version bumps
# Update version in all files with frontmatter
git add .
git commit -m "chore: bump version to 1.1.0"
git tag v1.1.0
git push && git push --tags
```

---

## Example Workflows

### Starting a New Project

```bash
# 1. Create project learnings file
cat > ~/your-learnings/projects/new-project.md <<'EOF'
[Use template from above]
EOF

# 2. Create symlink in project
cd ~/path/to/new-project
ln -s ~/your-learnings/projects/new-project.md YOUR_LEARNINGS.md

# 3. Add to MASTER_LEARNINGS.md project contexts
vim ~/your-learnings/MASTER_LEARNINGS.md

# 4. Commit
cd ~/your-learnings
git add .
git commit -m "docs: add new-project learnings"
```

### Adding a New Term

```bash
# 1. Open TERM_DICTIONARY.md
vim ~/your-learnings/TERM_DICTIONARY.md

# 2. Add term in appropriate section
### [Term Name]
**Definition**: [Definition]
**Example**: [Example]
**Related**: [Links]

# 3. Commit
git add TERM_DICTIONARY.md
git commit -m "docs: add [term] to dictionary"
```

### Updating Preferences

```bash
# 1. Update MASTER_LEARNINGS.md with new preference
vim ~/your-learnings/MASTER_LEARNINGS.md

# 2. Update AI_QUICKSTART.md if critical
vim ~/your-learnings/AI_QUICKSTART.md

# 3. Update auto-load script if needed
vim ~/.claude/scripts/auto-load-learnings.sh

# 4. Commit
git add .
git commit -m "docs: update testing preferences"
```

---

## Tips for Success

### 1. Start Small
- Begin with core files only
- Add complexity as needed
- Don't over-engineer initially

### 2. Be Consistent
- Update learnings after each significant session
- Use semantic versioning
- Keep formatting consistent

### 3. Make It Yours
- Adapt templates to your style
- Use terminology that makes sense to you
- Document what actually helps

### 4. Iterate
- Review what's working
- Remove what isn't useful
- Refine over time

### 5. Share Selectively
- Keep sensitive information out
- Use .gitignore for private notes
- Consider public vs private repos

---

## Troubleshooting

### Symlinks Not Working?

```bash
# Check symlink exists
ls -la ~/path/to/project/YOUR_LEARNINGS.md

# If broken, recreate
rm ~/path/to/project/YOUR_LEARNINGS.md
ln -s ~/your-learnings/projects/project-name.md ~/path/to/project/YOUR_LEARNINGS.md
```

### Auto-Load Not Working?

```bash
# Test script manually
~/.claude/scripts/auto-load-learnings.sh

# Check VS Code settings
code ~/.config/Code/User/settings.json

# Verify hook is configured
grep "claudeCode.hooks" ~/.config/Code/User/settings.json
```

### Git Issues?

```bash
# If you haven't created a remote yet
git remote add origin https://github.com/yourusername/your-learnings.git
git push -u origin main

# If you need to fix commit messages
git commit --amend -m "new message"

# If you need to reset
git reset --soft HEAD~1  # Undo last commit, keep changes
```

---

## Next Steps

1. **Set up basic structure**: Create core files
2. **Integrate with Claude Code**: Set up auto-load script
3. **Add first project**: Create symlink and project file
4. **Start documenting**: Begin capturing learnings
5. **Iterate**: Refine as you learn what works

---

## Additional Resources

- **cory-learnings**: Reference implementation at https://github.com/calm/cory-learnings
- **Claude Code Docs**: https://docs.claude.com
- **Semantic Versioning**: https://semver.org

---

**Version**: 1.0.0 | **Last Updated**: 2025-10-31

**Questions?** Review the cory-learnings repository for examples and inspiration.
