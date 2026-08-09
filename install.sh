#!/bin/bash

export RB_HOME=$(pwd)

# Install xCode cli tools
if [[ "$(uname)" == "Darwin" ]]; then
    if xcode-select -p &>/dev/null; then
        echo "Xcode already installed"
    else
        echo "Installing commandline tools..."
        xcode-select --install
    fi
fi

brew analytics off
brew tap FelixKratz/formulae

brew install git node npm tmux neovim

npm install -g ios-deploy

# install tmux plugin manager (tpm)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

brew install coreutils zplug stow zsh-autosuggestions zsh-syntax-highlighting \
    fzf bat fd zoxide lua luajit luarocks prettier make qmk lazygit \
    lazykube lazydocker tree-sitter tree borders imagemagick htop btop

brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-sf-pro

brew install --cask zulu@17
brew info --cask zulu@17

# Install softwares
brew install --cask iterm2
brew install --cask tableplus
brew install --cask phpstorm
brew install --cask 1password
brew install --cask android-studio
brew install --cask openlogi
brew install --cask postman
brew install --cask macfuse
brew install borgbackup/tap/borgbackup-fuse
brew install --cask vorta

# mac settings
sudo defaults write NSGlobalDomain KeyRepeat -int 2
sudo defaults write InitialKeyRepeat -int 15
csrutil status

echo 'export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"' >>~/.zshrc

echo 'source $RB_HOME/rbrc.sh' >>~/.zshrc
