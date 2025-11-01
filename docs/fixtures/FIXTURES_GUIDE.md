---
title: "Test Fixtures Guide"
description: "Reusable test data for faster, consistent testing"
version: "1.0"
last_updated: "2025-11-01"
---

# Test Fixtures Guide

Copy test data into your project's `tests/fixtures/` directory.

---

## calm-couples Fixtures

### User Fixture
```json
{
  "id": "test-user-1",
  "email": "test@example.com",
  "name": "Test User",
  "createdAt": "2025-01-01T00:00:00Z",
  "status": "active"
}
```

### Plant Fixture
```json
{
  "id": "plant-1",
  "userId": "test-user-1",
  "species": "Rose",
  "health": 85,
  "lastWatered": "2025-11-01T10:00:00Z",
  "createdAt": "2025-10-01T00:00:00Z"
}
```

### Relationship Fixture
```json
{
  "id": "rel-1",
  "user1Id": "test-user-1",
  "user2Id": "test-user-2",
  "startDate": "2020-01-01T00:00:00Z",
  "connectionScore": 85,
  "lastSync": "2025-11-01T09:00:00Z"
}
```

---

## ios-automation Fixtures

### Test User
```json
{
  "id": "ios-test-1",
  "email": "ios-test@example.com",
  "password": "TestPass123!",
  "device": "iPhone13",
  "osVersion": "16.0"
}
```

### Test Workflow
```json
{
  "name": "Plant Creation Flow",
  "steps": [
    { "action": "tap", "target": "Add Plant Button" },
    { "action": "input", "target": "Species Field", "value": "Rose" },
    { "action": "tap", "target": "Save Button" },
    { "action": "verify", "target": "Plant Created", "expected": true }
  ]
}
```

---

## calm-ai-project-manager Fixtures

### Project Fixture
```json
{
  "id": "project-1",
  "name": "calm-couples",
  "description": "Relationship wellness app",
  "status": "in-progress",
  "createdAt": "2025-01-01T00:00:00Z",
  "rciMatrix": {
    "responsibility": 85,
    "communication": 90,
    "integration": 75
  }
}
```

### Task Fixture
```json
{
  "id": "task-1",
  "projectId": "project-1",
  "title": "Fix plant rendering",
  "description": "3D plant not showing in some browsers",
  "status": "in-progress",
  "priority": "high",
  "assignee": "dev-1",
  "createdAt": "2025-11-01T08:00:00Z"
}
```

---

## Usage in Tests

### TypeScript/JavaScript
```typescript
// Load fixture
import { users } from '../fixtures/users.json'

describe('UserService', () => {
  test('creates user', () => {
    const testUser = users[0]
    const result = createUser(testUser)
    expect(result.id).toBeDefined()
  })
})
```

### Jest
```typescript
const fixtures = {
  user: require('../fixtures/users.json')[0],
  plant: require('../fixtures/plants.json')[0],
  project: require('../fixtures/projects.json')[0]
}

beforeEach(() => {
  // Use fixtures in each test
  mockUser = fixtures.user
})
```

---

## Benefits

- **Consistency**: Same data across tests
- **Speed**: No setup code, instant data
- **Clarity**: Real-world examples in test files
- **Reusability**: Share fixtures across test files

---

## Creating New Fixtures

1. **Identify data**: What objects do tests need?
2. **Create JSON**: Export representative examples
3. **Store in**: `tests/fixtures/{resource}.json`
4. **Reference in**: Test files
5. **Update**: When schema changes

---

## Fixture Structure

```
tests/
├── fixtures/
│   ├── users.json
│   ├── plants.json
│   ├── tasks.json
│   └── projects.json
├── setup.ts
└── specs/
    └── user.test.ts
```

---

**Pro tip**: Create both "happy path" and "edge case" fixtures for thorough testing!

