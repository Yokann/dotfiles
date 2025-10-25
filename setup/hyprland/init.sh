#!/usr/bin/env zsh

set -e

if [ -z "$DOTFILES_PATH" ]; then
    echo "DOTFILES_PATH is not set. Please set it to the path of your dotfiles dir"
    exit 1
fi

SETUP_PATH="$DOTFILES_PATH/setup"

# Set zsh as default shell
sudo chsh -s $(which zsh) $USER

sudo pacman -Syu --noconfirm

# Install dependencies
source $SETUP_PATH/hyprland/install/packages/00_core.sh
source $SETUP_PATH/hyprland/install/packages/01_adds_deps.sh
source $SETUP_PATH/hyprland/install/packages/02_cargo.sh

# Post install configurations
source $SETUP_PATH/generic/post_install/git.sh
source $SETUP_PATH/generic/post_install/starship.sh
source $SETUP_PATH/generic/post_install/btop.sh
source $SETUP_PATH/generic/post_install/neovim.sh
source $SETUP_PATH/generic/post_install/zsh.sh
source $SETUP_PATH/generic/post_install/tmux.sh
source $SETUP_PATH/hyprland/post_install/keyboard.sh
source $SETUP_PATH/hyprland/post_install/walker.sh
source $SETUP_PATH/hyprland/post_install/hyprland.sh

# Set default applications
xdg-mime default nemo.desktop inode/directory
xdg-mime default nvim.desktop text/plain

# Enable services
sudo systemctl enable greetd.service NetworkManager.service cups.service cups-browsed.service
