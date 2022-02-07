#!/bin/bash
rm -rf files/
mkdir files
cp ~/.gitconfig files/
cp ~/.gitignore_global files/
cp ~/.hushlogin files/
cp ~/.tmux.conf files/
cp ~/.zshrc files/
cp -R ~/.scripts files/
mkdir -p files/.config/nvim
cp -R ~/.config/nvim/lua files/.config/nvim
cp ~/.config/nvim/init.vim files/.config/nvim
