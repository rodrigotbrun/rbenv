#!/bin/bash

set -euo pipefail

# ============================================================
# Brun Environment Installer
# Detects OS and delegates to the platform-specific installer.
# Clone this repo to ~/.brun and run: bash ./install.sh
# ============================================================

export RB_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

EXPECTED_HOME="$HOME/.brun"

echo ""
echo "============================================================"
echo " Brun Environment Installer"
echo "============================================================"
echo ""
echo "RB_HOME: $RB_HOME"

if [[ "$RB_HOME" != "$EXPECTED_HOME" ]]; then
    echo ""
    echo "WARNING: Expected repo at $EXPECTED_HOME"
    echo "         Currently running from $RB_HOME"
    echo "         rbrc.sh will still use ~/.brun — clone/move there if needed."
    echo ""
fi

OS="$(uname -s)"

case "$OS" in
Darwin)
    echo "Detected macOS"
    exec bash "$RB_HOME/install-macos.sh" "$@"
    ;;
Linux)
    echo "Detected Linux"
    if [[ ! -f "$RB_HOME/install-linux.sh" ]]; then
        echo "ERROR: install-linux.sh not found at $RB_HOME"
        exit 1
    fi
    exec bash "$RB_HOME/install-linux.sh" "$@"
    ;;
*)
    echo "Unsupported OS: $OS"
    echo "Supported: macOS (Darwin), Linux"
    exit 1
    ;;
esac
