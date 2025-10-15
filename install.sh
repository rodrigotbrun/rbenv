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

# install zsh
echo "Installing ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install homebrew
echo "Installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

brew tap homebrew/cask-fonts
brew tap FelixKratz/formulae

brew install git
brew install tmux
brew install neovim
brew install gitmux
brew install dysk

# install tmux plugin manager (tpm)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

brew install coreutils
brew install zplug
brew install stow
brew install pngpaste
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install fzf
brew install bat
brew install fd
brew install zoxide
brew install lua
brew install luajit
brew install luarocks
brew install prettier
brew install make
brew install qmk
brew install ripgrep

brew install lazygit
brew install lazydocker
brew install starship
brew install tree-sitter
brew install tree
brew install borders

brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-sf-pro

# mac settings
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write InitialKeyRepeat -int 15
csrutil status

# Clone dotfiles repository
if [ ! -d "$HOME/.rbdev" ]; then
  echo "Cloning repository..."
  git clone https://github.com/rodrigotbrun/dev-on-my-mac $HOME/rbdev
fi

echo 'export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"' >> ~/.zshrc

echo 'source ~/.rbdev/rbrc.sh' >> ~/.zshrc

stow -t ~ tmux zsh nvim

# install my nvim

npm install -g spotify-cli-mac

