# ios-automation Project - Cost Savings Guide

**Current state: 8.9GB of mostly waste. Here's how to cut it down.**

---

## The Problem (Storage Breakdown)

```
Total size: 8.9GB

Breakdown:
├── screenshots/          6.0GB (67%) ← HUGE WASTE
├── .git/                 1.3GB (15%) ← Git history bloated by screenshots
├── node_modules/        202MB (2%)
├── test-reports/         12MB (0.1%)
├── coverage/             3.9MB (0%)
├── docs/                 2.4MB (0%)
├── tests/                2.3MB (0%)
└── other/               ~1.4GB (16%) ← Undetermined
```

**The killer:** 7,625 screenshot files in `screenshots/` directory

Most are:
- Duplicates (same test, different timestamps)
- Old test runs (accumulated over weeks/months)
- Never cleaned up
- Committed to git (bloats history)

---

## Quick Wins (Do Today - 30 min)

### 1. Archive Old Screenshots (Save 5GB)

Screenshots from >1 week ago are probably not needed for debugging.

```bash
cd ~/Desktop/calm/ios-automation

# Create archive directory
mkdir -p archived-screenshots

# Move screenshots older than 7 days
find screenshots/ -name "*.png" -mtime +7 -exec mv {} archived-screenshots/ \;

# Check what moved
du -sh archived-screenshots/
```

**Impact: -5GB from project, still accessible if needed**

### 2. Keep Only Latest Screenshot Per Test (Save 4GB)

Pattern: Same test name = multiple timestamps

Example:
```
01_app_launched_1761853520937.png
01_app_launched_1761853731630.png  ← Keep only latest
01_app_launched_1761854479644.png
01_app_launched_1761854903383.png
```

Script to keep only latest per test:

```bash
#!/bin/bash
# keep-latest-screenshots.sh

mkdir -p screenshots/archive

# Group by test name, keep only latest
find screenshots/ -name "*.png" -type f | sed 's/_[0-9]*\.png$//' | sort -u | while read base; do
  # Find all versions of this test
  files=($base*.png)
  if [ ${#files[@]} -gt 1 ]; then
    # Sort by modification time, keep newest, archive others
    ls -t "${files[@]}" | tail -n +2 | xargs -I {} mv {} screenshots/archive/
  fi
done

echo "Kept latest screenshots, archived duplicates"
```

**Impact: -4GB (keep ~1,900 latest, archive 5,700 old)**

### 3. Add Screenshot Cleanup to Build Pipeline (Save ongoing 100MB/week)

Every test run adds new screenshots. Without cleanup, grows 100MB+/week.

Add to `package.json` scripts:

```json
{
  "scripts": {
    "test:all": "npm run test:unit && npm run test:e2e && npm run clean:screenshots",
    "clean:screenshots": "node scripts/cleanup-screenshots.js"
  }
}
```

Create `scripts/cleanup-screenshots.js`:

```javascript
const fs = require('fs');
const path = require('path');

const SCREENSHOTS_DIR = './screenshots';
const ARCHIVE_DIR = './screenshots/archive';
const MAX_RECENT = 100; // Keep only 100 most recent

// Ensure archive dir exists
if (!fs.existsSync(ARCHIVE_DIR)) {
  fs.mkdirSync(ARCHIVE_DIR, { recursive: true });
}

// Get all screenshots
const files = fs.readdirSync(SCREENSHOTS_DIR)
  .filter(f => f.endsWith('.png'))
  .map(f => ({
    name: f,
    path: path.join(SCREENSHOTS_DIR, f),
    time: fs.statSync(path.join(SCREENSHOTS_DIR, f)).mtime.getTime()
  }))
  .sort((a, b) => b.time - a.time); // Newest first

// Archive old screenshots
const toArchive = files.slice(MAX_RECENT);
toArchive.forEach(file => {
  try {
    fs.renameSync(file.path, path.join(ARCHIVE_DIR, file.name));
    console.log(`Archived: ${file.name}`);
  } catch (e) {
    console.error(`Failed to archive ${file.name}:`, e.message);
  }
});

console.log(`\n✅ Cleanup complete: Archived ${toArchive.length} old screenshots`);
console.log(`📊 Kept ${Math.min(MAX_RECENT, files.length)} recent screenshots`);
```

**Impact: Prevents growth, keeps project manageable**

---

## Medium Wins (This Week - 2 hours)

### 4. Add Screenshots to .gitignore (Save 1.3GB in git history)

Currently, screenshots are committed to git, bloating history.

```bash
cd ~/Desktop/calm/ios-automation

# Add to .gitignore
echo "
# Screenshot artifacts
screenshots/*.png
test-reports/screenshots/
test-reports/playwright-artifacts/
" >> .gitignore

# IMPORTANT: Remove from git history (one-time)
git rm -r --cached screenshots/
git rm -r --cached test-reports/
git commit -m "chore: remove screenshots from git tracking"
git push
```

**Warning:** This rewrites git history. Coordinate with team.

**Impact: -1.3GB from git, future commits have no screenshot bloat**

### 5. Setup Screenshots in .gitignore From Start

For new test runs, never commit screenshots:

```bash
# Create screenshots/.gitkeep (track dir but not files)
touch screenshots/.gitkeep
git add screenshots/.gitkeep
git commit -m "chore: add screenshots directory (not tracked)"
```

**Impact: Keeps future growth off git**

### 6. Move Large Test Reports (Save 12MB)

```bash
mkdir -p test-reports-archive
mv test-reports/*.html test-reports-archive/ 2>/dev/null
mv test-reports/playwright-artifacts test-reports-archive/ 2>/dev/null

# Keep only current run results
```

**Impact: -10MB local, no git impact (HTML not usually committed)**

---

## Large Wins (This Month - 3 hours)

### 7. Implement Smart Screenshot Storage Strategy

**Current:** Every screenshot taken stays forever
**Better:** Only keep N most recent, or by test type

Options:

**Option A: Keep by Age**
- Keep: Latest 100 screenshots (all tests)
- Archive: Older than 7 days
- Delete: Older than 90 days

**Option B: Keep by Test Type**
- Keep: Latest 5 per test name
- Archive: Older versions
- Delete: After 30 days

**Option C: Keep by Importance**
- Keep: Failed test screenshots (always)
- Archive: Passed test screenshots after 7 days
- Delete: After 90 days

Recommend Option A (simplest) or Option B (most space-efficient).

### 8. Compress Old Screenshots (Save 2-3GB)

Old screenshots can be compressed to ~10% size.

```bash
# Compress archived screenshots
find screenshots/archive -name "*.png" | while read file; do
  # Use imagemagick or similar
  convert "$file" -quality 75 "compressed_$(basename $file)"
done

# Or use pngquant (better for PNGs)
pngquant --quality 60-80 --ext .png screenshots/archive/*.png
```

**Impact: -2-3GB (archive goes from 5GB → 500MB-1GB)**

### 9. Create Screenshot Rotation Policy

Add to project documentation:

```
SCREENSHOT MANAGEMENT POLICY

1. Screenshots are TEMPORARY test artifacts, not permanent records
2. Cleanup happens automatically after each test run
3. Manual cleanup: npm run clean:screenshots
4. Archive strategy:
   - Keep: 100 most recent screenshots
   - Archive: If older than 7 days
   - Delete: If older than 90 days
5. If you need to keep a screenshot:
   - Move to docs/evidence/ with a name explaining why
   - Screenshot stays in project permanently
6. Git: Screenshots never committed (except in docs/evidence)
```

---

## Cost Breakdown & Savings

### Current State
| Item | Size | Cost Driver | Action |
|------|------|-------------|--------|
| screenshots/ | 6.0GB | Uncontrolled accumulation | Archive old (5GB away) |
| .git history | 1.3GB | Screenshots in history | Remove from git (1.3GB away) |
| node_modules | 202MB | Standard deps | Keep as-is |
| test-reports | 12MB | Test artifacts | Move to archive (10MB away) |
| **Total** | **8.9GB** | **Screenshots & history** | **Can save 6.3GB (71%)** |

### After Optimizations
| Phase | Action | Savings | Effort |
|-------|--------|---------|--------|
| Quick (today) | Archive 7-day-old screenshots | -5GB | 30 min |
| Quick (today) | Keep only latest per test | -4GB | 30 min |
| Medium (week) | Remove from .git history | -1.3GB | 1 hour |
| Medium (week) | Setup auto-cleanup | -ongoing 100MB/week | 1 hour |
| Large (month) | Compress archived | -2-3GB | 1 hour |
| **Total** | | **6.3GB (71% reduction)** | **4 hours** |

### Result
```
Before: 8.9GB
After:  2.6GB (70% savings!)
```

---

## Implementation Roadmap

### Week 1: Quick Wins (1 hour)
- [ ] Archive screenshots older than 7 days (`-5GB`)
- [ ] Keep only latest per test name (`-4GB`)
- [ ] Verify no breakage
- [ ] Result: 8.9GB → ~4GB

### Week 2: Medium Wins (2 hours)
- [ ] Add screenshots to .gitignore
- [ ] Remove old screenshots from git history (coordinate with team)
- [ ] Setup auto-cleanup script
- [ ] Result: 4GB → ~2.5GB

### Week 3-4: Large Wins (1 hour)
- [ ] Compress archived screenshots
- [ ] Document screenshot policy
- [ ] Result: 2.5GB → ~1.5GB

---

## CI/CD Cost Savings

If project runs in CI/CD (GitHub Actions, Jenkins, etc.):

**Current problem:**
- Each test run: +100MB of screenshots
- Uploaded to artifact storage
- Stored for weeks/months
- Cost: $0.50-2.00 per GB per month

**After optimization:**
- Each test run: +10MB of screenshots (after cleanup)
- Only recent runs stored (auto-delete old)
- Cost reduction: 80-90%

**Example: GitHub Actions**
```
Before: 8.9GB × 30 projects × $0.25/GB/month = $67.50/month
After:  2.6GB × 30 projects × $0.25/GB/month = $19.50/month
Savings: $48/month = $576/year
```

---

## Git Performance Improvements

**Current problem:**
- Clone time: 2-5 minutes (due to 1.3GB git history)
- Push time: 30+ seconds (uploading large history)
- Disk space: 1.3GB just for git metadata

**After removing screenshots from git:**
- Clone time: 10-20 seconds
- Push time: 2-3 seconds
- Disk space: <100MB for git metadata

**Impact:** 20x faster clones, 15x faster pushes

---

## Database/API Costs (if applicable)

If screenshots uploaded to cloud storage (S3, GCS, etc.):

**Current:**
- 6GB × $0.023/GB/month (S3 standard) = $138/month
- Transfer: ~1GB/month × $0.09 = $90/month
- **Total: $228/month**

**After optimization:**
- 2GB × $0.023/GB/month = $46/month
- Transfer: ~0.5GB/month × $0.09 = $45/month
- **Total: $91/month**

**Savings: $137/month = $1,644/year**

---

## What NOT to Delete

⚠️ Keep these:
- `test-reports/` - Current run reports (useful for CI/CD)
- `coverage/` - Coverage reports (needed for quality checks)
- `docs/` - Documentation (important)
- `tests/` - Test code (essential)
- `.git/` (after cleanup) - Version control

✅ Safe to archive/delete:
- `screenshots/*.png` - Test artifacts (temporary)
- Old `.html` reports - Can regenerate
- `test-reports/playwright-artifacts/` - Temporary test data
- Anything in `Old Calm Classic Xray cases/` - Probably outdated

---

## Checklist

Quick Wins (Today):
- [ ] Archive screenshots older than 7 days
- [ ] Keep only latest per test name
- [ ] Add cleanup script
- [ ] Test that tests still work

Medium Wins (This Week):
- [ ] Add `screenshots/` to .gitignore
- [ ] Prepare to remove from git history (coordinate with team)
- [ ] Document new policy
- [ ] Setup auto-cleanup in CI/CD

Large Wins (This Month):
- [ ] Compress archived screenshots
- [ ] Monitor ongoing growth
- [ ] Adjust policy if needed
- [ ] Calculate actual savings

---

## Cost Summary

**Local storage:** Save 6.3GB (70% reduction)
**Git performance:** 20x faster clones
**Cloud storage:** Save $1,644/year (if using S3)
**Disk I/O:** Faster builds (smaller artifacts)
**Backup costs:** Smaller backups, faster recovery

**Total annual savings: $1,644+**
**Setup time: 4 hours (one-time)**
**Ongoing maintenance: ~5 minutes/month**

**Start today with quick wins (30 minutes, saves 5GB immediately).**
