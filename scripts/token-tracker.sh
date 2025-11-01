#!/usr/bin/env bash
# Token usage tracker - log and analyze token spend

set -e

TRACKER_FILE="${HOME}/.claude/token-usage.log"
TODAY=$(date +%Y-%m-%d)

# Initialize log file if needed
if [ ! -f "$TRACKER_FILE" ]; then
  touch "$TRACKER_FILE"
fi

# Function: Log token usage
log_tokens() {
  local project="$1"
  local task="$2"
  local tokens="$3"
  local cost=$(echo "scale=2; $tokens * 0.0026 / 1000" | bc)  # Approx cost

  echo "$(date '+%Y-%m-%d %H:%M:%S') | $project | $task | $tokens tokens | \$$cost" >> "$TRACKER_FILE"
}

# Function: Show today's usage
show_today() {
  echo "=== Token Usage - $TODAY ==="
  grep "$TODAY" "$TRACKER_FILE" | awk -F'|' '{
    print $2 " | " $3 " | " $4 " | " $5
    total += $(echo $4 | sed "s/ tokens//")
  } END {
    print "---"
    print "Total: " total " tokens"
  }'
}

# Function: Show by project
show_by_project() {
  echo "=== Token Usage by Project - $TODAY ==="
  grep "$TODAY" "$TRACKER_FILE" | awk -F'|' '{
    project = $2
    tokens = $(echo $4 | sed "s/ tokens//")
    total[project] += tokens
  } END {
    for (p in total) {
      printf "%s: %d tokens\n", p, total[p]
    }
  }' | sort -k2 -rn
}

# Function: Estimate cost
show_cost() {
  local tokens="${1:-170000}"  # Default to today's usage
  local input_cost=$(echo "scale=4; $tokens * 0.0008 / 1000" | bc)
  local output_cost=$(echo "scale=4; $tokens * 0.0024 / 1000" | bc)
  local total=$(echo "scale=2; $input_cost + $output_cost" | bc)

  echo "Estimated cost for $tokens tokens:"
  echo "  Input (1/3): \$$input_cost"
  echo "  Output (2/3): \$$output_cost"
  echo "  Total: \$$total"
}

# Main
case "${1:-show}" in
  log)
    if [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
      echo "Usage: $0 log <project> <task> <tokens>"
      exit 1
    fi
    log_tokens "$2" "$3" "$4"
    echo "✓ Logged: $2 | $3 | $4 tokens"
    ;;
  today)
    show_today
    ;;
  project)
    show_by_project
    ;;
  cost)
    show_cost "${2:-170000}"
    ;;
  *)
    echo "Usage: $0 [log|today|project|cost]"
    echo "  log <project> <task> <tokens>  - Log token usage"
    echo "  today                          - Show today's usage"
    echo "  project                        - Show by project"
    echo "  cost [tokens]                  - Estimate cost"
    exit 1
    ;;
esac
