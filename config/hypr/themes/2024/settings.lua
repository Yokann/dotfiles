hl.config({
    general = {
        gaps_in = 8,
        gaps_out = 8,
        border_size = 3,
        col = {
            active_border = { colors = { "rgba(A8C5E655)", "rgba(f1a7e2ff)" }, angle = 45 },
            inactive_border = { colors = { "0x000B0A10" } },
        },
    },
    decoration = {
        rounding = 5,
        blur = {
            enabled = true,
            size = 8,
            passes = 2,
            new_optimizations = true,
            xray = true,
        },
        shadow = {
            enabled = true,
            range = 15,
            render_power = 2,
            offset = { 0, 4 },
            color = "0x55000000",
            color_inactive = "0x55000000",
        },
    },
    group = {
        col = {
            border_active = { colors = { "rgba(A8C5E6ff)", "rgba(f1a7e2ff)" }, angle = 45 },
            border_inactive = { colors = { "0x000B0A10" } },
        },
        groupbar = {
            gaps_in = 5,
            height = 20,
            font_family = "Cantarell",
            font_size = 11,
            text_color = "0xFFFFFFFF",
            col = {
                active = "rgba(c6a0f6ff)",
                inactive = "rgba(8aadf455)",
            },
        },
    },
})

hl.curve("linear", { type = "bezier", points = { { 0.1, 0.1 }, { 0.1, 0.1 } } })
hl.animation({ leaf = "borderangle", enabled = true, speed = 4, bezier = "linear", style = "once" })
