sudo pacman -S --noconfirm --needed mise

if command -v mise &>/dev/null; then
    echo "Mise installed successfully!"
    eval "$(mise activate --shims)"
    mise use -g go
    mise use -g node npm yarn pnpm
    # Setup dummy package to replace the default package manager with Mise
    for pkg in "$DOTFILES_PATH"/setup/hyprland/assets/pkg/*; do
        makepkg -si --noconfirm -D "$pkg"
    done
else
    echo "Failed to install Mise. Please check the installation script for errors."
fi
