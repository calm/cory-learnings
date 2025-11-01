# 🔄 Dependency Sync System

**Automatically detect and apply updates from external dependencies, APIs, and services across all projects**

## 🎯 Problem Solved

Manual version checking is:
- ❌ Time-consuming (requires manual npm outdated runs)
- ❌ Error-prone (easy to miss critical updates)
- ❌ Risky (no testing before update)
- ❌ Inconsistent (different approaches per project)

**Dependency Sync** solves this with:
- ✅ Automated detection (scheduled checks)
- ✅ Cost-optimized (24-hour cache, minimal API calls)
- ✅ Quality-gated (tests before applying)
- ✅ Intelligent routing (auto-apply safe updates, manual review for breaking changes)
- ✅ Unified across all projects

---

## 🏗️ Architecture

### Phase 1: Cost-Optimized Tracking
- npm registry API queries with 24-hour cache
- Scheduled weekly/bi-weekly checks (not real-time)
- Semantic versioning analysis
- Breaking change detection

### Phase 2: Quality Gates
- Full test suite before auto-update
- Rollback on failure with backup system
- API compatibility validation
- Service health monitoring

### Phase 3: Efficiency
- Parallel detection across projects
- Smart caching layer
- Automated PR generation
- GitHub Actions CI/CD integration

---

## 📦 Components

### Core Modules

**config.js** - Project configurations and update strategies
- Define which dependencies to monitor
- Set test thresholds and commands
- Configure notification channels

**update-detector.js** - Detects new versions available
- Queries npm registry (cached)
- Analyzes semantic versioning
- Detects breaking changes
- Checks service health

**update-applier.js** - Applies updates safely
- Creates backup before updating
- Runs tests after update
- Validates package imports
- Creates git commits
- Handles rollback on failure

**orchestrator.js** - Coordinates detection and application
- Runs detection in parallel
- Routes updates intelligently
- Manages notification system
- Generates reports

**notifier.js** - Sends notifications
- Slack webhooks
- Email alerts
- GitHub PR creation

**cli.js** - Command-line interface
- `npm run sync` - Full sync across all projects
- `npm run check [project]` - Check specific project
- `npm run watch` - Scheduled background monitoring

---

## 🚀 Quick Start

### 1. Setup

```bash
# Clone/install dependency-sync system
cd ~/cory-learnings/dependency-sync
npm install

# Set environment variables
export SLACK_WEBHOOK_URL="https://hooks.slack.com/..."
export ALERT_EMAIL="alerts@example.com"
```

### 2. Run Check

```bash
# Check all projects for updates
npm run sync

# Check specific project
npm run check calm-couples
npm run check ios-automation
npm run check calm-ai-project-manager
```

### 3. Review Results

Output shows:
- Available updates with version numbers
- Update strategy (auto-patch, auto-minor, manual-major)
- Critical status and breaking changes
- Service health status

### 4. Auto-Apply Updates

The system will:
1. ✅ Auto-apply safe updates (PATCH for critical, PATCH for non-critical)
2. ✅ Run full test suite
3. ✅ Commit changes on success
4. ✅ Rollback on failure with backups
5. ✅ Send notifications (Slack, email, GitHub)

---

## 📋 Update Strategies

### auto-patch
- **When**: PATCH version updates (e.g., 1.2.3 → 1.2.4)
- **Action**: Automatically applied
- **Testing**: Full test suite
- **Review**: None required

### auto-minor
- **When**: MINOR version updates (e.g., 1.2.0 → 1.3.0)
- **Action**: Automatically applied
- **Testing**: Full test suite + integration tests
- **Review**: None required

### manual-major
- **When**: MAJOR version updates (e.g., 1.0.0 → 2.0.0)
- **Action**: Create PR with manual review
- **Testing**: Full test suite + integration tests
- **Review**: Required before merge

---

## 🔧 Configuration

### .dependencies.json (per project)

Located in each project root:

```json
{
  "project": "calm-couples",
  "checkInterval": "weekly",
  "dependencies": [
    {
      "package": "@supabase/supabase-js",
      "updateStrategy": "auto-patch",
      "critical": true
    }
  ],
  "testConfig": {
    "command": "npm test",
    "expectedPassing": 63
  }
}
```

### config.js (central)

Manage all projects:

```javascript
const PROJECTS = {
  'calm-couples': {
    path: '~/Desktop/calm/calm-couples',
    checkInterval: 'weekly',
    testCommand: 'npm test',
    testThreshold: 63,
    dependencies: [...]
  }
}
```

---

## 📊 Examples

### Example 1: Auto-Apply PATCH Update

```
Input: @supabase/supabase-js v2.76.1 → v2.76.2 (PATCH)

Process:
1. ✅ Create backup
2. ✅ npm install @supabase/supabase-js@2.76.2
3. ✅ npm test → 63/63 passing
4. ✅ git commit
5. ✅ Slack notification: "✅ Updated @supabase/supabase-js"

Result: Update applied, no manual intervention needed
```

### Example 2: Manual Review for MAJOR Breaking Change

```
Input: react v18.2.0 → v19.0.0 (MAJOR)

Process:
1. 🔍 Detect breaking changes
2. 📝 Create PR with proposed update
3. 🔔 Slack notification: "👤 Manual review needed"
4. ✋ Wait for team review
5. ✅ Manual merge on approval

Result: Breaking change handled safely with team visibility
```

### Example 3: Failed Update with Rollback

```
Input: jest v29.0.0 → v30.0.0

Process:
1. ✅ Create backup
2. ✅ npm install jest@30.0.0
3. ❌ npm test → 2/30 failing (jest config incompatible)
4. 🔙 Rollback: restore from backup
5. ❌ Slack notification: "Update failed - reverted"

Result: Safe rollback, project remains stable
```

---

## 🎯 Cost Analysis

### Token Efficiency
- **Detection**: 1 API call per package per 24 hours (cached)
- **No speculative reads**: Only check what's configured
- **Parallel checks**: Reduce serial overhead

### Real Impact
- **Without system**: 15 minutes/week manual checking × 52 weeks = 13 hours/year
- **With system**: Automated, 0 manual hours
- **Cost**: < 1 API call/day on average

---

## 🔐 Safety Features

### Rollback Strategy
- Automatic backup before each update
- Git-based reversal on failure
- Keep last 10 backups per project
- Manual rollback available anytime

### Test Requirements
- 95% test pass threshold (5% variance allowed)
- Run before AND after update
- Track test coverage
- Alert on failures

### Breaking Change Detection
- Semantic version analysis
- CHANGELOG parsing
- API compatibility checking
- Service health monitoring

---

## 📱 Notifications

### Slack
- ✅ Success: "Updated package X to v1.2.3"
- ❌ Failure: "Update failed: reason"
- 👤 Review: "Manual review needed for breaking change"
- 📊 Summary: Daily/weekly sync summary

### Email
- Critical failures
- Manual review requests
- Weekly summary reports

### GitHub
- Auto-generated PR for breaking changes
- Status checks before merge
- Linked to commit history

---

## 🛠️ Maintenance

### Manual Override
```bash
# Check what would be updated
npm run check calm-couples

# Manually apply specific update
npm run apply @supabase/supabase-js
```

### Logs
- All updates logged to `.dependency-sync-backups/`
- Backup directory per update
- Rollback history available

### Cleanup
- Auto-cleanup: keep last 10 backups
- Manual cleanup: `rm -rf .dependency-sync-backups/*`

---

## 📈 Monitoring Dashboard

Future enhancement - track:
- Total updates applied
- Success/failure rates
- Average time to update
- Critical vulnerabilities caught
- Cost savings (time & errors prevented)

---

## 🚀 Future Enhancements

- [ ] Security vulnerability scanning (npm audit integration)
- [ ] Dependency tree analysis (detect duplicate versions)
- [ ] Performance regression testing
- [ ] Automated dependency consolidation
- [ ] Custom update schedules per dependency
- [ ] Integration with Dependabot
- [ ] ML-based timing optimization (best time to update)

---

## 📞 Support

Issues or questions?

1. Check `.dependencies.json` in your project
2. Run `npm run check [project]` to see detailed status
3. Review backup history in `.dependency-sync-backups/`
4. Check Slack notifications for alerts

---

## 📝 License

MIT - Part of Cory's learnings system
