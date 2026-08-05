if ! command -v cht.sh &>/dev/null; then
    curl -s https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh
fi

if [ -z "$DOTFILES_CUSTOM_PATH" ]; then
    cht.sh :zsh > "$DOTFILES_CUSTOM_PATH/completions/_cht"
fi
