# 🚀 Ultra-Quick Demo (5 Minutes)

**For when you only have 5 minutes**

---

## Setup (Do This Before Demo)

```bash
cd ~/cory-learnings
# Have terminal ready
# Have DEMO.md open in another window
```

---

## The Pitch (30 seconds)

**The Problem:**
"I was spending 10-15 minutes every AI session explaining my preferences. That's 40-60 minutes wasted per day."

**The Solution:**
"This repository teaches Claude once. Hooks automatically inject it into every conversation. Zero manual work."

---

## Show Don't Tell (4 minutes)

### 1. The Proof (30 seconds)
```bash
# Show it works
./tests/run-all-tests.sh
```
**Say:** "All tests passing = 6,800+ lines validated automatically."

---

### 2. The Scale (30 seconds)
```bash
ls -lh | head -15
```
**Say:**
- "19 markdown files"
- "6,800+ lines of documentation"
- "Zero dependencies"
- "Pure markdown + bash"

---

### 3. The Search (30 seconds)
```bash
./scripts/search-learnings.sh "testing"
```
**Say:** "Instant search across everything. Example: my 98% test coverage requirement."

---

### 4. The Automation (1 minute)
```bash
cat ~/.claude/settings.local.json
```
**Say:** "This hook runs before EVERY Claude conversation. Automatic injection of critical rules."

**Show the rules:**
- Todo lists for multi-step tasks
- Complete implementations (no TODOs)
- Zero test failures
- Work autonomously

---

### 5. The Impact (1 minute)
```bash
cat projects/calm-couples.md | head -40
```
**Say:** "Real example: calm-couples project."

**Point out:**
- Tech stack details (React 19, TypeScript, Supabase)
- Database context (RLS policies, procedures)
- Testing standards (98% coverage)
- Port config (localhost:3000)

**The payoff:**
"Claude knows this automatically in every session. No explanation needed."

---

### 6. The Metrics (30 seconds)
**Rapid fire:**
- ✅ **Time saved**: 40-60 min/day
- ✅ **Projects**: 3 active
- ✅ **Test coverage**: 98% enforced
- ✅ **Consistency**: 100%
- ✅ **Cost**: $0 (just markdown + bash)

---

## The Closer (30 seconds)

**One sentence value prop:**
> "Instead of explaining my preferences in every conversation, I teach Claude once and it applies everywhere automatically."

**Results:**
- 10-15% productivity gain
- Zero test failures enforced
- Single source of truth
- Scales to teams

**Next step:** SETUP_GUIDE.md shows how to build your own.

---

## Questions?

**Q: How long to build?**
A: 1-2 days to v1.0, evolved to v2.4.0 with use.

**Q: Works with other AI?**
A: Yes, model-agnostic markdown.

**Q: Team use?**
A: Absolutely - shared prefs + individual overrides.

**Q: Maintenance?**
A: 5 min daily, 15 min weekly, 30 min monthly.

---

**Time Check:** Should be ~5 minutes total
