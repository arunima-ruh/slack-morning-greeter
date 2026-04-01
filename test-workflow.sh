#!/usr/bin/env bash
set -euo pipefail

echo "Testing Slack Morning Greeter workflow..."
echo ""

# Source environment
if [ -f .env ]; then
  set -a
  source .env
  set +a
else
  echo "❌ .env file not found. Copy .env.example to .env and configure."
  exit 1
fi

# Set runtime variables
export PROJECT_ROOT=$(pwd)
export RUN_ID=$(uuidgen || echo "test-run-$(date +%s)")

echo "PROJECT_ROOT: $PROJECT_ROOT"
echo "RUN_ID: $RUN_ID"
echo ""

# Test data writer provision
echo "1. Provisioning database schema..."
if [ -n "${PG_CONNECTION_STRING:-}" ]; then
  python3 scripts/data_writer.py provision
  echo "✅ Schema provisioned"
else
  echo "⚠️  Skipping database provision (PG_CONNECTION_STRING not set)"
fi

echo ""

# Test greeting sender skill
echo "2. Testing greeting-sender skill..."
bash workspace/skills/greeting-sender/scripts/run.sh
echo "✅ Greeting sender executed"

echo ""

# Query results
echo "3. Querying delivery history..."
if [ -n "${PG_CONNECTION_STRING:-}" ]; then
  python3 scripts/data_writer.py query \
    --table result_greeting_deliveries \
    --order-by "sent_at DESC" \
    --limit 5
  echo "✅ Query executed"
else
  echo "⚠️  Skipping query (PG_CONNECTION_STRING not set)"
fi

echo ""
echo "✅ Workflow test complete!"
echo ""
echo "Note: This test runs the workflow logic but does NOT send the actual Slack message."
echo "To test Slack delivery, run the agent via OpenClaw with message() tool enabled."
