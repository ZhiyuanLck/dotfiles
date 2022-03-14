#!/bin/env bash

if [ ! -f $HOME/.cargo/env ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if [ ! -f $HOME/.cargo/bin/exa ]; then
  cargo install exa
fi
