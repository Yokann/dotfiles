rm -f $HOME/.config/walker
ln -s $DOTFILES_PATH/config/hypr/themes/2024/dots/walker $HOME/.config/walker
rm -f $HOME/.config/elephant
ln -s $DOTFILES_PATH/config/hypr/themes/2024/dots/elephant $HOME/.config/elephant
elephant service enable
