# AI Agents Guide

**Project**: [PROJECT_NAME]
**Last Updated**: [DATE]
**Purpose**: Comprehensive guide for AI agents working on this project

---

## Quick Context

**Tech Stack**: [e.g., React 19, TypeScript, Supabase]
**Port**: [e.g., localhost:3000]
**Package Manager**: [npm/yarn/pnpm]

**Key Commands**:
```bash
npm run dev        # Start development server
npm test          # Run test suite
npm run build     # Build for production
npm run lint      # Lint code
```

---

## Critical Rules (MUST FOLLOW)

1. **Todo Lists**: Use TodoWrite for ANY task with 2+ steps BEFORE starting
2. **Complete Work**: ZERO TODOs in code - implement fully
3. **Zero Test Failures**: Tests must pass - zero tolerance (98% coverage target)
4. **Token Efficiency**: <30% budget per task (Ask → Grep → Sample → Target → Execute)
5. **Make Things Fast**: Parallel operations, optimized builds, efficient code
6. **Work Autonomously**: "Be critical and continue" = keep going without hand-holding

---

## Project Structure

```
[PROJECT_NAME]/
├── src/                    # Source code
│   ├── components/        # [Description]
│   ├── pages/            # [Description]
│   ├── lib/              # [Description]
│   └── types/            # [TypeScript types]
├── tests/                 # Test files
├── public/               # Static assets
├── [other-dirs]/         # [Description]
└── package.json
```

**Key Files**:
- `[file1]`: [Purpose]
- `[file2]`: [Purpose]
- `[file3]`: [Purpose]

---

## Architecture Overview

**[High-level description of architecture]**

### Data Flow
1. [Step 1]
2. [Step 2]
3. [Step 3]

### Key Patterns
- **[Pattern 1]**: [When/how used]
- **[Pattern 2]**: [When/how used]
- **[Pattern 3]**: [When/how used]

---

## Development Workflow

### Starting Development
```bash
1. git pull
2. npm install
3. npm run dev
4. Open http://localhost:[PORT]
```

### Before Committing
```bash
1. npm test                    # All tests pass
2. npm run lint               # Zero warnings
3. npm run build              # Builds successfully
4. git add .
5. git commit -m "type: message"
```

### Commit Convention
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation
- `test:` - Tests
- `refactor:` - Code restructuring
- `perf:` - Performance improvement

**Always include**:
```
🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## Testing Standards

**Coverage Target**: 98%
**Tolerance**: ZERO failing tests

### Test Types
- **Unit**: Mocked dependencies, fast, isolated
- **Integration**: Real dependencies, slower, connected
- **E2E**: Full user flows (if applicable)

### Running Tests
```bash
npm test                      # All tests
npm test -- [file]           # Specific file
npm test -- --coverage       # With coverage
npm test -- --watch          # Watch mode
```

---

## Code Quality Standards

### TypeScript
- Strict mode enabled
- Zero `any` (unless absolutely necessary)
- All interfaces properly defined
- Type-safe throughout

### Logging
```typescript
// ❌ NEVER
console.log('debug info')

// ✅ ALWAYS
logger.info('User action', {
  component: 'ComponentName',
  action: 'actionName',
  metadata: { ... }
})
```

### Error Handling
- Try/catch for async operations
- Proper error messages
- Log errors with context
- Return appropriate HTTP status codes (APIs)

---

## Common Tasks

### Adding a New Feature
1. Create todo list with TodoWrite
2. Write tests first (TDD approach)
3. Implement feature
4. Ensure tests pass
5. Update documentation
6. Commit with conventional format

### Fixing a Bug
1. Reproduce the bug
2. Write failing test
3. Fix the bug
4. Verify test passes
5. Check for similar issues
6. Commit with `fix:` prefix

### Refactoring
1. Ensure tests pass before starting
2. Make incremental changes
3. Run tests after each change
4. No functional changes
5. Document significant restructuring

---

## Environment Setup

### Required Environment Variables
```bash
# [FILE: .env.local or .env]
VAR_NAME=value              # Description
ANOTHER_VAR=value          # Description
```

### Configuration Files
- `[config-file-1]`: [Purpose]
- `[config-file-2]`: [Purpose]

---

## Database / State Management

**[Describe database setup, state management, etc.]**

### Schema
[Link to schema file or brief description]

### Migrations
```bash
[Commands for running migrations]
```

### Seeding Data
```bash
[Commands for seeding data]
```

---

## API Endpoints (if applicable)

### Base URL
`http://localhost:[PORT]/api/v1`

### Key Endpoints
- `GET /[endpoint]`: [Description]
- `POST /[endpoint]`: [Description]
- `PUT /[endpoint]`: [Description]
- `DELETE /[endpoint]`: [Description]

---

## Troubleshooting

### Common Issues

**Issue 1: [Description]**
```bash
# Solution
[commands or steps]
```

**Issue 2: [Description]**
```bash
# Solution
[commands or steps]
```

---

## Communication Decoder

| Cory says | Means |
|-----------|-------|
| "do it" | Full approval, implement completely |
| "be critical" | Honest assessment, find ALL issues |
| "continue" / "c" | Keep working autonomously |
| "test all and make sure ok" | Zero tolerance for failures |
| "do this yourself" | Complete implementation, no TODOs |
| "make things fast" | Optimize for speed and efficiency |

---

## AI Agent Priority

**Use in this order:**
1. **Copilot in VSCode** (Claude through Copilot) - Until monthly limit
2. **Gemini Agent/CLI** - UNLIMITED (Google Workspace)
3. **Claude Agent/Code** - Fallback with token efficiency

---

## Project-Specific Context

**[Add any project-specific information here]**

### Known Quirks
- [Quirk 1]
- [Quirk 2]

### Performance Considerations
- [Consideration 1]
- [Consideration 2]

### Security Notes
- [Note 1]
- [Note 2]

---

## Resources

**Documentation**:
- [Link to internal docs]
- [Link to external docs]

**Related Projects**:
- [Link to related repo]

**Team Context**:
- [Relevant team information]

---

## For More Details

- **Master Learnings**: `~/cory-learnings/MASTER_LEARNINGS.md`
- **Token Efficiency**: `~/cory-learnings/TOKEN_EFFICIENCY.md`
- **Quick Reference**: `~/cory-learnings/AI_QUICKSTART.md`
- **Project Learnings**: `./CORY_LEARNINGS.md` or `./Cory learnings.md`

---

**Last Updated**: [DATE]
**Maintained By**: [TEAM/PERSON]
**Status**: [Active/Archived/etc.]
