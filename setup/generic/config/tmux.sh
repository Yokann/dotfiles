CURRENT_DATE=$(date "+%Y-%m-%d-%H-%M-%S")
rm -rf $HOME/.tmux/plugins/tpm
if [ -f $HOME/.tmux.conf ]; then
    cp $HOME/.tmux.conf "$HOME/.tmux.conf.bak$CURRENT_DATE"
fi
echo "source $DOTFILES_PATH/config/tmux/tmux.conf" > $HOME/.tmux.conf
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
echo "#################################################"
echo "Don't forget to run Prefix + I to install plugins"
echo "#################################################"
