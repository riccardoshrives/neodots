#!/bin/bash

git clone git clone https://github.com/neovim/neovim ~/.config/nvim/neovim

sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/

cd ~/.config/nvim/neovim

make CMAKE_BUILD_TYPE=Release

sudo make install

rm -rf ~/.config/nvim/neovim
