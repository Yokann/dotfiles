# set qwerty layout for login prompt
if [ $STATE_FLAG = "first-install" ]; then
    localectl set-x11-keymap us pc105
    mkdir -p $HOME/.xkb/symbols
    rm -rf $HOME/.xkb/symbols/fr
    ln -s $DOTFILES_PATH/config/qwerty-l.xkb_symbols $HOME/.xkb/symbols/fr
fi
