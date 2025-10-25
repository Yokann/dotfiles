if command -v cargo &> /dev/null; then
    cargo install pomodoro-cli twitch-tui
else
    echo "Cargo is not installed, skipping installation"
fi
