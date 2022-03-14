# Setup fzf
# ---------
if [[ ! "$PATH" == */home/zhiyuan/.linuxbrew/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/zhiyuan/.linuxbrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/zhiyuan/.linuxbrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/zhiyuan/.linuxbrew/opt/fzf/shell/key-bindings.zsh"
