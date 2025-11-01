---
title: "Pattern Library: Logging"
description: "Copy-paste logging patterns for different scenarios"
version: "1.0"
last_updated: "2025-11-01"
---

# Logging Patterns

Copy-paste these patterns into your code.

---

## Basic Setup (All projects)

**TypeScript/JavaScript**:
```typescript
import { logger } from './logger' // or your logging library

// Never use console.log - use logger instead
```

---

## Pattern 1: Successful Operation

```typescript
logger.info('User created', {
  userId: user.id,
  email: user.email,
  timestamp: new Date().toISOString()
})
```

---

## Pattern 2: Error with Context

```typescript
try {
  await database.query()
} catch (error) {
  logger.error('Database query failed', {
    query: 'SELECT * FROM users',
    error: error.message,
    userId: currentUser?.id
  })
  throw error
}
```

---

## Pattern 3: Warning (Something Concerning)

```typescript
if (responseTime > 1000) {
  logger.warn('Slow API response', {
    endpoint: '/api/users',
    responseTime: responseTime,
    threshold: 1000
  })
}
```

---

## Pattern 4: Debug (Development Only)

```typescript
logger.debug('Processing user data', {
  input: userData,
  transformedData: transformed
})
// Disabled in production
```

---

## Pattern 5: Multiple Operations (Track Progress)

```typescript
logger.info('Import started', { fileSize, recordCount })
for (const record of records) {
  try {
    await processRecord(record)
    successCount++
  } catch (error) {
    logger.error('Record processing failed', { record, error })
    failureCount++
  }
}
logger.info('Import completed', { successCount, failureCount })
```

---

## Pattern 6: Async Operations

```typescript
const requestId = generateId()
logger.info('Request started', { requestId, path: '/api/data' })

try {
  const result = await fetchData()
  logger.info('Request succeeded', { requestId, dataSize: result.length })
  return result
} catch (error) {
  logger.error('Request failed', { requestId, error })
  throw error
}
```

---

## Pattern 7: User Action Tracking

```typescript
logger.info('User action', {
  action: 'plant-created',
  userId: user.id,
  plantId: plant.id,
  timestamp: new Date().toISOString()
})
```

---

## Pattern 8: Performance Tracking

```typescript
const start = performance.now()

// ... do work ...

const duration = performance.now() - start
logger.info('Operation completed', {
  operation: 'heavy-calculation',
  duration: `${duration.toFixed(2)}ms`,
  threshold: 100,
  slow: duration > 100
})
```

---

## Anti-Patterns (DON'T DO)

❌ `console.log('error')` → Use `logger.error()`
❌ `console.log(user)` → Log structured data with keys
❌ Logging sensitive data (passwords, tokens) → Sanitize first
❌ Logging in production that aren't errors → Use debug level
❌ `logger.info('done')` → Add context, what did you do?

---

## Field Names (Standard)

Use these consistently:
- `userId` - User identifier
- `error` - Error object or message
- `duration` - Time in milliseconds
- `timestamp` - ISO date string
- `endpoint` - API endpoint path
- `requestId` - Unique request identifier
- `message` - Human-readable description

---

## Severity Levels

| Level | Use When | Example |
|-------|----------|---------|
| **error** | System failure | Database error, uncaught exception |
| **warn** | Concerning but continuing | Slow operation, retry needed |
| **info** | Important events | User created, process completed |
| **debug** | Detailed development info | Variable values, step traces |

---

**Remember**: Good logging = fast debugging. Be specific!

