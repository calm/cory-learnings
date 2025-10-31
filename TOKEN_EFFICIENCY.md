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

---

## 🔥 Extreme Optimization Tactics

### Tactic 1: The "Question First" Rule
```
❌ NEVER: Read files to understand what to do
✅ ALWAYS: Ask user to clarify scope first

Example:
User: "Fix the authentication system"
❌ Bad: Read auth files to understand system
✅ Good: "What specifically needs fixing? Login flow, tokens, or session management?"
```

### Tactic 2: The "1-File Rule" for Exploration
```
When exploring unfamiliar codebase:
- Read at most 1 file fully
- Use grep/glob for everything else
- Ask user for architecture doc if confused

❌ Bad: Read 5 files to understand structure
✅ Good: grep -r "class.*Auth" + ask user
```

### Tactic 3: The "No Speculation" Rule
```
❌ NEVER: Read extra files "just in case"
✅ ALWAYS: Read only what you KNOW you need

If you're reading a file "to see if it might help" → STOP
```

### Tactic 4: Aggressive Output Limiting
```bash
# ALWAYS use these limits:
ls | head -5          # Not ls
git log -3            # Not git log
grep pattern | head -10    # Not grep pattern
find . -name "*.ts" | head -5  # Not full find

# Default limits by command:
head: 10 lines max
tail: 5 lines max
grep: 10 results max
git log: 3-5 commits max
```

### Tactic 5: The "Parallel Everything" Rule
```
If reading 2+ files → ALWAYS parallel in same message

❌ Bad: Read file1 → respond → Read file2 → respond
✅ Good: Read(file1) + Read(file2) + Read(file3) in one message

Saves: ~1-2K tokens per additional file
```

### Tactic 6: Grep Before Read
```
❌ NEVER: Read file to find something specific
✅ ALWAYS: Grep first, read only if needed

Example:
Task: "Find where API endpoint is defined"
❌ Bad: Read routes.ts, api.ts, controllers/*.ts
✅ Good: grep -r "POST /api" --include="*.ts" -n | head -5

Saves: 5K-10K tokens
```

### Tactic 7: Use limit Parameter Religiously
```typescript
// When exploring unknown files:
Read(file_path, limit=20)  // Preview
Read(file_path, limit=50)  // If need more context
Read(file_path)            // Only if absolutely necessary

// Never read full file first!
```

### Tactic 8: The "Summary Response" Pattern
```
Instead of showing full output:

❌ Bad:
Uses Bash → Shows 200 lines of output → Explains

✅ Good:
Uses Bash with | tail -5 → Shows summary → Explains

User can ask for more if needed
```

---

## 💰 Token Cost Examples

### Real Cost Breakdown

| Action | Tokens | Cost (@$15/1M) | Multiply by 10 sessions |
|--------|--------|---------------|------------------------|
| Read 500-line file | ~2,000 | $0.03 | $0.30 |
| Full test output (200 lines) | ~1,000 | $0.015 | $0.15 |
| Git log (50 commits) | ~800 | $0.012 | $0.12 |
| ls -la (100 files) | ~500 | $0.0075 | $0.075 |
| **Unnecessary reads (3 files)** | **~6,000** | **$0.09** | **$0.90** |

**Daily Impact** (4 sessions):
- Good habits: ~60K tokens = $0.90/day
- Bad habits: ~180K tokens = $2.70/day
- **Savings: $1.80/day = $657/year**

---

## 🎯 Quick Wins (Do These NOW)

### Win 1: Add to Every Bash Command
```bash
# Add these ALWAYS:
command | head -10      # Limit output
command 2>/dev/null    # Suppress errors
command --quiet        # If available
command | tail -5      # Just the end
```

### Win 2: Never Read Full Docs
```
❌ NEVER: Read README.md (usually 200+ lines)
✅ ALWAYS: head -30 README.md
Then ask: "Should I read more?"
```

### Win 3: Use Glob Instead of Read for Lists
```
Task: "What files are in src/?"
❌ Bad: Read multiple files to see
✅ Good: ls -1 src/ | head -10
```

### Win 4: Batch All Initial Reads
```
Start of session:
❌ Bad: Read AI_QUICKSTART → respond → Read PROJECT.md → respond
✅ Good: Read(AI_QUICKSTART, limit=50) + Read(PROJECT.md, limit=50) parallel

Saves: 2-3K tokens
```

### Win 5: Suppress Verbose Tool Output
```typescript
// Configure tools for minimal output:
Bash: Always pipe to head/tail
Grep: Always use head_limit parameter
Read: Use limit parameter when exploring
```

---

## 📊 Session Token Budget Tracker

### Use This Template

```markdown
## Session Start
- Budget: 200,000 tokens
- Target: <60,000 tokens (30%)
- Task Type: [Demo/Feature/Bug/Docs]
- Expected: [15K/40K/25K/12K per type]

## Checkpoint 1 (After initial understanding)
- Used: _____ tokens
- Percentage: _____%
- On track? [Yes/No]
- Adjust: [What to do different]

## Checkpoint 2 (Midway)
- Used: _____ tokens
- Percentage: _____%
- On track? [Yes/No]
- Adjust: [What to do different]

## Session End
- Total: _____ tokens
- Target: <60,000
- Actual %: _____%
- Grade: [A/B/C/D/F]
- Lessons: [What drove usage]
- Next time: [How to improve]
```

### Grade Scale
- **A**: <20% of budget (40K tokens)
- **B**: 20-30% (40-60K tokens)
- **C**: 30-40% (60-80K tokens)
- **D**: 40-50% (80-100K tokens)
- **F**: >50% (100K+ tokens)

---

## 🚫 Absolute Never-Do List

### 1. Never Read Documentation Front-to-Back
```
❌ Read README.md (200 lines)
❌ Read CONTRIBUTING.md (150 lines)
❌ Read API_DOCS.md (300 lines)

✅ head -20 each file
✅ Ask: "Which section matters?"
```

### 2. Never Run Full Test Suite for Info
```
❌ npm test (shows 500 lines)
✅ npm test 2>&1 | tail -10
✅ npm test --silent | grep -E "(PASS|FAIL)"
```

### 3. Never List All Files
```
❌ ls -la (100 files)
❌ find . -name "*.ts" (200 files)

✅ ls -1 | head -10
✅ find . -name "*.ts" | head -5
```

### 4. Never Read Multiple Files Sequentially
```
❌ Read file1 → analyze → Read file2 → analyze
✅ Read file1 + file2 + file3 in parallel
```

### 5. Never Show Full Bash Output
```
❌ git log
❌ npm test
❌ ls -la
❌ grep -r pattern .

✅ git log -5
✅ npm test | tail -10
✅ ls -1 | head -10
✅ grep -r pattern . | head -5
```

### 6. Never Read Files to "Understand Context"
```
❌ "Let me read a few files to understand the project"
✅ "What aspect of the project should I focus on?"

If exploring: Use grep/glob, not Read
```

### 7. Never Use TodoWrite for Single-Step Tasks
```
❌ Task: "Run tests" → Create todo list
✅ Task: "Run tests" → Just run them

TodoWrite itself costs tokens!
```

---

## 🎓 Advanced Patterns

### Pattern 1: The "Grep-First" Workflow
```bash
# Always grep before reading:
Task: "Find authentication logic"

Step 1: grep -r "authenticate\|auth" --include="*.ts" | head -10
Step 2: Identify likely file (e.g., auth.service.ts:42)
Step 3: Read(auth.service.ts, offset=35, limit=20)
# Not: Read entire auth.service.ts

Saves: 80% tokens vs reading full file
```

### Pattern 2: The "Sample-Decide-Target" Workflow
```bash
# For unknown codebases:
Step 1: ls -1 src/ | head -10          # Structure
Step 2: head -15 src/main.ts           # Entry point
Step 3: Ask user: "Is X the right file?"
Step 4: Read specific file if confirmed

# Not: Read 5 files to understand
Saves: 5-8K tokens
```

### Pattern 3: The "Suppress-Everything" Workflow
```bash
# Maximum output suppression:
command 2>/dev/null | grep "key pattern" | head -5

# Examples:
npm test 2>/dev/null | grep -E "(✓|✗)" | head -10
git log --oneline -3 2>/dev/null
find . -name "*.ts" 2>/dev/null | grep "auth" | head -5
```

### Pattern 4: The "Lazy Load" Workflow
```
Don't load project context upfront

❌ Bad: Read AI_QUICKSTART + MASTER + PROJECT at start
✅ Good: Read AI_QUICKSTART(limit=50) only
Then read more ONLY when specifically needed

Saves: 10-15K tokens
```

---

## 📈 Token Reduction Scorecard

Track these ratios:

### Files Read vs Files Used
- **Target**: 1:1 (every file read gets used)
- **Acceptable**: 2:1 (half of reads useful)
- **Poor**: 3:1+ (reading speculatively)

### Lines Read vs Lines Referenced
- **Target**: Read only needed sections
- **Measure**: Use Read with offset/limit
- **Goal**: <25% of file read on average

### Tool Calls Per Task
- **Simple tasks**: 3-5 tool calls
- **Medium tasks**: 8-12 tool calls
- **Complex tasks**: 15-25 tool calls
- **Red flag**: >30 tool calls

### Parallel vs Sequential Ratio
- **Target**: 60%+ of tool calls in parallel
- **Measure**: Batch independent operations
- **Red flag**: <40% parallel

---

## 🏆 Optimization Hall of Fame

### Best Practices Seen in Wild

1. **Ask First**: "What part of auth needs fixing?" (saved 15K)
2. **Grep Pattern**: `grep -r "TODO" | wc -l` instead of reading files (saved 10K)
3. **Limit Everything**: `head -10` on every bash command (saved 5K)
4. **Parallel Reads**: 3 files in one message (saved 3K)
5. **Targeted Read**: Read with offset+limit (saved 8K)

---

## Related Documents

- [AI_QUICKSTART.md](AI_QUICKSTART.md) - Core guidelines (includes token efficiency)
- [MASTER_LEARNINGS.md](MASTER_LEARNINGS.md) - Comprehensive preferences
- [EXAMPLES.md](EXAMPLES.md) - Good vs bad patterns

---

**Remember**: Every token costs money and uses context. Be ruthlessly efficient.

**New Mantra**: "Ask → Grep → Sample → Target → Execute"

**Ultimate Goal**: <20K tokens for typical tasks (10% of budget)
