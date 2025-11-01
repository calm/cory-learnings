---
title: "Project Pain Points & Solutions"
description: "Known issues, gotchas, and solutions per project"
version: "1.0"
last_updated: "2025-11-01"
---

# Project Pain Points & Solutions

Documented issues, root causes, and proven solutions for all 3 projects.

---

## 🌱 calm-couples (React SaaS)

### Pain Point 1: Plant Rendering Race Conditions
**Symptom**: Plant doesn't update immediately, or renders with wrong growth stage
**Root cause**: Supabase realtime subscription conflicts with local state updates
**Impact**: Medium - affects plant growth visualization (cosmetic, not data loss)
**Solution**:
- Use Zustand store as source of truth
- Batch realtime updates (debounce 500ms)
- Always optimistic update before API call
- Ref: `src/lib/store.ts` - see `updatePlantGrowth()`

### Pain Point 2: GDPR Compliance Complexity
**Symptom**: Data export fails, deletion doesn't cascade properly
**Root cause**: Supabase RLS policies + foreign key constraints interact unexpectedly
**Impact**: High - legal/compliance risk
**Solution**:
- Use database views for cascading logic
- Test deletion in full: user → gardens → plants → care_moments
- Document RLS rules per table
- Ref: `src/lib/gdpr.ts` - see full export/delete flow

### Pain Point 3: 3D Plant Rendering Performance
**Symptom**: 10+ plants cause janky animations on mobile
**Root cause**: CSS 3D transforms + transforms on every re-render
**Impact**: Medium-High - affects UX on lower-end devices
**Solution**:
- Use `will-change: transform` selectively
- Memoize plant components with `React.memo()`
- Throttle animation frames
- Ref: `src/components/garden/Plant3D.tsx` - see memo + CSS optimization

### Pain Point 4: Stripe Webhook Signature Verification
**Symptom**: Webhooks fail silently, subscriptions don't activate
**Root cause**: Webhook endpoint wasn't reading raw body correctly
**Impact**: High - payment flow breaks
**Solution**:
- Always read raw body for Stripe (not JSON parsed)
- Verify signature with timestamp + nonce
- Log verification failures for debugging
- Ref: `src/lib/stripe.ts` - see webhook handler

---

## 🤖 calm-ai-project-manager (Node.js API)

### Pain Point 1: N+1 Query Explosions
**Symptom**: Dashboard loads slowly (3-5s), database load spikes
**Root cause**: Loading tasks → then loading related projects/users in loop
**Impact**: High - degrades to O(n) instead of O(1)
**Solution**:
- Use Prisma `include` for related data upfront
- Never fetch then loop-query
- Add query batching for bulk operations
- Ref: `src/api/controllers/bulkController.js` - see `createMany()` pattern
- Check: `/api/v1/token-stats` shows query counts

### Pain Point 2: Circular Dependency in RCI Matrix
**Symptom**: Task → Project → Task creates infinite loop during validation
**Root cause**: RCI validation checks all related tasks (can be cyclic)
**Impact**: Medium - can cause infinite loops if not careful
**Solution**:
- Use visited set to track already-checked items
- Depth limit on recursive checks (max 5 levels)
- Cache validation results
- Ref: `docs/BUG_FIX_DATABASE.md` - full cycle detection algorithm

### Pain Point 3: Cache Invalidation Timing
**Symptom**: User sees stale data after update (cache didn't refresh)
**Root cause**: Cache TTL too long, or invalidation pattern incomplete
**Impact**: Medium - confuses users, looks like bug
**Solution**:
- Keep cache TTL SHORT for mutable data (5-10min max)
- Invalidate on CREATE/UPDATE/DELETE
- Use pattern-based invalidation (not just key-based)
- Ref: `src/lib/cache.js` - see TTL settings per endpoint

### Pain Point 4: Jira/Slack API Rate Limits
**Symptom**: Sync fails with 429 (rate limit), then stops retrying
**Root cause**: No exponential backoff, no rate limit tracking
**Impact**: Medium - integration breaks silently
**Solution**:
- Check rate limit headers BEFORE calling
- Implement exponential backoff (2s, 4s, 8s...)
- Queue requests if approaching limit
- Ref: `src/api/controllers/integrationController.js` - see rate limiting

---

## 🧪 qa-automation (E2E Testing)

### Pain Point 1: Modal Dismissal Timing
**Symptom**: Test fails intermittently trying to dismiss modal
**Root cause**: Modal animation completes async, test tries to interact too early
**Impact**: High - flaky tests undermine confidence
**Solution**:
- Wait for modal overlay to be GONE (not just invisible)
- Use `waitForElementRemoved()` not `waitForElementHidden()`
- Platform-specific handling (iOS modal vs Android AlertDialog)
- Ref: `docs/ERROR_CATALOG_IOS_AUTOMATION.md` - see modal section
- Pattern: `docs/patterns/TESTING_PATTERNS.md` - safe modal template

### Pain Point 2: Device State Isolation
**Symptom**: Test A passes alone, fails when run after Test B
**Root cause**: Previous test left app in dirty state (not logged out, cache full)
**Impact**: High - makes tests unreliable
**Solution**:
- ALWAYS clear app state before each test (logout, clear cache)
- Use fresh simulator/device state per test run
- Don't assume previous test cleaned up
- Ref: `docs/patterns/TESTING_PATTERNS.md` - beforeEach setup

### Pain Point 3: Device Debugging Cost Explosion
**Symptom**: One test costs 3x normal when debugging device issue
**Root cause**: Device communication is slow, every interaction is expensive
**Impact**: High - debugging becomes prohibitively expensive
**Solution**:
- Test locally/on simulator first (cheaper, faster)
- Use logs & screenshots instead of live debugging
- Batch device debugging (fix multiple issues per device run)
- Budget +200% for device-specific debugging
- Ref: `README.md` - Cost Efficiency section

### Pain Point 4: OCR/Vision Tier Cost Creep
**Symptom**: Simple test now costs 2x more (using Vision API instead of accessibility)
**Root cause**: Element finding degraded to Tier 3 (Claude Vision) from Tier 1
**Impact**: Medium - costs spiral if not monitored
**Solution**:
- Check element finding tier FIRST before accepting results
- Use accessibility attributes when possible (Tier 1 free)
- Fall back to OCR (Tier 2 cheap) before Vision (Tier 3 expensive)
- Ref: `README.md` - 5-tier hierarchy section

---

## 🚨 Cross-Project Issues

### Issue 1: Token Cost Creep
**Happens in**: All projects
**Symptom**: Monthly costs gradually increase without adding features
**Root cause**: Using more powerful/expensive models unnecessarily, caching disabled
**Solution**:
- Track cost per commit
- Use cheaper models first (Haiku before Sonnet)
- Enable caching aggressively
- Review monthly (budgeting in MASTER_LEARNINGS.md)

### Issue 2: Documentation Decay
**Happens in**: All projects
**Symptom**: AGENTS.md hasn't been updated in months, becomes unreliable
**Root cause**: New patterns discovered but not documented
**Solution**:
- Update AGENTS.md when you learn something new
- Review quarterly
- Link to cory-learnings error catalogs

### Issue 3: Test Infrastructure Brittleness
**Happens in**: qa-automation, calm-ai-project-manager
**Symptom**: Tests pass locally, fail in CI
**Root cause**: Environment differences (timing, ports, secrets)
**Solution**:
- Document env vars needed
- Use same test harness locally and CI
- Add debug output that CI can capture

---

## 📊 Pain Points by Severity & Frequency

| Issue | Severity | Frequency | Fix Time | Priority |
|-------|----------|-----------|----------|----------|
| N+1 queries | High | Often | 1 hour | CRITICAL |
| Modal timing | High | Often | 30 min | CRITICAL |
| Device state | High | Often | 1-2 hours | CRITICAL |
| Race conditions | Medium | Sometimes | 2-4 hours | HIGH |
| Cache stale data | Medium | Sometimes | 1 hour | HIGH |
| Device debugging cost | High | Rarely | 4+ hours | MEDIUM |
| GDPR compliance | High | Rarely | 4+ hours | HIGH |
| Rate limiting | Medium | Rarely | 2 hours | MEDIUM |

---

## Using This Document

1. **Before starting work**: Scan your project's pain points
2. **When debugging**: Search this file for symptom match
3. **When learning**: Update this with new issues you discover
4. **Monthly review**: Check if any pain points have been resolved

**Pro tip**: Reference error catalogs for more detail:
- calm-couples: `ERROR_CATALOG_CALM_COUPLES.md`
- calm-ai-pm: `ERROR_CATALOG_CALM_AI_PM.md`
- qa-automation: `ERROR_CATALOG_IOS_AUTOMATION.md`
