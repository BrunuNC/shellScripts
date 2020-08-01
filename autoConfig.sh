#!/bin/zsh

system="`lsb_release -sd`"
machine="`uname -m`"
echo ""
echo ""
arch="amd64"
arch2="x64"
if [ "$machine" != "x86_64" ]
then
  arch="i386"
  arch2="ia32"
fi
echo ""
echo ""

echo "LINUX UBUNTU"
echo "Author: Bruno Nunes"
echo "System: $system"
echo "Architecture: $arch"
echo "Home: $HOME"
echo "User: $USER"
echo ""
echo ""

dpkgInstall() {
  file="$HOME/$1"
  wget -O "$file" "$2"
  sudo dpkg -i "$file"
  rm -fv "$file"
  sudo apt install -fy
}
echo "##################################################"
echo "Removendo travas eventuais do apt"
echo "##################################################"
sudo rm /var/lib/apt/lists/lock
sudo rm /var/lib/dpkg/lock
sudo apt update
sudo apt upgrade

echo "##################################################"
echo "Instalando Programas Basicos..."
echo "##################################################"
sudo apt update
sudo apt install wget jq neofetch htop tar synaptic -y

echo ""
echo ""

echo "##################################################"
echo "Instalando Git..."
echo "##################################################"
sudo apt install git -y

echo ""
echo ""

echo "##################################################"
echo "Instalando VsCode..."
echo "##################################################"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
echo ""

sudo apt install apt-transport-https
sudo apt update
sudo apt install code

echo ""
echo ""

echo "##################################################"
echo "Configurando VsCode..."
echo "##################################################"
echo ""
code_extensions=( \
  "pkief.material-icon-theme" \
  "ritwickdey.LiveServer" \
  "formulahendry.auto-rename-tag" \
  "bierner.color-info" \
  "dracula-theme.theme-dracula" \
  "ms-ceintl.vscode-language-pack-pt-br" \
  "esbenp.prettier-vscode" \
  "nobuhito.printcode" \
  "2gua.rainbow-brackets" \
  "visualstudioexptteam.vscodeintellicode" \
)
i=0
while [ $i != ${#code_extensions[@]} ]
do
  local="`which code`"
  "$local" --install-extension "${code_extensions[$i]}"  
  let "i++"
done

file="$HOME/.config/Code/User/settings.json"
json="`cat "$file"`"
if [ -z "$json" ]
then
  json="{}"
  json="`echo "$json" | jq '."window.zoomLevel"=0'`" 
  json="`echo "$json" | jq '."window.titleBarStyle"="custom"'`" 
  json="`echo "$json" | jq '."editor.mouseWheelZoom"=true'`"  
  json="`echo "$json" | jq '."editor.fontFamily"="Fira Code Retina"'`"
  json="`echo "$json" | jq '."editor.fontLigatures"=true'`"
  json="`echo "$json" | jq '."editor.tabSize"=2'`"
  json="`echo "$json" | jq '."editor.wordWrap"="on"'`"
  json="`echo "$json" | jq '."editor.renderLineHighlight"="gutter"'`"
  json="`echo "$json" | jq '."editor.parameterHints.enabled"=false'`"
  json="`echo "$json" | jq '."editor.suggestSelection"="first"'`"
  json="`echo "$json" | jq '."workbench.startupEditor"="newUntitledFile"'`"
  json="`echo "$json" | jq '."workbench.colorTheme"="Dracula"'`"
  json="`echo "$json" | jq '."workbench.iconTheme"="material-icon-theme"'`"
  json="`echo "$json" | jq '."terminal.integrated.shell.linux"="/bin/zsh"'`"
  json="`echo "$json" | jq '."terminal.integrated.cursorStyle"="underline"'`"
  json="`echo "$json" | jq '."terminal.integrated.fontSize"=12'`"
  json="`echo "$json" | jq '."terminal.integrated.fontWeightBold"="normal"'`"
  json="`echo "$json" | jq '."explorer.confirmDragAndDrop"=false'`"
  json="`echo "$json" | jq '."explorer.confirmDelete"=false'`"
  json="`echo "$json" | jq '."telemetry.enableTelemetry"=false'`"
  json="`echo "$json" | jq '."telemetry.enableCrashReporter"=false'`"
fi
  json="`echo "$json" | jq '."colorInfo.fields"= [
    "rgb",
    "css-color-name",
    "alpha"
  ]'`"
json="`echo "$json" | jq '."workbench.colorCustomizations"= {
    "terminal.background": "#282936",
    "terminal.foreground": "#E9E9F4",
    "terminalCursor.foreground": "#E9E9F4",
    "terminal.ansiBlack": "#282936",
    "terminal.ansiBlue": "#62D6E8",
    "terminal.ansiBrightBlack": "#626483",
    "terminal.ansiBrightBlue": "#62D6E8",
    "terminal.ansiBrightCyan": "#A1EFE4",
    "terminal.ansiBrightGreen": "#EBFF87",
    "terminal.ansiBrightMagenta": "#B45BCF",
    "terminal.ansiBrightRed": "#EA51B2",
    "terminal.ansiBrightWhite": "#F7F7FB",
    "terminal.ansiBrightYellow": "#00F769",
    "terminal.ansiCyan": "#A1EFE4",
    "terminal.ansiGreen": "#EBFF87",
    "terminal.ansiMagenta": "#B45BCF",
    "terminal.ansiRed": "#EA51B2",
    "terminal.ansiWhite": "#E9E9F4",
    "terminal.ansiYellow": "#00F769",
    "terminalCursor.background": "#E9E9F4",
    "minimap.background": "#00000055"
  }'`"
json="`echo "$json" | jq '."emmet.syntaxProfiles"= {
    "javascript": "jsx",
    "nunjucks": "html"
  }'`"
json="`echo "$json" | jq '."emmet.includeLanguages"= {
    "html": "html",
    "javascript": "javascriptreact"
  }'`"
json="`echo "$json" | jq '."breadcrumbs.enabled"=true'`"
json="`echo "$json" | jq '."git.enableSmartCommit"=true'`"
json="`echo "$json" | jq '."git.confirmSync"=false'`"
json="`echo "$json" | jq '."typescript.tsserver.log"="verbose"'`"
json="`echo "$json" | jq '."vsintellicode.modify.editor.suggestSelection"="automaticallyOverrodeDefaultValue"'`"
json="`echo "$json" | jq '."files.exclude"= {
    "**/.classpath": true,
    "**/.project": true,
    "**/.settings": true,
    "**/.factorypath": true
  }'`"
json="`echo "$json" | jq '."files.associations"= {
    "*.slf": "hlsl",
    "*.slv": "hlsl"
  }'`"
json="`echo "$json" | jq '."debug.allowBreakpointsEverywhere"=true'`"
json="`echo "$json" | jq '."prettier.jsxSingleQuote"=true'`"
json="`echo "$json" | jq '."prettier.printWidth"=100'`"
json="`echo "$json" | jq '."prettier.semi"=false'`"
json="`echo "$json" | jq '."prettier.useTabs"=true'`"
json="`echo "$json" | jq '."prettier.tabWidth"=2'`"
json="`echo "$json" | jq '."liveServer.settings.donotVerifyTags"=true'`"
json="`echo "$json" | jq '."liveServer.settings.donotShowInfoMsg"=true'`"
echo "$json" > "$file"
echo ""
echo "VsCode esta configurado"

echo ""
echo ""

echo "##################################################"
echo "Instalando Discord..."
echo "##################################################"   
wget -cO ~/Downloads/discord.deb https://discordapp.com/api/download?platform=linux&format=deb
cd Downloads
sudo apt install -y ./discord.deb

echo ""
echo ""

echo "##################################################"
echo "Instalando IntelliJ IDEA Ultimate..."
echo "##################################################"
#sudo snap install intellij-idea-ultimate --classic

echo ""
echo ""

echo "##################################################"
echo "Instalando PhpStorm..."
echo "##################################################"
sudo snap install phpstorm --classic

echo ""
echo ""

echo "##################################################"
echo "Instalando vlc..."
echo "##################################################"
sudo apt install vlc -y

echo ""
echo ""

echo "##################################################"
echo "Instalando Spotify..."
echo "##################################################"
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install spotify-client -y

echo ""
echo ""

echo "##################################################"
echo "Instalando Telegram..."
echo "##################################################"
wget -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C /opt/
sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram-desktop

echo ""
echo ""

echo "##################################################"
echo "Removendo alguns programas..."
echo "##################################################"
sudo apt remove pidgin hexchat cheese pix -y

echo ""
echo ""

sudo apt update
echo ""

echo "##################################################"
echo "Limpando e Removendo Pacotes..."
echo "##################################################"
sudo apt autoclean -y
sudo apt autoremove -y
