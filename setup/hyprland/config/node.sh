mkdir -p "$HOME/.config/mise/"
cat >"$HOME/.config/mise/config.toml"<<'EOF'
[tools]
node = "latest"
yarn = "latest"
EOF

mise use -g node@latest
