CURRENT_DATE=$(date "+%Y-%m-%d-%H-%M-%S")
mkdir -p $HOME/.cache/zinit/completions
#Symlink .Xresources
rm -f $HOME/.Xresources
ln -s $DOTFILES_PATH/config/.Xresources $HOME/.Xresources
if [ -f $HOME/.zshrc ]; then
    cp $HOME/.zshrc "$HOME/.zshrc.bak$CURRENT_DATE"
fi
echo "source $DOTFILES_PATH/config/zsh/.zshrc" > $HOME/.zshrc
