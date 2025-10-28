Name = "twitch"
NamePretty = "Twitch"
Icon = "mpv"
FixedOrder = true
Cache = false
Actions = {
    stream = "lua:Launch",
    chat = "lua:OpenChat",
    both = "lua:Both",
}
HideFromProviderlist = false
Description = "Launch stream via livestream binary"
SearchName = true

function GetEntries()
    local json = require("dkjson")
    local entries = {}
    local handle = io.popen("livestream-ctl list")
    if not handle then
        return entries
    end

    if handle then
        -- decode handle json output
        local streams, _, err = json.decode(handle:read("*a"), 1, nil)
        if err then
            print("Error:", err)
            return entries
        end

        for _, stream in ipairs(streams) do
            table.insert(entries, {
                Text = stream.channel,
                Subtext = stream.title,
                Value = stream.channel,
                Icon = stream.thumbnail,
            })
        end
        handle:close()
    end

    return entries
end

function Launch(value, args)
    os.execute("livestream-ctl launch " .. value)
end

function OpenChat(value, args)
    -- Use kitty for emoji support in twitch-tui
    os.execute("kitty -e stream -c -n " .. value)
end

function Both(value, args)
    Launch(value, args)
    OpenChat(value, args)
end
