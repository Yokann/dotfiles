CURRENT_DATE=$(date "+%Y-%m-%d-%H-%M-%S")
XDG_HYPR_CONFIG_PATH=$HOME/.config/hypr

if [ $STATE_FLAG = "first-install" ]; then
    echo "Setting up Hyprland configuration for the first time..."
    if [ -d $XDG_HYPR_CONFIG_PATH ]; then
        echo "Backing up existing Hyprland config to $XDG_HYPR_CONFIG_PATH.bak.$CURRENT_DATE"
        mv $XDG_HYPR_CONFIG_PATH $XDG_HYPR_CONFIG_PATH.bak.$CURRENT_DATE
    fi
    ln -s $DOTFILES_PATH/config/hypr $XDG_HYPR_CONFIG_PATH/config
    touch $XDG_HYPR_CONFIG_PATH/hyprpaper.conf
    touch $XDG_HYPR_CONFIG_PATH/monitors.conf
    touch $XDG_HYPR_CONFIG_PATH/workspaces.conf
    cp $DOTFILES_PATH/config/hypr/themes/2024/hyprqt6engine.conf $XDG_HYPR_CONFIG_PATH/hyprqt6engine.conf

    cat > $XDG_HYPR_CONFIG_PATH/hyprland.lua <<"EOF"
local hyprland = require("config.hyprland")
local opts = {
    enableNvidia = false,
    beforeExecs = function()
        hl.env("HYPR_MAIN_MONITOR", "DP-1", true)
    end,
}
hyprland.setup(opts)
-- To load custom device config
-- hyprland.loadConfig({ "steelseries-aerox" })

hl.on("hyprland.start", function()
--    hl.exec_cmd("easyeffects --gapplication-service")
    hl.exec_cmd("signal-desktop", { no_initial_focus = true, workspace = "6 silent" })
    hl.exec_cmd("1password", { no_initial_focus = true, workspace = "2 silent" })
end)

--require("monitors")
--hl.monitor({
--    output = "DP-1",
--    mode = "3840x2160@60",
--    position = "5097x3101",
--    scale = "1.2",
--})
--hl.monitor({
--    output = "HDMI-A-2",
--    mode = "1920x1080@59.94",
--    position = "3177x3469",
--    scale = "1.0",
--})
EOF

    cat > $XDG_HYPR_CONFIG_PATH/hypridle.conf <<"EOF"
source = $HYPR_CONFIG_PATH/hypridle-laptop.conf
EOF

    gsettings set org.gnome.desktop.interface color-sheme prefer-dark

fi
