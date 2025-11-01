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

**Status as of 2025-11-01 00:15:**

✅ **Session Complete - No Pending Todos**

### cory-learnings Review Session - 2025-11-01

**Task**: Provide first-time user feedback on cory-learnings repository

**Completed:**
- ✅ Explored repository structure (README, docs/, projects/)
- ✅ Analyzed AI_QUICKSTART.md entry points
- ✅ Reviewed project-specific learnings (calm-couples.md)
- ✅ Provided comprehensive user feedback with specific suggestions:
  - Identified 5 major UX friction points
  - Proposed consolidation of cost optimization docs (8 → 2-3 files)
  - Suggested status badges for file types
  - Recommended interactive menu system
  - Provided assessment rating (6-8/10 across dimensions)

**Key Feedback Themes:**
- Too many similar cost analysis files (repetition)
- Navigation could be clearer for first-time users
- Missing "active vs archived" separation
- Templates exist but not well-documented
- Foundation is solid, needs curation not more content

**Recommendation**: Review cost-optimization folder consolidation as quick win

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
