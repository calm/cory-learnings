---
title: "Cost Tracking Dashboard Guide"
description: "Real-time token usage and cost visualization across all projects"
version: "1.0"
last_updated: "2025-11-01"
---

# Cost Tracking Dashboard Guide

Real-time visualization of token usage and costs across all projects. Helps you stay within budget and identify cost optimization opportunities.

---

## Quick Start

### 1. Start the Dashboard

```bash
# From cory-learnings directory
node cost-tracking-dashboard.js

# Or from anywhere (if added to PATH)
cost-tracking-dashboard
```

Opens dashboard at: **http://localhost:5000**

### 2. Log Token Usage

```bash
# From anywhere
token-tracker.sh log <project> <task> <tokens>

# Examples:
token-tracker.sh log calm-ai-pm "Add AGENTS.md" 3500
token-tracker.sh log qa-automation "Fix flaky test" 2800
token-tracker.sh log calm-couples "Plant renderer fix" 2100
```

### 3. View Dashboard

Go to **http://localhost:5000** in your browser. Dashboard auto-refreshes every 30 seconds.

---

## Dashboard Features

### 📊 Summary Cards

- **Total Cost** - Total $ spent across all logged tasks
- **Total Tokens** - Total tokens consumed
- **Tasks Logged** - Number of tasks tracked
- **Avg Cost/Task** - Average cost per task

### 📈 Costs by Project

Table showing breakdown by project:
- Number of tasks
- Total tokens used
- Total cost
- Average tokens per task

**Use this to**: Identify which projects consume most budget

### 🎯 Top Tasks by Cost

Top 15 tasks ranked by cost:
- Which projects used this task type
- Task count and total cost
- Helps identify expensive workflows

**Use this to**: Find optimization opportunities (e.g., "Feature creation" costs too much)

### 📅 Costs by Date

Last 30 days of spending:
- Date
- Number of tasks that day
- Tokens and cost for that day

**Use this to**: See spending trends and identify high-cost days

### 📝 Recent Activity

Last 20 logged tasks with full details:
- Exact timestamp
- Project
- Task description
- Tokens and cost

**Use this to**: Track what was just logged and spot patterns

---

## API Endpoints

Dashboard also provides JSON APIs for programmatic access:

### `/api/stats`

Get aggregate statistics:

```bash
curl http://localhost:5000/api/stats
```

Response:
```json
{
  "totalTokens": 45000,
  "totalCost": 117.00,
  "logs": 42,
  "byProject": {
    "calm-ai-pm": {
      "tokens": 25000,
      "cost": 65.00,
      "count": 18
    }
  },
  "byDate": { ... },
  "byTask": { ... }
}
```

### `/api/logs`

Get raw log entries:

```bash
curl http://localhost:5000/api/logs
```

Response:
```json
[
  {
    "datetime": "2025-11-01 14:30:45",
    "date": "2025-11-01",
    "time": "14:30:45",
    "project": "calm-ai-pm",
    "task": "Add AGENTS.md",
    "tokens": 3500,
    "cost": 9.10
  }
]
```

### `/api/projects`

Get list of projects with logged tasks:

```bash
curl http://localhost:5000/api/projects
```

Response:
```json
["calm-ai-pm", "qa-automation", "calm-couples"]
```

---

## Logging Best Practices

### ✅ DO

1. **Log after task completion**
   ```bash
   # When task is done
   token-tracker.sh log calm-ai-pm "Fix N+1 query" 3200
   ```

2. **Use descriptive task names**
   ```bash
   # Good - specific and actionable
   token-tracker.sh log qa-automation "Fix modal dismissal timeout" 2800

   # Avoid - too vague
   token-tracker.sh log qa-automation "Fix bug" 2800
   ```

3. **Be honest with token counts**
   ```bash
   # Use actual tokens from Claude usage
   # Check: session token counter or from previous session summary
   token-tracker.sh log calm-couples "Plant 3D rendering" 4500
   ```

4. **Log real work sessions**
   ```bash
   # After bug fix
   token-tracker.sh log calm-ai-pm "Debug rate limiting issue" 5600

   # After feature
   token-tracker.sh log calm-ai-pm "Implement cost dashboard" 8200
   ```

### ❌ DON'T

1. **Don't log exploratory work**
   ```bash
   # Avoid - unless it leads to actual change
   token-tracker.sh log calm-couples "Research styling options" 2100
   ```

2. **Don't log partial work**
   ```bash
   # Avoid - log when done, not mid-work
   token-tracker.sh log qa-automation "Work in progress" 3000
   ```

3. **Don't exaggerate token counts**
   ```bash
   # Avoid - inflate numbers
   token-tracker.sh log calm-ai-pm "Small fix" 10000  # Actually 2000
   ```

---

## Understanding Costs

### Token Pricing (Haiku 4.5)

```
Input:  $0.80 per 1M tokens
Output: $2.40 per 1M tokens
Ratio:  ~1:3 (input:output)
```

### Cost Calculation

```
tokens * 0.0026 / 1000 = cost in dollars

Example: 3500 tokens
3500 * 0.0026 / 1000 = $0.0091 ≈ $0.01
```

### Real Examples

| Task | Tokens | Cost |
|------|--------|------|
| Simple bug fix | 2,000 | $0.01 |
| Feature addition | 5,000 | $0.01 |
| Large feature | 15,000 | $0.04 |
| Device debugging | 12,000+ | $0.03+ |
| Full refactor | 18,000 | $0.05 |

---

## Tracking & Analysis

### Daily Budget Check

```bash
# See today's spending
token-tracker.sh today

# Get breakdown by project
token-tracker.sh project

# Estimate cost for X tokens
token-tracker.sh cost 50000  # $0.13
```

### Cost Patterns to Watch

| Pattern | Meaning | Action |
|---------|---------|--------|
| 🔴 Single task > 10K tokens | Task too expensive | Break into smaller pieces |
| 🟡 Feature costs 50% more this week | Cost creep | Check for model changes |
| 🟢 Costs trending down | Good optimization | Document what changed |
| 🔴 Device debugging = 30% of budget | Mobile costs high | Plan device work carefully |

### Monthly Review

```bash
# Check last 30 days of spending
# Use dashboard to see trends
# Calculate: totalCost / 30 = daily average
# Plan next month based on patterns
```

Example:
- November total: $87.50
- Tasks: 65
- Daily average: $2.92/day
- Goal for December: Reduce to $2.50/day through optimization

---

## Integration with Projects

Each project README has a "💰 Token & Cost Efficiency" section that references:
- Typical task costs for that project
- How to track and optimize
- Real examples
- Baseline goals

**To add to your project**:

1. Check project's README for "💰 Token & Cost Efficiency" section
2. Add logging: `token-tracker.sh log <project> <task> <tokens>`
3. View dashboard to verify tracking works
4. Review weekly to identify optimization opportunities

---

## Troubleshooting

### Dashboard won't start

```bash
# Check Node.js is installed
node --version

# Check logs file exists
ls ~/.claude/token-usage.log

# Try with explicit path
node /path/to/cost-tracking-dashboard.js
```

### No data showing

1. Logs haven't been created yet
2. Check `~/.claude/token-usage.log` exists
3. Add a test entry: `token-tracker.sh log test-project "test task" 1000`
4. Refresh dashboard

### Wrong costs displayed

1. Verify token counts are accurate
2. Check `~/.claude/token-usage.log` format (should be pipe-delimited)
3. Look at `/api/logs` endpoint to inspect raw data
4. Manually fix entries in log file if needed (backup first!)

### High cost for small task

Possible causes:
1. Token count was higher than expected (check summary)
2. Device debugging + normal work in same session
3. Multiple attempts/iterations included in count
4. Review the work to see what consumed tokens

---

## Advanced Usage

### Export Data for Analysis

```bash
# Get all logs as JSON
curl http://localhost:5000/api/logs > token-logs.json

# Filter specific project
cat token-logs.json | grep "calm-ai-pm"

# Calculate average by project
curl http://localhost:5000/api/stats | jq '.byProject'
```

### Monitor Spending in Script

```bash
#!/bin/bash
# Check if daily spending > $5
STATS=$(curl -s http://localhost:5000/api/stats)
COST=$(echo $STATS | jq '.totalCost')

if (( $(echo "$COST > 5.0" | bc -l) )); then
  echo "⚠️  Warning: Daily spending exceeds $5 ($${COST})"
fi
```

### Track Multiple Sessions

Dashboard reads `~/.claude/token-usage.log` continuously.

To track multiple Claude sessions:
1. Each session's agent should log via `token-tracker.sh`
2. Dashboard aggregates all sessions
3. Use task names to differentiate work (e.g., "Session-1: feature-x")

---

## Rules

1. ✅ Log all significant work (not exploratory)
2. ✅ Use accurate token counts from session summary
3. ✅ Include descriptive task names
4. ✅ Check dashboard weekly
5. ✅ Plan budget based on historical costs
6. ❌ Don't speculate on costs
7. ❌ Don't log failed/abandoned work
8. ❌ Don't round token counts wildly

---

## See Also

- [TOKEN_EFFICIENCY.md](TOKEN_EFFICIENCY.md) - Optimization strategies
- [TOKEN_BASELINES.md](TOKEN_BASELINES.md) - Real costs per task type
- [Project READMEs](../) - Project-specific cost sections

