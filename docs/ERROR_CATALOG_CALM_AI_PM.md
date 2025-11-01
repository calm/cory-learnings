---
title: "Error Catalog - calm-ai-project-manager"
description: "Common errors in calm-ai-project-manager"
version: "1.0"
last_updated: "2025-11-01"
---

# Error Catalog - calm-ai-project-manager

Node.js + Express + Prisma + Claude API troubleshooting.

---

## Error 1: "Prisma query failed"

**Symptom**:
```
Error: Invalid `prisma.task.findUnique()` invocation
```

**Root Cause**:
- Schema mismatch
- Field doesn't exist
- Query syntax wrong
- Database out of sync

**Solution**:
1. Check schema: `cat prisma/schema.prisma`
2. Verify field name: `model Task { id ... }`
3. Run migration: `npm run db:push`
4. Check generated client: `npm run prisma:generate`
5. Try simpler query first: `await prisma.task.findMany()`

**Prevention**:
- Always update schema before using new fields
- Use type checking: TypeScript will catch errors
- Test queries in Prisma Studio: `npx prisma studio`
- Review schema changes before commit

**Related Files**:
- `prisma/schema.prisma` - Database schema
- `src/models/` - Model definitions
- `prisma/migrations/` - Schema history

---

## Error 2: "Database is locked" (SQLite)

**Symptom**:
```
Error: database is locked
```

**Root Cause**:
- Multiple processes writing
- Long-running transaction
- SQLite single-writer limitation
- File permissions

**Solution**:
1. Stop other npm processes: `npm run dev` (only one instance)
2. Check for hung connections: `lsof | grep .db`
3. Kill process: `kill -9 PID`
4. Increase timeout in `prisma/schema.prisma`: `connectionLimit = 5`
5. Check disk space: `df -h`

**Prevention**:
- Use one dev instance at a time
- Close connections properly
- Monitor active connections
- Use connection pooling for production

**Related Files**:
- `prisma/schema.prisma` - Connection settings
- Development: Single process only

---

## Error 3: "Claude API timeout"

**Symptom**:
```
Error: Request timed out after 30s
```

**Root Cause**:
- API slow or overloaded
- No API key
- Network issue
- Query too complex (too many tokens)

**Solution**:
1. Check API key: `echo $CLAUDE_API_KEY`
2. Verify .env: `cat .env.local | grep CLAUDE`
3. Add to .env if missing: `CLAUDE_API_KEY=sk-...`
4. Increase timeout: `timeout: 60000` in client config
5. Reduce tokens: Simplify prompt, use shorter context

**Prevention**:
- Validate API key at startup
- Log API calls for debugging
- Set reasonable timeouts
- Monitor token usage
- Add retry logic with exponential backoff

**Related Files**:
- `.env.local` - Configuration
- `src/services/claude.ts` - Claude client
- `src/utils/retryLogic.ts` - Retry handler

---

## Error 4: "RCI matrix calculation off"

**Symptom**:
- Scores don't match expected values
- Weights not applied correctly
- Division by zero errors

**Root Cause**:
- Missing data points
- Formula implementation wrong
- Data type mismatch (string vs number)
- Edge cases not handled

**Solution**:
1. Check formula: `RCI = (R + C + I) / 3`
2. Verify data types: Are scores numbers?
3. Add null checks: `score || 0`
4. Test with known values: RCI([10,10,10]) should be 10
5. Log intermediate values

**Prevention**:
- Unit test RCI calculation
- Validate inputs before calculation
- Handle edge cases (0 items, null values)
- Document formula in code

**Related Files**:
- `src/services/rciCalculator.ts` - Calculation logic
- `tests/rci.test.js` - Tests

---

## Error 5: "Knowledge base search returns nothing"

**Symptom**:
- No results even for obvious queries
- Search is too slow
- Results irrelevant

**Root Cause**:
- Index not built
- Query too specific
- Knowledge base empty
- Search syntax wrong

**Solution**:
1. Check KB populated: `SELECT COUNT(*) FROM knowledge_base;`
2. Verify index: `SELECT * FROM sqlite_master WHERE name LIKE '%index%';`
3. Try simpler query: Search for common words
4. Re-index: `npm run kb:reindex`
5. Check search implementation

**Prevention**:
- Build index after KB updates
- Test search with sample queries
- Monitor search performance
- Add query logging

**Related Files**:
- `src/services/knowledgeBase.ts` - Search logic
- `prisma/schema.prisma` - KB schema

---

## Error 6: "Task dependency circular reference"

**Symptom**:
```
Error: Circular dependency detected
```

**Root Cause**:
- Task A depends on B, B depends on A
- User created circular relationship
- Dependency validation missing

**Solution**:
1. Find circular path: `A → B → C → A`
2. Break one link: Remove one dependency
3. Add validation check before save
4. Use topological sort to detect cycles
5. Prevent in UI (disable circular dependencies)

**Prevention**:
- Validate on every dependency change
- Don't allow self-dependencies
- Test with user data
- Add graph cycle detection

**Related Files**:
- `src/services/taskService.ts` - Task logic
- `src/utils/graphUtils.ts` - Graph operations

---

## Error 7: "Express CORS error"

**Symptom**:
```
Access to XMLHttpRequest blocked by CORS
```

**Root Cause**:
- CORS not configured
- Wrong origin in whitelist
- Credentials not handled

**Solution**:
1. Check CORS config: `const cors = require('cors')`
2. Add to Express: `app.use(cors())`
3. For production, whitelist origins:
   ```javascript
   app.use(cors({
     origin: process.env.CLIENT_URL,
     credentials: true
   }))
   ```
4. Test with curl: `curl -H "Origin: ..." -X GET http://localhost:3000`

**Prevention**:
- Configure CORS in development
- Document allowed origins
- Test cross-origin requests
- Use environment variables

**Related Files**:
- `src/server.ts` - Express setup
- `.env.local` - Config

---

## Error 8: "Migration failed"

**Symptom**:
```
Error: The migration X failed
```

**Root Cause**:
- Migration conflicts
- Data type mismatch
- Foreign key constraint violated
- Previous migration incomplete

**Solution**:
1. Check migration status: `npm run db:status`
2. Review latest migration: `cat prisma/migrations/latest/migration.sql`
3. Resolve conflicts manually if needed
4. Reset database (dev only): `npm run db:reset`
5. Re-run migration: `npm run db:push`

**Prevention**:
- Test migrations locally first
- Back up database before migrations
- Keep migrations small and focused
- Review SQL before applying

**Related Files**:
- `prisma/migrations/` - Migration files
- `prisma/schema.prisma` - Current schema

---

## How to Use

1. Search your error above
2. Read root cause
3. Follow solution steps
4. Check related files
5. Restart server: `npm run dev`

**Found a new error?**
Add it here with: symptom, root cause, solution, prevention, files

