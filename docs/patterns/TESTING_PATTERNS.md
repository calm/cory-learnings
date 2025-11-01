---
title: "Pattern Library: Testing"
description: "Copy-paste test patterns for unit and integration tests"
version: "1.0"
last_updated: "2025-11-01"
---

# Testing Patterns

Copy-paste these patterns into your test files.

---

## Pattern 1: Simple Unit Test

```typescript
describe('calculateTotal', () => {
  test('sums prices correctly', () => {
    const items = [{ price: 10 }, { price: 20 }, { price: 5 }]
    const total = calculateTotal(items)
    expect(total).toBe(35)
  })
})
```

---

## Pattern 2: Test with Setup/Teardown

```typescript
describe('UserService', () => {
  let db: Database

  beforeEach(async () => {
    db = new Database(':memory:') // In-memory for testing
    await db.init()
  })

  afterEach(async () => {
    await db.close()
  })

  test('creates user', async () => {
    const user = await db.createUser({ name: 'John' })
    expect(user.id).toBeDefined()
  })
})
```

---

## Pattern 3: Testing Error Cases

```typescript
describe('parseJSON', () => {
  test('returns data for valid JSON', () => {
    const result = parseJSON('{"name":"John"}')
    expect(result).toEqual({ name: 'John' })
  })

  test('throws for invalid JSON', () => {
    expect(() => parseJSON('invalid')).toThrow(SyntaxError)
  })

  test('throws for empty string', () => {
    expect(() => parseJSON('')).toThrow()
  })
})
```

---

## Pattern 4: Testing React Components

```typescript
import { render, screen } from '@testing-library/react'

describe('UserCard', () => {
  test('displays user name', () => {
    render(<UserCard user={{ id: '1', name: 'John' }} />)
    expect(screen.getByText('John')).toBeInTheDocument()
  })

  test('handles click on delete button', async () => {
    const onDelete = jest.fn()
    render(<UserCard user={{ id: '1', name: 'John' }} onDelete={onDelete} />)

    const deleteBtn = screen.getByRole('button', { name: /delete/i })
    fireEvent.click(deleteBtn)

    expect(onDelete).toHaveBeenCalled()
  })
})
```

---

## Pattern 5: Testing Async Operations

```typescript
describe('fetchUser', () => {
  test('fetches user data', async () => {
    const mockFetch = jest.fn().mockResolvedValue({
      json: async () => ({ id: '1', name: 'John' })
    })

    const user = await fetchUser('1')

    expect(user).toEqual({ id: '1', name: 'John' })
    expect(mockFetch).toHaveBeenCalled()
  })

  test('handles fetch error', async () => {
    jest.spyOn(global, 'fetch').mockRejectedValue(new Error('Network error'))

    await expect(fetchUser('1')).rejects.toThrow('Network error')
  })
})
```

---

## Pattern 6: Testing with Fixtures/Test Data

```typescript
const testUser = {
  id: '1',
  name: 'John Doe',
  email: 'john@example.com',
  createdAt: new Date('2025-01-01')
}

describe('UserModel', () => {
  test('validates user email', () => {
    expect(isValidEmail(testUser.email)).toBe(true)
  })

  test('rejects invalid email', () => {
    expect(isValidEmail('invalid')).toBe(false)
  })
})
```

---

## Pattern 7: Snapshot Testing (UI)

```typescript
describe('Button', () => {
  test('renders correctly', () => {
    const { container } = render(
      <Button label="Click me" />
    )
    expect(container).toMatchSnapshot()
  })
})
```

---

## Pattern 8: Integration Test (Multiple Components)

```typescript
describe('User Registration Flow', () => {
  test('creates user and redirects to dashboard', async () => {
    render(<App />)

    // Fill form
    fireEvent.change(screen.getByLabel('Email'), {
      target: { value: 'john@example.com' }
    })
    fireEvent.change(screen.getByLabel('Password'), {
      target: { value: 'password123' }
    })

    // Submit
    fireEvent.click(screen.getByRole('button', { name: /register/i }))

    // Verify redirect
    await waitFor(() => {
      expect(screen.getByText('Dashboard')).toBeInTheDocument()
    })
  })
})
```

---

## Pattern 9: Parameterized Tests (Run Same Test Multiple Times)

```typescript
describe('isValidAge', () => {
  const testCases = [
    { age: 18, expected: true },
    { age: 65, expected: true },
    { age: 17, expected: false },
    { age: 120, expected: false },
    { age: -1, expected: false }
  ]

  testCases.forEach(({ age, expected }) => {
    test(`returns ${expected} for age ${age}`, () => {
      expect(isValidAge(age)).toBe(expected)
    })
  })
})
```

---

## Pattern 10: Mocking External Services

```typescript
jest.mock('./stripe', () => ({
  chargeCard: jest.fn()
}))

describe('PaymentService', () => {
  test('processes payment', async () => {
    const mockCharge = require('./stripe').chargeCard
    mockCharge.mockResolvedValue({ success: true })

    const result = await processPayment(100)

    expect(result).toEqual({ success: true })
    expect(mockCharge).toHaveBeenCalledWith(100)
  })
})
```

---

## Test Organization Best Practices

```typescript
describe('FeatureName', () => {
  // Setup
  beforeEach(() => {
    // Run before each test
  })

  afterEach(() => {
    // Cleanup after each test
  })

  describe('Scenario 1', () => {
    test('behavior A', () => {})
    test('behavior B', () => {})
  })

  describe('Scenario 2', () => {
    test('behavior C', () => {})
  })
})
```

---

## Anti-Patterns (DON'T DO)

❌ `test('stuff works')` → Be specific about what
❌ Testing implementation, not behavior → Test user perspective
❌ Tests that sometimes pass, sometimes fail (flaky) → Fix timing
❌ Too many assertions per test → One assertion per test
❌ No setup/teardown → Tests can interfere with each other

---

**Remember**: Good tests = fewer bugs. Test behavior, not implementation!

