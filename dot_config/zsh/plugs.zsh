export ZPLUG_HOME=$HOME/.linuxbrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

zplug "zsh-users/zsh-autosuggestions", defer:2
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1

zplug "zsh-users/zsh-history-substring-search", defer:2

zplug "plugins/command-not-found", from:oh-my-zsh

zplug "romkatv/powerlevel10k", as:theme, depth:1

# z.lua
eval "$(lua $HOME/.linuxbrew/share/z.lua/z.lua  --init zsh once enhanced echo fzf)"
alias zc='z -c'      # 严格匹配当前路径的子路径
alias zz='z -i'      # 使用交互式选择模式
alias zf='z -I'      # 使用 fzf 对多个结果进行选择
alias zb='z -b'      # 快速回到父目录
alias zh='z -I -t .' # MRU

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
