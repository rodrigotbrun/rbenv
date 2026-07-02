#!/bin/bash

export RBHOME=~/.rbdev

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

brew install node

brew tap FelixKratz/formulae

npm install -g ios-deploy

brew install git tmux neovim gitmux

# install tmux plugin manager (tpm)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

brew install coreutils zplug stow zsh-autosuggestions zsh-syntax-highlighting \
  fzf bat fd zoxide lua luajit luarocks prettier make qmk lazygit \
  lazykube lazydocker tree-sitter tree borders imagemagick

brew tap hashicorp/tap

brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-sf-pro

# mac settings
sudo defaults write NSGlobalDomain KeyRepeat -int 2
sudo defaults write InitialKeyRepeat -int 15
csrutil status

echo 'export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"' >> ~/.zshrc

echo 'source ~/.rbdev/rbrc.sh' >> ~/.zshrc


