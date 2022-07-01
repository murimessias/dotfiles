#!/bin/bash
# git
ln -sf $PWD/git/.gitconfig ~/
ln -sf $PWD/git/.gitconfig-murimessias ~/

# ssh
mkdir -p ~/.ssh/
ln -sf $PWD/ssh/config ~/.ssh/config

# zsh
touch ~/.zshrc
ln -sf $PWD/zsh/.zshrc ~/.zshrc

# lvim
ln -sf $PWD/lvim ~/.config/lvim
