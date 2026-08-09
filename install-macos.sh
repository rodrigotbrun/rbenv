#!/bin/bash

set -euo pipefail

# ============================================================
# Mac Developer Machine Bootstrap
#
# Fail-fast with checkpoint resume:
#   - Completed steps are recorded in $RB_HOME/.install-state
#   - Re-run ./install.sh to continue after a failure
#   - Delete .install-state (or set INSTALL_RESET=1) to redo all steps
# ============================================================

export RB_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

STATE_FILE="${RB_HOME}/.install-state"
BACKUP_DIR="${RB_HOME}/.install-backups"
CURRENT_STEP=""

mkdir -p "$BACKUP_DIR"
touch "$STATE_FILE"

if [[ "${INSTALL_RESET:-}" == "1" ]]; then
    echo "INSTALL_RESET=1 — clearing install checkpoints"
    : >"$STATE_FILE"
fi

echo ""
echo "============================================================"
echo " Mac Developer Machine Bootstrap"
echo "============================================================"
echo ""
echo "Checkpoints: $STATE_FILE"
echo "Backups:     $BACKUP_DIR"
echo ""

# ============================================================
# Helpers
# ============================================================

log() {
    echo ""
    echo "==> $1"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

step_done() {
    grep -qxF "$1" "$STATE_FILE" 2>/dev/null
}

mark_step_done() {
    if ! step_done "$1"; then
        echo "$1" >>"$STATE_FILE"
    fi
}

run_step() {
    local name="$1"
    shift
    CURRENT_STEP="$name"

    if step_done "$name"; then
        echo "==> Skipping completed step: $name"
        return 0
    fi

    log "$name"
    "$@"
    mark_step_done "$name"
}

backup_file() {
    local src="$1"
    local name="$2"

    if [[ -f "$src" ]]; then
        cp "$src" "${BACKUP_DIR}/${name}.$(date +%Y%m%d%H%M%S)"
    fi
}

on_error() {
    echo ""
    echo "ERROR: failed at step: ${CURRENT_STEP:-unknown}"
    echo "Fix the issue, then re-run: bash ./install.sh"
    echo "To redo everything from scratch: INSTALL_RESET=1 bash ./install.sh"
    exit 1
}

trap on_error ERR

# ============================================================
# Architecture
# ============================================================

ARCH="$(uname -m)"

echo "Architecture: $ARCH"

if [[ "$ARCH" != "arm64" && "$ARCH" != "x86_64" ]]; then
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

configure_homebrew_path() {
    if [[ "$ARCH" == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}

# ============================================================
# Steps
# ============================================================

step_command_line_tools() {
    if xcode-select -p >/dev/null 2>&1; then
        echo "Command Line Tools already installed:"
        xcode-select -p
    else
        echo "Installing Command Line Tools..."
        xcode-select --install

        echo ""
        echo "Please complete the Command Line Tools installation dialog."
        echo "Waiting for installation to finish..."

        until xcode-select -p >/dev/null 2>&1; do
            sleep 5
        done

        echo "Command Line Tools installed."
    fi
}

step_homebrew() {
    if command_exists brew; then
        echo "Homebrew already installed."
    else
        NONINTERACTIVE=1 /bin/bash -c \
            "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    configure_homebrew_path
    brew update
    brew analytics off
}

step_oh_my_zsh() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        echo "Oh My Zsh already installed."
    else
        RUNZSH=no \
            CHSH=no \
            KEEP_ZSHRC=yes \
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
}

step_homebrew_taps() {
    brew tap FelixKratz/formulae
    brew trust FelixKratz/formulae
    brew tap borgbackup/tap
    brew trust borgbackup/tap
    brew tap shopify/shopify
    brew trust shopify/shopify
}

step_brew_bundle() {
    brew bundle --file="$RB_HOME/Brewfile"
}

step_npm_globals() {
    npm install --global ios-deploy
}

step_tpm() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"

    if [[ -d "$tpm_dir" ]]; then
        echo "TPM already installed."
    else
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    fi
}

step_xcode_install() {
    local xcode_app="/Applications/Xcode.app"

    if [[ -d "$xcode_app" ]]; then
        echo "Xcode already installed."
    else
        echo ""
        echo "Installing latest stable Xcode using xcodes."
        echo ""
        echo "You may be asked for your Apple Developer credentials."
        echo ""
        xcodes install --latest
    fi
}

step_xcode_configure() {
    local xcode_app="/Applications/Xcode.app"

    if [[ -d "$xcode_app" ]]; then
        sudo xcode-select --switch "$xcode_app"

        echo "Accepting Xcode license..."
        sudo xcodebuild -license accept

        echo "Running Xcode first launch setup..."
        sudo xcodebuild -runFirstLaunch
    else
        echo "WARNING: Xcode.app was not found."
        echo "Skipping Xcode configuration."
    fi
}

step_ios_runtime() {
    local xcode_app="/Applications/Xcode.app"

    if [[ -d "$xcode_app" ]]; then
        echo "Downloading latest iOS platform/runtime..."
        xcodebuild -downloadPlatform iOS
    else
        echo "WARNING: Xcode.app was not found."
        echo "Skipping iOS Simulator runtime."
    fi
}

step_macos_settings() {
    # Keyboard repeat: short delay, fast rate
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15

    # Hold key to repeat instead of showing accent menu
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

    # Trackpad: three-finger drag
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -bool true
}

step_shell_config() {
    local zshrc="$HOME/.zshrc"

    backup_file "$zshrc" "zshrc"

    touch "$zshrc"

    if [[ "$ARCH" == "arm64" ]]; then
        local coreutils_path='export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"'

        if ! grep -Fqx "$coreutils_path" "$zshrc"; then
            echo "" >>"$zshrc"
            echo "# GNU coreutils" >>"$zshrc"
            echo "$coreutils_path" >>"$zshrc"
        fi
    fi

    if ! grep -Fq "zsh-autosuggestions.zsh" "$zshrc"; then
        cat >>"$zshrc" <<'EOF'

# Homebrew zsh plugins
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
EOF
    fi

    if ! grep -Fq "rbrc.sh" "$zshrc"; then
        cat >>"$zshrc" <<'EOF'

# Brun environment
source ~/.brun/rbrc.sh
EOF
    fi
}

step_stow() {
    (
        cd "$RB_HOME"
        bash ./stow.sh
    )
}

step_login_items() {
    osascript <<'EOF'
tell application "System Events"

    try
        delete login item "Docker"
    end try

    try
        delete login item "Docker Desktop"
    end try

    try
        delete login item "1Password"
    end try

    try
        delete login item "1Password 8"
    end try

    try
        delete login item "Rectangle"
    end try

    if exists application file "Docker.app" of folder "Applications" of startup disk then
        make login item at end with properties {
            path:"/Applications/Docker.app",
            hidden:false
        }
    end if

    if exists application file "1Password.app" of folder "Applications" of startup disk then
        make login item at end with properties {
            path:"/Applications/1Password.app",
            hidden:false
        }
    end if

    if exists application file "Rectangle.app" of folder "Applications" of startup disk then
        make login item at end with properties {
            path:"/Applications/Rectangle.app",
            hidden:false
        }
    end if

end tell
EOF

    echo ""
    echo "Login items configured:"
    echo "  - Docker Desktop"
    echo "  - 1Password"
    echo "  - Rectangle"
}

step_brew_cleanup() {
    brew cleanup
}

step_dock() {
    local dock_plist="$HOME/Library/Preferences/com.apple.dock.plist"

    backup_file "$dock_plist" "dock.plist"

    dockutil --remove all --no-restart

    dockutil --add "/System/Library/CoreServices/Finder.app" --no-restart
    dockutil --add "/System/Applications/Launchpad.app" --no-restart
    dockutil --add "/Applications/iTerm.app" --no-restart
    dockutil --add "/Applications/Google Chrome.app" --no-restart
    dockutil --add "/Applications/PhpStorm.app" --no-restart
    dockutil --add "/Applications/WhatsApp.app" --no-restart
    dockutil --add "/Applications/Cursor.app" --no-restart
    dockutil --add "/Applications/Docker.app" --no-restart
    dockutil --add "/System/Applications/Calendar.app" --no-restart
    dockutil --add "/Applications/TablePlus.app" --no-restart
    dockutil --add "/Applications/Notion.app" --no-restart
    dockutil --add "/Applications/Discord.app" --no-restart

    defaults write com.apple.dock show-recents -bool false
    killall Dock

    echo ""
    echo "Dock configured:"
    echo "  Finder"
    echo "  Launchpad"
    echo "  iTerm2"
    echo "  Google Chrome"
    echo "  PhpStorm"
    echo "  WhatsApp"
    echo "  Cursor"
    echo "  Docker Desktop"
    echo "  Calendar"
    echo "  TablePlus"
    echo "  Notion"
    echo "  Discord"
    echo ""
    echo "Recent applications disabled."
}

step_verify() {
    echo ""
    echo "Homebrew:"
    brew --version | head -n 1

    echo ""
    echo "Oh My Zsh:"
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        echo "Installed"
    else
        echo "Not installed"
    fi

    echo ""
    echo "Git:"
    git --version

    echo ""
    echo "Node:"
    node --version

    echo ""
    echo "npm:"
    npm --version

    echo ""
    echo "Shopify CLI:"
    shopify version

    echo ""
    echo "Docker:"
    docker --version ||
        echo "Docker CLI not available yet; start Docker Desktop."

    echo ""
    echo "Xcode:"
    xcodebuild -version ||
        echo "Xcode unavailable."

    echo ""
    echo "Swift:"
    swift --version 2>/dev/null || true

    echo ""
    echo "iOS Simulator runtimes:"
    xcrun simctl list runtimes 2>/dev/null || true

    echo ""
    echo "Java:"
    java -version 2>&1 | head -n 1 || true

    echo ""
    echo "Ollama:"
    ollama --version 2>/dev/null || true
}

# ============================================================
# Run
# ============================================================

run_step "command-line-tools" step_command_line_tools
run_step "homebrew" step_homebrew

# Always refresh brew PATH in this shell (needed after resume)
if [[ -x /opt/homebrew/bin/brew || -x /usr/local/bin/brew ]]; then
    configure_homebrew_path
fi

run_step "oh-my-zsh" step_oh_my_zsh
run_step "homebrew-taps" step_homebrew_taps
run_step "brew-bundle" step_brew_bundle
run_step "npm-globals" step_npm_globals
run_step "tpm" step_tpm
run_step "xcode-install" step_xcode_install
run_step "xcode-configure" step_xcode_configure
run_step "ios-runtime" step_ios_runtime
run_step "macos-settings" step_macos_settings
run_step "shell-config" step_shell_config
run_step "stow" step_stow
run_step "login-items" step_login_items
run_step "brew-cleanup" step_brew_cleanup
run_step "dock" step_dock

# Verification always runs
CURRENT_STEP="verify"
log "Final verification"
step_verify

echo ""
echo "============================================================"
echo " Installation complete!"
echo "============================================================"
echo ""

echo "Recommended next steps:"
echo ""
echo "  1. Restart your terminal"
echo "  2. Restart your Mac"
echo "  3. Docker Desktop will start automatically"
echo "  4. 1Password will start automatically"
echo "  5. Rectangle will start automatically (grant Accessibility if prompted)"
echo "  6. Open Xcode once"
echo "  7. Sign into 1Password"
echo "  8. Sign into Chrome"
echo "  9. Sign into the Mac App Store if required"
echo " 10. Log out/in (or reboot) for trackpad three-finger drag to apply"
echo ""

echo "Done."
