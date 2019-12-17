#!/usr/bin/env bash

curl -fsSL https://raw.github.com/hunter-read/powerlevel10k-custom-os-colors/master/os-colors.zsh > ~/.os-colors.zsh
echo "source ~/.os-colors.zsh" >> ~/.zshrc
