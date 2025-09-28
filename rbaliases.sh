#!/bin/bash

# my common aliases
alias ls="lsd"
alias ll="ls -lah"
alias t="tree"
alias cat="bat"
alias vim="nvim"

# Git
alias gt="git"
alias ga="git add ."
alias gs="git status -s"
alias gc='git commit -m'
alias glog='git log --oneline --graph --all'

# tree
alias tree="tree -L 3 -a -I '.git' --charset X "
alias dtree="tree -L 3 -a -d -I '.git' --charset X "

# ssh to my home server
alias rb="ssh rb"
alias rbdev="cd ~/.rbdev/ && nvim"

# lazygit
alias lg="lazygit"

# My common dev dirs and config editors/sources
alias backend="cd ~/dev/backend/"
alias rn="cd ~/dev/rn/"
alias tmuxconf="nvim ~/.tmux.conf"
alias znano="nvim ~/.zshrc"
alias zsource="source ~/.zshrc"

# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

alias sail=./vendor/bin/sail
alias envoy=php ./vendor/bin/envoy
