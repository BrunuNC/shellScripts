#!/bin/zsh

# limpeza de arquivos inuteis
# ana c pereira

echo "Limpando a Lixeira"
sudo rm -rf /home/$USER/.local/share/Trash/files/*
echo ""
echo ""
echo "Limpando a pasta TMP"
sudo rm -rf /var/tmp/*
echo ""
echo ""
echo "Exclusão de caches inuteis do sistema. Cópias de atualizações do gerenciador de atualização"
sudo apt clean -y
echo ""
echo ""
echo "Exclusão de Programas que não estão sendo mais utilizados pelo sistema"
sudo apt autoremove -y
echo ""
echo ""
echo "Exclusão de Arquivos Duplicado"
sudo apt autoclean -y
echo ""
echo ""
echo "Reparando pacotes quebrados durante atualização"
sudo dpkg --configure -a
echo ""
echo ""
clear
echo "Limpeza Concluída"
sleep 4
exit


