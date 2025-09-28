eval "$(/opt/homebrew/bin/brew shellenv)"

export LANG=en_US.UTF-8

export BROWSER='open'

#------------All PATHS------------
# GNU coreutils
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# Add local ~/scripts to the PATH
#export PATH="$HOME/scripts:$PATH"

# Mason
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# NVM 
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X to enable it.
if [[ -z "$LESS" ]]; then
  export LESS='-g -i -M -R -S -w -X -z-4'
fi

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
