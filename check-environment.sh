#!/bin/bash
# check-environment.sh
# Validates that all required dependencies are installed for slack-morning-greeter

set -e

echo "🔍 Checking slack-morning-greeter Environment..."
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0

# Check required binaries
echo "=== Checking Required Binaries ==="

check_binary() {
    local cmd=$1
    local install_hint=$2
    if command -v "$cmd" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $cmd is installed"
    else
        echo -e "${RED}✗${NC} $cmd is NOT installed"
        echo "  Install: $install_hint"
        ERRORS=$((ERRORS + 1))
    fi
}

check_binary "bash" "Usually pre-installed on Unix systems"
check_binary "python3" "apt install python3 or brew install python3"
check_binary "date" "Usually pre-installed on Unix systems"
check_binary "jq" "apt install jq or brew install jq"

echo ""
echo "=== Checking Environment Variables ==="

check_env() {
    local var=$1
    if [ -z "${!var}" ]; then
        echo -e "${RED}✗${NC} $var is NOT set"
        ERRORS=$((ERRORS + 1))
    else
        # Mask sensitive values
        if [[ $var == *"KEY"* ]] || [[ $var == *"TOKEN"* ]]; then
            echo -e "${GREEN}✓${NC} $var is set (value: ${!var:0:8}...)"
        else
            echo -e "${GREEN}✓${NC} $var is set (value: ${!var})"
        fi
    fi
}

check_env "SLACK_BOT_TOKEN"
check_env "SLACK_CHANNEL"

echo ""
echo "=== Checking OpenClaw Installation ==="

if command -v openclaw &> /dev/null; then
    echo -e "${GREEN}✓${NC} openclaw CLI is installed"
    OPENCLAW_VERSION=$(openclaw --version 2>&1 | head -1 || echo "unknown")
    echo "  Version: $OPENCLAW_VERSION"
else
    echo -e "${YELLOW}⚠${NC} openclaw CLI not found in PATH"
    echo "  This is expected if running inside OpenClaw instance"
fi

echo ""
echo "=== Checking Database (Optional) ==="

if [ -n "$PG_CONNECTION_STRING" ]; then
    echo -e "${GREEN}✓${NC} PG_CONNECTION_STRING is set"
    echo "  Database tracking enabled"
else
    echo -e "${YELLOW}⚠${NC} PG_CONNECTION_STRING not set"
    echo "  Agent will run without database tracking"
fi

echo ""
echo "=== Summary ==="

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✅ All checks passed!${NC}"
    echo ""
    echo "Your environment is ready for slack-morning-greeter."
    exit 0
else
    echo -e "${RED}❌ $ERRORS check(s) failed${NC}"
    echo ""
    echo "Please fix the issues above before deploying."
    exit 1
fi
