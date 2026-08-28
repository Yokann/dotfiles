hl.on("hyprland.start", function()
    hl.exec_cmd(
        Uwsm
            .. "swaync -c "
            .. DotfilesPath
            .. "/config/swaync/config.json -s "
            .. DotfilesPath
            .. "/config/swaync/style-"
            .. ThemeName
            .. ".css"
    )
end)
