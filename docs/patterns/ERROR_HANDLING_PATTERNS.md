---
title: "Pattern Library: Error Handling"
description: "Copy-paste error handling patterns for common scenarios"
version: "1.0"
last_updated: "2025-11-01"
---

# Error Handling Patterns

Copy-paste these patterns into your code.

---

## Pattern 1: Try/Catch with Logging

```typescript
try {
  await database.query(sql)
} catch (error) {
  logger.error('Database query failed', {
    query: sql,
    error: error.message,
    code: error.code
  })
  throw error  // Re-throw to propagate
}
```

---

## Pattern 2: Graceful Degradation

```typescript
async function getUserWithDefaults(userId: string) {
  try {
    const user = await fetchUser(userId)
    return user
  } catch (error) {
    logger.warn('User fetch failed, using defaults', { userId, error })
    return { id: userId, name: 'Unknown', role: 'user' }
  }
}
```

---

## Pattern 3: Retry Logic

```typescript
async function fetchWithRetry(url: string, maxRetries = 3) {
  let lastError

  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fetch(url)
    } catch (error) {
      lastError = error
      logger.warn(`Attempt ${i + 1} failed, retrying...`, { url })
      await new Promise(resolve => setTimeout(resolve, 1000 * (i + 1)))
    }
  }

  logger.error('All retries exhausted', { url, error: lastError })
  throw lastError
}
```

---

## Pattern 4: Input Validation Before Processing

```typescript
function createUser(data: unknown) {
  // Validate input first
  if (!data || typeof data !== 'object') {
    throw new Error('Invalid user data')
  }

  if (!data.email || !isValidEmail(data.email)) {
    throw new Error('Invalid email')
  }

  if (!data.password || data.password.length < 8) {
    throw new Error('Password too short')
  }

  // Process safe input
  return saveUser(data)
}
```

---

## Pattern 5: Custom Error Types

```typescript
class DatabaseError extends Error {
  constructor(message: string, public query: string) {
    super(message)
    this.name = 'DatabaseError'
  }
}

class ValidationError extends Error {
  constructor(message: string, public field: string) {
    super(message)
    this.name = 'ValidationError'
  }
}

// Usage
try {
  await db.query(sql)
} catch (error) {
  throw new DatabaseError('Query failed', sql)
}
```

---

## Pattern 6: Error Handler Middleware (Express)

```typescript
app.use((error, req, res, next) => {
  logger.error('Request error', {
    method: req.method,
    path: req.path,
    error: error.message,
    statusCode: error.statusCode || 500
  })

  const statusCode = error.statusCode || 500
  res.status(statusCode).json({
    error: error.message,
    code: error.code || 'INTERNAL_ERROR'
  })
})
```

---

## Pattern 7: React Error Boundary

```typescript
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props)
    this.state = { hasError: false }
  }

  static getDerivedStateFromError(error) {
    logger.error('React error boundary caught', { error })
    return { hasError: true }
  }

  render() {
    if (this.state.hasError) {
      return <div>Something went wrong. Please refresh.</div>
    }
    return this.props.children
  }
}
```

---

## Pattern 8: Async Function Error Handling

```typescript
async function processData(data) {
  const results = []

  for (const item of data) {
    try {
      const result = await processItem(item)
      results.push(result)
    } catch (error) {
      logger.error('Item processing failed', { item, error })
      // Continue processing others instead of crashing
      results.push({
        status: 'failed',
        item,
        error: error.message
      })
    }
  }

  return results
}
```

---

## Pattern 9: Timeout Handling

```typescript
async function fetchWithTimeout(url: string, timeoutMs = 5000) {
  const controller = new AbortController()
  const timeoutId = setTimeout(() => controller.abort(), timeoutMs)

  try {
    const response = await fetch(url, { signal: controller.signal })
    clearTimeout(timeoutId)
    return response
  } catch (error) {
    clearTimeout(timeoutId)
    if (error.name === 'AbortError') {
      throw new Error(`Request timed out after ${timeoutMs}ms`)
    }
    throw error
  }
}
```

---

## Pattern 10: Finally Block for Cleanup

```typescript
let connection

try {
  connection = await openConnection()
  const data = await connection.query()
  return data
} catch (error) {
  logger.error('Connection error', { error })
  throw error
} finally {
  if (connection) {
    await connection.close()
  }
}
```

---

## Anti-Patterns (DON'T DO)

❌ Silent failures: `try { } catch (e) { }` → Always log errors
❌ Catching all errors: `catch (error) { }` → Log with context
❌ Re-throwing without logging → Log then re-throw
❌ Using `error.toString()` → Log the full error object
❌ Ignoring async errors → Use try/catch or .catch()

---

## Error Severity Levels

| Level | When | Recovery |
|-------|------|----------|
| **Critical** | System down | Restart, alert team |
| **Error** | Operation failed | Log, return error to user |
| **Warn** | Unusual but continuing | Log, may need attention |
| **Info** | Expected failures | Log for tracking |

---

**Remember**: Good error handling = happy users and fast debugging!

