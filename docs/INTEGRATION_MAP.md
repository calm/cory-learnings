---
title: "Project Integration Map"
description: "How calm-couples, qa-automation, and calm-ai-project-manager connect"
version: "1.0"
last_updated: "2025-11-01"
---

# Integration Map - Calm Projects

How the 3 projects talk to each other and share data.

---

## Project Roles

| Project | Type | Purpose | Users |
|---------|------|---------|-------|
| **calm-couples** | Consumer App | Relationship wellness, plant tracking | Couples using Calm app |
| **qa-automation** | Test Framework | E2E testing (Web, iOS, Android) | QA, CI/CD |
| **calm-ai-project-manager** | Internal Tool | Project management + RCI matrix | Calm team |

---

## Data Flow

```
calm-couples (React + Supabase)
    ↓
    ├─ User data, plant status
    ├─ Relationship metrics
    └─ Session activity

         ↓ (consumed by)

calm-ai-project-manager (Node.js + Express + SQLite)
    ├─ Imports: User growth, feature usage
    ├─ Generates: RCI matrix, insights
    ├─ Produces: Task suggestions, analytics
    └─ Exports: Reports, metrics

         ↓ (tests)

qa-automation (Playwright + WebdriverIO/Appium)
    ├─ Tests: calm-couples features (web, iOS, Android)
    ├─ Validates: User workflows end-to-end
    ├─ Reports: Test results back to project manager
    └─ Uses: calm-ai-project-manager data for test scenarios
```

---

## Direct Dependencies

### calm-couples → calm-ai-project-manager
**What**: User activity and feature usage data
**How**: API endpoints or database sync
**Frequency**: Daily/hourly
**Critical**: No (PM tool doesn't block app)

### calm-ai-project-manager → qa-automation
**What**: Test scenario data, user workflows
**How**: Test fixtures, config files
**Frequency**: Per test run
**Critical**: No (tests are validation)

### qa-automation → calm-couples
**What**: Validates that features work across platforms
**How**: E2E tests of actual app behavior
**Frequency**: Before releases
**Critical**: Yes (validates shipping)

---

## Shared Resources

**Database**: Each project has its own (no shared DB)
**Auth**: calm-couples uses Supabase, others use own
**API**: REST endpoints between projects (if needed)
**Config**: Shared .env patterns

---

## Integration Points

### 1. User Data Sharing
- **From**: calm-couples
- **To**: calm-ai-project-manager
- **Data**: `{ userId, email, createdAt, plantCount, activityLevel }`
- **Purpose**: Analytics, RCI scoring
- **Sync method**: API or database export

### 2. Test Data Generation
- **From**: calm-ai-project-manager
- **To**: qa-automation
- **Data**: Test user accounts, workflows
- **Purpose**: E2E testing with real scenarios
- **Format**: JSON fixtures in test directory

### 3. Test Result Reporting
- **From**: qa-automation
- **To**: calm-ai-project-manager
- **Data**: Pass/fail, coverage, timing
- **Purpose**: Release gating
- **Frequency**: Per deployment

---

## Common Scenarios

### Scenario 1: New Feature in calm-couples
1. **develop** feature in calm-couples
2. **Write tests** in ios-automation (E2E)
3. **Track** in calm-ai-project-manager (task status)
4. **Ship** when tests pass

### Scenario 2: Bug in Production
1. **Detect** via ios-automation (test failure)
2. **Create task** in calm-ai-project-manager
3. **Fix** in calm-couples
4. **Test** with ios-automation E2E
5. **Deploy** when verified

### Scenario 3: Performance Analysis
1. **Collect metrics** from calm-couples (usage, timing)
2. **Analyze** in calm-ai-project-manager (RCI, trends)
3. **Identify bottlenecks** (slow features, high churn)
4. **Optimize** in calm-couples
5. **Test** with ios-automation (no regression)

---

## API Contract (if needed)

### calm-couples → calm-ai-project-manager

**Endpoint**: `POST /api/metrics/daily`
```json
{
  "date": "2025-11-01",
  "metrics": {
    "activeUsers": 1234,
    "newUsers": 45,
    "plantCount": 5678,
    "sessionDuration": 23.5,
    "errorRate": 0.02
  }
}
```

### ios-automation → calm-ai-project-manager

**Endpoint**: `POST /api/tests/results`
```json
{
  "testRun": "ios-e2e-release-2.0",
  "timestamp": "2025-11-01T10:00:00Z",
  "summary": {
    "total": 50,
    "passed": 48,
    "failed": 2,
    "coverage": 0.87
  },
  "failures": [
    { "test": "plant-creation", "error": "timeout" }
  ]
}
```

---

## Troubleshooting Integration Issues

| Issue | Diagnosis | Solution |
|-------|-----------|----------|
| Test data stale | Check sync time | Re-sync from calm-couples |
| Metrics missing | Check API call logs | Verify endpoint, retry |
| Test failures | Check app version | Update test fixtures |
| Slow sync | Check network | Add caching, batch updates |

---

## Future Integrations

- [ ] Webhook notifications (test failures → Slack)
- [ ] Automated deployment gating (tests must pass)
- [ ] Performance tracking dashboard
- [ ] User feedback loop (iOS crashes → bug tracking)

---

**Remember**: Loose coupling, clear data contracts = healthy integrations

