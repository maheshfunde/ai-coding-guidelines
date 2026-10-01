#!/usr/bin/env bash
# Universal AI Skills Installer for macOS / Linux
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================================="
echo "       Universal AI Skills & Architecture Installer        "
echo "=========================================================="
echo "Compatible with: Antigravity, Claude Code, Cursor, Copilot, Windsurf"
echo ""

install_antigravity() {
    local dest="$HOME/.gemini/config/skills"
    mkdir -p "$dest"
    cp -r "$SCRIPT_DIR/skills/"* "$dest/"
    echo "✓ Installed for Antigravity globally: $dest"
}

install_claude() {
    local dest="$HOME/.claude/skills"
    mkdir -p "$dest"
    cp -r "$SCRIPT_DIR/skills/"* "$dest/"
    echo "✓ Installed for Claude Code globally: $dest"
}

install_workspace() {
    local target="${1:-$(pwd)}"
    echo "Configuring workspace at: $target"
    
    # Antigravity
    mkdir -p "$target/.agents/skills"
    cp -r "$SCRIPT_DIR/skills/"* "$target/.agents/skills/"
    
    # Cursor
    mkdir -p "$target/.cursor/rules"
    cp "$SCRIPT_DIR/.cursor/rules/"*.mdc "$target/.cursor/rules/" 2>/dev/null || true
    cp "$SCRIPT_DIR/.cursorrules" "$target/" 2>/dev/null || true
    
    # Claude
    cp "$SCRIPT_DIR/CLAUDE.md" "$target/" 2>/dev/null || true
    
    # GitHub Copilot
    mkdir -p "$target/.github"
    cp "$SCRIPT_DIR/.github/copilot-instructions.md" "$target/.github/" 2>/dev/null || true
    
    # Windsurf & Cline
    cp "$SCRIPT_DIR/.windsurfrules" "$target/" 2>/dev/null || true
    cp "$SCRIPT_DIR/.clinerules" "$target/" 2>/dev/null || true
    
    echo "✓ Workspace configured successfully for all AI assistants!"
}

echo "Select installation target:"
echo "  1) Antigravity IDE (Global ~/.gemini/config/skills)"
echo "  2) Claude Code (Global ~/.claude/skills)"
echo "  3) Current Project Workspace (Cursor, Claude, Copilot, Windsurf)"
echo "  4) Everything (Global + Project)"
echo "  q) Quit"
read -rp "Enter option [1-4]: " choice

case "$choice" in
    1) install_antigravity ;;
    2) install_claude ;;
    3) install_workspace ;;
    4)
        install_antigravity
        install_claude
        install_workspace
        ;;
    *) echo "Exiting without changes." ;;
esac
