#!/bin/bash
# Search across all learnings files with context

LEARNINGS_DIR="$HOME/cory-learnings"

if [ -z "$1" ]; then
    echo "Usage: $0 <search_term> [--all]"
    echo ""
    echo "Examples:"
    echo "  $0 'todo list'           # Search in main files only"
    echo "  $0 'testing' --all       # Search in all files including projects"
    echo "  $0 'autonomous'          # Case-insensitive by default"
    exit 1
fi

SEARCH_TERM="$1"
SEARCH_ALL="${2:-}"

echo "==================================="
echo "Searching for: $SEARCH_TERM"
echo "==================================="
echo ""

cd "$LEARNINGS_DIR"

if [ "$SEARCH_ALL" = "--all" ]; then
    # Search all markdown files
    echo "Searching in all files..."
    echo ""
    grep -n -i -C 2 "$SEARCH_TERM" *.md projects/*.md 2>/dev/null | head -50
else
    # Search only main files (not project-specific)
    echo "Searching in main files (use --all for project files)..."
    echo ""
    grep -n -i -C 2 "$SEARCH_TERM" README.md AI_QUICKSTART.md MASTER_LEARNINGS.md EXAMPLES.md 2>/dev/null | head -50
fi

TOTAL_MATCHES=$(grep -r -i "$SEARCH_TERM" . --include="*.md" 2>/dev/null | wc -l | tr -d ' ')

echo ""
echo "==================================="
echo "Found $TOTAL_MATCHES total matches across repository"
echo "==================================="
