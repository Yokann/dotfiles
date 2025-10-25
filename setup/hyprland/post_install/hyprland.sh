CURRENT_DATE=$(date "+%Y-%m-%d-%H-%M-%S")
mv $HOME/.config/hypr $HOME/.config/hypr.bak.$CURRENT_DATE
mkdir -p $HOME/.config/hypr/conf.d
touch $HOME/.config/hypr/conf.d/overrides.conf
touch $HOME/.config/hypr/hypridle.conf
echo '$configPath = $DOTFILES_PATH/config/hypr' > $HOME/.config/hypr/hyprland.conf
echo '$wallpapersPath = $HOME/Images/wallpapers' >> $HOME/.config/hypr/hyprland.conf
echo '$machineType = laptop' >> $HOME/.config/hypr/hyprland.conf
echo '# env = HYPR_MAIN_MONITOR, DP-1'
echo 'source = $configPath/hyprland.conf' >> $HOME/.config/hypr/hyprland.conf
