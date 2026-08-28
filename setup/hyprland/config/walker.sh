rm -f $HOME/.config/walker
ln -s $DOTFILES_PATH/config/walker $HOME/.config/walker
rm -f $HOME/.config/elephant
ln -s $DOTFILES_PATH/config/elephant $HOME/.config/elephant
if [[ $(systemctl --user is-enabled elephant) != "enabled" ]]; then
    elephant service enable
fi
