---
title: "cory-learnings Architecture"
description: "Visual architecture and component relationships"
version: "2.4.0"
last_updated: "2025-10-31"
type: "architecture"
audience: ["developers", "ai-agents"]
tags: ["architecture", "diagrams", "system-design"]
---

# cory-learnings Architecture

## System Architecture Overview

```mermaid
graph TB
    subgraph "Developer Environment"
        VSCode[VS Code + Claude Code Extension]
        User[Cory]
    end

    subgraph "Central Repository ~/cory-learnings"
        Core[Core Documentation]
        Projects[Project-Specific Files]
        Scripts[Automation Scripts]
        Tests[Test Suite]
    end

    subgraph "Active Projects"
        P1[calm-couples<br/>localhost:3000]
        P2[ios-automation<br/>localhost:4000]
        P3[calm-ai-project-manager<br/>localhost:3001]
    end

    subgraph "Claude Code Integration"
        Hooks[VS Code Hooks]
        AutoLoad[Auto-Load System]
        TodoTool[TodoWrite Tool]
    end

    User -->|Types message| VSCode
    VSCode -->|Triggers| Hooks
    Hooks -->|Auto-injects| AutoLoad
    AutoLoad -->|Reads| Core
    VSCode -->|Uses| TodoTool

    Core -.->|Symlink| P1
    Core -.->|Symlink| P2
    Core -.->|Symlink| P3

    Projects -->|Contains| P1
    Projects -->|Contains| P2
    Projects -->|Contains| P3

    Scripts -->|Validates| Core
    Scripts -->|Validates| Projects
    Tests -->|Validates| Core

    style Core fill:#e1f5ff
    style Hooks fill:#ffe1f5
    style AutoLoad fill:#ffe1f5
    style P1 fill:#f0ffe1
    style P2 fill:#f0ffe1
    style P3 fill:#f0ffe1
```

## Three-Tier Documentation Architecture

```mermaid
graph LR
    subgraph "Tier 1: Quick Reference"
        Q[AI_QUICKSTART.md<br/>540 lines<br/>Ultra-concise]
    end

    subgraph "Tier 2: Comprehensive"
        M[MASTER_LEARNINGS.md<br/>1,154 lines<br/>Complete guide]
    end

    subgraph "Tier 3: Project-Specific"
        P1[calm-couples.md<br/>541 lines]
        P2[ios-automation.md<br/>272 lines]
        P3[calm-ai-project-manager.md<br/>426 lines]
    end

    subgraph "Supporting"
        T[TERM_DICTIONARY.md<br/>600+ lines]
        E[EXAMPLES.md<br/>513 lines]
    end

    Q -->|References| M
    M -->|Links to| P1
    M -->|Links to| P2
    M -->|Links to| P3
    Q -->|Uses| T
    M -->|Uses| T
    M -->|Uses| E

    style Q fill:#ff9999
    style M fill:#ffcc99
    style P1 fill:#99ccff
    style P2 fill:#99ccff
    style P3 fill:#99ccff
    style T fill:#ccffcc
    style E fill:#ccffcc
```

## Auto-Load System Flow

```mermaid
sequenceDiagram
    participant User
    participant VSCode
    participant Hook as user-prompt-submit Hook
    participant Claude as Claude Code Agent
    participant Repo as ~/cory-learnings

    User->>VSCode: Types message
    VSCode->>Hook: Triggers hook
    Hook->>Claude: Injects critical rules
    Note over Hook,Claude: AUTOMATIC REMINDER:<br/>- Todo lists (2+ steps)<br/>- Complete implementations<br/>- Zero test failures<br/>- Autonomous quality
    Claude->>Repo: Reads AI_QUICKSTART.md (if needed)
    Repo-->>Claude: Returns context
    Claude->>User: Responds with context-aware answer

    Note over User,Claude: Every single message automatically<br/>includes critical rules!
```

## Symlink Pattern

```mermaid
graph TB
    subgraph "Central Repository"
        Central[~/cory-learnings/projects/]
        CC[calm-couples.md]
        IOS[ios-automation.md]
        AI[calm-ai-project-manager.md]

        Central --> CC
        Central --> IOS
        Central --> AI
    end

    subgraph "Project 1: calm-couples"
        P1Link[CORY_LEARNINGS.md<br/>symlink]
    end

    subgraph "Project 2: ios-automation"
        P2Link[CORY_LEARNINGS.md<br/>symlink]
    end

    subgraph "Project 3: calm-ai-project-manager"
        P3Link[Cory learnings.md<br/>symlink]
    end

    CC -.->|Symlinked to| P1Link
    IOS -.->|Symlinked to| P2Link
    AI -.->|Symlinked to| P3Link

    style Central fill:#e1f5ff
    style CC fill:#ffe1e1
    style IOS fill:#ffe1e1
    style AI fill:#ffe1e1
    style P1Link fill:#e1ffe1
    style P2Link fill:#e1ffe1
    style P3Link fill:#e1ffe1
```

## Todo List State Machine

```mermaid
stateDiagram-v2
    [*] --> Pending: TodoWrite creates task
    Pending --> InProgress: Mark as in_progress<br/>(only ONE at a time)
    InProgress --> Completed: Mark as completed<br/>(immediately after finishing)
    InProgress --> Pending: Blocked/need to pause
    Completed --> [*]

    note right of InProgress
        CRITICAL: Only ONE task
        can be in_progress at a time
    end note

    note right of Completed
        Mark IMMEDIATELY after
        finishing - no batching!
    end note
```

## Interface Verification Protocol (v2.4.0)

```mermaid
flowchart TD
    Start[User: Run interface] --> Step1[Step 1: Start server<br/>npm run dev]
    Step1 --> Step2[Step 2: Verify URL responds<br/>curl localhost:PORT]
    Step2 --> Step3[Step 3: Check expected behavior<br/>Page loads? No errors? UI renders?]
    Step3 --> Step4[Step 4: Report detailed status<br/>What works? What doesn't?]
    Step4 --> Done[User can confidently<br/>open browser]

    style Step3 fill:#ffcccc
    style Step4 fill:#ccffcc
```

## Decision Framework: When to Ask vs Decide

```mermaid
flowchart TD
    Question[Faced with decision]

    Question --> Documented{Is this<br/>documented?}
    Documented -->|Yes| CheckDocs[Check learnings]
    CheckDocs --> Proceed[Proceed with<br/>documented approach]

    Documented -->|No| Reversible{Is this<br/>reversible?}
    Reversible -->|Yes| Decide[Decide and proceed]
    Reversible -->|No| HighStakes{High-stakes<br/>operation?}

    HighStakes -->|Yes| Ask[Ask user<br/>for confirmation]
    HighStakes -->|No| Tradeoffs{Significant<br/>tradeoffs?}

    Tradeoffs -->|Yes| Present[Present options<br/>with recommendation]
    Tradeoffs -->|No| IntentClear{Intent<br/>clear?}

    IntentClear -->|Yes| Decide
    IntentClear -->|No| Clarify[Ask for<br/>clarification]

    style Ask fill:#ffcccc
    style Clarify fill:#ffcccc
    style Proceed fill:#ccffcc
    style Decide fill:#ccffcc
```

## Component Relationships

```mermaid
graph TD
    subgraph "Core Documentation Layer"
        README[README.md<br/>Overview]
        QUICK[AI_QUICKSTART.md<br/>Quick Reference]
        MASTER[MASTER_LEARNINGS.md<br/>Comprehensive]
        DICT[TERM_DICTIONARY.md<br/>Terminology]
        EXAMPLES[EXAMPLES.md<br/>Patterns]
        CHANGELOG[CHANGELOG.md<br/>History]
        SETUP[SETUP_GUIDE.md<br/>Setup Instructions]
    end

    subgraph "Template Layer"
        TEMPLATE_NEW[TEMPLATE_NEW_PROJECT.md]
        TEMPLATE_README[TEMPLATE_README.md]
        README_BEST[README_BEST_PRACTICES.md]
    end

    subgraph "Project Layer"
        PROJ_README[projects/README.md]
        CALM[projects/calm-couples.md]
        IOS[projects/ios-automation.md]
        AI[projects/calm-ai-project-manager.md]
    end

    subgraph "Automation Layer"
        ADD[add-project.sh]
        CHECK[scripts/check-symlinks.sh]
        VALIDATE[scripts/validate-structure.sh]
        SEARCH[scripts/search-learnings.sh]
    end

    subgraph "Testing Layer"
        TEST_RUN[tests/run-all-tests.sh]
        TEST_STRUCT[tests/structure.test.sh]
        TEST_FRONT[tests/frontmatter.test.sh]
        TEST_MD[tests/markdown.test.sh]
    end

    README --> QUICK
    README --> MASTER
    README --> SETUP

    QUICK --> MASTER
    QUICK --> DICT
    MASTER --> DICT
    MASTER --> EXAMPLES
    MASTER --> PROJ_README

    SETUP --> TEMPLATE_NEW
    SETUP --> README_BEST
    README_BEST --> TEMPLATE_README

    PROJ_README --> CALM
    PROJ_README --> IOS
    PROJ_README --> AI

    ADD --> TEMPLATE_NEW
    CHECK --> CALM
    CHECK --> IOS
    CHECK --> AI

    TEST_RUN --> TEST_STRUCT
    TEST_RUN --> TEST_FRONT
    TEST_RUN --> TEST_MD

    TEST_STRUCT --> README
    TEST_STRUCT --> QUICK
    TEST_STRUCT --> MASTER

    style QUICK fill:#ff9999
    style MASTER fill:#ffcc99
    style DICT fill:#ccffcc
```

## Version Evolution Timeline

```mermaid
timeline
    title cory-learnings Version History

    section Pre-1.0
        v0.1.0 : Scattered files per project
               : No central repository
               : No version control

    section 1.x
        v1.0.0 (2025-10-29) : MASTER_LEARNINGS.md (447 lines)
                             : Core working principles
                             : 3 project files
                             : Symlink pattern
                             : User prompt submit hook

    section 2.x
        v2.0.0 (2025-10-30) : AI_QUICKSTART.md
                             : YAML frontmatter
                             : Core directives
                             : Communication protocol

        v2.1.0 (2025-10-30) : EXAMPLES.md
                             : When to Ask guidance
                             : Decision framework
                             : CHANGELOG.md

        v2.2.0 (2025-10-30) : FAQ (40+ Q&A)
                             : Glossary (50+ terms)
                             : Mermaid diagrams
                             : Auto-loading system

        v2.3.0 (2025-10-30) : Validation scripts
                             : Search helpers
                             : Table of Contents

        v2.4.0 (2025-10-30) : Interface verification
                             : Port management
                             : README best practices
                             : README template
```

## Information Flow

```mermaid
flowchart LR
    subgraph "Input Sources"
        Daily[Daily Work]
        Issues[Issues Found]
        Patterns[Patterns Discovered]
    end

    subgraph "Capture"
        Notes[Quick Notes]
        ProjectFiles[Update Project Files]
        Dict[Add to TERM_DICTIONARY]
    end

    subgraph "Consolidation"
        Weekly[Weekly Review]
        Elevate[Elevate to MASTER_LEARNINGS]
        Examples[Add to EXAMPLES]
    end

    subgraph "Refinement"
        Monthly[Monthly Review]
        Quick[Update AI_QUICKSTART]
        Version[Bump Version]
    end

    subgraph "Distribution"
        Git[Git Commit + Push]
        AutoLoad[Auto-Load Hook]
        Projects[All Projects via Symlinks]
    end

    Daily --> Notes
    Issues --> Notes
    Patterns --> Notes

    Notes --> ProjectFiles
    Notes --> Dict

    ProjectFiles --> Weekly
    Dict --> Weekly

    Weekly --> Elevate
    Weekly --> Examples

    Elevate --> Monthly
    Examples --> Monthly

    Monthly --> Quick
    Monthly --> Version

    Quick --> Git
    Version --> Git

    Git --> AutoLoad
    AutoLoad --> Projects

    style Daily fill:#e1f5ff
    style Weekly fill:#ffe1f5
    style Monthly fill:#f5e1ff
    style Git fill:#e1ffe1
```

## Quality Assurance Architecture

```mermaid
graph TB
    subgraph "Prevention Layer"
        Templates[Templates]
        Standards[Standards Docs]
        Examples[Good/Bad Examples]
    end

    subgraph "Detection Layer"
        Tests[Test Suite]
        Scripts[Validation Scripts]
        Hooks[Git Hooks]
    end

    subgraph "Validation Targets"
        Structure[File Structure]
        Frontmatter[YAML Frontmatter]
        Markdown[Markdown Syntax]
        Versions[Version Consistency]
        Links[Symlinks]
    end

    subgraph "Outcomes"
        Pass[Tests Pass ✓]
        Fail[Tests Fail ✗]
        Fix[Fix Issues]
    end

    Templates --> Structure
    Standards --> Frontmatter
    Examples --> Markdown

    Tests --> Structure
    Tests --> Frontmatter
    Tests --> Markdown
    Tests --> Versions

    Scripts --> Links
    Scripts --> Structure

    Structure --> Pass
    Structure --> Fail
    Frontmatter --> Pass
    Frontmatter --> Fail

    Fail --> Fix
    Fix --> Tests

    Pass --> Hooks

    style Pass fill:#ccffcc
    style Fail fill:#ffcccc
    style Fix fill:#ffffcc
```

## Multi-Window Coordination

```mermaid
sequenceDiagram
    participant W1 as Claude Window 1<br/>(Feature A)
    participant Repo as ~/cory-learnings
    participant Todos as ACTIVE_TODOS.md
    participant W2 as Claude Window 2<br/>(Feature B)

    W1->>Todos: Read pending todos
    W1->>Todos: Add Feature A todos
    W1->>Repo: Work on Feature A

    par Parallel Work
        W2->>Todos: Read pending todos
        W2->>Todos: Add Feature B todos
        W2->>Repo: Work on Feature B
    and
        W1->>Repo: Continue Feature A
        W1->>Todos: Update status
    end

    W2->>Repo: git pull (sync)
    W1->>Repo: git pull (sync)

    W1->>Todos: Mark Feature A complete
    W2->>Todos: Mark Feature B complete

    Note over W1,W2: Both windows coordinate<br/>via ACTIVE_TODOS.md
```

## Port Management Strategy

```mermaid
graph LR
    subgraph "Development Ports"
        P3000[calm-couples<br/>localhost:3000<br/>React + Supabase]
        P4000[ios-automation<br/>localhost:4000<br/>Test Framework]
        P3001[calm-ai-project-manager<br/>localhost:3001<br/>Node.js + Express]
    end

    subgraph "Port Conflicts"
        Conflict[Port already in use?]
    end

    subgraph "Resolution"
        Check[Check package.json<br/>or .env]
        Update[Update PORT env var]
        Restart[Restart server]
    end

    P3000 -->|Start server| Conflict
    P4000 -->|Start server| Conflict
    P3001 -->|Start server| Conflict

    Conflict -->|Yes| Check
    Check --> Update
    Update --> Restart

    Conflict -->|No| Success[✓ Server running]

    style Success fill:#ccffcc
    style Conflict fill:#ffcccc
```

---

## Architecture Principles

### 1. Single Source of Truth
All preferences documented once in central repository, distributed via symlinks.

### 2. Automated Consistency
Hooks ensure every conversation has context without manual intervention.

### 3. Layered Complexity
Three tiers allow AI to load appropriate depth: quick, comprehensive, or project-specific.

### 4. Version Control
Git tracks evolution of preferences over time, enabling rollback and history analysis.

### 5. Validation First
Test suite prevents inconsistencies before they propagate.

### 6. Symlink Distribution
Edit once centrally, available everywhere via filesystem symlinks.

### 7. Zero External Dependencies
Pure bash + markdown = works everywhere, no installation required.

### 8. Progressive Enhancement
Start simple, add automation/validation/search tools as needed.

---

## Technology Decisions

### Why Markdown?
- Universal format
- Git-friendly (text-based diffs)
- Human-readable
- Supports YAML frontmatter for metadata
- Renders beautifully in VS Code and GitHub

### Why Bash Scripts?
- Available on macOS/Linux by default
- No dependencies to install
- Fast execution
- Perfect for file operations and validation

### Why YAML Frontmatter?
- Machine-readable metadata
- Enables programmatic validation
- Doesn't interfere with human readability
- Standard in documentation tools (Jekyll, Hugo, etc.)

### Why Symlinks?
- OS-level feature (no tools needed)
- Transparent to applications
- Single source of truth enforced at filesystem level
- Works with any text editor

### Why Claude Code Hooks?
- Automatic context injection
- Zero user effort required
- Consistent across all conversations
- Configured once, works forever

---

## Scalability Considerations

### Adding New Projects
```bash
./add-project.sh new-project ~/path/to/new-project
# Automatically creates project file + symlink
```

### Adding New Terms
Edit TERM_DICTIONARY.md, add to appropriate category.

### Growing Documentation
- Quick reference stays under 600 lines (fast loading)
- Comprehensive guide can grow indefinitely
- Project files isolated (no cross-contamination)

### Multi-Developer Support
- Fork repository per developer
- Customize preferences while preserving structure
- Merge common patterns back to team repo

---

## Future Architecture Enhancements

### Potential Additions
1. **Export Tools**: Generate PDF documentation
2. **Search API**: REST endpoint for querying learnings
3. **Analytics**: Track which rules are most referenced
4. **IDE Integration**: Deep VS Code extension integration
5. **Collaboration**: Multi-developer coordination tools
6. **AI Fine-tuning**: Export for model fine-tuning

### Architectural Constraints
- **No external dependencies**: Must remain pure bash + markdown
- **Fast loading**: AI_QUICKSTART must stay under 600 lines
- **Zero manual work**: Automation via hooks is non-negotiable
- **Backward compatibility**: New versions must not break existing projects

---

**End of Architecture Documentation**
