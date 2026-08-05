_HYPR_SETUP_PATH="$DOTFILES_PATH/setup"
_HYPR_SETUP_STATE_PATH="$HOME/.local/state/dotfiles"
mkdir -p $_HYPR_SETUP_STATE_PATH

hyprsetup:get_state_flag() {
    if [[ ! -f "$_HYPR_SETUP_STATE_PATH/installed" ]]; then
        return "first-install"
    else
        return "update"
    fi
}

hyprsetup:mark_as_installed() {
    touch $_HYPR_SETUP_STATE_PATH/installed
}

hyprsetup:source_if_exists() {
    if [[ -f "$1" ]]; then
        source "$1"
    fi
}

hyprsetup:check_dotfiles_path() {
    if [[ -z "$DOTFILES_PATH" ]]; then
        echo "DOTFILES_PATH is not set. Please set it to the path of your dotfiles dir"
        exit 1
    fi
}

# read user input with a prompt and return the input
hyprsetup:prompt() {
    local prompt_message="$1"
    local user_input
    read -p "$prompt_message" user_input
    echo "$user_input"
}

# yes/no prompt with a default value
hyprsetup:yes_no_prompt() {
    local prompt_message="$1"
    local default_value="$2"
    local user_input

    if [ "$default_value" = "y" ]; then
        read -p "$prompt_message [Y/n]: " user_input
        user_input=${user_input:-y}
    else
        read -p "$prompt_message [y/N]: " user_input
        user_input=${user_input:-n}
    fi

    if [[ "$user_input" =~ ^[Yy]$ ]]; then
        return 0 # Yes
    else
        return 1 # No
    fi
}
