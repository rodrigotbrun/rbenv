#/bin/bash
# source your zshrc with this at the end

export RBHOME=~/.rbdev/

export TERM=xterm

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# Set my common aliases
source $HOME/.rbdev/rbaliases.sh
source $HOME/.rbdev/rbfunctions.sh

# Restart to my tmux session

function dmux(){
if [[ -z $TMUX ]]; then
    session_name="dev" # You can customize the session name
    if tmux has-session -t "$session_name" 2>/dev/null; then
        exec tmux attach-session -t "$session_name"
    else
        exec tmux new-session -s "$session_name"
    fi
fi
}

eval "$(fzf --zsh)"

# zsh plugin manager
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

source ~/.zsh-plugins

eval "$(zoxide init zsh)"

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --style full
  --walker-skip .git,node_modules,target,vendor
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top --style full'
