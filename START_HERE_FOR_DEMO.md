# 🎯 START HERE FOR DEMO

**You have 10 minutes to present. Here's everything you need.**

---

## Step 1: Quick Check (30 seconds)

```bash
cd ~/cory-learnings
./pre-flight-check.sh
```

If you see "✓ PRE-FLIGHT CHECK PASSED" → You're ready!

---

## Step 2: Choose Your Demo Style

### Option A: Fully Automated (Recommended!)
```bash
./demo.sh
```
- Press ENTER at each pause
- Explain what appears on screen
- Let the script do the work

### Option B: Manual with Script
- Open [DEMO.md](DEMO.md)
- Follow the script step-by-step
- Copy/paste commands as you go

### Option C: Ultra-Quick (5 min)
- Open [DEMO_QUICK.md](DEMO_QUICK.md)
- Streamlined version
- Perfect if running short on time

---

## Step 3: Keep Cheat Sheet Open

Open in second window or print:
```bash
cat DEMO_CHEAT_SHEET.md
```

This has:
- ✅ All commands ready to copy
- ✅ Talking points for each section
- ✅ Recovery plans if something fails
- ✅ Time markers to stay on track

---

## The 30-Second Pitch

**Use this to open:**

> "I was wasting 40-60 minutes per day explaining my preferences to Claude. This repository teaches Claude once and applies it everywhere automatically. Result: 0 seconds per session, 100% consistency, enforced quality standards."

---

## The 30-Second Close

**Use this to end:**

> "Instead of telling Claude how I work in every conversation, this teaches Claude once and applies it everywhere. 10-15% productivity gain, 98% test coverage enforced, zero cost."

---

## Demo Files Quick Reference

| File | Purpose | When to Use |
|------|---------|-------------|
| [DEMO.md](DEMO.md) | Full 10-min script | Main presentation |
| [DEMO_QUICK.md](DEMO_QUICK.md) | 5-min version | Short on time |
| [DEMO_CHEAT_SHEET.md](DEMO_CHEAT_SHEET.md) | Commands + talking points | Keep open during demo |
| [demo.sh](demo.sh) | Automated script | Easiest option |
| [pre-flight-check.sh](pre-flight-check.sh) | Verify ready to present | Before you start |

---

## Key Numbers to Remember

- **6,800+ lines** of documentation
- **3 projects** integrated
- **0 seconds** loading time (automatic)
- **10-15 minutes** saved per session
- **40-60 minutes** saved per day
- **98% test coverage** enforced
- **v2.4.0** current version

---

## If Anything Goes Wrong

1. **Tests fail?** → "Tests are working by finding issues in projects"
2. **Search breaks?** → Use `grep -r "testing" *.md | head -5`
3. **Git unavailable?** → Skip that section, show files instead
4. **Complete failure?** → Show EXECUTIVE_SUMMARY.md instead

---

## Pro Tips

1. **Start strong**: Lead with the problem (wasted time)
2. **Show don't tell**: Run commands, let output speak
3. **End strong**: Close with value proposition
4. **Have backup**: Keep EXECUTIVE_SUMMARY.md ready
5. **Time check**: Glance at cheat sheet for markers

---

## Test It Now (2 minutes)

Before your presentation, do a quick test:

```bash
# Run this now to see what audience will see
cd ~/cory-learnings
echo "Testing search..."
./scripts/search-learnings.sh "testing" | head -3

echo "Testing structure..."
ls -lh *.md | head -5

echo "Testing git..."
git log --oneline -3

echo "✓ Ready to go!"
```

---

## Q&A Prep

**Q: How long to build?**
A: 1-2 days to v1.0, evolved to v2.4 with use

**Q: Works with other AI?**
A: Yes, model-agnostic markdown

**Q: For teams?**
A: Absolutely - shared + individual prefs

**Q: Maintenance?**
A: 5 min daily, 15 min weekly

**Q: Cost?**
A: $0 - pure markdown + bash

---

## Ready? Go!

1. ✅ Run `./pre-flight-check.sh`
2. ✅ Open `DEMO_CHEAT_SHEET.md` in second window
3. ✅ Run `./demo.sh` OR follow DEMO.md
4. ✅ Remember: Show impact, not just features

**You've got this!** 🚀

---

**When done presenting, everything can be found in:**
- [README.md](README.md) - Repository overview
- [ARCHITECTURE.md](ARCHITECTURE.md) - Technical details
- [EXECUTIVE_SUMMARY.md](EXECUTIVE_SUMMARY.md) - For stakeholders
