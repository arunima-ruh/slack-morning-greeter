#!/bin/bash
# install-dependencies.sh
# Installs required dependencies for slack-morning-greeter

set -e

echo "📦 Installing slack-morning-greeter Dependencies..."
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if running with sudo (for system packages)
if [ "$EUID" -eq 0 ]; then 
    SUDO=""
else
    SUDO="sudo"
fi

echo "=== System Package Dependencies ==="

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    OS=$(uname -s)
fi

echo "Detected OS: $OS"
echo ""

# Install system packages based on OS
case $OS in
    ubuntu|debian)
        echo "Installing via apt-get..."
        $SUDO apt-get update
        $SUDO apt-get install -y python3 python3-pip jq
        echo -e "${GREEN}✓${NC} System packages installed"
        ;;
    
    centos|rhel|fedora)
        echo "Installing via yum..."
        $SUDO yum install -y python3 python3-pip jq
        echo -e "${GREEN}✓${NC} System packages installed"
        ;;
    
    darwin|Darwin)
        echo "Installing via brew (macOS)..."
        if ! command -v brew &> /dev/null; then
            echo -e "${RED}✗${NC} Homebrew not found. Install from https://brew.sh"
            exit 1
        fi
        brew install python3 jq
        echo -e "${GREEN}✓${NC} System packages installed"
        ;;
    
    *)
        echo -e "${YELLOW}⚠${NC} Unknown OS: $OS"
        echo "Please install manually: python3 python3-pip jq"
        ;;
esac

echo ""
echo "=== Python Dependencies ==="

if [ -f requirements.txt ]; then
    echo "Installing from requirements.txt..."
    pip3 install -r requirements.txt
    echo -e "${GREEN}✓${NC} Python packages installed"
else
    echo -e "${YELLOW}⚠${NC} requirements.txt not found, skipping"
fi

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Next steps:"
echo "1. Copy .env.example to .env and fill in your credentials"
echo "2. Run: ./check-environment.sh"
echo "3. Test: openclaw workflow run workflows/main.yaml"
echo ""
echo "See README.md for full deployment guide."
