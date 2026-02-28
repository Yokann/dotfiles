if [ ! -f "$HOME/.config/mise/config.toml" ]; then
    mkdir -p "$HOME/.config/mise/"
    cat >"$HOME/.config/mise/config.toml"<<'EOF'
[tools]
node = "latest"
yarn = "latest"
EOF
fi
mise use -g node@latest
