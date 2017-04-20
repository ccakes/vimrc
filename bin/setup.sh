#!/bin/bash

if [[ -f ~/.vimrc || -f ~/.gvimrc || -d ~/.vim ]]; then
  echo "Existing Vim config found. Would you like to create"
  echo "a backup in ~/vim.bak/? [y/n] "

  read ANS

  if [[ "$ANS" == "y" ]]; then
    mkdir ~/vim.bak
    [ -f ~/.vimrc ]  && mv ~/.vimrc  ~/vim.bak/
    [ -f ~/.gvimrc ] && mv ~/.gvimrc ~/vim.bak/
    [ -d ~/.vim ]    && mv ~/.vim/   ~/vim.bak/
  fi
fi

ln -s $PWD/vimrc  ~/.vimrc
ln -s $PWD/gvimrc ~/.gvimrc
ln -s $PWD  ~/.vim

echo "Setup complete"
