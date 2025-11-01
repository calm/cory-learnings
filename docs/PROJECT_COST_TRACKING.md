---
title: "Project Cost Tracking Template"
description: "How to add cost tracking to project READMEs"
version: "1.0"
last_updated: "2025-11-01"
---

# Project Cost Tracking - README Template

Copy this section into each project's README to make costs transparent.

---

## For README.md

```markdown
## 💰 Token & Cost Efficiency

**Quick Stats**:
- Typical task cost: 2-5K tokens ($0.005-0.015)
- Cost per feature: 5-12K tokens ($0.012-0.030)
- Cost per bug fix: 2-4K tokens ($0.005-0.010)

**How to estimate:**
1. Task type: Bug fix? Feature? Refactor?
2. Complexity: Simple? Medium? Complex?
3. Check baseline: [TOKEN_BASELINES.md](../../TOKEN_BASELINES.md)
4. Budget: Baseline + 20% buffer
5. Track: Use `token-tracker.sh log {project} {task} {tokens}`

**Optimize:**
- Use AGENTS.md for patterns
- Copy prompts from AI_PROMPT_LIBRARY.md
- Check error catalogs first
- Use test fixtures (docs/fixtures/)

**Session Example** (calm-couples):
| Task | Type | Cost | Time |
|------|------|------|------|
| Fix plant render bug | Bug fix | 2.1K | 15 min |
| Add dark mode | Feature | 8.5K | 45 min |
| Write tests | Testing | 1.8K | 20 min |
| **Total** | | **12.4K** | **80 min** |

**Estimated cost**: $0.031 (Haiku pricing)
**Tokens saved vs baseline**: 40% (used 8-10K optimization tools)

### Cost Reduction Tips

1. **Error Catalogs** (85% faster diagnosis)
   - Search: `./scripts/find-bug.sh "error message"`
   - Saves: 30-60 min, 1-2K tokens

2. **Pattern Library** (copy-paste code)
   - Find: `./scripts/find-pattern.sh "logging"`
   - Saves: 200-300 tokens per use

3. **Prompts** (pre-built, tested)
   - Reference: `docs/AI_PROMPT_LIBRARY.md`
   - Saves: 200-500 tokens per prompt

4. **Decision Trees** (prevent bad choices)
   - When stuck: Check `docs/decision-trees/`
   - Saves: 500-1000 tokens (rework prevention)

5. **Test Fixtures** (instant data)
   - Ready-to-use: `docs/fixtures/{project}.fixtures.json`
   - Saves: 300-400 tokens per test

### Track Your Costs

```bash
# After each work session
./../../scripts/token-tracker.sh log {project} "{task description}" {tokens_used}

# View today's usage
./../../scripts/token-tracker.sh today

# See project breakdown
./../../scripts/token-tracker.sh project

# Estimate cost
./../../scripts/token-tracker.sh cost 5000
```

**Goal**: Stay under 50% of session budget = 8-10K tokens max per session

---

## Key Resources

- **Baselines**: What's typical → [TOKEN_BASELINES.md](../../docs/TOKEN_BASELINES.md)
- **Optimization**: How to reduce costs → [AGENT_OPTIMIZATION.md](../../.claude/AGENT_OPTIMIZATION.md)
- **Prompts**: Copy-paste saves → [AI_PROMPT_LIBRARY.md](../../docs/AI_PROMPT_LIBRARY.md)
- **Patterns**: Code templates → [docs/patterns/](../../docs/patterns/)
- **Errors**: Quick diagnosis → [docs/ERROR_CATALOG_{PROJECT}.md](../../docs/)
- **Project Guide**: Quick start → [AGENTS.md](./AGENTS.md)
```

---

## How to Add This to Your README

1. Copy the section above (after "## 💰 Token & Cost Efficiency")
2. Paste into your project's README.md
3. Update {project} placeholders
4. Add real example from first session
5. Commit with message: "docs: add cost tracking section to README"

---

## Making It Real: Examples

### Example 1: calm-couples

```markdown
## 💰 Token & Cost Efficiency

**Stats for calm-couples**:
- Bug fix (simple): 1.5-2K tokens ($0.004)
- Feature (small): 5-7K tokens ($0.013)
- Feature (large): 12-18K tokens ($0.036)
- Test coverage: +1-2K tokens ($0.002-0.005)

**Last Session** (Nov 1, 2025):
- Fixed: Plant render bug → 2.1K tokens
- Added: Dark mode toggle → 8.5K tokens
- Tests: 100% coverage → 1.8K tokens
- **Total**: 12.4K tokens ($0.031)
- **Vs baseline**: 40% savings (used patterns + fixtures)

**How to reduce**:
1. Error occurs? Search: `find-bug.sh "RLS policy"`
2. Building component? Use: `docs/patterns/LOGGING_PATTERNS.md`
3. Writing tests? Copy: `docs/fixtures/calm-couples.fixtures.json`

**Track your session**:
```bash
token-tracker.sh log calm-couples "fix plant render" 2100
token-tracker.sh today
```
```

### Example 2: ios-automation

```markdown
## 💰 Token & Cost Efficiency

**Stats for ios-automation**:
- Test creation: 2-3K tokens ($0.005)
- Framework enhancement: 5-10K tokens ($0.012-0.025)
- Device debugging: +200% overhead (very expensive!)
- Test isolation fix: 3-6K tokens ($0.007-0.015)

**Last Session** (Nov 1, 2025):
- Created: User registration test → 2.5K tokens
- Fixed: Modal dismissal issue → 4.2K tokens
- Setup: Test fixtures + workflows → 1.8K tokens
- **Total**: 8.5K tokens ($0.021)
- **Vs baseline**: 50% savings (used error catalog + patterns)

**Expensive scenarios to avoid**:
- Device connection issues (lost 2K diagnosing) → Use checklist first
- Flaky tests (repeated runs, +500t each) → Add waits, isolate state
- Modal problems (common blocker) → Check error catalog first

**Save tokens**:
1. Flaky test? Search: `find-bug.sh "modal dismissal"`
2. New test needed? Copy: `docs/fixtures/ios-automation.fixtures.json`
3. Unsure about pattern? Reference: `docs/patterns/TESTING_PATTERNS.md`

**Track**:
```bash
token-tracker.sh log ios-automation "user registration test" 2500
token-tracker.sh cost 8500
```
```

### Example 3: calm-ai-project-manager

```markdown
## 💰 Token & Cost Efficiency

**Stats for calm-ai-project-manager**:
- Endpoint creation: 2-3K tokens ($0.005)
- Bug fix: 2-4K tokens ($0.005-0.010)
- Feature: 5-10K tokens ($0.012-0.025)
- Database work: +1-2K tokens ($0.002-0.005)

**Last Session** (Nov 1, 2025):
- Created: Task API endpoint → 2.8K tokens
- Fixed: Circular dependency bug → 3.5K tokens
- Tests: Added coverage → 1.2K tokens
- **Total**: 7.5K tokens ($0.019)
- **Vs baseline**: 60% savings (used prompt library + error catalog)

**Common expensive mistakes**:
- Prisma schema out of sync → Lost 1K debugging → Check .schema.prisma first
- Claude API timeouts → +500t troubleshooting → Verify API key, use timeout

**Quick wins**:
1. Building API? Use: `docs/AI_PROMPT_LIBRARY.md` (prompt 3)
2. Database error? Search: `find-bug.sh "Prisma query failed"`
3. Writing tests? Copy: `docs/patterns/TESTING_PATTERNS.md`

**Track**:
```bash
token-tracker.sh log calm-ai-project-manager "task endpoint" 2800
token-tracker.sh project
```
```

---

## Tips for Accuracy

1. **Start tracking immediately** - Don't wait until end of session
2. **Include setup time** - npm install, env setup, etc counts
3. **Note blockers** - "Spent 2K diagnosing device issue" → learn for next time
4. **Compare to baseline** - Did you beat 60% savings? Celebrate!
5. **Share insights** - "Error catalog saved 30 min" → help team reuse

---

## Sharing Costs Transparently

**Why show costs?**
- Transparency helps make better decisions
- Visibility into optimization impact
- Team can learn from each other
- Realistic expectations for new features

**What to show**:
- ✅ Average costs per task type
- ✅ Savings from using tools
- ✅ Expensive pain points
- ✅ How to reduce future costs

**What NOT to show** (if sensitive):
- ❌ Individual contributor costs
- ❌ Exact budget limits
- ❌ Cost comparisons between people

---

## Monthly Review

Add to each project's monthly standup:

```markdown
### Cost Efficiency Summary (November)

**Token Usage**:
- 8 sessions × avg 6K tokens = 48K tokens total
- Cost: ~$0.12 (Haiku pricing)
- Vs baseline (10K/session): 40% savings = $0.30 saved

**What worked**:
- Error catalogs saved 30 min (4 sessions)
- Prompt library used 12 times (2.4K tokens saved)
- Fixtures eliminated setup 8 times (2.4K tokens saved)

**Pain points**:
- Device debugging cost extra 4K tokens (use checklist next time)
- One bad decision cost rework (1.5K tokens) → use decision trees

**Next month's goal**: 35% savings (beat this month's 40%)
```

---

**Remember**: Making costs visible enables optimization. Transparency = better decisions!

