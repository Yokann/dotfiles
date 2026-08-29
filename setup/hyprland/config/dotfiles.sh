if [ ! -f "$HOME/.config/profile.d/00-dotfiles.sh" ]; then
    cat >$HOME/.config/profile.d/00-dotfiles.sh <<EOF
export DOTFILES_PATH="$DOTFILES_PATH"
EOF
fi

if [ ! -f "$HOME/.config/environment.d/00-dotfiles.conf" ]; then
    mkdir -p $HOME/.config/environment.d
    cat >$HOME/.config/environment.d/10-dotfiles.conf <<EOF
DOTFILES_PATH=$DOTFILES_PATH
EOF
fi

# Create custom dotfiles directory if it doesn't exis8t
if [ ! -d "$DOTFILES_CUSTOM_PATH" ]; then
    mkdir -p "$DOTFILES_CUSTOM_PATH/zsh"
    mkdir -p "$DOTFILES_CUSTOM_PATH/completions"
    dotfcustom_files=(
        "aliases"
        "exports"
        "functions"
        "post_zshrc"
    )
    for file in "${dotfcustom_files[@]}"; do
        touch "$DOTFILES_CUSTOM_PATH/zsh/$file"
    done
fi
