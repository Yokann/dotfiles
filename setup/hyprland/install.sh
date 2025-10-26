#!/usr/bin/env zsh

set -eE+o pipefail

if [ -z "$DOTFILES_PATH" ]; then
    echo "DOTFILES_PATH is not set. Please set it to the path of your dotfiles dir"
    exit 1
fi

SETUP_PATH="$DOTFILES_PATH/setup"
STATE_PATH="$HOME/.local/state/dotfiles"
mkdir -p $STATE_PATH

# Set zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as default shell..."
    sudo chsh -s $(which zsh) $USER
fi

sudo pacman -Syu --noconfirm

source $SETUP_PATH/hyprland/pre_install/init.sh

# Install dependencies
for package_script in $SETUP_PATH/hyprland/packages/*.sh; do
    source $package_script
done

# Post install deps configurations
source $SETUP_PATH/generic/config/git.sh
source $SETUP_PATH/generic/config/starship.sh
source $SETUP_PATH/generic/config/btop.sh
source $SETUP_PATH/generic/config/neovim.sh
source $SETUP_PATH/generic/config/zsh.sh
source $SETUP_PATH/generic/config/tmux.sh

# Core config
source $SETUP_PATH/hyprland/config/gtk-theme.sh
source $SETUP_PATH/hyprland/config/walker.sh
source $SETUP_PATH/hyprland/config/keyboard.sh
source $SETUP_PATH/hyprland/config/mimetypes.sh
source $SETUP_PATH/hyprland/config/systemd.sh
source $SETUP_PATH/hyprland/config/hyprland.sh

touch $STATE_PATH/installed
