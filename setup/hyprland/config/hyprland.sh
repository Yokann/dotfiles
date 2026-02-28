CURRENT_DATE=$(date "+%Y-%m-%d-%H-%M-%S")
XDG_HYPR_CONFIG_PATH=$HOME/.config/hypr

if [ $STATE_FLAG = "first-install" ]; then
    echo "Setting up Hyprland configuration for the first time..."
    if [ -d $XDG_HYPR_CONFIG_PATH ]; then
        echo "Backing up existing Hyprland config to $XDG_HYPR_CONFIG_PATH.bak.$CURRENT_DATE"
        mv $XDG_HYPR_CONFIG_PATH $XDG_HYPR_CONFIG_PATH.bak.$CURRENT_DATE
    fi
    mkdir -p $XDG_HYPR_CONFIG_PATH/conf.d
    echo "# Add you overrides values here" > $XDG_HYPR_CONFIG_PATH/conf.d/overrides.conf
    touch $XDG_HYPR_CONFIG_PATH/hypridle.conf
    touch $XDG_HYPR_CONFIG_PATH/hyprpaper.conf
    touch $XDG_HYPR_CONFIG_PATH/monitors.conf
    touch $XDG_HYPR_CONFIG_PATH/workspaces.conf
    cp $DOTFILES_PATH/config/hypr/themes/2024/hyprqt6engine.conf $XDG_HYPR_CONFIG_PATH/hyprqt6engine.conf

    cat > $XDG_HYPR_CONFIG_PATH/hyprland.conf <<"EOF"
$configPath = $DOTFILES_PATH/config/hypr
$wallpapersPath = $XDG_PICTURES_DIR/wallpapers
$machineType = laptop
# To get monitors list: hyprctl monitors | grep 'Monitor' | awk '{print $2}'
# env = HYPR_MAIN_MONITOR, DP-1
# monitor = DP-1, 1920x1080@60, 0x0, 1
source = $configPath/hyprland.conf
source = ./monitors.conf
exec-once = [workspace 6 silent;noinitialfocus] signal-desktop
EOF

fi
