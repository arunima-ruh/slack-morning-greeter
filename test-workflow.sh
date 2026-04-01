#!/bin/bash
# test-workflow.sh
# Runs the slack-morning-greeter workflow for local testing

set -e

echo "🧪 Testing slack-morning-greeter Workflow..."
echo ""

# Load environment
if [ -f .env ]; then
    echo "Loading .env file..."
    export $(grep -v '^#' .env | xargs)
    echo "✓ Environment loaded"
else
    echo "⚠ No .env file found. Using system environment."
fi

# Set PROJECT_ROOT for data_writer.py
export PROJECT_ROOT=$(pwd)

# Generate run ID
export RUN_ID=$(date +%s)-test

echo ""
echo "=== Test Configuration ==="
echo "RUN_ID: $RUN_ID"
echo "PROJECT_ROOT: $PROJECT_ROOT"
echo "SLACK_CHANNEL: ${SLACK_CHANNEL:-not set}"
echo ""

# Run workflow
echo "=== Running Workflow ==="
openclaw workflow run workflows/main.yaml

echo ""
echo "✅ Workflow test complete!"
echo ""
echo "Check results:"
echo "- /tmp/greeting-composer_${RUN_ID}.json"
echo "- Database: result_greeting_log table"
