#!/usr/bin/env bash
# Install the scheduled sync as a macOS launchd job.
# Runs scheduled-sync.sh weekdays (Mon-Fri) at 22:00.

set -euo pipefail

SINAPSIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLIST_SRC="$SINAPSIS_DIR/scripts/com.sinapsis.scheduled-sync.plist"
PLIST_DST="$HOME/Library/LaunchAgents/com.sinapsis.scheduled-sync.plist"

if [[ ! -f "$PLIST_SRC" ]]; then
  echo "Error: $PLIST_SRC not found"
  exit 1
fi

mkdir -p "$HOME/Library/LaunchAgents"

# If already loaded, unload first
if launchctl list | grep -q "com.sinapsis.scheduled-sync"; then
  echo "Unloading existing job…"
  launchctl unload "$PLIST_DST" 2>/dev/null || true
fi

cp "$PLIST_SRC" "$PLIST_DST"
launchctl load "$PLIST_DST"

echo "Installed. Sinapsis will sync weekdays at 22:00."
echo "Logs: $SINAPSIS_DIR/.sync-logs/"
echo ""
echo "To run immediately:  launchctl start com.sinapsis.scheduled-sync"
echo "To uninstall:        launchctl unload $PLIST_DST && rm $PLIST_DST"
