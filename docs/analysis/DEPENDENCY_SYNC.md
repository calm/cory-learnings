# 🔄 Dependency Sync System

**Purpose**: Automatically detect and apply updates from external services across all projects

**Optimization Principle**: Cost → Quality → Efficiency

---

## Architecture Overview

### Phase 1: Cost-Optimized Tracking
- Single `.dependencies.json` per project (tracks critical deps)
- Scheduled daily checks (not constant monitoring)
- npm registry API + GitHub releases (free)
- 24-hour caching

### Phase 2: Quality Gates
- Full test suite before auto-update
- Semantic versioning validation
- Breaking change detection
- Rollback capability

### Phase 3: Efficiency
- Parallel checks across projects
- Smart caching layer
- Automated PR generation
- GitHub Actions CI/CD

---

## Project Configurations

### calm-couples
**Critical Dependencies**:
- `@supabase/supabase-js` (breaking API changes)
- `@stripe/stripe-js` (payment system - critical)
- `react` & `@react-router-dom` (breaking changes)
- `tailwindcss` (styling framework)

**External Services**:
- Supabase (database, auth)
- Stripe (payments)

**Update Strategy**:
- Check weekly for MAJOR.minor changes
- Auto-apply PATCH updates
- Manual review for MAJOR breaking changes
- Test: Run full test suite (63 tests)

---

### ios-automation
**Critical Dependencies**:
- `@anthropic-ai/sdk` (AI integration)
- `playwright` (web automation)
- `webdriverio` (mobile automation)
- `jest` (testing framework)

**External Services**: None (self-contained)

**Update Strategy**:
- Check weekly for framework updates
- Auto-apply library updates
- Test: Run 648-test suite
- Validate: E2E test execution still works

---

### calm-ai-project-manager
**Critical Dependencies**:
- `@anthropic-ai/sdk` (Claude AI)
- `@prisma/client` (database ORM)
- `express` (API framework)

**External Services** (9 integrations):
- Anthropic Claude API
- Jira Cloud API
- Confluence API
- Slack API
- GitHub API
- Linear API
- Zoom API
- SQLite (dev)
- PostgreSQL (prod)

**Update Strategy**:
- Check twice weekly (multiple integrations)
- Auto-apply library updates
- Validate against live APIs (with fallback)
- Test: Run 105+ test suite + integration tests

---

## Implementation Details

### File: `.dependencies.json` (each project)
```json
{
  "project": "calm-couples",
  "lastChecked": "2025-10-31T12:00:00Z",
  "checkInterval": "weekly",
  "dependencies": [
    {
      "package": "@supabase/supabase-js",
      "current": "2.76.1",
      "constraint": "^2.76.0",
      "updateStrategy": "auto-patch",
      "critical": true
    },
    {
      "package": "@stripe/stripe-js",
      "current": "8.2.0",
      "constraint": "^8.0.0",
      "updateStrategy": "auto-patch",
      "critical": true
    }
  ],
  "externalServices": [
    {
      "service": "Supabase",
      "type": "database-auth",
      "healthcheck": "https://supabase.com/status"
    }
  ]
}
```

### Script: `scripts/check-updates.sh`
- Queries npm registry for new versions
- Checks GitHub releases for breaking changes
- Validates API documentation updates
- Returns: `{package: version, breaking: bool, recommendation: string}`

### Script: `scripts/apply-updates.sh`
- Updates package.json
- Runs `npm install`
- Executes test suite
- On failure: rollback + alert
- On success: create git commit

### Central Orchestrator: `dependency-sync/index.js`
- Coordinates updates across 3 projects
- Manages notification system
- Tracks rollback history
- Generates monthly reports

---

## Workflow Example

```
Day 1 (Daily 2:00 AM):
  1. check-updates.sh runs on all 3 projects
  2. Finds: @supabase/supabase-js v2.77.0 available
  3. Analyzes: PATCH update (safe)
  4. Creates: PR with updated package.json
  5. Runs: Tests pass ✓
  6. Auto-merges: To main branch
  7. Notifies: Slack #engineering-updates

Day 2 (Critical: Breaking change detected):
  1. Finds: react v20.0.0 (MAJOR update)
  2. Analyzes: Breaking API changes detected
  3. Creates: Alert + manual PR (requires review)
  4. Notifies: Slack #urgent-updates
  5. Waits: Manual approval from team
```

---

## Benefits

✅ **Cost**: Minimal API calls (scheduled, cached)
✅ **Quality**: All updates tested automatically
✅ **Efficiency**: 0 manual version checks needed
✅ **Safety**: Rollback on failure
✅ **Visibility**: Dashboard + notifications
✅ **Compliance**: Breaking changes flagged for review

---

## System Location

All files are in: `/Users/coryweinstein_1_2/cory-learnings/dependency-sync/`

```
dependency-sync/
├── config.js              # Central configuration
├── update-detector.js     # Detection engine (npm registry)
├── update-applier.js      # Application engine (tests, rollback)
├── orchestrator.js        # Coordinator (parallel, routing)
├── notifier.js            # Notification system
├── cli.js                 # Command-line interface
├── package.json           # Dependencies
├── README.md              # Full documentation
└── .github-workflow-template.yml  # GitHub Actions template
```

Manifests in each project:
```
calm-couples/.dependencies.json
ios-automation/.dependencies.json
calm-ai-project-manager/.dependencies.json
```

---

## Quick Commands

```bash
cd ~/cory-learnings/dependency-sync

# Check all projects for updates
npm run sync

# Check specific project
npm run check calm-couples
npm run check ios-automation
npm run check calm-ai-project-manager

# Watch for updates (scheduled background)
npm run watch
```

---

## Implementation Status

✅ **COMPLETE** - Full system implemented with:
- Cost-optimized detection (24-hour caching)
- Quality gates (tests before updates)
- Automatic rollback on failure
- Intelligent routing (auto vs manual)
- Multi-channel notifications (Slack, email, GitHub)
- Unified across all 3 projects
