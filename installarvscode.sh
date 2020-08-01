#!/bin/bash

echo "Instalando..."
echo ""
sudo snap install code --classic

sudo apt update
echo "##################################################"
echo "Configurando VsCode..."
echo "##################################################"
echo ""
cd
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
  local="`/snap/bin/code`"
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
fi
echo "$json" > "$file"
echo ""
echo "VsCode esta configurado"

echo ""
echo ""
echo "Pronto"
