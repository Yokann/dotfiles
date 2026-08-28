hl.env("HYPR_CONFIG_PATH", ConfigPath, true)
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland", true)
hl.env("XDG_SESSION_DESKTOP", "Hyprland", true)
hl.env("XDG_SESSION_TYPE", "wayland", true)
hl.env("MOZ_ENABLE_WAYLAND", "1", true)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("GDK_SCALE", "1", true)
hl.env("HYPR_THEME", ThemeName, true)

-- SDL
hl.env("SDL_VIDEODRIVER", "wayland;x11")

-- Apps
hl.env("TERMINAL", Terminal, true)
hl.env("EDITOR", "nvim", true)
hl.env("XDG_UTILS_TERMINAL", Terminal, true)

-- QT
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1", true)
hl.env("QT_QPA_PLATFORMTHEME", "hyprqt6engine", true)
hl.env("QT_QPA_PLATFORM", "wayland;xcb", true)
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1", true)

-- User directory
local picture_dir = os.getenv("XDG_PICTURES_DIR")
-- or (home .. "/Pictures")
hl.env("WALLPAPERS_PATH", picture_dir .. "/wallpapers", true)
hl.env("HYPRSHOT_DIR", picture_dir .. "/Screenshots", true)
