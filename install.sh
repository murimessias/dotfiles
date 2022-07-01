#!/bin/bash
# git
ln -sf $PWD/git/.gitconfig ~/
ln -sf $PWD/git/.gitconfig-murimessias ~/

# ssh
mkdir -p ~/.ssh/
ln -sf $PWD/ssh/config ~/.ssh/config

# zsh
ln -sf $PWD/zsh/.zshrc ~/.zshrc

# lvim
mkdir -p ~/.config/lvim
ln -sf $PWD/lvim ~/.config/lvim
