if ! grep -q "source $DOTFILES_PATH/config/zsh/.zshrc" "$HOME/.zshrc" 2>/dev/null; then
    CURRENT_DATE=$(date "+%Y-%m-%d-%H-%M-%S")
    mkdir -p "$HOME/.cache/zinit/completions"
    if [ -f $HOME/.zshrc ]; then
        cp $HOME/.zshrc "$HOME/.zshrc.bak$CURRENT_DATE"
    fi
    echo "source $DOTFILES_PATH/config/zsh/.zshrc" > "$HOME/.zshrc"
else
    echo "Zsh is already configured. Skipping..."
fi

# Set zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as default shell..."
    sudo chsh -s $(which zsh) $USER
fi
