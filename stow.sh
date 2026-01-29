#/bin/bash

stow -t ~ tmux zsh nvim aerospace alacritty 

# macOS launchd things
stow -t ~ . -d system/macos/launchd -v
