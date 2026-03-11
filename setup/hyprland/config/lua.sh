if [ ! -f "/etc/profile.d/luarock.sh" ]; then
    sudo cp $DOTFILES_PATH/setup/hyprland/assets/etc/profile.d/luarock.sh /etc/profile.d/luarock.sh
fi

# We need luarocks to be in systemd env for Twitch walker menu
if [ ! -f "$HOME/.config/environment.d/10-luarocks.conf" ]; then
    mkdir -p $HOME/.config/environment.d
    source (luarocks path --no-bin)
    cat > $HOME/.config/environment.d/10-luarocks.conf << EOF
    LUA_PATH="$LUA_PATH"
    LUA_CPATH="$LUA_CPATH"
EOF
fi
