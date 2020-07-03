#!/bin/bash
rm -rf files/
mkdir files
cp -R ~/.gitconfig files/
cp -R ~/.gitignore_global files/
cp -R ~/.hushlogin files/
cp -R ~/.tmux.conf files/
mkdir files/.config
cp -R ~/.config/alacritty files/.config
cp -R ~/.config/fish files/.config
cp -R ~/.config/omf files/.config
mkdir files/.config/nvim
cp -R ~/.config/nvim/autoload files/.config/nvim
cp -R ~/.config/nvim/init.vim files/.config/nvim
cp -R ~/.config/nvim/coc-settings.json files/.config/nvim
