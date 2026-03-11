if [ ! -f "/etc/profile.d/dotfiles.sh" ]; then
    cat > /tmp/dotfiles.sh <<EOF
export DOTFILES_PATH="$DOTFILES_PATH"
EOF
    sudo cp /tmp/dotfiles.sh /etc/profile.d/dotfiles.sh
fi

if [ ! -f "$HOME/.config/environment.d/00-dotfiles.conf" ]; then
    mkdir -p $HOME/.config/environment.d
    cat > $HOME/.config/environment.d/10-dotfiles.conf << EOF
DOTFILES_PATH=$DOTFILES_PATH
PATH=${HOME}/.local/bin:${HOME}/.cargo/bin:${HOME}/go/bin:${PATH}
EOF
fi

