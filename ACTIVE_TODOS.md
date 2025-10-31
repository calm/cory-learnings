---
title: "Active Todo List"
description: "Persistent todo list across Claude Code conversations"
last_updated: "2025-10-30"
status: "active"
---

# Active Todos

**Purpose**: Preserve todo context between Claude Code conversations

**How to Use:**
- Claude saves pending todos here at end of session
- Next Claude conversation loads from this file
- Delete completed todos, keep only pending/in_progress

---

## Current Todos

**Status as of 2025-10-30 22:40:**

✅ **Session Complete - No Pending Todos**

All work from today's session completed:
- ✅ cory-learnings optimized for AI use (v2.3.0 → v2.4.0)
- ✅ Interface verification with expected behavior checks
- ✅ Localhost port management documented
- ✅ README best practices guide created
- ✅ Professional README template created
- ✅ Cross-project context sharing preference documented
- ✅ All commits pushed to GitHub

---

## Template for Next Session

When Claude creates todos, they'll be saved here in this format:

```markdown
### [Project Name] - [Date] - [Window ID]

**Context**: Brief description of what we're working on

**Window**: Window 1 / Window 2 / Window 3 (if using multiple)

**Pending Todos:**
- [ ] Todo item 1 - Brief description
- [ ] Todo item 2 - Brief description
- [ ] Todo item 3 - Brief description

**In Progress:**
- [ ] Current task being worked on

**Completed (for reference):**
- [x] Completed task 1
- [x] Completed task 2
```

**Multi-Window Coordination:**
```markdown
### Window 1 - Feature Work
- [IN PROGRESS] Implementing authentication flow
- Branch: feature/auth

### Window 2 - Bug Fixes
- [PENDING] Fix race condition in petal system
- Branch: fix/race-condition

### Window 3 - Documentation
- [PENDING] Update README with new features
- Branch: docs/readme-update
```

---

## Usage Notes

**For Claude:**
- At end of session: Save any pending/in_progress todos here
- At start of session: Check this file for context
- Keep format clean and scannable

**For Cory:**
- Check this file to see what Claude is working on
- Add todos manually if needed
- Clear completed items periodically

---

**Last Updated**: 2025-10-30 22:40
