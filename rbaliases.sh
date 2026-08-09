#!/bin/bash

# my common aliases
alias ll="ls -lah"
alias t="tree"
alias vim="nvim"
alias nano="nvim"
alias a="php artisan"

# zsh
alias zi="zplug install"
alias zu="zplug update"

# Git
alias gt="git"
alias ga="git add ."
alias gs="git status -s"
alias gc='git commit -m'
alias glog='git log --oneline --graph --all'
alias gp='git push'

# tree
alias tree="tree -L 3 -a -I '.git' --charset X "
alias dtree="tree -L 3 -a -d -I '.git' --charset X "

# ssh to my home server
alias rb="ssh rb"
alias rbdev="cd ~/.brun && nvim"

alias lg="lazygit"

# My common dev dirs and config editors/sources
alias znano="nvim ~/.zshrc"
alias zsource="source ~/.zshrc"

# Shopify Hydrogen alias to local projects
alias pest=./vendor/bin/pest