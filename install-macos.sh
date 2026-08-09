#!/bin/bash

set -euo pipefail

# ============================================================
# Mac Developer Machine Bootstrap
# ============================================================

export RB_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "============================================================"
echo " Mac Developer Machine Bootstrap"
echo "============================================================"
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

# ============================================================
# Architecture
# ============================================================

ARCH="$(uname -m)"

echo "Architecture: $ARCH"

if [[ "$ARCH" != "arm64" && "$ARCH" != "x86_64" ]]; then
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# ============================================================
# Apple Command Line Tools
# ============================================================

log "Installing Apple Command Line Tools"

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

# ============================================================
# Homebrew
# ============================================================

log "Installing Homebrew"

if command_exists brew; then
    echo "Homebrew already installed."
else
    NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Configure Homebrew PATH
if [[ "$ARCH" == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

brew update
brew analytics off

# ============================================================
# Oh My Zsh
# ============================================================

log "Installing Oh My Zsh"

if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "Oh My Zsh already installed."
else
    RUNZSH=no \
        CHSH=no \
        KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ============================================================
# Homebrew Taps
# ============================================================

log "Adding Homebrew taps"

brew tap FelixKratz/formulae
brew trust FelixKratz/formulae
brew tap borgbackup/tap
brew tap shopify/shopify

# ============================================================
# CLI / Development Tools
# ============================================================

log "Installing CLI and development tools"

brew install \
    git \
    node \
    npm \
    tmux \
    neovim \
    coreutils \
    stow \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    zplug \
    fzf \
    bat \
    fd \
    zoxide \
    lua \
    luajit \
    luarocks \
    prettier \
    make \
    qmk \
    lazygit \
    lazykube \
    lazydocker \
    tree-sitter \
    tree \
    borders \
    imagemagick \
    htop \
    btop \
    borgbackup \
    xcodes \
    shopify-cli \
    dockutil

# ============================================================
# Docker
# ============================================================

log "Installing Docker Desktop"

brew install --cask docker-desktop

# ============================================================
# Java
# ============================================================

log "Installing Java"

brew install --cask zulu@17

# ============================================================
# Fonts
# ============================================================

log "Installing fonts"

brew install --cask \
    font-hack-nerd-font \
    font-jetbrains-mono-nerd-font \
    font-sf-pro

# ============================================================
# Applications
# ============================================================

log "Installing applications"

brew install --cask \
    google-chrome \
    spotify \
    iterm2 \
    tableplus \
    phpstorm \
    cursor \
    1password \
    discord \
    notion \
    anydesk \
    android-studio \
    postman \
    macfuse \
    vorta \
    ollama \
    openlogi \
    the-unarchiver \
    whatsapp \
    rectangle

# ============================================================
# Borg FUSE
# ============================================================

log "Installing Borg FUSE"

brew install borgbackup/tap/borgbackup-fuse

# ============================================================
# Node Global Packages
# ============================================================

log "Installing global npm packages"

npm install --global ios-deploy

# ============================================================
# tmux Plugin Manager
# ============================================================

log "Installing tmux plugin manager"

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [[ -d "$TPM_DIR" ]]; then
    echo "TPM already installed."
else
    git clone \
        https://github.com/tmux-plugins/tpm \
        "$TPM_DIR"
fi

# ============================================================
# Xcode
# ============================================================

log "Installing Xcode"

XCODE_APP="/Applications/Xcode.app"

if [[ -d "$XCODE_APP" ]]; then
    echo "Xcode already installed."
else
    echo ""
    echo "Installing latest stable Xcode using xcodes."
    echo ""
    echo "You may be asked for your Apple Developer credentials."
    echo ""

    xcodes install --latest
fi

# ============================================================
# Configure Xcode
# ============================================================

log "Configuring Xcode"

if [[ -d "$XCODE_APP" ]]; then

    sudo xcode-select --switch "$XCODE_APP"

    echo "Accepting Xcode license..."
    sudo xcodebuild -license accept

    echo "Running Xcode first launch setup..."
    sudo xcodebuild -runFirstLaunch

else
    echo "WARNING: Xcode.app was not found."
    echo "Skipping Xcode configuration."
fi

# ============================================================
# iOS Simulator Runtime
# ============================================================

log "Installing latest iOS Simulator runtime"

if [[ -d "$XCODE_APP" ]]; then

    echo "Downloading latest iOS platform/runtime..."

    xcodebuild -downloadPlatform iOS

else
    echo "WARNING: Xcode.app was not found."
    echo "Skipping iOS Simulator runtime."
fi

# ============================================================
# macOS Settings
# ============================================================

log "Applying macOS settings"

# Keyboard repeat: short delay, fast rate
# (System Settings → Keyboard / Accessibility key repeat)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Hold key to repeat instead of showing accent menu
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Trackpad: three-finger drag
# (System Settings → Accessibility → Pointer Control → Trackpad Options)
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -bool true

# ============================================================
# Shell Configuration
# ============================================================

log "Configuring shell"

ZSHRC="$HOME/.zshrc"

touch "$ZSHRC"

# GNU coreutils
if [[ "$ARCH" == "arm64" ]]; then

    COREUTILS_PATH='export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"'

    if ! grep -Fqx "$COREUTILS_PATH" "$ZSHRC"; then
        echo "" >>"$ZSHRC"
        echo "# GNU coreutils" >>"$ZSHRC"
        echo "$COREUTILS_PATH" >>"$ZSHRC"
    fi

fi

# zsh-autosuggestions
if ! grep -Fq "zsh-autosuggestions.zsh" "$ZSHRC"; then
    cat >>"$ZSHRC" <<'EOF'

# Homebrew zsh plugins
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
EOF
fi

# Brun environment (rbrc.sh)
if ! grep -Fq "rbrc.sh" "$ZSHRC"; then
    cat >>"$ZSHRC" <<'EOF'

# Brun environment
source ~/.brun/rbrc.sh
EOF
fi

# ============================================================
# Dotfiles (stow)
# ============================================================

log "Linking dotfiles with stow"

(
    cd "$RB_HOME"
    bash ./stow.sh
)

# ============================================================
# Login Items
# ============================================================

log "Configuring login items"

osascript <<'EOF'
tell application "System Events"

    -- Remove existing entries if present
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

    -- Add login items
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

# ============================================================
# Homebrew Cleanup
# ============================================================

log "Cleaning Homebrew"

brew cleanup

# ============================================================
# Dock Configuration
# ============================================================

log "Configuring macOS Dock"

# dockutil makes Dock management much more reliable than
# manipulating the Dock plist directly.

# Remove all existing Dock applications
dockutil --remove all --no-restart

# ------------------------------------------------------------
# Add only the applications we want
# ------------------------------------------------------------
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

# Disable "Show recent applications" in the Dock
defaults write com.apple.dock show-recents -bool false

# Restart Dock
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

# ============================================================
# Final Verification
# ============================================================

log "Final verification"

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
