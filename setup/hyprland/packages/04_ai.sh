if hyprsetup:yes_no_prompt "Do you want to install AI tools?" "n"; then
    yay -S --noconfirm --norebuild --needed \
        claude-desktop-extras \
        herdr-bin \
        claude-code \
        opencode-beta
    uv tool install opentab-ai
fi
