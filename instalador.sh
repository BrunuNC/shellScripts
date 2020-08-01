#!/bin/zsh

#Atualizando repositórios e atualizando o sistema operacional
sudo apt update && sudo apt upgrade -y &&

#finalizando e limpando arquivos desnecessários

sudo apt-get autoclean

sudo apt-get autoremove -y
