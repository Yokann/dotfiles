curl https://mise.run | sh
if [ -f "$HOME/.local/bin/mise" ]; then
    echo "Mise installed successfully!"
    eval "$(mise activate --shims)"
    mise use -g go
    mise use -g node npm
    # Setup dummy package to replace the default package manager with Mise
    for pkg in "$DOTFILES_PATH/setup/hypr/assets/pkg/*"; do
        makepkg -si --noconfirm -D $pkg
    done
else
    echo "Failed to install Mise. Please check the installation script for errors."
fi
