hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = { colors = { "rgba(595959aa)" } },
        },
        layout = "dwindle",
        allow_tearing = true,
    },
    decoration = {
        rounding = 10,
        blur = {
            enabled = true,
            passes = 1,
        },
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
    },
    dwindle = {
        force_split = 2, -- always split on right/bottom
        preserve_split = true,
    },
    misc = {
        -- See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0, --  Set to 0 to disable the anime mascot wallpapers
        focus_on_activate = 1,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.curve("overshot", { type = "bezier", points = { { 0.13, 0.99 }, { 0.29, 1.10 } } })
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, style = "slide", bezier = "default" })
hl.animation({ leaf = "layers", enabled = true, speed = 2, bezier = "overshot", style = "slide" })
