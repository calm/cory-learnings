#!/bin/bash
#
# add-project.sh - Add a new project to the central learnings repository
#
# Usage: ./add-project.sh <project-name> <project-path>
# Example: ./add-project.sh "my-new-app" "~/Desktop/projects/my-new-app"

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check arguments
if [ "$#" -ne 2 ]; then
    echo -e "${YELLOW}Usage: $0 <project-name> <project-path>${NC}"
    echo "Example: $0 my-new-app ~/Desktop/projects/my-new-app"
    exit 1
fi

PROJECT_NAME="$1"
PROJECT_PATH="$2"
CENTRAL_REPO="$HOME/cory-learnings"
LEARNINGS_FILE="${CENTRAL_REPO}/projects/${PROJECT_NAME}.md"
SYMLINK_TARGET="${PROJECT_PATH}/CORY_LEARNINGS.md"

echo -e "${BLUE}Adding project: ${PROJECT_NAME}${NC}"
echo ""

# Verify central repo exists
if [ ! -d "$CENTRAL_REPO" ]; then
    echo -e "${YELLOW}Error: Central learnings repo not found at ${CENTRAL_REPO}${NC}"
    exit 1
fi

# Verify project path exists
if [ ! -d "$PROJECT_PATH" ]; then
    echo -e "${YELLOW}Error: Project path not found: ${PROJECT_PATH}${NC}"
    exit 1
fi

# Create learnings file from template
if [ ! -f "$LEARNINGS_FILE" ]; then
    echo -e "${BLUE}Creating learnings file from template...${NC}"
    cp "${CENTRAL_REPO}/TEMPLATE_NEW_PROJECT.md" "$LEARNINGS_FILE"

    # Replace placeholders
    CURRENT_DATE=$(date +%Y-%m-%d)
    sed -i '' "s/\[PROJECT NAME\]/${PROJECT_NAME}/g" "$LEARNINGS_FILE"
    sed -i '' "s/\[DATE\]/${CURRENT_DATE}/g" "$LEARNINGS_FILE"

    echo -e "${GREEN}✓ Created ${LEARNINGS_FILE}${NC}"
else
    echo -e "${YELLOW}Warning: Learnings file already exists: ${LEARNINGS_FILE}${NC}"
fi

# Create symlink
if [ -L "$SYMLINK_TARGET" ] || [ -f "$SYMLINK_TARGET" ]; then
    echo -e "${YELLOW}Warning: File or symlink already exists: ${SYMLINK_TARGET}${NC}"
    read -p "Overwrite? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -f "$SYMLINK_TARGET"
    else
        echo "Skipping symlink creation"
        exit 0
    fi
fi

ln -s "$LEARNINGS_FILE" "$SYMLINK_TARGET"
echo -e "${GREEN}✓ Created symlink: ${SYMLINK_TARGET} -> ${LEARNINGS_FILE}${NC}"

# Create CLAUDE_INSTRUCTIONS.md in project
CLAUDE_INSTRUCTIONS="${PROJECT_PATH}/CLAUDE_INSTRUCTIONS.md"
if [ ! -f "$CLAUDE_INSTRUCTIONS" ]; then
    cat > "$CLAUDE_INSTRUCTIONS" << 'EOF'
# Instructions for Claude Code

## Before Starting Work

**IMPORTANT**: Read Cory's learnings before starting any work session:

```bash
# Read master learnings (universal preferences)
cat ~/cory-learnings/MASTER_LEARNINGS.md

# Read project-specific learnings
cat CORY_LEARNINGS.md
```

## Core Working Principles

1. **"Do this yourself"** - Complete implementations, no TODOs
2. **"Be critical and continue"** - Autonomous quality mindset, honest assessment
3. **"Test all and make sure ok"** - Comprehensive testing, zero failing tests
4. **"Do next todo"** - Keep momentum, handle blockers gracefully

## Communication Style

- Cory says **"do it"** → Full approval, proceed with implementation
- Cory says **"be critical"** → Wants honest assessment, not sugar-coating
- Cory says **"continue"** / **"keep going"** → Trust your direction, keep working
- Cory says **"do next todo"** → Work autonomously, use judgment on priorities

## What to Avoid

- ❌ Asking for permission repeatedly
- ❌ Leaving TODOs in code
- ❌ Over-explaining every decision
- ❌ Analysis paralysis
- ❌ Hiding broken things

## What Cory Values

- ✅ Complete implementations (no placeholders)
- ✅ Comprehensive testing (all tests passing)
- ✅ Structured logging (not console.log)
- ✅ Type safety (strict TypeScript)
- ✅ Autonomous execution with trust
- ✅ Graceful degradation

## After Each Session

Update the learnings file with:
- New preferences discovered
- Decisions made and rationale
- Patterns that worked well
- Issues found and solutions

```bash
cd ~/cory-learnings
git add .
git commit -m "docs: update [project] learnings"
git push
```

## Resources

- [Master Learnings](~/cory-learnings/MASTER_LEARNINGS.md) - Universal preferences
- [CORY_LEARNINGS.md](CORY_LEARNINGS.md) - Project-specific context
- [Central Repo](~/cory-learnings) - All learnings centralized

---

*Remember: "be critical and continue" + "do this yourself" + "test all and make sure ok"*
EOF
    echo -e "${GREEN}✓ Created ${CLAUDE_INSTRUCTIONS}${NC}"
else
    echo -e "${YELLOW}CLAUDE_INSTRUCTIONS.md already exists in project${NC}"
fi

# Commit to central repo
cd "$CENTRAL_REPO"
git add "$LEARNINGS_FILE"
git commit -m "docs: add learnings file for ${PROJECT_NAME}" 2>/dev/null || true

echo ""
echo -e "${GREEN}✓ Successfully added ${PROJECT_NAME} to central learnings!${NC}"
echo ""
echo "Next steps:"
echo "1. Edit the learnings file: ${LEARNINGS_FILE}"
echo "2. Fill in project-specific details"
echo "3. Start working on the project with Claude Code"
echo "4. Claude will read CLAUDE_INSTRUCTIONS.md and CORY_LEARNINGS.md"
echo ""
