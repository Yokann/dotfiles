local home = os.getenv("HOME")
hl.env("HYPR_CONFIG_PATH", ConfigPath, true)
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland", true)
hl.env("XDG_SESSION_DESKTOP", "Hyprland", true)
hl.env("XDG_SESSION_TYPE", "wayland", true)
hl.env("MOZ_ENABLE_WAYLAND", "1", true)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("GDK_SCALE", "1", true)
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
hl.env("XDG_DESKTOP_DIR", home .. "/Desktop", true)
hl.env("XDG_DOWNLOAD_DIR", home .. "/Downloads", true)
hl.env("XDG_TEMPLATES_DIR", home .. "/Templates", true)
hl.env("XDG_PUBLICSHARE_DIR", home .. "/Public", true)
hl.env("XDG_DOCUMENTS_DIR", home .. "/Documents", true)
hl.env("XDG_MUSIC_DIR", home .. "/Music", true)
hl.env("XDG_PICTURES_DIR", home .. "/Pictures", true)
hl.env("XDG_VIDEOS_DIR", home .. "/Videos", true)
hl.env("WALLPAPERS_PATH", home .. "/Pictures/wallpapers", true)
hl.env("HYPRSHOT_DIR", home .. "/Pictures/Screenshots", true)
