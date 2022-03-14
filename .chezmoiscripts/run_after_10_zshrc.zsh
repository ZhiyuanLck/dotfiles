#!/bin/env zsh

CONDA=$HOME/.local/share/miniconda3
if [ -d $CONDA ]; then
  "$CONDA/bin/conda" init zsh
fi
