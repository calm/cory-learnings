---
title: "cory-learnings Learning Paths"
description: "Guided tours through the repository based on your learning goals"
version: "2.4.0"
last_updated: "2025-10-31"
type: "guide"
audience: ["developers", "ai-agents", "new-users"]
tags: ["learning", "onboarding", "tutorial"]
---

# cory-learnings Learning Paths

Choose your learning path based on what you want to achieve.

---

## Path 1: "I'm an AI Agent Starting a New Task"

**Goal**: Understand Cory's preferences quickly and start working effectively.

### Step 1: Read AI_QUICKSTART.md (5 minutes)
- **File**: [AI_QUICKSTART.md](AI_QUICKSTART.md)
- **Focus**: Critical Rules section (lines 1-100)
- **Key Takeaways**:
  - When to use TodoWrite (2+ steps)
  - Complete implementations (no TODOs)
  - Zero test failures
  - Autonomous quality mindset

### Step 2: Review Communication Decoder (2 minutes)
- **File**: [AI_QUICKSTART.md](AI_QUICKSTART.md)
- **Section**: Communication Decoder
- **Key Phrases**:
  - "do it" = full approval
  - "be critical" = honest assessment
  - "continue" / "c" = keep going
  - "do next todo" = work through list

### Step 3: Check Project-Specific Context (3 minutes)
- **File**: [projects/README.md](projects/README.md)
- **Pick Project**: calm-couples, ios-automation, or calm-ai-project-manager
- **Key Info**:
  - Tech stack
  - Common tasks
  - Port number
  - Key files

### Step 4: Start Working
- Use TodoWrite if 2+ steps
- Follow documented patterns
- Work autonomously

**Total Time**: 10 minutes
**Success Criteria**: You can start work with full context

---

## Path 2: "I Want to Create My Own Learnings Repository"

**Goal**: Set up a similar system for your own preferences.

### Step 1: Read SETUP_GUIDE.md (15 minutes)
- **File**: [SETUP_GUIDE.md](SETUP_GUIDE.md)
- **What You'll Learn**:
  - Repository structure
  - Core files needed
  - How to set up symlinks
  - Claude Code hook configuration

### Step 2: Study Templates (10 minutes)
- **Files**:
  - [TEMPLATE_NEW_PROJECT.md](TEMPLATE_NEW_PROJECT.md)
  - [TEMPLATE_README.md](TEMPLATE_README.md)
  - [README_BEST_PRACTICES.md](README_BEST_PRACTICES.md)
- **What You'll Learn**:
  - Project file structure
  - README formatting
  - Documentation standards

### Step 3: Review MASTER_LEARNINGS.md Structure (20 minutes)
- **File**: [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md)
- **Focus**: Table of Contents and section organization
- **What You'll Learn**:
  - How to organize preferences
  - What topics to document
  - How to structure comprehensive guide

### Step 4: Examine TERM_DICTIONARY.md (10 minutes)
- **File**: [TERM_DICTIONARY.md](TERM_DICTIONARY.md)
- **What You'll Learn**:
  - How to document terminology
  - Category organization
  - Entry format (term, definition, example, related)

### Step 5: Build Your Repository (2-4 hours)
1. Create repository: `mkdir ~/my-learnings && cd ~/my-learnings`
2. Copy templates and customize
3. Add your first project
4. Set up Claude Code hooks
5. Create symlinks
6. Test the system

**Total Time**: 3-5 hours
**Success Criteria**: Working learnings repository with auto-load

---

## Path 3: "I Want to Understand the Architecture"

**Goal**: Deep understanding of how the system works.

### Step 1: Read ARCHITECTURE.md (30 minutes)
- **File**: [ARCHITECTURE.md](ARCHITECTURE.md)
- **Focus**: All Mermaid diagrams
- **What You'll Learn**:
  - System architecture overview
  - Three-tier documentation architecture
  - Auto-load system flow
  - Symlink pattern
  - Decision frameworks

### Step 2: Study the Auto-Load Hook (10 minutes)
- **File**: `~/.claude/settings.local.json`
- **Section**: `hooks.user-prompt-submit`
- **What You'll Learn**:
  - How automatic context injection works
  - What gets injected into every conversation
  - Why zero manual work is needed

### Step 3: Examine Symlink Implementation (15 minutes)
- **Run**: `./scripts/check-symlinks.sh`
- **Files to Read**:
  - [projects/calm-couples.md](projects/calm-couples.md)
  - Project symlinks (use `ls -la` in project directories)
- **What You'll Learn**:
  - How symlinks point to central files
  - Benefits of single source of truth
  - How to verify symlink integrity

### Step 4: Review Test Suite (20 minutes)
- **Run**: `./tests/run-all-tests.sh`
- **Files to Read**:
  - [tests/structure.test.sh](tests/structure.test.sh)
  - [tests/frontmatter.test.sh](tests/frontmatter.test.sh)
  - [tests/versions.test.sh](tests/versions.test.sh)
- **What You'll Learn**:
  - How validation works
  - What gets checked
  - How to ensure consistency

### Step 5: Trace Information Flow (15 minutes)
- **File**: [ARCHITECTURE.md](ARCHITECTURE.md)
- **Section**: Information Flow diagram
- **What You'll Learn**:
  - How learnings are captured daily
  - How they're consolidated weekly
  - How they're refined monthly
  - How they're distributed to projects

**Total Time**: 90 minutes
**Success Criteria**: Deep architectural understanding

---

## Path 4: "I Need to Find Specific Information"

**Goal**: Quickly locate information about a specific topic.

### Option A: Use Search Tools
```bash
# Search across all files
./scripts/search-learnings.sh "todo list"

# Interactive search with menu
./scripts/quick-find.sh
```

### Option B: Check TERM_DICTIONARY.md
- **File**: [TERM_DICTIONARY.md](TERM_DICTIONARY.md)
- **Best For**: Understanding specific terms
- **Categories**:
  - Development Workflow
  - Version Control
  - Testing & Quality
  - Project-Specific Terms
  - Tools & Frameworks

### Option C: Check FAQ in MASTER_LEARNINGS.md
- **File**: [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md)
- **Section**: FAQ (near bottom, 40+ questions)
- **Best For**: Common questions and their answers

### Option D: Use Quick Reference
- **File**: [QUICK_REFERENCE.md](QUICK_REFERENCE.md)
- **Best For**: Commands, ports, file structure, quality standards

**Success Criteria**: Found the information you need

---

## Path 5: "I Want to Understand Code Quality Standards"

**Goal**: Learn what quality standards are expected.

### Step 1: Read Quality Bars (10 minutes)
- **File**: [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md)
- **Section**: Quality Bars
- **What You'll Learn**:
  - 98% test coverage target
  - Zero failing tests tolerance
  - TypeScript strict mode
  - Performance targets

### Step 2: Study Testing Approach (15 minutes)
- **File**: [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md)
- **Section**: Testing & Quality Assurance
- **What You'll Learn**:
  - Unit vs Integration vs E2E tests
  - Test naming conventions
  - Expected behavior verification
  - Interface verification protocol (v2.4.0)

### Step 3: Review Good vs Bad Examples (20 minutes)
- **File**: [EXAMPLES.md](EXAMPLES.md)
- **Focus**: Testing Scenarios section
- **What You'll Learn**:
  - Real examples of proper testing
  - What NOT to do
  - How to report test results

### Step 4: Check Project-Specific Standards (10 minutes)
- **Files**:
  - [projects/calm-couples.md](projects/calm-couples.md) - React/Vitest standards
  - [projects/ios-automation.md](projects/ios-automation.md) - Jest standards
- **What You'll Learn**:
  - Tech-specific quality requirements
  - Coverage expectations per project

**Total Time**: 55 minutes
**Success Criteria**: Clear understanding of quality expectations

---

## Path 6: "I'm Working on a Specific Project"

**Goal**: Get project-specific context quickly.

### For calm-couples:

#### Step 1: Read Project File (5 minutes)
- **File**: [projects/calm-couples.md](projects/calm-couples.md)
- **Key Sections**:
  - Tech Stack Overview
  - Common Tasks
  - Known Issues & Blockers
  - Testing Approach

#### Step 2: Check Project Quick Reference (2 minutes)
- **File**: [projects/README.md](projects/README.md)
- **Section**: calm-couples card
- **Quick Info**: Port, tech stack, status

#### Step 3: Verify Server Setup (3 minutes)
```bash
cd ~/Desktop/calm/calm-couples
npm run dev
# Should start on localhost:3000
# Verify: curl http://localhost:3000
```

### For ios-automation:

#### Step 1: Read Project File (5 minutes)
- **File**: [projects/ios-automation.md](projects/ios-automation.md)
- **Key Sections**:
  - Tech Stack Overview
  - Common Tasks
  - Testing Approach (648 tests)

#### Step 2: Check Server Port (2 minutes)
- **Port**: localhost:4000
- **File**: [projects/README.md](projects/README.md)

### For calm-ai-project-manager:

#### Step 1: Read Project File (5 minutes)
- **File**: [projects/calm-ai-project-manager.md](projects/calm-ai-project-manager.md)
- **Key Sections**:
  - Tech Stack Overview
  - Common Tasks
  - Database Schema

#### Step 2: Check Server Port (2 minutes)
- **Port**: localhost:3001
- **File**: [projects/README.md](projects/README.md)

**Success Criteria**: Ready to work on project with full context

---

## Path 7: "I Want to See Examples of Good Conversations"

**Goal**: Understand what good AI-human collaboration looks like.

### Step 1: Read Good Conversations (15 minutes)
- **File**: [EXAMPLES.md](EXAMPLES.md)
- **Section**: Good Conversations
- **Examples**:
  1. Adding validation with tests
  2. Implementing metrics feature
  3. Investigating test failures
  4. Autonomous execution

### Step 2: Read Bad Conversations (15 minutes)
- **File**: [EXAMPLES.md](EXAMPLES.md)
- **Section**: Bad Conversations
- **Anti-Patterns**:
  1. Asking instead of doing
  2. Leaving TODOs in code
  3. Not using todo lists
  4. Batching todo updates

### Step 3: Study Decision-Making (10 minutes)
- **File**: [EXAMPLES.md](EXAMPLES.md)
- **Section**: When to Ask vs Not Ask
- **What You'll Learn**:
  - When verification is needed
  - When to proceed autonomously
  - How to handle ambiguity

### Step 4: Review Communication Style (10 minutes)
- **File**: [EXAMPLES.md](EXAMPLES.md)
- **Section**: Communication Style Examples
- **What You'll Learn**:
  - Concise vs verbose
  - Professional tone
  - Progress reporting

**Total Time**: 50 minutes
**Success Criteria**: Can distinguish good from bad patterns

---

## Path 8: "I Need to Maintain/Update the Repository"

**Goal**: Keep the repository healthy and up-to-date.

### Daily Maintenance (5-10 minutes)

#### Tasks:
1. Update project-specific files as you work
2. Add new terms to TERM_DICTIONARY.md
3. Note any new patterns discovered

#### Files:
- [projects/calm-couples.md](projects/calm-couples.md)
- [projects/ios-automation.md](projects/ios-automation.md)
- [projects/calm-ai-project-manager.md](projects/calm-ai-project-manager.md)
- [TERM_DICTIONARY.md](TERM_DICTIONARY.md)

### Weekly Maintenance (30-45 minutes)

#### Tasks:
1. Review week's work and consolidate learnings
2. Update MASTER_LEARNINGS.md with new patterns
3. Add examples to EXAMPLES.md if found good/bad patterns
4. Commit and push changes

#### Commands:
```bash
cd ~/cory-learnings
git status
git add .
git commit -m "docs: update learnings from weekly review"
git push
```

### Monthly Maintenance (1-2 hours)

#### Tasks:
1. Review MASTER_LEARNINGS.md and AI_QUICKSTART.md
2. Update AI_QUICKSTART.md with evolved preferences
3. Clean up outdated information
4. Update CHANGELOG.md
5. Bump version if significant changes
6. Run full test suite

#### Commands:
```bash
# Run tests
./tests/run-all-tests.sh

# Check symlinks
./scripts/check-symlinks.sh

# Validate structure
./scripts/validate-structure.sh

# Update version (if needed)
# Edit version in all files, then:
git tag v2.5.0
git push --tags
```

### Quarterly Maintenance (2-3 hours)

#### Tasks:
1. Major review of all preferences and standards
2. Verify symlinks are working
3. Review and elevate patterns to MASTER_LEARNINGS
4. Consider major version bump
5. Update README_BEST_PRACTICES if learned new patterns
6. Archive or remove outdated information

**Success Criteria**: Repository stays current and accurate

---

## Path 9: "I Want to Understand Version History"

**Goal**: See how the system evolved over time.

### Step 1: Read CHANGELOG.md (15 minutes)
- **File**: [CHANGELOG.md](CHANGELOG.md)
- **Focus**: Version history from v0.1.0 to v2.4.0
- **What You'll Learn**:
  - What changed in each version
  - Why changes were made
  - Evolution of thinking

### Step 2: Study Version Timeline (10 minutes)
- **File**: [ARCHITECTURE.md](ARCHITECTURE.md)
- **Section**: Version Evolution Timeline (Mermaid diagram)
- **What You'll Learn**:
  - Visual representation of evolution
  - Major milestones
  - Feature additions over time

### Step 3: Review Git History (20 minutes)
```bash
cd ~/cory-learnings
git log --oneline --graph --all
git log --stat
```
- **What You'll Learn**:
  - Actual commit history
  - File changes over time
  - Development patterns

### Step 4: Compare Current vs v1.0.0 (15 minutes)
```bash
# See what changed since v1.0.0
git diff v1.0.0..HEAD --stat

# Read initial version
git show v1.0.0:MASTER_LEARNINGS.md
```
- **What You'll Learn**:
  - How much documentation grew
  - What features were added
  - How organization improved

**Total Time**: 60 minutes
**Success Criteria**: Understand evolution and rationale

---

## Path 10: "I'm Debugging Issues with the System"

**Goal**: Troubleshoot problems with the learnings repository.

### Issue: Symlinks Broken

#### Diagnosis:
```bash
./scripts/check-symlinks.sh
```

#### Fix:
```bash
# If symlink is broken, recreate it:
cd ~/path/to/project
ln -sf ~/cory-learnings/projects/project-name.md CORY_LEARNINGS.md
```

### Issue: Tests Failing

#### Diagnosis:
```bash
./tests/run-all-tests.sh
# Or run individual tests:
./tests/structure.test.sh
./tests/frontmatter.test.sh
./tests/markdown.test.sh
./tests/versions.test.sh
```

#### Common Fixes:
- **Missing files**: Create required files
- **Invalid frontmatter**: Fix YAML syntax
- **Version mismatch**: Update version numbers in all files
- **Broken markdown**: Fix markdown syntax errors

### Issue: Can't Find Information

#### Solutions:
```bash
# Search across all files
./scripts/search-learnings.sh "search term"

# Interactive search
./scripts/quick-find.sh

# Check specific locations
grep -r "search term" ~/cory-learnings/
```

### Issue: Auto-Load Not Working

#### Diagnosis:
1. Check hook configuration: `cat ~/.claude/settings.local.json`
2. Verify hook is running: Start new Claude conversation, check for auto-reminder

#### Fix:
Re-add hook to `~/.claude/settings.local.json` from SETUP_GUIDE.md

### Issue: Version Inconsistency

#### Diagnosis:
```bash
./tests/versions.test.sh
```

#### Fix:
Update version number in all files to match current version (v2.4.0)

**Success Criteria**: Issues resolved, system working properly

---

## Recommended Learning Sequences

### For AI Agents (New to Cory's Preferences)
1. Path 1: "I'm an AI Agent Starting a New Task" (10 min)
2. Path 5: "I Want to Understand Code Quality Standards" (55 min)
3. Path 7: "I Want to See Examples of Good Conversations" (50 min)
**Total**: 115 minutes for full onboarding

### For Developers (Want to Build Similar System)
1. Path 3: "I Want to Understand the Architecture" (90 min)
2. Path 2: "I Want to Create My Own Learnings Repository" (3-5 hrs)
3. Path 8: "I Need to Maintain/Update the Repository" (ongoing)
**Total**: 5-7 hours for complete setup

### For Maintainers (Updating Existing Repository)
1. Path 8: "I Need to Maintain/Update the Repository" (ongoing)
2. Path 10: "I'm Debugging Issues with the System" (as needed)
3. Path 9: "I Want to Understand Version History" (60 min, occasionally)
**Total**: Variable based on needs

### For Quick Information Lookup
1. Path 4: "I Need to Find Specific Information" (5-10 min)
2. Use [QUICK_REFERENCE.md](QUICK_REFERENCE.md) for common info
**Total**: 5-10 minutes per lookup

---

## Learning Resources by File

| File | Best For | Time to Read |
|------|----------|--------------|
| [README.md](README.md) | Overview and introduction | 5 min |
| [AI_QUICKSTART.md](AI_QUICKSTART.md) | AI agents starting work | 10 min |
| [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) | Comprehensive understanding | 30 min |
| [TERM_DICTIONARY.md](TERM_DICTIONARY.md) | Understanding terminology | 15 min |
| [EXAMPLES.md](EXAMPLES.md) | Learning patterns | 20 min |
| [ARCHITECTURE.md](ARCHITECTURE.md) | System design | 30 min |
| [QUICK_REFERENCE.md](QUICK_REFERENCE.md) | Quick lookups | 5 min |
| [SETUP_GUIDE.md](SETUP_GUIDE.md) | Creating your own | 20 min |
| [CHANGELOG.md](CHANGELOG.md) | Version history | 10 min |
| [README_BEST_PRACTICES.md](README_BEST_PRACTICES.md) | README writing | 15 min |
| [projects/README.md](projects/README.md) | Project quick access | 3 min |

---

## Success Metrics by Path

### Path 1 Success:
- [ ] Can start work with full context
- [ ] Understand when to use TodoWrite
- [ ] Know key phrases and their meanings
- [ ] Have project-specific context loaded

### Path 2 Success:
- [ ] Have working learnings repository
- [ ] Auto-load hook configured
- [ ] At least one project integrated
- [ ] Tests passing

### Path 3 Success:
- [ ] Understand system architecture
- [ ] Can explain auto-load mechanism
- [ ] Know how symlinks work
- [ ] Understand information flow

### Path 4 Success:
- [ ] Found needed information
- [ ] Know which tools to use for search
- [ ] Can navigate documentation efficiently

### Path 5 Success:
- [ ] Clear understanding of quality standards
- [ ] Know testing expectations
- [ ] Can write tests that meet standards
- [ ] Understand interface verification

### Path 6 Success:
- [ ] Ready to work on project
- [ ] Know project tech stack
- [ ] Understand common tasks
- [ ] Server running correctly

### Path 7 Success:
- [ ] Can distinguish good from bad patterns
- [ ] Understand when to ask vs decide
- [ ] Know communication style
- [ ] Can replicate good patterns

### Path 8 Success:
- [ ] Repository stays current
- [ ] Tests continue passing
- [ ] Symlinks remain valid
- [ ] Documentation accurate

### Path 9 Success:
- [ ] Understand evolution rationale
- [ ] Know major milestones
- [ ] Can explain changes over time

### Path 10 Success:
- [ ] Issues resolved
- [ ] System working properly
- [ ] Tests passing
- [ ] Symlinks valid

---

**Choose your path and start learning!**

For most users, we recommend starting with Path 1 or Path 2 depending on whether you're an AI agent or a developer building your own system.
