---
title: "Error Catalog - ios-automation"
description: "Common errors in ios-automation E2E testing"
version: "1.0"
last_updated: "2025-11-01"
---

# Error Catalog - ios-automation

E2E testing framework troubleshooting.

---

## Error 1: "Element not found" (Appium)

**Symptom**:
```
Error: An element could not be located on the page
```

**Root Cause**:
- Element hasn't appeared yet
- Wrong locator/selector
- Element is hidden or off-screen
- Modal overlay blocking interaction

**Solution**:
1. Add wait: `await driver.wait(until.elementLocated(By.id('element')), 5000)`
2. Check selector in Xcode Inspector
3. Try different locators: id → accessibility → xpath
4. Dismiss modals first: `await dismissModals(driver)`
5. Add screenshots for debugging

**Prevention**:
- Always add waits before interactions
- Use stable selectors (IDs, not text)
- Test one element at a time
- Clear state between tests

**Related Files**:
- `test/helpers/gestures.js` - Interaction helpers
- `test/specs/` - Test files
- `logs/screenshots/` - Debug images

---

## Error 2: "Modal won't dismiss"

**Symptom**:
- Modal stays on screen
- Tests fail after modal appears
- Next test starts with modal visible

**Root Cause**:
- Close button not found
- Gesture coordinates wrong
- Modal is programmatic (not dismissible)
- Timing issue - too fast

**Solution**:
1. Add explicit wait: `await sleep(500)`
2. Verify close button exists: `await driver.findElement(By.id('close'))`
3. Try tap on overlay: `await driver.execute('mobile: tap', {x: 20, y: 20})`
4. Use keyboard: `await driver.executeScript('mobile: pressButton', {name: 'home'})`
5. Check if modal expected to stay

**Prevention**:
- Always dismiss modals after interactions
- Add helper: `dismissModals()` at test start
- Test modal dismissal separately
- Capture state before assertions

**Related Files**:
- `test/helpers/gestures.js` - Modal dismissal
- `test/specs/` - Test setup

---

## Error 3: "Test isolation failure" (Shared state)

**Symptom**:
- Test passes alone, fails with others
- Data from previous test affects current
- Random test failures

**Root Cause**:
- Shared app state between tests
- Database not reset
- Cached data persisting
- User session not cleared

**Solution**:
1. Clear app data before each test: `await clearAppData(driver)`
2. Reset database/fixtures
3. Logout and login fresh user
4. Clear notifications: `await driver.executeScript('mobile: clearNotifications')`
5. Restart app: `await driver.quit(); driver = new...`

**Prevention**:
- Use `beforeEach` to reset state
- Each test should be independent
- Use unique test data (timestamp IDs)
- Never rely on other tests' data

**Related Files**:
- `test/specs/` - Test structure
- `test/helpers/setup.js` - Test initialization

---

## Error 4: "Timeout waiting for element" (Performance)

**Symptom**:
```
Timeout: element locator (...) did not return any results
```

**Root Cause**:
- App is slow (network, processing)
- Element takes >5s to appear
- Test timeout too short
- Device is busy

**Solution**:
1. Increase timeout: `driver.manage().setTimeouts({implicit: 10000})`
2. Add explicit wait: `await driver.wait(until.elementLocated(...), 10000)`
3. Check device performance: `adb shell top`
4. Reduce app load time (network mock, cache)
5. Profile app with Xcode

**Prevention**:
- Measure typical load times
- Use appropriate timeouts (5s default, 10s for network)
- Mock slow APIs in tests
- Test on real devices (not just simulator)

**Related Files**:
- `test/config/appium.conf.js` - Timeout settings
- `test/specs/` - Individual timeouts

---

## Error 5: "OCR text recognition fails" (Tesseract)

**Symptom**:
```
Could not find text "expected text" in image
```

**Root Cause**:
- Text rendering blurry
- Wrong text on screen
- OCR confidence too low
- Font not recognized

**Solution**:
1. Check screenshot: `console.log(await driver.takeScreenshot())`
2. Verify text is visible: `const text = await driver.execute('mobile: getSystemLog')`
3. Use element locator instead: `driver.findElement(By.xpath(`//*[contains(text(), 'text')]`))`
4. Improve image quality before OCR
5. Adjust OCR confidence threshold

**Prevention**:
- Prefer element locators over OCR
- Test OCR separately with known good images
- Use high-resolution screenshots
- Have human verification for OCR

**Related Files**:
- `test/helpers/ocr.js` - OCR utilities
- `test/specs/` - Test files

---

## Error 6: "Device connection lost"

**Symptom**:
```
Error: Device is not connected
```

**Root Cause**:
- USB cable disconnected
- Device locked
- USB debugging disabled
- Port conflict

**Solution**:
1. Check connection: `adb devices`
2. Unlock device manually
3. Re-enable USB debugging: Device Settings → Developer Options
4. Reconnect USB cable
5. Kill ADB: `adb kill-server` then `adb start-server`

**Prevention**:
- Keep device plugged in during tests
- Disable screen timeout: Settings → Display
- Enable Stay Awake in Developer Options
- Run tests in controlled environment

**Related Files**:
- `test/config/appium.conf.js` - Device configuration
- Device settings

---

## Error 7: "Screenshot/video recording failed"

**Symptom**:
- No screenshots captured
- Video won't start
- Space full on device

**Root Cause**:
- Device storage full
- Permission denied
- Recording already active
- Path doesn't exist

**Solution**:
1. Clear device storage: `adb shell pm clear com.calm`
2. Check permissions: `adb shell ls -la /data/local/`
3. Stop active recording: `adb shell stop screenrecord`
4. Create directory: `adb shell mkdir -p /data/local/tmp`
5. Change output path

**Prevention**:
- Monitor device storage
- Delete old screenshots regularly
- Use device cloud storage for large files
- Set up automated cleanup

**Related Files**:
- `test/config/appium.conf.js` - Capture settings
- `reports/screenshots/` - Stored images

---

## How to Use

1. Search your error above
2. Read root cause
3. Follow solution steps
4. Check related files
5. Re-run test

**Found a new error?**
Add it here with: symptom, root cause, solution, prevention, files

