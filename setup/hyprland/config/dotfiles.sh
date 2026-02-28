if [ ! -f "/etc/profile.d/dotfiles.sh" ]; then
    cat > /tmp/dotfiles.sh <<EOF
export DOTFILES_PATH="$DOTFILES_PATH"
EOF
    sudo cp /tmp/dotfiles.sh /etc/profile.d/dotfiles.sh
fi

