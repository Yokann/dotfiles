Name = "shaders"
NamePretty = "Shaders Picker"
Icon = "oilpaint"
Cache = true
HideFromProviderlist = false
Description = "Pick a shader for Hyprland"
SearchName = true

function GetEntries()
    local entries = {}
    local hyprland_dir = os.getenv("HYPR_CONFIG_PATH")

    local handle =
        io.popen("find '" .. hyprland_dir .. "/shaders" .. "' -maxdepth 1 -type f -name '*.glsl' 2>/dev/null")
    if handle then
        table.insert(entries, {
            Text = "Off",
            Value = "off",
            Actions = {
                set = hyprland_dir .. "/scripts/switch_shader",
            },
        })
        for line in handle:lines() do
            local filename = line:match("([^/]+)$")
            if filename then
                table.insert(entries, {
                    Text = filename,
                    Value = line,
                    Actions = {
                        set = hyprland_dir .. "/scripts/switch_shader '" .. filename .. "'",
                    },
                })
            end
        end
        handle:close()
    end

    return entries
end
