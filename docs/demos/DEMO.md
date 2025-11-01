# cory-learnings Live Demo Script
**Duration**: 10 minutes
**Audience**: Technical stakeholders

---

## 🎯 The Problem (30 seconds)

"Every time I work with Claude, I spend 10-15 minutes explaining:
- How I want code written
- My testing standards (98% coverage, zero failures)
- Communication preferences
- Project-specific context

**This wastes 40-60 minutes per day.**"

---

## 💡 The Solution (30 seconds)

"This repository teaches Claude once and applies it everywhere automatically."

**Key metrics:**
- 6,800+ lines of documentation
- 0 seconds loading time (automatic)
- 3 active projects
- 100% consistency

---

## 🚀 Live Demo

### 1. Show the Repository Structure (1 min)

```bash
# Navigate to repository
cd ~/cory-learnings

# Show the structure
ls -1
```

**Point out:**
- `AI_QUICKSTART.md` - What Claude reads first (540 lines)
- `MASTER_LEARNINGS.md` - Complete guide (1,154 lines)
- `TERM_DICTIONARY.md` - Terminology (600+ lines)
- `projects/` - Project-specific learnings
- `tests/` - Validation suite
- `scripts/` - Automation tools

---

### 2. Run the Test Suite (1 min)

```bash
# Run all validation tests
./tests/run-all-tests.sh
```

**Explain while running:**
"This validates:
- File structure integrity
- YAML frontmatter consistency
- Markdown syntax
- Version numbers match across all files
- AI agent compliance with documented standards"

---

### 3. Demonstrate Search (1 min)

```bash
# Quick search for a term
./scripts/search-learnings.sh "testing"
```

**Say:**
"I can instantly find any guidance across all 6,800+ lines. Example: searching for 'testing' shows my 98% coverage requirement."

---

### 4. Show Symlink Pattern (1 min)

```bash
# Show symlinks in action
ls -la projects/

# Show one project's symlink
ls -la ~/Desktop/calm/calm-couples/CORY_LEARNINGS.md 2>/dev/null || echo "Project directory example"
```

**Explain:**
"Each project has a symlink to the central file. Edit once, available everywhere."

---

### 5. Show Auto-Loading Hook (2 min)

```bash
# Show the hook configuration
cat ~/.claude/settings.local.json
```

**Explain:**
"This hook automatically injects critical rules into EVERY Claude conversation:
- Todo lists for multi-step tasks
- Complete implementations (no TODOs in code)
- Zero tolerance for test failures
- Work autonomously"

**Demo the effect:**
"When I open Claude Code in any project, these rules are automatically loaded. No manual work required."

---

### 6. Show Real Example (2 min)

```bash
# Open a project-specific file
cat projects/calm-couples.md | head -50
```

**Explain:**
"This shows project-specific context:
- Tech stack (React 19, TypeScript, Supabase)
- Database details (RLS policies, procedures)
- Testing requirements
- Port configuration (localhost:3000)"

**Show the impact:**
"Claude knows to:
- Use localhost:3000 for this project
- Implement RLS policies correctly
- Follow React 19 patterns
- Target 98% test coverage"

---

### 7. Show Version Control (1 min)

```bash
# Show git history
git log --oneline -10

# Show recent commit
git show --stat HEAD
```

**Explain:**
"Git tracks how my preferences evolve:
- v1.0.0: Initial centralization
- v2.0.0: AI-first optimization
- v2.4.0: Interface verification standards

I can see what changed and when."

---

### 8. Demonstrate Interactive Search (30 seconds)

```bash
# Run interactive search
./scripts/quick-find.sh
```

**Navigate through the menu to show:**
"Interactive search menu for quick access to any information."

---

## 🎁 The Payoff (1 min)

**Results:**
- ✅ **Time saved**: 40-60 minutes/day (10-15 min per session × 4-6 sessions)
- ✅ **Quality**: 98% test coverage enforced, zero test failures
- ✅ **Consistency**: Same standards across all projects
- ✅ **Scalability**: Add new projects in seconds

**The Core Value:**
> "Instead of telling Claude how I work in every conversation, this system teaches Claude once and applies it everywhere."

---

## 🤔 Q&A Prep (30 seconds)

**Common Questions:**

**Q: "Does this work with other AI assistants?"**
A: Yes - the documentation is model-agnostic. Currently optimized for Claude Code, but adaptable.

**Q: "How long did this take to build?"**
A: 1-2 days to v1.0, evolved to v2.4.0 with active use.

**Q: "Can teams use this?"**
A: Yes - create shared preferences + individual overrides. Perfect for onboarding.

**Q: "What if preferences change?"**
A: Git tracks all changes. Semantic versioning shows evolution.

**Q: "Maintenance burden?"**
A: Daily updates (5 min), weekly review (15 min), monthly cleanup (30 min).

---

## 💪 Live Coding Demo (if time allows)

**Open Claude Code and show:**

1. Open any project
2. Show hook message appears automatically
3. Ask Claude: "What are my testing requirements?"
4. Claude should reference the 98% coverage, zero failures policy
5. Show Claude creating a todo list without being asked

---

## 🎬 Closing (30 seconds)

"This repository represents a novel approach to AI-assisted development:
- Zero-touch automation
- Single source of truth
- Proven at scale (3 projects)
- Actively maintained (v2.4.0)

**Next steps:**
- SETUP_GUIDE.md for creating your own
- Open to feedback and questions
- Considering open-sourcing for community"

---

## 📊 Backup Slides (if needed)

### System Architecture
```
Central Repository (~/cory-learnings)
          ↓ (symlinks)
    Active Projects (3)
          ↓ (auto-load hook)
   VS Code + Claude Code
```

### Tech Stack
- Language: Bash + Markdown
- Dependencies: Zero
- Integration: VS Code + Claude Code
- Version Control: Git

### Competitive Advantages
- vs Manual: 0s vs 10-15min
- vs Docs: Automatic vs manual loading
- vs Wiki: Git vs platform-specific

---

**Presenter Notes:**
- Keep energy high
- Show, don't tell
- Run commands confidently
- Have terminal pre-positioned
- Use metrics to anchor impact
- End with clear value proposition

---

**Total Time**: ~10 minutes
**Backup Time**: +2-3 minutes for Q&A
