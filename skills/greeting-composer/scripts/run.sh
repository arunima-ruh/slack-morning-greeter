#!/usr/bin/env bash
set -euo pipefail

# Greeting Composer — generates morning greeting message

# File paths
OUTPUT_FILE="/tmp/greeting-composer_${RUN_ID}.json"

# Generate greeting message
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%S%z")
MESSAGE="Good morning! ☀️"

# Write output
cat > "${OUTPUT_FILE}" <<EOF
{
  "message": "${MESSAGE}",
  "channel": "${SLACK_CHANNEL}",
  "timestamp": "${TIMESTAMP}"
}
EOF

# Validate output
[ -s "${OUTPUT_FILE}" ] || { echo "ERROR: Output file is empty"; exit 1; }

echo "✓ Greeting message generated: ${OUTPUT_FILE}"
