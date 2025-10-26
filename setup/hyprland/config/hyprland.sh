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

    echo '$configPath = $DOTFILES_PATH/config/hypr' > $XDG_HYPR_CONFIG_PATH/hyprland.conf
    echo '$wallpapersPath = $HOME/Images/wallpapers' >> $XDG_HYPR_CONFIG_PATH/hyprland.conf
    echo '$machineType = laptop' >> $XDG_HYPR_CONFIG_PATH/hyprland.conf
    echo "# To get monitors list: hyprctl monitors | grep 'Monitor' | awk '{print \$2}'" >> $XDG_HYPR_CONFIG_PATH/hyprland.conf
    echo '# env = HYPR_MAIN_MONITOR, DP-1' >> $XDG_HYPR_CONFIG_PATH/hyprland.conf
    echo '# monitor = DP-1, 1920x1080@60, 0x0, 1' >> $XDG_HYPR_CONFIG_PATH/hyprland.conf
    echo 'source = $configPath/hyprland.conf' >> $XDG_HYPR_CONFIG_PATH/hyprland.conf
fi
