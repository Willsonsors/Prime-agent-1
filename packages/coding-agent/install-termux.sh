#!/bin/bash
# Prime Agent - Termux Automatic Installation Script
# One-stop setup for Android + Termux
# Usage: bash install-termux.sh

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log() {
  echo -e "${BLUE}▶${NC} $1"
}

success() {
  echo -e "${GREEN}✓${NC} $1"
}

error() {
  echo -e "${RED}✗${NC} $1"
  exit 1
}

warning() {
  echo -e "${YELLOW}!${NC} $1"
}

# Header
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Prime Agent - Termux Installer${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""

# Step 1: Check if running in Termux
log "Checking environment..."
if [ -d "/data/data/com.termux/files" ]; then
  success "Running in Termux"
else
  warning "Not running in Termux. Install Termux from GitHub or F-Droid first."
  echo "  📱 GitHub: https://github.com/termux/termux-app"
  echo "  📱 F-Droid: https://f-droid.org/packages/com.termux"
fi

# Step 2: Update packages
log "Updating package manager..."
pkg update -y || error "Failed to update packages"
pkg upgrade -y || error "Failed to upgrade packages"
success "Packages updated"

# Step 3: Install dependencies
log "Installing dependencies..."
dependencies="nodejs termux-api git ripgrep"
for dep in $dependencies; do
  log "  Installing $dep..."
  pkg install -y "$dep" || error "Failed to install $dep"
done
success "Dependencies installed"

# Step 4: Verify Node.js
log "Verifying Node.js..."
node_version=$(node --version 2>/dev/null)
if [ -z "$node_version" ]; then
  error "Node.js not found after installation"
fi
success "Node.js $node_version installed"

# Step 5: Setup storage permissions (optional, but recommended)
log "Setting up storage permissions..."
if [ ! -d "$HOME/storage" ]; then
  log "  Running termux-setup-storage..."
  termux-setup-storage 2>/dev/null || warning "Could not auto-setup storage - you may need to run termux-setup-storage manually"
  success "Storage setup attempted"
else
  success "Storage already configured"
fi

# Step 6: Clone Prime Agent
log "Cloning Prime Agent repository..."
if [ -d "prime-agent" ]; then
  warning "prime-agent directory already exists. Skipping clone."
else
  git clone https://github.com/PrimeIntellect-ai/prime-agent.git || error "Failed to clone repository"
  success "Repository cloned"
fi

cd prime-agent || error "Failed to change to prime-agent directory"

# Step 7: Install npm dependencies
log "Installing npm dependencies..."
npm ci || error "Failed to install npm dependencies"
success "npm dependencies installed"

# Step 8: Create default AGENTS.md if it doesn't exist
log "Creating Termux environment config..."
agents_dir="$HOME/.prime/agent"
if [ ! -d "$agents_dir" ]; then
  mkdir -p "$agents_dir"
fi

if [ ! -f "$agents_dir/AGENTS.md" ]; then
  cat > "$agents_dir/AGENTS.md" << 'EOF'
# Agent Environment: Termux on Android

## Device Info
- OS: Android (Termux)
- Home: /data/data/com.termux/files/home
- Shared Storage: /storage/emulated/0

## Key Limitations
- Text clipboard only (no image paste)
- Storage access may require termux-setup-storage

## Useful Commands
- Copy: termux-clipboard-set "text"
- Paste: termux-clipboard-get
- Open URL: termux-open-url "https://..."
- Open file: termux-open file.pdf

## Notes
- Keep responses concise on mobile
- Use sessions to save work (/resume, /new)
- Sessions auto-save to ~/.prime/agent/sessions/
EOF
  success "AGENTS.md created at $agents_dir/AGENTS.md"
else
  success "AGENTS.md already exists"
fi

# Step 9: Verify Termux:API (if available)
log "Checking Termux:API..."
if command -v termux-clipboard-get &> /dev/null; then
  success "Termux:API tools available"
else
  warning "Termux:API tools not found"
  echo "  Install Termux:API app from GitHub or F-Droid:"
  echo "  📱 GitHub: https://github.com/termux/termux-api"
  echo "  Then run: pkg install termux-api"
fi

# Step 10: Final summary
echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  Installation Complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo ""
log "Next steps:"
echo ""
echo "  1. Authenticate with a provider:"
echo "     ${BLUE}./prime-agent.sh${NC}"
echo "     Then run: ${BLUE}/login${NC}"
echo ""
echo "  2. Try a first prompt:"
echo "     ${BLUE}Summarize this repo and tell me how to run checks${NC}"
echo ""
echo "  3. Save your session:"
echo "     ${BLUE}prime-agent -c${NC}  (continue last session)"
echo ""
echo "  4. Find help:"
echo "     📖 Docs: https://github.com/Willsonsors/prime-agent/tree/main/packages/coding-agent/docs"
echo "     📖 Troubleshooting: ${BLUE}termux.md${NC} in docs"
echo ""
echo "  🚀 Start now:"
echo "     ${BLUE}./prime-agent.sh${NC}"
echo ""
