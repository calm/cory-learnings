#!/bin/bash
# Quick access to common search patterns

LEARNINGS_DIR="$HOME/cory-learnings"

show_menu() {
    echo "==================================="
    echo "Quick Find - Common Searches"
    echo "==================================="
    echo ""
    echo "1. Todo list guidelines"
    echo "2. Testing requirements"
    echo "3. Communication style"
    echo "4. Code quality standards"
    echo "5. When to ask for help"
    echo "6. Autonomous execution"
    echo "7. Project-specific notes"
    echo "8. Common pitfalls"
    echo "9. Search custom term"
    echo "0. Exit"
    echo ""
    echo -n "Select option (0-9): "
}

search_pattern() {
    local PATTERN="$1"
    local TITLE="$2"

    echo ""
    echo "==================================="
    echo "$TITLE"
    echo "==================================="
    echo ""

    cd "$LEARNINGS_DIR"
    grep -n -i -C 3 "$PATTERN" AI_QUICKSTART.md MASTER_LEARNINGS.md 2>/dev/null | head -40

    echo ""
    echo "Press Enter to continue..."
    read
}

# Main loop
while true; do
    clear
    show_menu
    read CHOICE

    case $CHOICE in
        1)
            search_pattern "todo list\|TodoWrite" "Todo List Guidelines"
            ;;
        2)
            search_pattern "testing\|test coverage" "Testing Requirements"
            ;;
        3)
            search_pattern "communication style\|how cory" "Communication Style"
            ;;
        4)
            search_pattern "code quality\|quality standards" "Code Quality Standards"
            ;;
        5)
            search_pattern "when to ask\|always ask" "When to Ask for Help"
            ;;
        6)
            search_pattern "autonomous\|do it yourself" "Autonomous Execution"
            ;;
        7)
            cd "$LEARNINGS_DIR"
            echo ""
            echo "==================================="
            echo "Project Files"
            echo "==================================="
            echo ""
            ls -lh projects/*.md
            echo ""
            echo "Enter project name to view (or press Enter to skip): "
            read PROJECT
            if [ -n "$PROJECT" ]; then
                if [ -f "projects/$PROJECT.md" ]; then
                    less "projects/$PROJECT.md"
                else
                    echo "Project file not found: projects/$PROJECT.md"
                    sleep 2
                fi
            fi
            ;;
        8)
            search_pattern "pitfall\|anti-pattern\|avoid" "Common Pitfalls"
            ;;
        9)
            echo ""
            echo "Enter search term: "
            read CUSTOM_TERM
            if [ -n "$CUSTOM_TERM" ]; then
                search_pattern "$CUSTOM_TERM" "Search Results: $CUSTOM_TERM"
            fi
            ;;
        0)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Press Enter to continue..."
            read
            ;;
    esac
done
