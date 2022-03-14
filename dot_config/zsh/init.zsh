load () {
  local CONF="$HOME/.config/zsh"
  [[ -n $1 ]] && source "$CONF/$1.zsh"
}

load basic
load alias
load plugs
load p10k
load mappings
if command -v fzf &> /dev/null; then
  load fzf
fi
