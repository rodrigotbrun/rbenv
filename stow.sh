#!/bin/bash
stow -t ~ tmux zsh nvim

tpm_dir="$HOME/.tmux/plugins/tpm"
if [[ ! -x "$tpm_dir/tpm" ]]; then
    mkdir -p "$(dirname "$tpm_dir")"
    rm -rf "$tpm_dir"
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
fi
"$tpm_dir/bin/install_plugins"