#!/bin/bash

echo "##################################################"
echo "Instalando ZSH..."
echo "##################################################"
sudo apt install zsh
zsh --version
sudo chsh -s $(which zsh)

local="/usr/bin/zsh"
if [ "$SHELL" == "$local" ]
  then
    setopt +o nomatch
    sudo apt install curl fonts-firacode -y  && sudo apt update
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
  else
    echo "ERRO: ZSH nao e o shell padrao"
fi

