#!/bin/bash

git clone --recursive https://github.com/pachulo/dotfiles.git pachulo-dotfiles.git
ln -s ~/pachulo-dotfiles.git/.vim ~/
ln -s ~/pachulo-dotfiles.git/.vimrc ~/
