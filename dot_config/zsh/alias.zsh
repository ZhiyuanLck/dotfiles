# chezmoi
alias cz="chezmoi "
alias ce="chezmoi edit "
alias cap="chezmoi apply "
alias cud="chezmoi update "
alias cdf="chezmoi diff "

function cad() {
  [ -e $1 ] && chezmoi add $1
}

function caa() {
  cad $HOME/.tmux.conf
  cad $HOME/.condarc
  # cad $HOME/.gitconfig
  cad $HOME/.cargo/config
  cad $HOME/.config/zsh
  cad $HOME/.config/pip
  cad $HOME/.config/nvim
}

if [ -f $HOME/.cargo/bin/exa ]; then
  alias ls="$HOME/.cargo/bin/exa --git --icons --color=always "
else
  alias ls="ls --color=always "
fi
alias ll="ls -l "

# reload
alias rl="source $HOME/.zshrc"

alias cl="clear"

# mkdir && cd
mk() {
  mkdir -p $1 && cd $1
}

alias chm='sudo chmod +x'

# ss
export hostip=$(cat /etc/resolv.conf |grep -oP '(?<=nameserver\ ).*')
port=7890
# port=10808
alias setss='export all_proxy="socks5://${hostip}:$port";'
alias unsetss='unset all_proxy'

# cd
alias cdnp="cd $HOME/.local/share/nvim/site/pack/packer/opt"
alias cdnv="cd $HOME/.config/nvim"

# git
alias g='git '
alias ga='git add '
alias gaa='git add --all '
alias gcm='git commit -m '
alias gac='git add --all && git commit -m "update"'
alias gco='git checkout '
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gda='git diff HEAD'
alias gi='git init'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gps='git push'
alias gpo='git push -u origin master'
alias gr='git rebase'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'
alias gsma='git submodule add'
alias gsmu='git submodule update --init --recursive'
function glf() { git log --all --grep="$1"; }
