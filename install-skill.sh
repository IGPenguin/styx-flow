#!/bin/bash
# Installs the Styx Flow /styx skill into Claude Code.

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
STYX_CONFIG="$HOME/.claude/styx"

echo "🌊 Installing Styx Flow..."

# 1. Register the GitHub repo as a marketplace (idempotent)
if claude plugins marketplace list 2>/dev/null | grep -q "styx-flow"; then
    claude plugins marketplace update styx-flow 2>/dev/null || true
else
    claude plugins marketplace add IGPenguin/styx-flow --scope user
fi

# 2. Install (or update) the styx plugin
if claude plugins list 2>/dev/null | grep -q "styx@styx-flow"; then
    claude plugins update styx@styx-flow 2>/dev/null || true
else
    claude plugins install styx@styx-flow --scope user
fi

# 3. Copy user-editable config files
mkdir -p "$STYX_CONFIG"
cp "$REPO_DIR/.styx/papyrus.md" "$STYX_CONFIG/papyrus.md"
cp "$REPO_DIR/.styx/manifesto.md" "$STYX_CONFIG/manifesto.md"

echo "✨ Done. Restart Claude Code, then type /styx in any project."
