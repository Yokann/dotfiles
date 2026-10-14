local lib = require("lib")
hl.bind(MainMod .. " + G", lib.exec(Terminal))
hl.bind(MainMod .. " + Q", hl.dsp.window.close())
hl.bind(MainMod .. " + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(MainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" }))
hl.bind(MainMod .. " + F2", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))
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
hl.bind("XF86AudioPlay", lib.exec("playerctl play-pause"))
hl.bind("XF86AudioNext", lib.exec("playerctl next"))
hl.bind("XF86AudioPrev", lib.exec("playerctl previous"))
hl.bind("XF86AudioMute", lib.exec("pamixer -t"))
hl.bind("XF86AudioMicMute", lib.exec("pamixer --default-source -t"))
hl.bind("XF86AudioLowerVolume", lib.exec("pamixer -d 5"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", lib.exec("pamixer -i 5"), { repeating = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", lib.exec("brightnessctl -c backlight set +10%"), { repeating = true })
hl.bind("XF86MonBrightnessDown", lib.exec("brightnessctl -c backlight set 10%-"), { repeating = true })

-- Misc
hl.bind(MainMod .. " + SHIFT + B", lib.exec_uwsm("firefox -P Perso"))
hl.bind(MainMod .. " + B", lib.exec_uwsm("firefox"))
hl.bind(MainMod .. " + C", lib.exec(ConfigPath .. "/scripts/colorpicker"))
hl.bind(MainMod .. " + SHIFT + P", lib.exec("1password --toggle --quick-access"))
hl.bind(MainMod .. " + SHIFT + C", lib.exec("hyprctl reload"))
hl.bind(MainMod .. " + Y", lib.exec(Terminal .. " yazi"))
hl.bind(MainMod .. " + SHIFT + K", lib.exec_uwsm("slack"))
hl.bind(MainMod .. " + SHIFT + F", lib.exec_uwsm("nemo"))
hl.bind(MainMod .. " + SHIFT + N", lib.exec("swaync-client -t -sw")) -- Notifications center
hl.bind(MainMod .. " + SHIFT + A", lib.exec("claude-desktop --toggle"))
hl.bind(MainMod .. " + M", lib.exec("qs ipc call bar-all toggle")) -- Hide quickshell bar
hl.bind(MainMod .. " + W", lib.exec("wayscriber --light-draw-toggle")) -- Hide quickshell bar

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
        hl.dispatch(lib.exec(purgeClipist))
        hl.dispatch(lib.exec("systemctl reboot"))
    end)
    hl.bind("S", function()
        hl.dispatch(lib.exec(purgeClipist))
        hl.dispatch(lib.exec("systemctl poweroff"))
    end)
    hl.bind("E", function()
        hl.dispatch(lib.exec(purgeClipist))
        hl.dispatch(lib.exec("loginctl kill-session $XDG_SESSION_ID"))
    end)
    hl.bind("L", function()
        hl.dispatch(lib.exec("loginctl lock-session"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Screenshot
local submapScreenshot = "(r)egion | (w)indow | rec(o)rd"
hl.bind(MainMod .. " + F6", hl.dsp.submap(submapScreenshot))
hl.define_submap(submapScreenshot, function()
    hl.bind("R", function()
        hl.dispatch(lib.exec("hyprshot -m region"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("W", function()
        hl.dispatch(lib.exec("hyprshot -m window"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("O", function()
        hl.dispatch(lib.exec("recorder"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("escape", hl.dsp.submap("reset"))
end)

if Launcher == "walker" then
    require("core.bind.walker")
end

if Launcher == "vicinae" then
    require("core.bind.vicinae")
end

hl.bind("SUPER + F1", function()
    local game_mode = (hl.get_config("animations.enabled") == false)

    if game_mode then
        hl.exec_cmd("qs ipc call bar-all reveal")
        hl.exec_cmd("hyprctl reload")
        return
    end

    hl.config({
        general = {
            gaps_in = 0,
            gaps_out = 0, -- Disable gaps
            border_size = 0,
        },

        animations = {
            enabled = false, -- Disable animations
        },

        -- Disable blur, shadow and window rounding
        decoration = {
            shadow = { enabled = false },
            blur = { enabled = false },
            rounding = 0,
        },
    })
    hl.exec_cmd("qs ipc call bar-all hide")
end)
