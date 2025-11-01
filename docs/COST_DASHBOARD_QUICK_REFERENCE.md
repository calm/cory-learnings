# 💻 Cost Dashboard Quick Reference

## Start Dashboard

```bash
# Option 1: Use launcher script (recommended)
~/cory-learnings/launch-dashboard.sh

# Option 2: Direct Node.js
cd ~/cory-learnings
node cost-tracking-dashboard.js

# Option 3: From anywhere if in PATH
cost-tracking-dashboard
```

**Opens at**: http://localhost:5000

---

## Log Token Usage

```bash
token-tracker.sh log <project> <task> <tokens>
```

### Examples

```bash
# After fixing a bug
token-tracker.sh log calm-ai-pm "Fix N+1 query" 3200

# After adding a feature
token-tracker.sh log calm-couples "Plant 3D rendering" 4500

# After test work
token-tracker.sh log qa-automation "Fix modal timing" 2800

# After complex feature
token-tracker.sh log calm-ai-pm "Add cost dashboard" 8200
```

---

## Dashboard Views

| View | Shows | Use For |
|------|-------|---------|
| **Summary Cards** | Total cost, tokens, tasks, average | Quick overview |
| **By Project** | Costs breakdown per project | Identify expensive projects |
| **By Task** | Top 15 tasks by cost | Find optimization opportunities |
| **By Date** | Last 30 days spending | Track trends |
| **Recent** | Last 20 logged tasks | Spot patterns |

---

## API Endpoints

### Get Statistics
```bash
curl http://localhost:5000/api/stats | jq
```

### Get All Logs
```bash
curl http://localhost:5000/api/logs | jq
```

### Get Projects
```bash
curl http://localhost:5000/api/projects | jq
```

---

## Quick Commands

### See Today's Spending
```bash
token-tracker.sh today
```

### See by Project
```bash
token-tracker.sh project
```

### Estimate Cost for Tokens
```bash
token-tracker.sh cost 5000    # Cost of 5000 tokens
token-tracker.sh cost         # Cost of 170000 tokens (default)
```

---

## Tips & Tricks

### 🎯 After Each Task
```bash
# Always log when done
token-tracker.sh log calm-ai-pm "Task name" 3500
```

### 📊 Weekly Review
```bash
# Check what's costing most
curl http://localhost:5000/api/stats | jq '.byProject | to_entries | sort_by(.value.cost) | reverse'
```

### 🔍 Debug Logs
```bash
# View raw log file
cat ~/.claude/token-usage.log

# Count entries
wc -l ~/.claude/token-usage.log

# Last 10 entries
tail -10 ~/.claude/token-usage.log
```

### 💡 Set as Habit
```bash
# Add to your shell profile
alias dashboard="cd ~/cory-learnings && node cost-tracking-dashboard.js"

# Then just run:
dashboard
```

---

## Pricing Reference

| Model | Input | Output |
|-------|-------|--------|
| Haiku | $0.80/1M | $2.40/1M |

**Quick Calc**: `tokens * 0.0026 / 1000 = cost`

| Tokens | Cost |
|--------|------|
| 1,000 | $0.0026 |
| 2,000 | $0.0052 |
| 5,000 | $0.0130 |
| 10,000 | $0.0260 |
| 15,000 | $0.0390 |
| 20,000 | $0.0520 |

---

## Common Patterns

### Weekly Tracking
```bash
# Monday: Check last week's spending
token-tracker.sh today

# After work: Log the session
token-tracker.sh log <project> "<task>" <tokens>

# Friday: Review weekly trends
curl http://localhost:5000/api/stats | jq '.byProject'
```

### Cost Control
```bash
# If daily cost > $3, reduce next day's work
# If project > 30% of budget, optimize or pause

# Use dashboard to identify patterns
# Then apply TOKEN_EFFICIENCY.md strategies
```

### Budget Planning
```bash
# Check monthly trend
# (Daily average * 30) = estimated monthly
# Compare to budget goal
# Adjust tasks if needed
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Dashboard won't start | Check Node.js: `node --version` |
| No data showing | Log a test: `token-tracker.sh log test "test" 1000` |
| Port 5000 in use | Kill: `lsof -i :5000` then `kill -9 <pid>` |
| Old data | Check `~/.claude/token-usage.log` exists |
| Wrong costs | Verify token count accuracy |

---

## Learn More

- 📖 [COST_DASHBOARD_GUIDE.md](COST_DASHBOARD_GUIDE.md) - Full documentation
- 📈 [TOKEN_EFFICIENCY.md](../docs/cost-optimization/TOKEN_EFFICIENCY.md) - Optimization strategies
- 💰 [COMPREHENSIVE_COST_ANALYSIS.md](../docs/cost-optimization/COMPREHENSIVE_COST_ANALYSIS.md) - Cost breakdown
- 🎯 [TOKEN_BASELINES.md](TOKEN_BASELINES.md) - Real costs per task type

---

## Key Rules

✅ **DO**
- Log after task completion
- Use descriptive task names
- Check dashboard weekly
- Plan budget based on trends

❌ **DON'T**
- Forget to log work
- Use vague task names
- Ignore high-cost patterns
- Speculate on token counts

---

**Quick Start**: `~/cory-learnings/launch-dashboard.sh` → http://localhost:5000

