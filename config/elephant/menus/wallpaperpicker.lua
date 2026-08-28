Name = "wallpaperpicker"
NamePretty = "Wallpaper Picker"
Icon = "applications-other"
Cache = true
HideFromProviderlist = false
Description = "Pick a wallpaper from your wallpapers folder:$WALLPAPERS_PATH"
SearchName = true

function GetEntries()
    local entries = {}
    local wallpaper_dir = os.getenv("WALLPAPERS_PATH")
    local hyprland_dir = os.getenv("HYPR_CONFIG_PATH")

    local handle = io.popen(
        "find '"
            .. wallpaper_dir
            .. "' -maxdepth 1 -type f -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' 2>/dev/null"
    )
    if handle then
        for line in handle:lines() do
            local filename = line:match("([^/]+)$")
            if filename then
                table.insert(entries, {
                    Text = filename,
                    Subtext = "wallpaper",
                    Value = line,
                    Actions = {
                        set = hyprland_dir .. "/scripts/wallpaper_picker '" .. line .. "'",
                    },
                    Preview = line,
                })
            end
        end
        handle:close()
    end

    return entries
end
