---
title: "Efficient Codebase Search Guide"
description: "How AI agents can quickly find information in the cory-learnings repository"
version: "1.0"
last_updated: "2025-11-01"
audience: ["ai-agents"]
---

# Efficient Codebase Search Guide

**Goal**: Find what you need in <30 seconds without reading entire files.

---

## 🚀 Search Strategy

### 1. Use quick-index.json First (5 seconds)
```bash
cat ~/.claude/quick-index.json | grep -i "keyword"
```
**What it does**: JSON lookup for fast CLI integration
**Speed**: Instant, no file reads

### 2. Grep Before Reading (10 seconds)
```bash
grep -r "pattern" --include="*.md" /Users/coryweinstein_1_2/cory-learnings/
```
**What it does**: Find all occurrences before reading files
**Speed**: < 1 second for entire repo

### 3. Search Learnings Script (15 seconds)
```bash
./scripts/search-learnings.sh "keyword"
```
**What it does**: Smart search across docs and projects
**Speed**: Instant context

### 4. Use INDEX.md as Navigation (20 seconds)
See [INDEX.md](../INDEX.md) for table of contents
**What it does**: Get file paths and descriptions
**Speed**: No reads needed

---

## 📍 Critical Files Location Guide

| Need | File | Lines | Read Time |
|------|------|-------|-----------|
| Rules | MASTER_LEARNINGS_SUMMARY.md | 380 | 5 min |
| Quick start | AI_QUICKSTART.md | 605 | 8 min |
| Reference | MASTER_LEARNINGS.md | 1234 | 20 min |
| Navigation | INDEX.md | 95 | 2 min |
| Dictionary | TERM_DICTIONARY.md | 541 | 10 min |
| Tokens | docs/cost-optimization/TOKEN_EFFICIENCY.md | 1190 | 15 min |

---

## 🎯 Common Searches & Solutions

### "What are the 5 critical rules?"
**Search**: `grep -i "critical rule" MASTER_LEARNINGS_SUMMARY.md`
**Result**: Instant (no file load needed, it's in quick-index.json)

### "When should I ask for help?"
**Search**: `grep -i "when to ask" INDEX.md`
**Result**: Points to MASTER_LEARNINGS_SUMMARY.md

### "How do I optimize tokens?"
**Search**: `grep -i "token" .claude/quick-index.json`
**Result**: Points to docs/cost-optimization/TOKEN_EFFICIENCY.md

### "What's the project structure?"
**Search**: `ls -1 projects/*.md`
**Result**: Lists all projects

### "How do tests work?"
**Search**: `grep -i "test" tests/README.md`
**Result**: Test documentation

---

## 🔧 Tools Available

| Tool | Purpose | Speed |
|------|---------|-------|
| INDEX.md | Navigation only | Instant |
| quick-index.json | CLI lookups | Instant |
| search-learnings.sh | Smart search | <1s |
| Grep | Pattern matching | <1s |
| AI_QUICKSTART.md | Essential rules | 5 min |
| MASTER_LEARNINGS_SUMMARY.md | 80% of info | 5 min |
| MASTER_LEARNINGS.md | Complete reference | 20 min |

---

## ⚡ Optimization Rules for Future Sessions

### NEVER (Wastes tokens)
- Read entire files to "understand context"
- Load MASTER_LEARNINGS.md when searching for 1 thing
- Read files sequentially
- Use Read tool when Grep will work

### ALWAYS (Saves tokens)
- Start with grep/search
- Use quick-index.json for instant lookups
- Check INDEX.md for navigation
- Reference quick-index.json in responses

### Smart Patterns
```
Pattern 1: Question → quick-index.json → Grep → Result
Pattern 2: Need file? → INDEX.md → Grep → Read (if necessary)
Pattern 3: Searching? → search-learnings.sh → Grep → Result
```

---

## 📊 Token Savings

**Typical search with wrong approach**:
- Read INDEX.md (2K tokens)
- Read MASTER_LEARNINGS_SUMMARY.md (4K tokens)
- Search content (1K tokens)
- **Total**: 7K tokens

**Optimized search approach**:
- Check quick-index.json (200 tokens)
- Single grep (100 tokens)
- Point to result (200 tokens)
- **Total**: 500 tokens
- **Savings**: 93% ✅

---

## 🎓 Future AI Agent Optimization

For any future AI agent working with this repository:

1. **First question**: Check quick-index.json
2. **Not found?**: Use grep or search-learnings.sh
3. **Need details?**: Consult INDEX.md
4. **Read files**: Only if grep results unclear
5. **Report back**: Reference file + line number

---

## Example: Finding "Todo List Rules"

**Goal**: Find todo list requirements quickly

**Process**:
```bash
# Step 1: Check quick-index.json (instant)
cat .claude/quick-index.json | grep -i "todo"
→ Points to AI_QUICKSTART.md

# Step 2: Grep for pattern (< 1 second)
grep -n "Todo List" AI_QUICKSTART.md
→ Line numbers appear

# Step 3: Reference specific lines
AI_QUICKSTART.md:39-48 has the rules
```

**Result**: Found in < 2 seconds, 200 tokens used
**Without optimization**: 15 seconds, 5000 tokens used

---

## 📞 Quick Reference

**When stuck on a problem**:
1. Search quick-index.json
2. Use search-learnings.sh
3. Grep for pattern
4. Check INDEX.md
5. Read specific section (not whole file)

**Golden Rule**: Always grep first, read second.

