# 🎯 Demo Cheat Sheet - Keep This Open!

**Print this or keep on second screen during demo**

---

## Before You Start

```bash
cd ~/cory-learnings
./pre-flight-check.sh     # Verify everything works
```

---

## Option 1: Automated Demo (Easiest!)

```bash
./demo.sh
```
Just press ENTER at each pause and explain what you see.

---

## Option 2: Manual Commands (Full Control)

### 1. The Big Numbers (30 sec)
```bash
ls -lh | grep "^-" | head -10
wc -l AI_QUICKSTART.md MASTER_LEARNINGS.md
```
**Say**: "6,800+ lines, 19 files, 3 projects"

### 2. Tests Work (1 min)
```bash
./tests/run-all-tests.sh
```
**Say**: "Validates structure, frontmatter, markdown, versions"

### 3. Search Works (30 sec)
```bash
./scripts/search-learnings.sh "testing"
```
**Say**: "Instant search finds my 98% coverage requirement"

### 4. Projects (1 min)
```bash
ls -1 projects/*.md | grep -v README
head -40 projects/calm-couples.md
```
**Say**: "Project-specific context auto-loaded"

### 5. The Hook (1 min)
```bash
cat ~/.claude/settings.local.json
```
**Say**: "Automatically injects rules into EVERY conversation"

### 6. Git History (30 sec)
```bash
git log --oneline -10
```
**Say**: "v1.0 to v2.4 in days, tracks evolution"

---

## Key Talking Points

### The Problem
"I waste 10-15 minutes per session explaining preferences = 40-60 min/day"

### The Solution
"Teach Claude once, apply everywhere automatically"

### The Results
- **Time**: 0 seconds (vs 10-15 min)
- **Coverage**: 6,800+ lines
- **Projects**: 3 integrated
- **Quality**: 98% test coverage enforced

### The Magic
"VS Code hook auto-injects critical rules before EVERY conversation"

### The Value
> "Instead of telling Claude how I work in every conversation, this teaches Claude once and applies it everywhere."

---

## If Something Fails

### Search doesn't work?
```bash
grep -r "testing" *.md | head -5
```

### Tests fail?
**Say**: "Tests finding issues = validation working!"

### Git not available?
**Say**: "Usually tracked in git, here's what it would show..."

### Symlinks broken?
**Say**: "Pattern: central file → symlinked to each project"

---

## Quick Recovery Phrases

**If confused**: "Let me show you the executive summary..."
```bash
head -50 EXECUTIVE_SUMMARY.md
```

**If technical**: "Here's the architecture..."
```bash
cat ARCHITECTURE.md | head -80
```

**If need examples**: "Let me show real usage..."
```bash
cat EXAMPLES.md | head -60
```

---

## Time Markers (10-min version)

- **0:00-1:00** - Problem statement + metrics
- **1:00-3:00** - Show tests + search working
- **3:00-5:00** - Project files + auto-load hook
- **5:00-7:00** - Git history + version evolution
- **7:00-9:00** - Real example + impact metrics
- **9:00-10:00** - Value prop + Q&A setup

---

## Closing Lines

**Technical audience**:
"Zero dependencies, pure markdown and bash, proven at scale across 3 projects"

**Business audience**:
"10-15% productivity gain, enforced quality standards, zero cost"

**Mixed audience**:
"Single source of truth that automatically teaches AI how I work"

---

## Next Steps After Demo

1. Point to SETUP_GUIDE.md
2. Mention open-sourcing consideration
3. Offer to show live in VS Code if time

---

## Emergency Backup

**If ALL tech fails, just talk through**:
1. Show EXECUTIVE_SUMMARY.md on screen
2. Walk through the numbers
3. Explain the hook concept verbally
4. Show impact metrics from summary

```bash
cat EXECUTIVE_SUMMARY.md
```

---

**Remember**:
- Show, don't tell
- Let the output speak
- Focus on impact numbers
- End with value proposition

**Good luck! You've got this!** 🚀
