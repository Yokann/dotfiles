hl.bind(MainMod .. " + G", hl.dsp.exec_cmd(Terminal))
hl.bind(MainMod .. " + Q", hl.dsp.window.close())
hl.bind(MainMod .. " + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(MainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))

hl.bind(MainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(MainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(MainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(MainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(MainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(MainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(MainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(MainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Workspace bindings
for i = 1, 10 do
    local key = i % 10
    hl.bind(MainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(MainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(MainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Scratchpad
hl.bind(MainMod .. " + SHIFT + I", hl.dsp.window.move({ workspace = "special:special", follow = false }))
hl.bind(MainMod .. " + I", hl.dsp.workspace.toggle_special("special"))

-- Layout bindings
hl.bind(MainMod .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(MainMod .. " + S", hl.dsp.layout("swapsplit"))
hl.bind(MainMod .. " + SHIFT + T", hl.dsp.group.toggle())
hl.bind(MainMod .. " + ALT_L + J", hl.dsp.group.next())
hl.bind(MainMod .. " + ALT_L + K", hl.dsp.group.prev())

-- Move/resize windows with MainMod + LMB/RMB and dragging
hl.bind(MainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(MainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Audio
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source -t"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { repeating = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -c backlight set +10%"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -c backlight set 10%-"), { repeating = true })

-- Clipboard
hl.bind(MainMod .. " + V", hl.dsp.exec_cmd("walker -m clipboard"))

-- Misc
hl.bind(MainMod .. " + SHIFT + B", hl.dsp.exec_cmd(Uwsm .. "firefox -P Perso"))
hl.bind(MainMod .. " + B", hl.dsp.exec_cmd(Uwsm .. "firefox"))
hl.bind(MainMod .. " + C", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(MainMod .. " + SHIFT + P", hl.dsp.exec_cmd("1password --toggle --quick-access"))
hl.bind(MainMod .. " + SHIFT + C", hl.dsp.exec_cmd(ConfigPath .. "/scripts/colorpicker"))
hl.bind(MainMod .. " + Y", hl.dsp.exec_cmd(Uwsm .. "fontclient yazi"))
hl.bind(MainMod .. " + SHIFT + K", hl.dsp.exec_cmd(Uwsm .. "slack"))
hl.bind(MainMod .. " + SHIFT + F", hl.dsp.exec_cmd(Uwsm .. "nemo"))
hl.bind(MainMod .. " + SHIFT + J", hl.dsp.exec_cmd("walker -m windows"))
hl.bind(MainMod .. " + SHIFT + Y", hl.dsp.exec_cmd("walker -m menus:twitch"))
hl.bind(MainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw")) -- Notifications center
hl.bind(MainMod .. " + SHIFT + A", hl.dsp.exec_cmd("claude-desktop --toggle"))
hl.bind(MainMod .. " + M", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar")) -- Hide waybar

-- Walker
hl.bind(MainMod .. " + O", hl.dsp.exec_cmd(ConfigPath .. "/scripts/audio_switcher"))
hl.bind(MainMod .. " + D", hl.dsp.exec_cmd("walker"))
hl.bind(MainMod .. " + SHIFT + D", hl.dsp.submap("walker"))
hl.define_submap("walker", function()
    hl.bind("S", function()
        hl.dispatch(hl.dsp.exec_cmd("walker -m websearch"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("F", function()
        hl.dispatch(hl.dsp.exec_cmd("walker -m finder"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("E", function()
        hl.dispatch(hl.dsp.exec_cmd("walker -m symbols"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("W", function()
        hl.dispatch(hl.dsp.exec_cmd("walker -m menus:wallpaperpicker"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Resize
hl.bind("SUPER + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    hl.bind("SHIFT + L", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
    hl.bind("SHIFT + H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
    hl.bind("SHIFT + K", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
    hl.bind("SHIFT + J", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Shutdown mode
local submapPower = "(r)eboot | (s)hutdown | (e)xit | (l)ock"
local purgeClipist = "rm -f $HOME/.cache/cliphist/db"
hl.bind(MainMod .. " + SHIFT + E", hl.dsp.submap(submapPower))
hl.define_submap(submapPower, function()
    hl.bind("R", function()
        hl.dispatch(hl.dsp.exec_cmd(purgeClipist))
        hl.dispatch(hl.dsp.exec_cmd("systemctl reboot"))
    end)
    hl.bind("S", function()
        hl.dispatch(hl.dsp.exec_cmd(purgeClipist))
        hl.dispatch(hl.dsp.exec_cmd("systemctl poweroff"))
    end)
    hl.bind("E", function()
        hl.dispatch(hl.dsp.exec_cmd(purgeClipist))
        hl.dispatch(hl.dsp.exec_cmd("systemctl --user exit"))
    end)
    hl.bind("L", function()
        hl.dispatch(hl.dsp.exec_cmd("loginctl lock-session"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("escape", hl.dsp.submap("reset"))
end)
