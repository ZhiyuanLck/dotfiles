#!/bin/env zsh

[ -d $HOME/.linuxbrew/bin ] && export PATH=$HOME/.linuxbrew/bin:$PATH
if command -v brew &> /dev/null
then
  # entr: for tmux-autoreload
  brew install fzf tmux z.lua zplug entr
else
  echo "brew not found"
fi
