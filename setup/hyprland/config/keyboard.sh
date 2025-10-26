# set qwerty layout for login prompt
localectl set-x11-keymap us pc105
mkdir -p $HOME/.xkb/symbols
rm $HOME/.xkb/symbols/fr
ln -s $DOTFILES_PATH/config/qwerty-l.xkb_symbols $HOME/.xkb/symbols/fr
