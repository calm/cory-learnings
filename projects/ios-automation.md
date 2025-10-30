# Cory's Learnings & Preferences

**Purpose**: Track everything Cory has asked, told, found out, and learned during iOS automation work.

**Last Updated**: 2025-10-30

---

## Cory's Communication Style

### How Cory Works
- **Direct & Concise** - Says "do it", "keep going", "be critical"
- **Action-Oriented** - Prefers doing over discussing
- **Honest Feedback** - Wants brutal honesty about what's working vs broken
- **Fast Iterations** - "do next todo", "ok do it", quick cycles

### Key Phrases
- "be critical" = wants honest assessment, not sugar-coating
- "continue" = keep working on current task
- "do it" = implement what we just discussed
- "keep going" = make progress, I trust your direction

---

## What Cory Has Found Out

### Session 1 Discoveries (From Previous Context)

**Critical Issues Found:**
1. **Bundle ID was WRONG** - `calm.calmapp.dev` should be `com.calm.calmapp.dev`
   - This was THE blocker preventing all E2E tests from running
   - Fixed and app now launches successfully

2. **Jest was IGNORING /tests/** - jest.config.js had tests excluded
   - Created separate jest.e2e.config.js
   - Now E2E tests run properly

3. **Appium needs ES modules** - WebDriverIO v9 requires `--experimental-vm-modules`
   - Added to npm scripts
   - Form filling now works

4. **App remembers previous sessions** - `UserSettings_hasCalmAppEverFinishedLaunching`
   - Created `resetAppState()` to clear app data
   - Enables testing first-launch flows

5. **Framework ACTUALLY works** - All infrastructure validated:
   - IDB: Works ✅
   - Appium: Works ✅
   - OCR (Tesseract): Works ✅
   - Vision AI (Claude): Works ✅
   - Multi-strategy element finding: Works ✅

### Session 2 Discoveries (Current Session)

**Reality Check:**
1. **Tests are BROKEN** (0/3 pass when run in sequence)
   - Framework is solid (8/10)
   - Test suite is broken (2/10)
   - No test isolation = state pollution
   - No cleanup between runs

2. **Modal dismissal was TOO WEAK**
   - Only tried 3-5 times
   - Gave up too easily
   - Didn't handle nested modals
   - **Solution**: Made it 10x more aggressive (15 attempts, 3 strategies)

3. **No "known good state" helper**
   - Tests started from chaos
   - Couldn't reliably get to app home
   - **Solution**: Created `ensureOnAppHome()`

4. **Hidden modals discovered**:
   - Signup/login screens
   - Subscription paywalls ("Unlock Calm for free")
   - Goal selection ("What brings you to Calm?")
   - Onboarding prompts
   - **NEW**: Survey screens ("How did you hear about Calm?")

---

## What Cory Has Asked For

### Explicit Requests
1. "be critical. what do we need to do?" - Initial request for honest assessment
2. "continue" - Keep working on current task
3. "be critical" - Another request for brutal honesty
4. "do B!" - Explicitly chose to implement real E2E tests over more unit tests
5. "keep going" - Continue with current direction
6. "woops i closed sim soz" - Accidentally closed simulator during test
7. "do next todo" - Work on next priority item
8. "ok do next best thing implement all E2E tests" - Implement E2E tests
9. "be critical and make updates for around 20 minutes" - Honest assessment + fixes
10. "ok do it" - Fix the broken tests
11. "make a file called 'Cory learnings'" - This file!

### Implied Preferences
- Wants working tests, not just proof-of-concept
- Values honesty over optimism
- Prefers action over planning
- Wants continuous progress
- Trusts AI to make decisions and keep going

---

## Key Technical Insights (What Cory Learned)

### About iOS Test Automation

**Framework Components:**
- **xcrun simctl** - Stable for most operations (launch, terminate, screenshot)
- **IDB** - Best for accessibility tree queries
- **Appium/WebDriverIO** - Required for webview form filling
- **Tesseract OCR** - Text extraction from screenshots
- **Claude Vision AI** - Last resort element finding

**Element Finding Strategy (fallback chain):**
1. Accessibility Tree (IDB) - fastest, most reliable
2. OCR - good for text detection
3. Vision AI - expensive but handles edge cases
4. Dynamic coordinates - last resort

**Common Pitfalls:**
- iOS apps remember state between launches
- Modal dismissal is HARD (nested modals, different button types)
- Webviews require different approach than native elements
- Tests need isolation or they pollute each other

### About Test Design

**What Works:**
- Small, focused tests
- Known-good starting state
- Aggressive modal dismissal
- Screenshot at every step
- Clear error messages

**What Doesn't Work:**
- Assuming clean state
- Weak modal dismissal
- Testing in unpredictable state
- No cleanup between tests
- Optimistic timeout values

---

## Cory's Project Context

### Project: calm/ios-automation
- **Goal**: Automated E2E testing for Calm iOS app
- **Status**: Framework validated, test suite in progress
- **Framework**: Custom (IDB + Appium + OCR + Vision AI)
- **Test Count**:
  - 648 unit tests passing
  - 3 E2E tests implemented (0 passing reliably)
  - ~100 placeholder tests awaiting implementation

### Recent Work
- Fixed critical bundle ID bug
- Added ES modules support
- Created 3 E2E tests (signup, login, navigation)
- Implemented aggressive modal dismissal
- Created honest assessment (REALITY_CHECK.md)
- Updated README with real status

### Current State
- **Framework**: 8/10 (solid foundation)
- **Test Suite**: 2/10 (broken, needs work)
- **Production Ready**: NO (4-6 weeks estimated)

---

## Cory's Patterns & Workflows

### When Starting Work
1. Cory reviews previous work
2. Asks for critical assessment
3. Makes quick decisions
4. Says "do it" or "continue"

### During Work
- Trusts AI to make technical decisions
- Interrupts if direction is wrong
- Quick feedback loops
- Appreciates brutally honest updates

### When Blocked
- Doesn't overthink
- Moves to next best thing
- "woops" - friendly about mistakes
- Keeps momentum going

---

## Lessons Learned (For Future Sessions)

### What Cory Values
1. **Honesty** - Don't oversell what's working
2. **Action** - Doing > talking
3. **Reality** - Face problems directly
4. **Speed** - Fast iterations, quick fixes
5. **Trust** - Lets AI make calls, provides feedback

### What to Avoid
- Long explanations without action
- Overpromising functionality
- Hiding broken things
- Overthinking before doing
- Analysis paralysis

### What to Do More
- Be brutally honest
- Show real test results
- Document what's actually broken
- Propose concrete fixes
- Keep momentum

---

## External Context

### Calm API Team Example
Cory shared: https://github.com/calm/calm-api/pull/13684
- Shows AGENTS.md files for AI agent onboarding
- Comprehensive documentation strategy
- Architecture snapshots and workflows
- **Insight**: Good documentation helps AI agents understand codebases

**Potential Application**: Could create similar AGENTS.md for ios-automation project

---

## Current Focus (As of Last Update)

**Working On**: Making tests actually pass
- QADTC-100 (Navigation) - ✅ NOW WORKS (with aggressive helpers!)
  - Survey screen detection added ("How did you hear about Calm?")
  - Successfully dismisses modals
  - Navigates Sleep → Discover → Profile → Home tabs ✅
  - Has timeout issues but core functionality works

**Progress Made**:
- ✅ Modal detection expanded to 32 indicators
- ✅ Survey screens now detected and dismissed
- ✅ ensureOnAppHome() successfully gets to clean state
- ✅ Navigation between tabs works
- ⚠️  Test times out at 180s (needs optimization)

**Next Steps**:
1. Optimize test timeouts and waits
2. Fix signup test (QADTC-54)
3. Fix login test (QADTC-55)
4. Verify all 3 can run in sequence without failing

---

## Notes for Future Cory

**If you come back to this project:**

1. **Read REALITY_CHECK.md first** - Gives honest state
2. **Framework is SOLID** - Don't rebuild, just use it
3. **Tests need isolation** - This is the #1 issue to fix
4. **Modal dismissal is HARD** - But we have aggressive helpers now
5. **Focus on ONE test at a time** - Make it rock-solid, then move on

**The gap to production is clear and documented.**

---

*This file will be continuously updated as we learn more.*
