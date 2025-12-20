# Config neovim
rm -rf $HOME/.config/nvim
ln -s $DOTFILES_PATH/config/nvim $HOME/.config/nvim
rm -rf $HOME/.editorconfig
ln -s $DOTFILES_PATH/config/.editorconfig $HOME/.editorconfig
