---
title: "CI/CD Cost Tracking Integration"
description: "Automated commit tracking for token cost association"
version: "1.0"
last_updated: "2025-11-01"
---

# CI/CD Cost Tracking Integration

Automatically track commits for token cost association via GitHub Actions.

---

## Overview

When you push commits, GitHub Actions automatically logs commit metadata. You then associate token costs with those commits using `token-tracker.sh`.

**Why?** Link which work (commit) consumed which tokens → understand what's expensive → optimize future work.

---

## How It Works

### 1. Commit Push
```bash
git commit -m "feat: add plant watering feature"
git push
```

### 2. GitHub Actions Triggers
Workflow file `.github/workflows/track-cost.yml` runs automatically on each push to `main` branch.

**Logs**:
- Commit hash (short)
- Author
- Commit message
- Timestamp

### 3. Manual Cost Association
After the work is complete, you log the token cost:

```bash
token-tracker.sh log calm-couples "plant watering feature" 5200
```

### 4. Dashboard View
The cost dashboard now shows:
- Which commits consumed tokens
- Author and message for context
- Trend over time

---

## Setup (Already Done)

All 3 projects have GitHub Actions workflows installed:

```
calm-couples/.github/workflows/track-cost.yml
calm-ai-project-manager/.github/workflows/track-cost.yml
qa-automation/.github/workflows/track-cost.yml
```

**Each workflow**:
- Triggers on push to `main`
- Logs commit metadata to GitHub Actions output
- Displays tracking info in workflow run
- Suggests token logging command

---

## Usage

### After Completing Work

1. **Push your commit**
   ```bash
   git push
   ```

2. **Check GitHub Actions** (optional)
   - Go to repo → Actions tab
   - Find "Track Commit Cost" run
   - View logs to confirm tracking

3. **Log token cost**
   ```bash
   token-tracker.sh log calm-couples "Your task description" 5000
   ```

### Example Workflow

```
11:30 AM - Complete feature work
11:31 AM - git push origin main
         → GitHub Actions logs commit automatically
11:32 AM - Check Actions tab (see commit tracked)
11:33 AM - token-tracker.sh log calm-couples "Add feature X" 4800
11:35 AM - View dashboard: http://localhost:5000
         → See commit linked with cost
```

---

## Format

### Workflow Output

Each workflow run displays:

```
✅ Commit cost tracking logged
📝 Commit: a1b2c3d
👤 Author: octocat
📅 Date: 2025-11-01 14:30:45

After merging, log the token cost with:
  token-tracker.sh log calm-couples "<task>" <tokens>
```

### Token Log Format

Format in `~/.claude/token-usage.log`:

```
2025-11-01 14:33:22 | calm-couples | Add feature X | 4800 tokens | $12.48
```

---

## Dashboard Integration

### View Commits with Costs

Dashboard shows:
- **By Project**: Costs per project across all commits
- **By Date**: Spend trends and which commits cost most
- **By Task**: Task patterns and expensive types
- **Recent Activity**: Latest logged costs with commit details

### Useful Queries

```bash
# See commits from today
curl http://localhost:5000/api/stats | jq '.byDate | keys' | tail -1

# See project costs
curl http://localhost:5000/api/stats | jq '.byProject'

# See recent commits with costs
curl http://localhost:5000/api/logs | jq '.[-10:]'
```

---

## Limitations & Next Steps

### Current (v1.0)
✅ Automatic commit tracking via GitHub Actions
✅ Manual token cost logging
✅ Dashboard aggregation
✅ Per-project support

### Future Enhancements
- ⏳ Auto-link commits to costs (detect from context)
- ⏳ PR comments showing estimated cost
- ⏳ Cost thresholds and alerts
- ⏳ Commit-to-cost analytics dashboard
- ⏳ Cost attribution per developer

---

## Troubleshooting

### Workflow Not Running

**Problem**: GitHub Actions not triggering

**Solution**:
1. Check `.github/workflows/track-cost.yml` exists in repo
2. Ensure pushing to `main` branch (not `master`)
3. Check GitHub Actions is enabled (Settings → Actions)
4. Re-trigger: `git commit --allow-empty -m "trigger" && git push`

### Commit Not Showing in Dashboard

**Problem**: Pushed commit but dashboard doesn't show it

**Reason**: Workflow logs commit metadata, but cost data is manual

**Solution**: Log the cost yourself:
```bash
token-tracker.sh log <project> "<task>" <tokens>
```

Dashboard will then show cost associated with today's date.

### Wrong Project Name

**Problem**: Workflow suggests wrong project in message

**Solution**: Manually use correct project name when logging:
```bash
# Ignore workflow suggestion, use correct project
token-tracker.sh log calm-ai-pm "task" 3000  # Not calm-ai-project-manager
```

---

## Best Practices

### ✅ DO

1. **Log cost immediately after work**
   ```bash
   # Right after pushing
   token-tracker.sh log calm-couples "feature" 5000
   ```

2. **Use descriptive task names that match commits**
   ```bash
   # Good - links to commit message
   token-tracker.sh log calm-ai-pm "Implement cost dashboard" 8200
   ```

3. **Include commit hash in log if complex**
   ```bash
   # Optional but helpful
   token-tracker.sh log qa-automation "Fix modal timing (abc1234)" 3200
   ```

4. **Review weekly**
   - Check dashboard for trends
   - Identify expensive commits
   - Plan optimizations

### ❌ DON'T

1. **Don't log without pushing**
   ```bash
   # Wait until code is pushed
   # Then log the cost
   ```

2. **Don't use vague task names**
   ```bash
   # Avoid
   token-tracker.sh log calm-couples "work" 5000

   # Use
   token-tracker.sh log calm-couples "Add plant watering reminders" 5000
   ```

3. **Don't forget to log**
   ```bash
   # Commit doesn't automatically get cost
   # You must manually log it
   ```

---

## Rules

1. ✅ GitHub Actions auto-logs every commit
2. ✅ You manually log token costs
3. ✅ Cost data is associated by date + task name
4. ✅ Review dashboard weekly
5. ❌ Workflows don't auto-calculate costs (manual process)
6. ❌ Don't rely on workflow logs as source of truth

---

## See Also

- [COST_DASHBOARD_GUIDE.md](COST_DASHBOARD_GUIDE.md) - Dashboard usage
- [COST_DASHBOARD_QUICK_REFERENCE.md](COST_DASHBOARD_QUICK_REFERENCE.md) - Quick commands
- [TOKEN_EFFICIENCY.md](../docs/cost-optimization/TOKEN_EFFICIENCY.md) - Cost optimization strategies
- Project READMEs - Project-specific cost baselines

---

**Version**: 1.0 | **Last Updated**: 2025-11-01
