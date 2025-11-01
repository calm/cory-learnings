#!/bin/bash

# Cost Tracking Dashboard Launcher
# Starts the dashboard and opens it in the browser

set -e

DASHBOARD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORT=5000

echo "🚀 Starting Cost Tracking Dashboard..."
echo "   Directory: $DASHBOARD_DIR"
echo "   Port: $PORT"
echo ""

# Check if Node.js is available
if ! command -v node &> /dev/null; then
  echo "❌ Node.js not found. Please install Node.js."
  exit 1
fi

# Check if token usage log exists (create if missing)
TRACKER_FILE="${HOME}/.claude/token-usage.log"
if [ ! -f "$TRACKER_FILE" ]; then
  echo "📝 Creating token usage log: $TRACKER_FILE"
  mkdir -p "${HOME}/.claude"
  touch "$TRACKER_FILE"
fi

# Check if port is already in use
if lsof -Pi :${PORT} -sTCP:LISTEN -t >/dev/null 2>&1; then
  echo "⚠️  Port $PORT is already in use. Waiting for existing process..."
  sleep 1
fi

# Start the dashboard
echo "📊 Dashboard starting..."
cd "$DASHBOARD_DIR"

# Try to open in browser (macOS)
if command -v open &> /dev/null; then
  # Background the server and open browser
  (node cost-tracking-dashboard.js &) 2>/dev/null
  sleep 2
  open "http://localhost:${PORT}" 2>/dev/null || true
  # Keep server running in foreground
  wait
else
  # Just run the server
  node cost-tracking-dashboard.js
fi
