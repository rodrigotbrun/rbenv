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

source $RBHOME/.zsh-plugins
