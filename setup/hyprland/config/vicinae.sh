if [ ! -f "$HOME/.config/vicinae/settings.json" ]; then
    mkdir -p $HOME/.config/vicinae
    cat >$HOME/.config/vicinae/settings.json <<EOF
{
   "\$schema": "https://vicinae.com/schemas/config.json",
   "imports": [
      "/home/ygenre/.dotfiles/config/vicinae/base.json"
   ],
   "providers": {
      "files": {
         "preferences": {
            "autoIndexing": true,
            "indexingPaths": [
               "$HOME"
            ]
         }
      }
   }
EOF
fi

# import shortcuts
if [ ! -f "$HOME/.local/share/vicinae/shortcuts/shortcuts.json" ]; then
    mkdir -p $HOME/.local/share/vicinae/shortcuts
    cp $DOTFILES_PATH/config/vicinae/share/shortcuts/shortcuts.json $HOME/.local/share/vicinae/shortcuts/shortcuts.json
fi


systemctl --user enable --now vicinae.service

#TODO: install vicinae package if not installed

# xdg-open vicinae://extensions/costeer/color-converter
# xdg-open vicinae://extensions/gelei/bluetooth
# xdg-open vicinae://extensions/aurelleb/dashboard-icons
# xdg-open vicinae://extensions/dagimg-dot/wifi-commander
# xdg-open vicinae://extensions/knoopx/firefox
# xdg-open vicinae://extensions/rastsislaux/pulseaudio
# xdg-open vicinae://extensions/rithvikvibhu/arch-packages


