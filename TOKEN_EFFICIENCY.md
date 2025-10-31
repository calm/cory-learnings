---
title: "Token Efficiency Guidelines"
description: "How to minimize token usage while maintaining quality"
version: "1.0.0"
last_updated: "2025-10-31"
type: "guidelines"
audience: ["ai-agents"]
tags: ["tokens", "efficiency", "optimization"]
---

# Token Efficiency Guidelines

**Critical**: Token usage directly impacts cost and context window. Optimize aggressively.

---

## 🎯 Token Budget Philosophy

**Target**: Use <30% of available tokens per conversation
**This session**: Used 52,465 tokens (26%) - good, but improvable
**Goal**: Stay under 20,000 tokens for typical tasks

---

## 📊 This Session's Token Analysis

### What Drove High Usage (52K tokens)

1. **Upfront file reads** (~15K tokens)
   - Read 3 large docs without asking scope first
   - EXECUTIVE_SUMMARY (410 lines), QUICK_REFERENCE (415 lines), README (259 lines)
   - Should have asked: "What aspect matters most?"

2. **Verbose test outputs** (~8K tokens)
   - Full test suite with ANSI colors and formatting
   - Should have used: `head -10` or summary only

3. **Sequential tool calls** (~5K overhead)
   - Read → think → read → think instead of parallel
   - 8 separate tool call rounds when could be 3-4

4. **Multiple iterations** (~10K tokens)
   - Created files, tested, revised
   - Should have planned more upfront

5. **Bash output verbosity** (~5K tokens)
   - Full directory listings
   - Complete git logs
   - Should have used: `head -5`, `tail -3`

---

## ✅ Token Efficiency Rules

### Rule 1: Ask Before Reading
```
❌ Bad: Read 3 docs to understand project
✅ Good: "I see multiple docs. Which should I focus on for X?"
```

### Rule 2: Sample First, Read Later
```
❌ Bad: Read entire file (1000 lines)
✅ Good: head -20 to preview, then read if needed
```

### Rule 3: Parallel Tool Calls
```
❌ Bad: Read file → analyze → read another → analyze
✅ Good: Read 3-5 files in single message (parallel)
```

### Rule 4: Limit Bash Output
```
❌ Bad: ls -la (shows everything)
✅ Good: ls -la | head -10

❌ Bad: git log --oneline
✅ Good: git log --oneline -5

❌ Bad: ./tests/run-all-tests.sh (full output)
✅ Good: ./tests/run-all-tests.sh | tail -20
```

### Rule 5: Read with Limits
```
❌ Bad: Read(file_path)
✅ Good: Read(file_path, limit=50)  # Only if exploring

✅ Better: Ask which section matters, then read targeted
```

### Rule 6: Suppress Verbose Output
```
✅ Good patterns:
  - command 2>/dev/null
  - command | grep "critical pattern"
  - command --quiet || echo "failed"
  - Use --no-color when possible
```

### Rule 7: Plan Before Creating
```
❌ Bad: Write file → test → revise → test → revise
✅ Good: Think through completely, write once, test once
```

### Rule 8: Avoid Redundant Reads
```
❌ Bad: Read same file multiple times
✅ Good: Remember what was read earlier in conversation
```

---

## 🎯 Task-Specific Guidelines

### Demo/Presentation Tasks
**Budget**: 15-20K tokens max

**Strategy**:
1. Ask: "What's the priority? Full automated or quick manual?"
2. Sample: `head -20 README.md` to understand scope
3. Create: Write demo script directly (no multiple iterations)
4. Test: Run 2-3 key commands only, not full suite
5. Validate: Quick spot check, not comprehensive

**This session**: Could have saved 30K tokens by following this

### Code Implementation Tasks
**Budget**: 40-60K tokens acceptable

**Strategy**:
1. Use Task tool with Explore agent for codebase understanding
2. Read only files being modified
3. Grep for patterns instead of reading multiple files
4. Parallel tool calls for independent reads
5. Write → test → commit in sequence

### Bug Investigation Tasks
**Budget**: 20-30K tokens

**Strategy**:
1. Read error logs first (narrow scope)
2. Grep for error patterns across codebase
3. Read only suspected files
4. Test hypothesis with minimal reproduction
5. Fix and verify

### Documentation Tasks
**Budget**: 10-15K tokens

**Strategy**:
1. Sample existing docs with `head`
2. Ask for scope/priorities
3. Write directly without extensive research
4. Single validation pass

---

## 📈 Optimization Techniques

### Technique 1: Batch Tool Calls
```typescript
// Instead of:
Read(file1) → response → Read(file2) → response

// Do:
Read(file1) + Read(file2) + Read(file3) in parallel
```

### Technique 2: Targeted Grep
```bash
# Instead of reading 10 files:
grep -r "pattern" --include="*.ts" | head -20

# This gives you context without reading full files
```

### Technique 3: Smart Limits
```bash
# File operations
head -20 file.md         # Preview
tail -10 file.log        # Recent entries
sed -n '100,120p' file   # Specific range

# Directory operations
ls -1 | head -10         # First 10 only
find . -name "*.ts" | head -20

# Git operations
git log --oneline -5     # Not full history
git diff --stat          # Summary, not full diff
```

### Technique 4: Structured Questions
```
❌ Bad: "Help me understand the codebase"
✅ Good: "What's the entry point for the API server?"

❌ Bad: "How does testing work?"
✅ Good: "Where are the test files and what command runs them?"
```

### Technique 5: Progressive Disclosure
```
Start: Ask high-level question
Then: Get specific answer
Only if needed: Read detailed files
```

---

## 🚨 Red Flags (Token Waste)

1. **Reading files "just in case"** - Ask first
2. **Full test suite outputs** - Use summary or tail
3. **Long directory listings** - Limit with head
4. **Reading documentation front-to-back** - Sample first
5. **Multiple revisions of same file** - Plan better
6. **Verbose bash commands** - Pipe to head/tail
7. **Full git logs** - Limit to recent (-5 or -10)
8. **Reading multiple large files in sequence** - Parallel or ask

---

## 📊 Token Budget by Task Type

| Task Type | Target Tokens | Max Tokens | Strategy |
|-----------|---------------|------------|----------|
| Quick fix | 5-10K | 15K | Grep → Read → Fix |
| Demo/docs | 10-20K | 25K | Sample → Ask → Create |
| Feature | 30-50K | 80K | Explore → Plan → Implement |
| Refactor | 40-60K | 100K | Understand → Design → Execute |
| Bug hunt | 15-30K | 50K | Log → Grep → Isolate → Fix |
| Review | 20-40K | 60K | Sample → Deep dive → Feedback |

---

## ✅ Before Starting Any Task

**Token Efficiency Checklist**:

- [ ] Asked user for scope/priority
- [ ] Sampled files with `head` before full read
- [ ] Planning parallel tool calls where possible
- [ ] Using `head`/`tail`/`grep` to limit output
- [ ] Reading only what's needed, not "just in case"
- [ ] Considering Task tool with Explore for large codebase searches
- [ ] Suppressing verbose output (2>/dev/null, --quiet)
- [ ] Avoiding redundant reads

---

## 💡 Pro Tips

### For Codebase Exploration
```bash
# Instead of reading many files:
# 1. Use tree to see structure
tree -L 2 src/

# 2. Use grep to find patterns
grep -r "export.*function" src/ --include="*.ts" | head -20

# 3. Use wc to see file sizes
wc -l src/**/*.ts | sort -n | tail -10

# 4. Use Task tool with Explore agent for multi-step searches
```

### For Testing
```bash
# Instead of full test output:
npm test 2>&1 | tail -30  # Just summary

# Or:
npm test --silent | grep -E "(PASS|FAIL|✓|✗)"
```

### For Git Operations
```bash
# Minimal git commands:
git status --short         # Abbreviated status
git log --oneline -5       # Recent 5 commits
git diff --stat HEAD~1     # Summary of last commit
git show --stat HEAD       # Last commit summary
```

---

## 🎯 Real Example: This Session Optimized

### What Happened (52K tokens):
```
1. Read 3 large files (15K tokens)
2. Run full test suite (8K tokens)
3. Sequential tool calls (5K overhead)
4. Multiple file iterations (10K tokens)
5. Verbose bash outputs (5K tokens)
6. Create and test demo files (9K tokens)
```

### Optimized Approach (18K tokens):
```
1. Ask: "Which doc matters for demo?" → Read 1 file (3K)
2. Sample: head -30 of key files (1K)
3. Create: Write demo.sh directly with plan (2K)
4. Test: Run 2 key commands only (1K)
5. Parallel: Create all 3 docs in one call (4K)
6. Validate: Spot check with limited output (1K)
7. Overhead: Tool calls and responses (6K)

Total: ~18K tokens (65% reduction)
```

---

## 📈 Success Metrics

Track these across sessions:
- **Tokens per task type** (should trend down)
- **Files read vs files actually used** (should be 1:1)
- **Revisions per file** (should be <2)
- **Parallel vs sequential tool calls** (should favor parallel)
- **Bash output length** (should use head/tail consistently)

---

## 🔄 Continuous Improvement

### Monthly Review
1. Analyze highest token usage sessions
2. Identify patterns of waste
3. Update guidelines
4. Share learnings

### Per-Session Habits
1. Check token usage at midpoint
2. Adjust if >50% budget used
3. Note what drove high usage
4. Update patterns file

---

## Related Documents

- [AI_QUICKSTART.md](AI_QUICKSTART.md) - Core guidelines (includes token efficiency)
- [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) - Comprehensive preferences
- [EXAMPLES.md](EXAMPLES.md) - Good vs bad patterns

---

**Remember**: Every token costs money and uses context. Be ruthlessly efficient.

**Mantra**: "Sample → Ask → Target → Execute"
