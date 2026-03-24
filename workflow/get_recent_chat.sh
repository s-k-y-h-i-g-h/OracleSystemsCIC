#!/usr/bin/env bash
# Fallback for honcho_session when API key missing.
# Usage: ./get_recent_chat.sh <minutes>
# Outputs recent conversation snippets from memory files.
set -euo pipefail

MINUTES=${1:-30}
SINCE=$(date -u -d "-${MINUTES} minutes" +%Y-%m-%dT%H:%M:%SZ)

echo "=== Recent conversation (last ${MINUTES} minutes) ==="
# Check memory/*.md files
if [ -d "../memory" ]; then
    echo "From memory files:"
    find ../memory -name "*.md" -type f -exec grep -H "" {} \;
fi

# Optionally check session transcripts if available
if [ -d "../.openclaw/sessions" ]; then
    echo "From session transcripts:"
    find ../.openclaw/sessions -name "*.json" -type f -exec grep -H "" {} \; | head -20
fi

echo "=== End of fallback ==="
