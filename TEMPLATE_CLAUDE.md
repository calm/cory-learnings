# Claude Quick Reference

**Last Updated**: [DATE]
**Project**: [PROJECT_NAME]

## Critical Rules

1. **Todo Lists**: Use TodoWrite for ANY task with 2+ steps BEFORE starting
2. **Complete Work**: ZERO TODOs in code - implement fully
3. **Zero Test Failures**: Tests must pass - zero tolerance
4. **Token Efficiency**: Ask → Sample → Target → Execute (<30% budget)
5. **Work Autonomously**: "Be critical and continue" = keep going

## Project Context

**Stack**: [e.g., React 19, TypeScript, Supabase]
**Port**: [e.g., localhost:3000]
**Key Commands**:
```bash
npm run dev        # Start dev server
npm test          # Run tests
npm run build     # Build for production
```

## Key Files

- **Source**: `src/`
- **Tests**: `tests/` or `src/**/*.test.ts`
- **Config**: [List key config files]
- **Learnings**: [Link to CORY_LEARNINGS.md or equivalent]

## Quality Standards

- **Test Coverage**: 98% target
- **TypeScript**: Strict mode, zero `any`
- **Logging**: Structured logger (no console.log)
- **Commits**: Conventional commits with Claude attribution

## Quick Links

- [Full Learnings](./CORY_LEARNINGS.md) - Project-specific details
- [Master Learnings](~/cory-learnings/MASTER_LEARNINGS.md) - Complete preferences
- [Token Efficiency](~/cory-learnings/TOKEN_EFFICIENCY.md) - Optimization guidelines

## Communication Decoder

| Phrase | Meaning |
|--------|---------|
| "do it" | Full approval, implement completely |
| "be critical" | Honest assessment, find ALL issues |
| "continue" / "c" | Keep working autonomously |
| "test all and make sure ok" | Zero tolerance for failures |

---

**For comprehensive guidance**: Read `~/cory-learnings/AI_QUICKSTART.md` (540 lines)
