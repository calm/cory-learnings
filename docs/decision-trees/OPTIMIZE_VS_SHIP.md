---
title: "Decision Tree: Optimize vs Ship"
description: "When to optimize code vs shipping working solution"
version: "1.0"
last_updated: "2025-11-01"
---

# Optimize vs Ship Decision Tree

**Question**: Should I optimize this or ship it as-is?

---

## Quick Decision Matrix

| Factor | SHIP | OPTIMIZE |
|--------|------|----------|
| **Users complaining** | SHIP (fix later) | OPTIMIZE (slow kills UX) |
| **Tech debt** | SHIP (works) | OPTIMIZE (for team) |
| **Performance bad** | OPTIMIZE (60%+ slower) | SHIP (acceptable) |
| **Code is messy** | SHIP (works) | OPTIMIZE (maintenance debt) |
| **Time available** | SHIP (pressure) | OPTIMIZE (have time) |
| **First version** | SHIP (MVP) | OPTIMIZE (proven concept) |

---

## Decision Flowchart

```
Is the feature working correctly?
│
├─ NO → FIX FIRST
│       Don't optimize broken code
│
└─ YES → Are users complaining about speed/performance?
         │
         ├─ YES → OPTIMIZE
         │        Performance is user-visible
         │        60%+ slower = ship blocker
         │
         └─ NO → How much slower than ideal?
                 │
                 ├─ >30% slower → OPTIMIZE
                 │                Performance margin too thin
                 │
                 └─ <30% slower → SHIP
                                  Acceptable performance
                                  Ship and iterate
```

---

## When to SHIP

**Conditions** (all true):
- ✅ Feature works correctly
- ✅ Tests pass
- ✅ Performance acceptable (<30% slower)
- ✅ Users can achieve their goal
- ✅ Code is understandable

**Advantage**: Get feedback sooner
**Risk**: Technical debt accumulates

**Examples**:
- "I hardcoded a value instead of fetching config" → SHIP (refactor later)
- "Query is O(n²) but only 100 items" → SHIP (add indexing if slow)
- "Component re-renders excessively but feels snappy" → SHIP (profile later)

---

## When to OPTIMIZE

**Conditions** (any one is true):
- 🐢 >30% performance gap from ideal
- 📊 Measurable user impact (slow, laggy, timeout)
- 💾 Memory or disk usage is problematic
- 🔄 Code is confusing/unmaintainable
- 📈 Technical debt affecting team velocity
- 🎯 Part of next sprint goals

**Process**:
1. **Profile** - Where is time/resources going?
2. **Understand** - Why is it slow?
3. **Optimize** - Fix root cause (not symptoms)
4. **Measure** - Verify improvement
5. **Commit** - Clear message explaining optimization

**Time**: 1 - 8 hours depending on complexity

---

## Performance Thresholds

| Metric | SHIP | OPTIMIZE |
|--------|------|----------|
| **Page load** | <3s | >3s |
| **API response** | <500ms | >500ms |
| **Component render** | <50ms | >100ms |
| **Query** | <100ms | >500ms |
| **Memory** | <50MB | >100MB |
| **Bundle size** | <500KB | >1MB |

---

## Optimization ROI

**High ROI (optimize immediately)**:
- API calls in a loop (can batch)
- Database query N+1 problem
- Re-rendering on every keystroke
- Loading entire dataset when filtering

**Low ROI (ship as-is)**:
- Renaming variables
- Refactoring code structure
- Optimizing for edge cases

---

## Real Scenarios

### Scenario 1: "Dashboard loads in 1.5s, ideal is 500ms"
→ **OPTIMIZE**
- 3x slower than ideal
- Affects every user every day
- Profiling likely finds easy wins

### Scenario 2: "Report generation takes 45 minutes, but it's a rare task"
→ **SHIP**
- Low frequency usage
- User expects it to take time
- Optimize if users complain

### Scenario 3: "I wrote a quick implementation that works but is messy"
→ **EVALUATE**
- If performance acceptable: SHIP + refactor later
- If slow: Clean up before shipping
- Usually: SHIP first, refactor if needed

### Scenario 4: "I found a query that's O(n²), could be O(n log n)"
→ **OPTIMIZE IF**
- Currently measurably slow
- You have time
- Affects real users

→ **SHIP IF**
- Performance acceptable
- Proof of concept stage
- More important features pending

---

## Strategy: Ship Early, Optimize Smart

**Best approach**:
1. **Ship** working solution
2. **Measure** what users experience
3. **Optimize** what actually matters
4. **Iterate** based on data

**Why this works**:
- Get feedback sooner
- Avoid optimizing wrong things
- Users drive priorities
- Tech debt paid with real value

---

## Red Flags (Optimize Signal)

🚩 Users complaining about speed
🚩 Page takes >3 seconds to load
🚩 API slower than competing products
🚩 Mobile app crashes from memory
🚩 Reports timeout regularly

---

## Rule of Thumb

**When unsure**: SHIP FIRST
- Working code beats perfect code
- Feedback is cheaper than guessing
- Optimize based on real data, not assumptions

---

## Time Investment

- **Shipping** unoptimized: Save 2-4 hours now
- **Optimization**: 1-8 hours (depending on complexity)
- **Optimization ROI**: Often huge when users complain

