#!/bin/env bash
[ -d $HOME/.tmux/plugins/tmp ] || git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
bash $HOME/.tmux/plugins/tpm/bin/install_plugins
tmux source ~/.tmux.conf
