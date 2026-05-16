hl.on("hyprland.start", function()
    hl.exec_cmd(
        Uwsm
            .. "swaync -c "
            .. ConfigPath
            .. "themes/2024/dots/swaync/config.json -s "
            .. ConfigPath
            .. "/themes/2024/dots/swaync/style.css"
    )
end)
