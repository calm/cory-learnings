---
title: "Cory's Learnings - calm-ai-project-manager"
description: "Project-specific learnings for calm-ai-project-manager"
version: "1.0.0"
last_updated: "2025-10-30"
project: "calm-ai-project-manager"
type: "project-learnings"
audience: ["ai-agents"]
tags: ["calm-ai-pm", "node", "prisma"]
---

# Cory Learnings - Knowledge Base

*Last updated: October 30, 2025*

This document captures key insights, preferences, patterns, and learnings from working with Cory Weinstein on the Calm AI Project Manager.

## Session Overview

**Context**: This session continued from a previous conversation that ran out of context. We built comprehensive project management features with AI integration.

---

## Cory's Working Style

### Preferences
1. **"Keep localhost running"** - Prefers to keep the server running while working on new features
2. **"Do next thing you pick"** - Trusts AI judgment on feature prioritization
3. **"Be critical and continue"** - Values critical analysis and continuous improvement
4. **"Make updates for around 20 minutes"** - Gives clear time boxes for work sessions
5. **"Push changes if needed - have versioning"** - Values version control and semantic versioning

### Communication Style
- Direct and concise
- Trusts the AI to make decisions ("do it")
- Points to resources when available (GitHub PR links)
- Expects proactive work without constant check-ins

---

## Key Requests & Decisions

### Session Start
**Request**: "keep localhost running - but work on next thing"
- Keep development server active (localhost:3000)
- Continue with next feature development
- Don't interrupt the workflow

### Feature Requests

#### 1. **Fix UI Errors** (Immediate Priority)
Cory showed browser console errors:
```
14:26:09.834 inject.bundle.js:1 Uncaught Error: Automatic publicPath is not supported
14:26:10.108 :3000/api/health:1 Failed to load resource: 404 (Not Found)
14:26:10.259 :3000/favicon.ico:1 Failed to load resource: 404 (Not Found)
14:26:25.165 :3000/api/v1/conversation/chat:1 Failed to load resource: 500 (Internal Server Error)
```

**Actions Taken**:
- Fixed 500 errors on AI endpoints (graceful degradation)
- Added /api/health endpoint
- Created functional UI (public/index.html)

#### 2. **Knowledge Base Features**
Cory explicitly requested:
- "LLM slack workflow creation thing"
- "AI tools directory - see what AI tools the company uses, maybe add reviews or something"
- "PTL Checklist - maybe a confluence integration"
- "Easy to use FAQ"
- "Add features you think teams would like"

**Actions Taken**:
- Built AI Tools Directory with reviews and ratings
- Built FAQ System with search and voting
- Built Slack Workflows with LLM-powered generation
- Added PTL Checklist system with Confluence placeholder

#### 3. **Team Wellness Features**
When I suggested 5 wellness features, Cory said:
**"do it"**

This meant:
- Full approval to implement
- No need to clarify details
- Trust the proposed design

**Features Built**:
1. Celebration Board
2. Team Mood/Energy Tracking
3. 1-on-1 Agenda Tracker
4. Decision Log
5. Kudos System

#### 4. **Task Board View** (Latest Request)
**Request**: "have feature - allow user to easily view all work in development and backlog and be able to edit"

**What Cory Wants**:
- Easy visualization of all work grouped by status
- See tasks in BACKLOG, IN_PROGRESS, BLOCKED, REVIEW, DONE
- Ability to edit tasks inline (update status, priority, assignee)
- Kanban-style board view

**Actions Taken**:
- ✅ Created GET /api/v1/tasks/board/view endpoint
- ✅ Returns tasks grouped by status with stats
- ✅ Shows counts by status and priority
- ✅ Supports optional project filtering (?projectId=xxx)
- ✅ Built full UI with kanban board view

**Additional Context**:
- Cory said "keep improve the cory file" - wants this file kept up to date
- Values having a reference document of what's been learned/requested

#### 5. **Comprehensive UI with Dedicated Views** (Latest Update)
**Request**: "click 'view all teams' 'view all...' etc should have its on ux and ui"

**What Cory Wants**:
- Each "view all" section needs proper UI, not just JSON dumps
- Dedicated views for Teams, Checklists, Knowledge, Wellness, etc.
- Navigation between sections
- Professional UX with proper layouts

**Actions Taken**:
- ✅ Created full single-page app with tabbed navigation
- ✅ 7 main sections: Overview, Tasks, Teams, Checklists, Knowledge, Wellness, Health
- ✅ Kanban board for tasks with status columns
- ✅ List views for teams, checklists, etc.
- ✅ Stats cards showing key metrics
- ✅ Color-coded priority badges
- ✅ Status-colored borders (BLOCKED=red, DONE=green, etc.)
- ✅ Empty states for sections with no data
- ✅ Hover effects and visual feedback
- ✅ Responsive design

**UI Features**:
- **Overview Tab**: Dashboard with 6 key stats (total tasks, in progress, blocked, done, AI status, server status)
- **Tasks Tab**: Full kanban board showing all 20 tasks organized by status (BACKLOG, READY, IN_PROGRESS, BLOCKED, REVIEW, DONE)
- **Teams Tab**: List of all teams with member counts
- **Checklists Tab**: PTL checklists with completion percentages
- **Knowledge Tab**: AI tools directory, FAQs count, workflows count
- **Wellness Tab**: Celebrations, kudos, mood check-ins
- **Health Tab**: System status and feature availability

**Design Patterns Used**:
- Clean, modern design with Calm's purple gradient header
- Card-based layouts for stats
- Grid layouts for board columns
- List layouts for items
- Color coding for priorities (URGENT=red, HIGH=yellow, MEDIUM=blue, LOW=green)
- Status borders on task cards
- Smooth hover transitions
- Empty states with icons

### Documentation Standards

#### 6. **AGENTS.md Documentation**
**Request**: "verify we have functionality from https://github.com/calm/api/pull/13684"

**Context**: PR #13684 added AGENTS.md files throughout calm/api to help AI agents understand the monorepo.

**Key Insights**:
- Calm uses comprehensive AGENTS.md files for AI agent guidance
- Documentation follows specific patterns:
  - Architecture overview
  - Common commands and PR checklist
  - Code style guidelines
  - Database schema documentation
  - API endpoints reference
  - Queue consumers and crons
- README.md should follow specific format:
  - Last updated timestamp
  - Core components with Mermaid diagrams
  - Relevant database tables
  - API endpoints with authentication details
  - Queue consumers and crons sections

**Actions Taken**:
- Created comprehensive AGENTS.md following calm/api patterns
- Updated README.md with proper format
- Added .env.example with all future integrations
- Bumped version to 1.1.0 with better package.json

---

## Technical Preferences & Patterns

### Database
- **Primary**: SQLite for development (zero config, easy reset)
- **Production**: Ready for PostgreSQL migration
- **ORM**: Prisma with TypeScript types
- **Migrations**: Sequential, descriptive names, backwards compatible

### AI Integration
- **Provider**: Anthropic Claude 3.5 Sonnet
- **Pattern**: Graceful degradation - core features work without AI
- **Error Handling**: Return 503 with helpful messages when AI unavailable
- **Philosophy**: AI enhances but never blocks functionality

### Code Organization
- Controllers handle HTTP and business logic
- Routes define endpoints
- Services contain complex business logic
- Middleware for cross-cutting concerns
- All errors logged with context

### Git Practices
- **Commit Format**: Conventional commits (feat:, fix:, docs:, etc.)
- **Attribution**: Include Claude Code attribution in commits
- **Versioning**: Semantic versioning (v1.1.0, v1.2.0, etc.)
- **Descriptive Messages**: Include what, why, and impact

---

## Feature Evolution

### Phase 1: Initial Setup
- Basic task management
- Project structure
- Express + Prisma + SQLite

### Phase 2: Core Features (Pre-session)
- Task management with RCI matrix
- Team collaboration
- AI-powered insights
- Test automation integration
- Centralized Prisma/AI clients
- Validation middleware
- Team dashboards

### Phase 3: This Session
1. Fixed UI errors and added health endpoint
2. Built knowledge base (AI tools, FAQs, Slack workflows)
3. Built team wellness features (celebrations, mood, 1-on-1s, decisions, kudos)
4. Built PTL checklist system with Confluence integration
5. Created comprehensive documentation (AGENTS.md, README.md)
6. Version bump to 1.1.0 with proper package.json

### Phase 4: Future (From Cory's Input)
- Sprint planning & velocity tracking
- Notification system (email, Slack, in-app)
- Analytics dashboard
- Full Confluence integration
- Full Slack integration
- Jira sync
- GitHub integration

---

## Calm Engineering Context

### From calm/api Exploration
Cory works on the **calm/api** monorepo which has:
- 80+ controllers
- 99+ database models
- Complex subscription system (Stripe, App Store, Play Store, etc.)
- Multiple integrations (Auth0, Slack, Salesforce, etc.)
- Service-oriented architecture
- Rush monorepo management
- Comprehensive testing and validation

### Key Calm Patterns
1. **Error Handling**: Use CalmError with specific codes
2. **Validation**: @calm/simpler-models for schema validation
3. **Promises**: @calm/promises instead of Promise.all
4. **Documentation**: AGENTS.md files for AI guidance
5. **README Format**: Specific sections (Core Components, Database Tables, API Endpoints, Queue Consumers, Crons)

---

## What Cory Values

### In Documentation
- ✅ Comprehensive but concise
- ✅ Clear examples
- ✅ Mermaid diagrams for architecture
- ✅ Last updated timestamps
- ✅ Future integrations documented

### In Code
- ✅ Graceful degradation (AI features optional)
- ✅ Consistent error handling
- ✅ Type safety (Prisma generates TypeScript)
- ✅ Good logging with context
- ✅ Clear commit messages

### In Features
- ✅ Team wellness (culture matters)
- ✅ Knowledge base (AI tools, FAQs)
- ✅ Launch checklists (nothing forgotten)
- ✅ AI-powered insights (optional but valuable)

### In Workflow
- ✅ Keep server running while developing
- ✅ Version control with semantic versioning
- ✅ Critical analysis and improvement
- ✅ Trust AI judgment on priorities
- ✅ Direct action ("do it" means go)

---

## Insights About Cory

1. **Technical Leadership**: Works on complex systems (calm/api monorepo)
2. **Process-Oriented**: Values checklists, documentation, standards
3. **Team-Focused**: Prioritized wellness features (celebrations, mood, kudos)
4. **Quality-Driven**: Asked for critical review, proper documentation
5. **Pragmatic**: Trusts AI judgment, doesn't micromanage
6. **Forward-Thinking**: Documents future integrations in .env.example

---

## Project Priorities (Inferred)

### High Priority
1. ✅ Core functionality working (tasks, projects, teams)
2. ✅ Error handling and graceful degradation
3. ✅ Team collaboration and wellness
4. ✅ Documentation for AI agents
5. ✅ Launch readiness (checklists)

### Medium Priority
- Authentication & authorization
- PostgreSQL migration
- Notification system
- Analytics dashboard

### Future Considerations
- Microservices extraction
- Multi-tenancy
- Advanced integrations
- Scale and performance optimization

---

## Communication Patterns

### When Cory Says:
- **"do it"** → Full approval, proceed with implementation
- **"do next thing you pick"** → Trust AI judgment on priorities
- **"be critical"** → Analyze deeply, find improvements
- **"keep localhost running"** → Don't interrupt the dev server
- **"push changes if needed"** → Version and commit proactively

### When Cory Shares:
- GitHub PRs → Study the patterns and apply them
- Browser errors → Immediate priority to fix
- Feature lists → All are desired, prioritize reasonably
- "that will help" → Confirmation that approach is good

---

## Lessons Learned

### What Works Well
1. Proactive implementation without constant approval
2. Following Calm engineering patterns from calm/api
3. Comprehensive documentation
4. Graceful degradation for optional features
5. Version control with semantic versioning

### What To Remember
1. Always keep server running during development
2. Document everything (AGENTS.md, README.md, comments)
3. Version bumps signal major improvements
4. Team wellness features are valued
5. AI should enhance, not block

---

## File Structure Created

```
calm-ai-project-manager/
├── AGENTS.md              # Comprehensive AI agent guidelines
├── README.md              # Detailed project documentation
├── Cory learnings.md      # This file
├── .env.example          # Environment variables template
├── package.json          # v1.1.0 with proper scripts
├── prisma/
│   ├── schema.prisma     # 20+ models
│   └── migrations/       # Sequential migrations
├── src/
│   ├── api/
│   │   ├── controllers/  # 12+ controllers
│   │   ├── routes/       # 12+ route files
│   │   └── server.js     # Express app
│   ├── lib/              # Prisma & AI clients
│   ├── services/         # Business logic
│   └── middleware/       # Validation, etc.
├── public/
│   └── index.html        # Functional UI
└── tests/                # Test files
```

---

## Quick Reference

### Features Implemented
- ✅ Task Management (CRUD, status, priority, effort)
- ✅ Project Management (health, teams, dashboards)
- ✅ RCI Matrix (Responsible, Consulted, Informed)
- ✅ AI-Powered Features (NLP, insights, analysis)
- ✅ Knowledge Base (AI tools, FAQs, Slack workflows)
- ✅ Team Wellness (celebrations, mood, 1-on-1s, decisions, kudos)
- ✅ PTL Checklists (templates, project-specific, Confluence)
- ✅ Test Automation Integration
- ✅ Retrospectives

### Key Technologies
- Node.js 22.x + Express.js 4.x
- SQLite (dev) + Prisma ORM
- Anthropic Claude 3.5 Sonnet (optional)
- Vanilla HTML/CSS/JS (frontend)

### Version History
- **v1.0.0** (Oct 30, 2025): Initial project with core features
- **v1.1.0** (Oct 30, 2025): Added knowledge base, wellness, checklists, comprehensive docs

---

## Next Session Prep

When resuming work:
1. Check git log for recent changes
2. Review open TODOs (if any)
3. Check server status (localhost:3000)
4. Review AGENTS.md for current architecture
5. Ask Cory what to work on next

Remember: **"keep localhost running - but work on next thing"**

---

*This document will evolve as we learn more about Cory's preferences and priorities.*
