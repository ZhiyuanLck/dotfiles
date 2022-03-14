export VISUAL=nvim
export EDITOR="$VISUAL"

# texlive
export PATH=$HOME/.local/share/texlive/2021/bin/x86_64-linux:$PATH
export MANPATH=$HOME/.local/share/texlive/2021/texmf-dist/doc/man:$MANPATH
export INFOPATH=$HOME/.local/share/texlive/2021/texmf-dist/doc/info:$INFOPATH

# brew
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export PATH=$HOME/.linuxbrew/bin:$PATH

# rust
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env
