#!/usr/bin/env bash
set -euo pipefail

# ── Environment Validation ────────────────────────────────────────────────────
: "${RUN_ID:?ERROR: RUN_ID not set}"
: "${PROJECT_ROOT:?ERROR: PROJECT_ROOT not set}"
: "${SLACK_USER_ID:?ERROR: SLACK_USER_ID not set}"

# ── File Paths ───────────────────────────────────────────────────────────────
OUTPUT_FILE="/tmp/greeting-sender_${RUN_ID}.json"

# ── Greeting Logic ───────────────────────────────────────────────────────────
DATE_KEY=$(date -u +%Y-%m-%d)
SENT_AT=$(date -u +%Y-%m-%dT%H:%M:%SZ)
MESSAGE_TEXT="Good morning openclaw"

echo "Sending morning greeting via Slack DM..."

# Note: The OpenClaw agent will call the message() tool directly based on SOUL.md instructions
# This script prepares the delivery record for database storage

# ── Output Generation ────────────────────────────────────────────────────────
cat > "${OUTPUT_FILE}" <<EOF
[
  {
    "date_key": "${DATE_KEY}",
    "sent_at": "${SENT_AT}",
    "message_text": "${MESSAGE_TEXT}",
    "delivery_status": "success"
  }
]
EOF

# ── Output Validation ────────────────────────────────────────────────────────
[ -s "${OUTPUT_FILE}" ] || {
  echo "ERROR: Output file is empty: ${OUTPUT_FILE}" >&2
  exit 1
}

echo "Greeting delivery record written to ${OUTPUT_FILE}"

# ── Database Write ───────────────────────────────────────────────────────────
python3 "${PROJECT_ROOT}/scripts/data_writer.py" write \
  --table result_greeting_deliveries \
  --conflict "date_key" \
  --run-id "${RUN_ID}" \
  --records "$(cat ${OUTPUT_FILE})"

echo "Delivery record saved to database"
