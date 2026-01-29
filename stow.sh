#/bin/bash

stow -t ~ tmux zsh nvim aerospace alacritty 

if [[ "$(uname)" == "Darwin" ]]; then
	# macOS launchd things
	stow -t ~ . -d system/macos/launchd -v
fi
