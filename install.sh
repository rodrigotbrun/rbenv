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
    INSTALLER="$RB_HOME/install-macos.sh"
    echo "Detected macOS"
    ;;
Linux)
    INSTALLER="$RB_HOME/install-linux.sh"
    echo "Detected Linux"
    ;;
*)
    echo "Unsupported OS: $OS"
    echo "Supported: macOS (Darwin), Linux"
    exit 1
    ;;
esac

if [[ ! -f "$INSTALLER" ]]; then
    echo "ERROR: installer not found: $INSTALLER"
    exit 1
fi

# Run without exec so a broken installer can't silently become an interactive shell
bash "$INSTALLER" "$@"
