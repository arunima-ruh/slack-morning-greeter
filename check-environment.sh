#!/usr/bin/env bash
set -euo pipefail

echo "Checking environment for Slack Morning Greeter..."
echo ""

ERRORS=0

# Check required binaries
for cmd in python3 bash date; do
  if ! command -v $cmd &> /dev/null; then
    echo "❌ Missing binary: $cmd"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅ Found: $cmd"
  fi
done

echo ""

# Check required environment variables
for var in SLACK_BOT_TOKEN SLACK_USER_ID; do
  if [ -z "${!var:-}" ]; then
    echo "❌ Missing required env var: $var"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅ Set: $var"
  fi
done

echo ""

# Check optional database variables
for var in PG_CONNECTION_STRING ORG_ID AGENT_ID; do
  if [ -z "${!var:-}" ]; then
    echo "⚠️  Optional env var not set: $var (agent will work without database)"
  else
    echo "✅ Set: $var"
  fi
done

echo ""

if [ $ERRORS -eq 0 ]; then
  echo "✅ Environment check passed!"
  exit 0
else
  echo "❌ Environment check failed with $ERRORS errors"
  exit 1
fi
