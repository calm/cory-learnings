---
title: "AI Agent Self-Optimization Guide"
description: "How to operate efficiently in this repository (token budget, speed, cost)"
version: "1.0"
last_updated: "2025-11-01"
audience: ["ai-agents"]
---

# AI Agent Self-Optimization Guide

**Goal**: Complete tasks in <10K tokens (5% of budget). This guide encodes efficient patterns.

---

## 🎯 Operating Mode: Extreme Efficiency

### Token Budget Per Task
- **Target**: <10K tokens (5% of 200K budget)
- **Search overhead**: <500 tokens
- **Answer delivery**: <200 tokens
- **Reading files**: Only if grep confirms relevance

### Search Strategy (Grep-First)
```bash
# Step 1: Check quick-index.json (instant, 0 tokens)
cat .claude/quick-index.json | grep -i "keyword"

# Step 2: If not found, grep repository (< 100 tokens)
grep -r "pattern" --include="*.md" .

# Step 3: Only read if grep confirms match (500-1000 tokens max)
# Never: Read to "understand context"
```

---

## ⚡ Token Optimization Rules

### ALWAYS Do
- Start with `quick-index.json` lookup
- Use grep before reading ANY file
- Ask before reading >1KB files
- Run all independent operations in parallel
- Use `head -10` / `tail -5` defaults
- Reference files, don't quote them
- Answer directly (no explanation padding)

### NEVER Do
- Read documentation to "understand"
- Load entire files without confirmation
- Read files sequentially (batch them)
- Show verbose output
- Explain obvious decisions
- Summarize what you read

### Smart Exceptions
- Templates with obvious TODOs = OK
- Quick wins over perfectionism = OK
- Skip perfection if shipping sooner = OK

---

## 🔍 Lookup Patterns

### Pattern 1: "What's the rule about X?"
```
1. Grep quick-index.json (50 tokens)
2. Reference specific section (100 tokens)
3. Total: 150 tokens
```

### Pattern 2: "Find code related to Y"
```
1. Grep repository (100 tokens)
2. Point to files (100 tokens)
3. Total: 200 tokens
```

### Pattern 3: "How do I do Z?"
```
1. Check quick-index.json (50 tokens)
2. Reference guide if needed (200 tokens)
3. Total: 250 tokens
```

**Key**: Never exceed 500 tokens for any search.

---

## 📋 Pre-Work Checklist

Before starting ANY task:
- [ ] Use quick-index.json first (instant)
- [ ] Search for pattern (grep)
- [ ] Ask scope before reading large files
- [ ] Batch all independent operations
- [ ] Check INDEX.md for navigation
- [ ] Reference files instead of reading

---

## 🚀 Fast Operations

### Run Tests Faster
```bash
./tests/run-fast.sh  # Parallel instead of sequential
# vs
./tests/run-all-tests.sh  # Sequential (slower)
```

### Search Learnings
```bash
./scripts/search-learnings.sh "keyword"  # <1 second
# vs
grep -r "keyword" .  # Slower, verbose
```

### Find Files
```bash
cat .claude/quick-index.json | jq '.files'  # Instant
# vs
find . -name "*.md"  # Slower, lots of matches
```

---

## 💾 Token Budget Breakdown

**Typical 10K task budget**:
- Search/navigation: 500 tokens (5%)
- File reading: 2000 tokens (20%)
- Analysis: 2000 tokens (20%)
- Implementation: 4000 tokens (40%)
- Tests/verification: 1000 tokens (10%)
- Communication: 500 tokens (5%)

**If you exceed any category** → Use parallel operations, skip verbose output, ask scope first.

---

## 🎓 Real Examples

### Example 1: "What's the todo list rule?"
```
❌ Wrong approach (5000+ tokens):
- Read MASTER_LEARNINGS.md (1K tokens)
- Read AI_QUICKSTART.md (1K tokens)
- Search within files (1K tokens)
- Total: 3K+ wasted

✅ Right approach (150 tokens):
- cat .claude/quick-index.json | grep -i "todo"
- Reference: AI_QUICKSTART.md:39-48
- Total: 150 tokens (95% savings!)
```

### Example 2: "How do I search this repo?"
```
❌ Wrong approach (2000+ tokens):
- Read EFFICIENT_SEARCH.md fully (800 tokens)
- Reference section (300 tokens)
- Total: 1100 tokens

✅ Right approach (250 tokens):
- Grep quick-index.json for "search" (50 tokens)
- Point to EFFICIENT_SEARCH.md:1-20 (100 tokens)
- Direct answer (100 tokens)
- Total: 250 tokens (77% savings!)
```

### Example 3: "Find cost optimization info"
```
❌ Wrong approach (3000+ tokens):
- Read COMPREHENSIVE_COST_ANALYSIS.md (500 tokens)
- Read TOKEN_EFFICIENCY.md (600 tokens)
- Summarize findings (500 tokens)
- Total: 1600 tokens

✅ Right approach (300 tokens):
- Grep quick-index.json for "cost" (50 tokens)
- List files: COMPREHENSIVE_COST_ANALYSIS.md, TOKEN_EFFICIENCY.md, COST_SAVINGS_GUIDE.md (100 tokens)
- Ask which one they need (50 tokens)
- Point to specific file (100 tokens)
- Total: 300 tokens (81% savings!)
```

---

## 🔧 Tool Usage Optimization

### Bash
- Use `head -10` / `tail -5` by default
- Chain with `&&` for dependencies
- Run all parallel operations in one block
- Suppress verbose output

### Grep
- Always use before Read tool
- Filter by type (`-i` for case-insensitive)
- Limit output with `head`
- Avoid `grep | grep | grep` chains

### Read
- Only after grep confirms relevance
- Use `limit` parameter (never full file)
- Point to line numbers in response
- Never read >2KB without asking

### Edit
- Make targeted changes only
- Batch related edits together
- Commit after group of edits

---

## 📊 Self-Monitoring

Track your token usage per session:
```
Session Checklist:
- [ ] Started <500 tokens on planning
- [ ] Searches <500 tokens
- [ ] File reads <2000 tokens
- [ ] Analysis <2000 tokens
- [ ] Implementation <4000 tokens
- [ ] Tests/verification <1000 tokens
- [ ] Communication <500 tokens

Total tokens used: _____ / 10,000
Efficiency rating: _____ %
```

**Grade yourself**:
- A: <5K tokens (50% of budget)
- B: 5-7K tokens (50-70% of budget)
- C: 7-10K tokens (70-100% of budget)
- D: 10-15K tokens (100-150% of budget)
- F: >15K tokens (>150% of budget)

---

## 🎯 Quick Reference

| Need | Action | Cost |
|------|--------|------|
| Find rule | grep quick-index.json | 50t |
| Search repo | grep + point to files | 200t |
| How to do X | quick-index.json + reference | 200t |
| Code location | grep + line numbers | 150t |
| Full reference | Grep then ask scope | 300t |

**Golden rule**: Grep first, read last. Ask before committing to large file reads.

---

## 🚀 Optimization Mindset

- **Speed > Perfection**: Quick wins over polish
- **Direct > Verbose**: Answer the question, no padding
- **Grep > Read**: Always search before reading
- **Parallel > Sequential**: Batch independent operations
- **Reference > Quote**: Point to files, don't quote them
- **Ask > Assume**: Confirm scope before large reads

---

## 📞 Emergency Abort

If you hit token limits mid-task:
1. Stop current operation
2. Summarize what's done (50 tokens)
3. List what's pending (50 tokens)
4. Ask user to continue in new session (0 tokens)

Better to finish partially with clear status than use 15K tokens.

