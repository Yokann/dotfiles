#!/usr/bin/env zsh

set -eEo pipefail

if [ -z "$DOTFILES_PATH" ]; then
    echo "DOTFILES_PATH is not set. Please set it to the path of your dotfiles dir"
    exit 1
fi

DOTFILES_CUSTOM_PATH=${DOTFILES_CUSTOM_PATH:-"$HOME/.dotfiles-custom"}

source $DOTFILES_PATH/setup/hyprland/lib/runtime.sh
source $DOTFILES_PATH/setup/hyprland/lib/log.sh
STATE_FLAG=$(hyprsetup:get_state_flag)

log_section "Update System"
sudo pacman -Syu --noconfirm

log_section "Installing Hyprland and dependencies"
for package_script in $SETUP_PATH/hyprland/packages/*.sh; do
    source $package_script
done

TOOLS_GENERIC_CONFIGS=(
    "zsh"
    "git"
    "starship"
    "btop"
    "neovim"
    "mpv"
    "tmux"
    "fastfetch"
    "foot"
    "yazi"
)

log_section "Configuring tools"
for config in "${TOOLS_GENERIC_CONFIGS[@]}"; do
    hyprsetup:source_if_exists $SETUP_PATH/generic/config/${config}.sh || {
        log_warning "Failed to source ${config} config script. Skipping..."
    }
done

log_section "Configuring Hyprland environment"
for config_script in $SETUP_PATH/hyprland/config/*.sh; do
    log_info "Sourcing config script: $config_script"
    source $config_script
done

hyprsetup:mark_as_installed
