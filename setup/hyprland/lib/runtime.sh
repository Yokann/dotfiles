SETUP_PATH="$DOTFILES_PATH/setup"
STATE_PATH="$HOME/.local/state/dotfiles"
mkdir -p $STATE_PATH

hyprsetup:get_state_flag() {
    if [[ ! -f "$STATE_PATH/installed" ]]; then
        return "first-install"
    else
        return "update"
    fi
}

hyprsetup:mark_as_installed() {
    touch $STATE_PATH/installed
}

hyprsetup:source_if_exists() {
    if [[ -f "$1" ]]; then
        source "$1"
    fi
}
