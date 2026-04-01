#!/usr/bin/env bash
set -euo pipefail

# Log Writer — records greeting delivery to database

# Environment checks
: "${PG_CONNECTION_STRING:?ERROR: PG_CONNECTION_STRING not set}"
: "${RUN_ID:?ERROR: RUN_ID not set}"
: "${PROJECT_ROOT:?ERROR: PROJECT_ROOT not set}"

# File paths
INPUT_FILE="/tmp/slack-sender_${RUN_ID}.json"

# Validate input
[ -s "${INPUT_FILE}" ] || { echo "ERROR: Input file missing or empty: ${INPUT_FILE}"; exit 1; }

# Extract data
STATUS=$(jq -r '.status' "${INPUT_FILE}")
CHANNEL=$(jq -r '.channel' "${INPUT_FILE}")
MESSAGE=$(jq -r '.message' "${INPUT_FILE}")
SENT_AT=$(jq -r '.timestamp' "${INPUT_FILE}")
DATE_KEY=$(date -u +"%Y-%m-%d")

# Build record JSON
RECORD=$(cat <<EOF
[{
  "date_key": "${DATE_KEY}",
  "channel": "${CHANNEL}",
  "message_content": ${MESSAGE},
  "sent_at": "${SENT_AT}",
  "status": "${STATUS}"
}]
EOF
)

# Write to database
python3 "${PROJECT_ROOT}/scripts/data_writer.py" write \
  --table result_greeting_log \
  --conflict "date_key" \
  --run-id "${RUN_ID}" \
  --records "${RECORD}"

echo "✓ Greeting log written to database"
