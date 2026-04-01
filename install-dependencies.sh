#!/usr/bin/env bash
set -euo pipefail

echo "Installing dependencies for Slack Morning Greeter..."
echo ""

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
  echo "❌ python3 not found. Please install Python 3.8 or later."
  exit 1
fi

# Install Python packages
echo "Installing Python dependencies..."
python3 -m pip install -r requirements.txt

echo ""
echo "✅ Dependencies installed successfully!"
echo ""
echo "Next steps:"
echo "1. Copy .env.example to .env"
echo "2. Fill in your SLACK_BOT_TOKEN and SLACK_USER_ID"
echo "3. Run: ./check-environment.sh"
