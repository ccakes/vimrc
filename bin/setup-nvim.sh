#!/bin/bash

if [[ -f ~/config/.nvim ]]; then
  echo "Existing Neovim config found. Would you like to create"
  echo "a backup in ~/neovim.bak/? [y/n] "

  read ANS

  if [[ "$ANS" == "y" ]]; then
    [ -d ~/.config/nvim ] && mv ~/.config/nvim/ ~/neovim.bak/
  fi
fi

ln -s $PWD  ~/.config/nvim
ln -s vimrc init.vim

echo "Setup complete"
