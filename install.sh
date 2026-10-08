#!/usr/bin/env bash
# ==============================================================================
# INSTALL.SH - Universal One-Line Installer & Sync for DevOps Skills Suite (Mac/Linux)
# Run remotely: curl -fsSL https://raw.githubusercontent.com/Adebayo0001/my-devop-tools/main/install.sh | bash
# ==============================================================================

set -e

REPO_URL="${1:-https://github.com/Adebayo0001/my-devop-tools.git}"
INSTALL_DIR="${2:-$HOME/My-DevOp-Tools}"

echo "=========================================================="
echo " Master DevOps Skills Suite - Universal Installer (macOS/Linux)"
echo "=========================================================="

if [ -d "./skills" ]; then
    SOURCE_DIR="./skills"
else
    if ! command -v git &> /dev/null; then
        echo "Error: git is required. Please install git and retry."
        exit 1
    fi

    if [ ! -d "$INSTALL_DIR" ]; then
        echo "Cloning master DevOps tools into $INSTALL_DIR..."
        git clone "$REPO_URL" "$INSTALL_DIR"
    else
        echo "Updating existing clone in $INSTALL_DIR..."
        git -C "$INSTALL_DIR" pull --ff-only
    fi
    SOURCE_DIR="$INSTALL_DIR/skills"
fi

# Target IDE directories
GEMINI_DIR="$HOME/.gemini/config/skills"
CLAUDE_DIR="$HOME/.claude/skills"
CURSOR_DIR="$HOME/.cursor/rules"
WINDSURF_DIR="$HOME/.codeium/windsurf/skills"

for TARGET in "$GEMINI_DIR" "$CLAUDE_DIR" "$CURSOR_DIR" "$WINDSURF_DIR"; do
    mkdir -p "$TARGET"
    cp -R "$SOURCE_DIR"/* "$TARGET"/ 2>/dev/null || true
    echo " [OK] Synced -> $TARGET"
done

echo "=========================================================="
echo " All 9 skills successfully installed across your AI IDEs!"
echo "  1. /kickoff                  (Discovery, UX research, 4-tier context generator)"
echo "  2. /intake                   (Tier 4 codebase audit and live site redesign)"
echo "  3. /architect                (Spec-first blueprint, Atomic decomposition, APM)"
echo "  4. /imprint                  (Living UI registry compiler and token check)"
echo "  5. /review                   (QA, zero-trust security and observability gate)"
echo "  6. /recover                  (Circuit breaker on 1st failed bugfix)"
echo "  7. /remember                 (Cold session persistence to memory.md)"
echo "  8. /broadcast                (Proof-of-work 4 daily posts generator)"
echo "  9. adebayo-authority-engine  (Positioning, commercial offers and voice rules)"
echo "=========================================================="
