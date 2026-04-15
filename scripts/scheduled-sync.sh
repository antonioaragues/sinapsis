#!/usr/bin/env bash
# Scheduled sync — runs `update everything` non-interactively.
# Designed to be invoked by cron or launchd, weekdays at 22:00.

set -euo pipefail

SINAPSIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="$SINAPSIS_DIR/.sync-logs"
mkdir -p "$LOG_DIR"

DATE=$(date +%Y-%m-%d)
LOG_FILE="$LOG_DIR/sync-$DATE.log"

cd "$SINAPSIS_DIR"

# Use Claude Code in non-interactive mode. Auto-accepts edits within the project.
# If you prefer Gemini, replace `claude` with `gemini` and adjust flags accordingly.
{
  echo "=== Sinapsis scheduled sync — $(date) ==="
  claude -p "/update" --permission-mode acceptEdits
  echo "=== Done — $(date) ==="
} >> "$LOG_FILE" 2>&1

# Auto-commit any wiki changes
if [[ -n "$(git status --porcelain)" ]]; then
  git add -A
  git commit -m "Scheduled sync: $DATE" >> "$LOG_FILE" 2>&1
  git push >> "$LOG_FILE" 2>&1 || true
fi
