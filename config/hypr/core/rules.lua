-- Layer rules
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, animation = "slide top" })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, animation = "slide right" })
hl.layer_rule({ match = { namespace = "walker" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true }) -- slurp selection layer

-- Window rules

hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, float = true })
hl.window_rule({ match = { class = "^(nv-connection-editor)$" }, float = true })
hl.window_rule({ match = { title = ".* is sharing your screen." }, float = true })
hl.window_rule({ match = { title = "Picture-in-Picture" }, float = true })
hl.window_rule({ match = { title = "Save File" }, float = true })
hl.window_rule({ match = { title = "btop" }, float = true })
hl.window_rule({ match = { title = "(Vivaldi Settings:.*)" }, float = true })
hl.window_rule({ match = { title = "Cryptomator" }, float = true })
hl.window_rule({ match = { class = "Manjaro.manjaro-settings-manager" }, float = true })
hl.window_rule({ match = { class = "nwg-look" }, float = true })
hl.window_rule({ match = { class = "ticktick" }, float = true })
hl.window_rule({ match = { class = "firefox" }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { class = "walker" }, no_initial_focus = true })
hl.window_rule({ match = { class = "org.gnome.Calculator" }, float = true, size = { 400, 600 } })
hl.window_rule({ match = { class = "nemo" }, opacity = 0.9 })

-- Video
hl.window_rule({ tag = "+pip", match = { class = "firefox", title = "Picture-in-Picture|Incrustation vidéo" } })
hl.window_rule({ tag = "+pip", match = { class = "mpv" } })
hl.window_rule({
    name = "PiP",
    match = { tag = "pip" },
    float = true,
    no_initial_focus = true,
    monitor = 1,
    move = { 1095, 121 },
    size = { 800, 452 },
})

-- Steam
hl.window_rule({ tag = "+game-launcher", match = { class = "[Ss]team" } })
hl.window_rule({ name = "game-launcher", match = { tag = "game-launcher", workspace = "8:silent" } })

hl.window_rule({ tag = "+steam-floats", match = { title = "Steam", float = true } })
hl.window_rule({
    name = "steam-updater-floating-window",
    match = { tag = "steam-floats" },
    workspace = "8:silent",
    no_focus = true,
})

hl.window_rule({ name = "steam-float-dialogs-and-stuff", match = { title = "SteamTinkerLaunch" }, float = true })
hl.window_rule({ tag = "+misc-game", match = { class = "steam_app.*", title = "^$" } })

hl.window_rule({ name = "non-game-windows-spawned-by-launching-games", match = { tag = "misc-game" }, center = true })

hl.window_rule({ tag = "+game", match = { class = "steam_app_.*", title = "negative:^$" } })
hl.window_rule({
    name = "game-windows",
    match = {
        tag = "game",
    },
    render_unfocused = true, -- fix workspace switches for games
    fullscreen = true,
})

-- 1password
hl.window_rule({
    name = "1Password Quick Access",
    match = {
        class = "1password",
        title = "(Quick Access — 1Password)",
    },
    float = true,
    stay_focused = true,
})

-- Lock screen share on password window
hl.window_rule({
    name = "no-screen-share-apps",
    match = {
        class = "^(polkit-gnome-authentication-agent-1|org.keepassxc.KeePassXC|1password)$",
    },
    no_screen_share = true,
})

-- Discord
hl.window_rule({ name = "Discord", match = { class = "discord" }, workspace = "8:silent" })
