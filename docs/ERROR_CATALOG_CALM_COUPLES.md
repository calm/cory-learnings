---
title: "Error Catalog - calm-couples"
description: "Common errors in calm-couples React app"
version: "1.0"
last_updated: "2025-11-01"
---

# Error Catalog - calm-couples

Quick lookup for common errors and fixes.

---

## Error 1: "RLS policy violation" (Supabase)

**Symptom**:
```
Error: new row violates row-level security policy
```

**Root Cause**:
- User is not authenticated
- RLS policy doesn't match the query
- User ID mismatch in policy

**Solution**:
1. Verify user is logged in: `const user = await supabase.auth.getUser()`
2. Check Supabase dashboard → Authentication → Policies
3. Ensure RLS policy includes: `(SELECT auth.uid()) = user_id`
4. For read: Add `auth.uid() = user_id` to WHERE clause

**Prevention**:
- Always check auth before queries
- Test RLS policies locally first
- Log auth state before queries

**Related Files**:
- `src/services/supabase.ts` - All queries
- `.supabase/migrations/` - RLS policies

---

## Error 2: "Cannot find module" (TypeScript)

**Symptom**:
```
Cannot find module 'src/utils/helpers' or '@utils/helpers'
```

**Root Cause**:
- Import path is wrong
- File not exported from index
- Case sensitivity mismatch
- tsconfig path aliases misconfigured

**Solution**:
1. Check file exists: `ls src/utils/helpers.ts`
2. Verify export: `export function` or `export default`
3. Check tsconfig.json paths: `"@utils": ["src/utils"]`
4. Try full path: `import from './src/utils/helpers'`
5. Run `npm install` if new dependency

**Prevention**:
- Use IDE auto-import
- Keep consistent naming
- Test import paths

**Related Files**:
- `tsconfig.json` - Path configuration
- `src/` - Source files

---

## Error 3: "Plant not rendering" (3D)

**Symptom**:
- Component shows but 3D plant is blank
- WebGL error in console
- Black screen

**Root Cause**:
- 3D model file not loading
- WebGL context not available
- Canvas dimensions are 0x0
- Browser doesn't support WebGL

**Solution**:
1. Check network tab → Is .glb file loading?
2. Verify canvas has size: `width="800" height="600"`
3. Check browser supports WebGL: `new THREE.WebGLRenderer()` error?
4. Try hard refresh: Cmd+Shift+R or Ctrl+Shift+R
5. Check `src/components/Plant3D.tsx` for errors

**Prevention**:
- Test 3D rendering on all browsers
- Add fallback UI if WebGL unavailable
- Monitor 3D asset loading

**Related Files**:
- `src/components/Plant3D.tsx` - Rendering logic
- `public/models/` - 3D assets

---

## Error 4: "Race condition in sync" (Database)

**Symptom**:
- Plant data inconsistent
- Updates lost randomly
- Sync conflicts between clients

**Root Cause**:
- Concurrent updates from multiple clients
- No optimistic locking
- Timestamp collisions
- Cache not updated after mutation

**Solution**:
1. Add `version` field to track updates
2. Use optimistic locking: check version before update
3. Implement conflict resolution in `src/services/sync.ts`
4. Add exponential backoff for retries
5. Invalidate cache after writes

**Prevention**:
- Add version/timestamp to all mutable records
- Use transactions for multi-table updates
- Test with concurrent operations

**Related Files**:
- `src/services/supabase.ts` - Queries
- `src/services/sync.ts` - Sync logic
- `.supabase/migrations/` - Schema

---

## Error 5: "Tests failing with 'act' warning"

**Symptom**:
```
Warning: An update to UserCard inside a test was not wrapped in act(...)
```

**Root Cause**:
- State update outside test scope
- Async operation not awaited
- useEffect not handled in tests

**Solution**:
1. Wrap state changes in `act()`: `act(() => { setState() })`
2. Await async operations: `await waitFor(() => { })`
3. Wait for elements: `await screen.findByText('text')`
4. Don't test implementation, test behavior

**Prevention**:
- Use `@testing-library/react` utilities
- Test from user perspective
- Await all async operations

**Related Files**:
- `__tests__/` - Test files
- `src/components/` - Components

---

## Error 6: "Supabase connection timeout"

**Symptom**:
```
Error: Request timed out
```

**Root Cause**:
- Network issue
- Supabase API down
- Query too slow
- Connection not configured

**Solution**:
1. Check network: Can you ping supabase.co?
2. Verify .env has SUPABASE_URL and KEY
3. Check Supabase status: status.supabase.com
4. Optimize query (add indexes on frequently queried columns)
5. Increase timeout in client config

**Prevention**:
- Test database queries in SQL editor
- Add indexes to queries
- Monitor API performance
- Use connection pooling

**Related Files**:
- `.env.local` - Config
- `src/services/supabase.ts` - Client setup

---

## How to Use

1. Search error message above
2. Read root cause
3. Follow solution steps
4. Check related files
5. Test fix with `npm test`

**Found a new error?**
Add it here with: symptom, root cause, solution, prevention, files

