if command -v cargo &>/dev/null; then
    cargo install twitch-tui cargo-watch
else
    echo "Cargo is not installed, skipping installation"
fi
