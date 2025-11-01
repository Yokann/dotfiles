if [ cat .zshrc | grep "source $DOTFILES_PATH/config/zsh/.zshrc" >/dev/null 2>&1 ]; then
    echo "Zsh is already configured. Skipping..."
else
    CURRENT_DATE=$(date "+%Y-%m-%d-%H-%M-%S")
    mkdir -p $HOME/.cache/zinit/completions
    if [ -f $HOME/.zshrc ]; then
        cp $HOME/.zshrc "$HOME/.zshrc.bak$CURRENT_DATE"
    fi
    echo "source $DOTFILES_PATH/config/zsh/.zshrc" > $HOME/.zshrc
fi
