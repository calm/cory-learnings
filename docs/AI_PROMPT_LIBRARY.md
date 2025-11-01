---
title: "AI Prompt Library"
description: "Pre-built prompts for common tasks (reusable, tested, optimized)"
version: "1.0"
last_updated: "2025-11-01"
type: "reference"
---

# AI Prompt Library

Copy-paste these prompts to save tokens and get consistent results.

---

## Usage

1. Find relevant prompt below
2. Copy the prompt
3. Replace {PLACEHOLDERS} with your context
4. Paste into chat
5. Done! (200-400t saved vs custom prompt)

---

## Bug Diagnosis

### Prompt 1: Understand Error

```
I'm getting this error in {PROJECT}:
{ERROR_MESSAGE}

This happened when I {ACTION}.

Can you:
1. Identify what's wrong
2. Point to likely file location
3. Suggest a fix
4. Help me verify it works

Provide minimal explanation, just the facts.
```

**Usage**: Immediate bug diagnosis
**Time saved**: 1-2 min
**Token saved**: 200-300t

---

### Prompt 2: Debug Flaky Test

```
This E2E test fails randomly in {PROJECT}:
```
{TEST_CODE}
```

The test passes 8/10 times. What's the likely issue and fix?

Focus on: timing, state, isolation, race conditions.
```

**Usage**: Flaky test investigation
**Token saved**: 300-400t

---

## Feature Implementation

### Prompt 3: Build Feature

```
I need to add {FEATURE} to {PROJECT}.

Context:
- What it does: {DESCRIPTION}
- Where it goes: {LOCATION}
- Similar code: {REFERENCE_FILE}

Generate:
1. Component/function skeleton with visible TODOs
2. Key implementation steps (numbered list)
3. Tests I should write
4. Integration points

Keep it concise.
```

**Usage**: Feature planning
**Token saved**: 300-400t

---

### Prompt 4: Code Review Self-Check

```
I wrote this code for {PROJECT}:

\`\`\`
{CODE}
\`\`\`

Quick quality check:
1. Any obvious bugs?
2. Missing error handling?
3. Performance issues?
4. Type safety problems (TypeScript)?
5. Test coverage needed?

Format: just the issues, no explanation needed.
```

**Usage**: Before committing
**Token saved**: 200-300t

---

## Testing

### Prompt 5: Write Unit Tests

```
I need tests for this function in {PROJECT}:

\`\`\`
{FUNCTION_CODE}
\`\`\`

Write Jest tests covering:
1. Happy path
2. Edge cases
3. Error handling
4. Boundary conditions

Use this test structure from {PATTERN_FILE}:
\`\`\`
{TEST_PATTERN}
\`\`\`
```

**Usage**: Test generation
**Token saved**: 300-500t

---

### Prompt 6: Debug Test Failure

```
This test is failing in {PROJECT}:

Error: {ERROR}
Test file: {FILE}

\`\`\`
{TEST_CODE}
\`\`\`

1. What went wrong?
2. Why is it happening?
3. One-line fix

No long explanations.
```

**Usage**: Quick test fixes
**Token saved**: 200-300t

---

## Documentation

### Prompt 7: Write README Section

```
Write a README section for {PROJECT}:

Topic: {TOPIC} (e.g., "Installation", "Architecture", "Contributing")
Audience: {WHO} (e.g., "developers", "contributors", "users")
Style: Concise, with examples

Include:
- Short description
- Code example if applicable
- Links to related docs
```

**Usage**: Documentation
**Token saved**: 200-300t

---

### Prompt 8: Explain Code

```
Explain what this code does in {PROJECT}:

\`\`\`
{CODE}
\`\`\`

For audience: {AUDIENCE}

Keep it: brief, practical, point to relevant files.
```

**Usage**: Code comprehension
**Token saved**: 100-200t

---

## Optimization

### Prompt 9: Optimize Code

```
Optimize this code for {GOAL} in {PROJECT}:

Current:
\`\`\`
{CODE}
\`\`\`

Optimize for: performance | readability | maintainability | bundle size

Constraints:
- Must pass existing tests
- Can't change API

Provide: before/after code with explanation.
```

**Usage**: Performance/quality improvements
**Token saved**: 200-300t

---

### Prompt 10: Reduce Dependencies

```
What can I remove from package.json in {PROJECT}?

\`\`\`
{PACKAGE_JSON}
\`\`\`

Find:
1. Unused packages
2. Duplicate versions
3. Oversized packages with lighter alternatives

For each: why remove it, what's the impact.
```

**Usage**: Dependency cleanup
**Token saved**: 200-300t

---

## Architecture

### Prompt 11: Design Component

```
Design a {COMPONENT} for {PROJECT}.

Requirements:
- {REQ_1}
- {REQ_2}
- {REQ_3}

Show me:
1. Component structure (props, state)
2. Integration points
3. Testing strategy
4. Alternative approaches

Keep it high-level.
```

**Usage**: Architecture decisions
**Token saved**: 300-400t

---

### Prompt 12: Database Schema

```
Design database schema for {PROJECT}:

Requirements:
- {REQ_1}
- {REQ_2}
- {REQ_3}

Show:
1. Table structure (Prisma/SQL)
2. Relationships
3. Indexes needed
4. Query patterns

Keep it minimal.
```

**Usage**: Data design
**Token saved**: 300-400t

---

## Debugging Deep Dives

### Prompt 13: Trace Bug Origin

```
I think there's a bug in {PROJECT} related to {SYMPTOM}.

Known facts:
- Happens when: {WHEN}
- Doesn't happen when: {WHEN_NOT}
- Error (if any): {ERROR}

Trace the bug:
1. Most likely source file
2. Why that location
3. Specific function to check
4. Debug steps

Be very specific.
```

**Usage**: Root cause analysis
**Token saved**: 400-500t

---

## Quick Reference

| Prompt | Use | Save |
|--------|-----|------|
| Understand Error | Bug diagnosis | 200-300t |
| Debug Flaky Test | Test issues | 300-400t |
| Build Feature | Feature planning | 300-400t |
| Code Review | Self-check | 200-300t |
| Write Tests | Test generation | 300-500t |
| Debug Test | Test fixes | 200-300t |
| Write Docs | Documentation | 200-300t |
| Explain Code | Understanding | 100-200t |
| Optimize Code | Performance | 200-300t |
| Reduce Deps | Cleanup | 200-300t |
| Design Component | Architecture | 300-400t |
| Database Schema | Data design | 300-400t |
| Trace Bug | Root cause | 400-500t |

**Average**: 250-350 tokens saved per prompt use

---

## Tips for Using Prompts

1. **Be specific**: Replace all {PLACEHOLDERS}
2. **Include context**: Paste relevant code
3. **Set constraints**: What can/can't change
4. **Keep it short**: Prompts work better with minimal fluff
5. **Save responses**: Build your own prompt library

---

## Creating Your Own Prompts

**Pattern**:
```
I need to {TASK}

Context: {RELEVANT_INFO}

Show me: {WHAT_YOU_WANT}

Constraints: {WHAT_MATTERS}

Format: {HOW_YOU_WANT_IT}
```

**Save to**: Local docs for your projects

---

**Pro tip**: After using a prompt, note if you'd change anything. Build better prompts over time!

