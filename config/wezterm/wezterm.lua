local wezterm = require 'wezterm'
local utils = require 'config.utils'


local scheme_for_appearance = function(appearance)
    if appearance:find "Dark" then
        return "Catppuccin Macchiato"
    else
        return "Catppuccin Latte"
    end
end

local c = {
    color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
    enable_scroll_bar = true,
    font_size = 13.0,
    font = wezterm.font('FiraCode Nerd Font', { weight = 'Medium' }),
    front_end = "WebGpu",
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    window_background_opacity = 0.8,
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
}

if utils.is_darwin() then
    -- Settings to make Qwerty Lafayette usable on macOS ->
    c.send_composed_key_when_left_alt_is_pressed = true
    c.send_composed_key_when_right_alt_is_pressed = false
end

-- then finally apply the plugin
-- these are currently the defaults:
wezterm.plugin.require("https://github.com/nekowinston/wezterm-bar").apply_to_config(c, {
  position = "bottom",
  max_width = 32,
  dividers = "slant_right", -- or "slant_left", "arrows", "rounded", false
  indicator = {
    leader = {
      enabled = true,
      off = " ",
      on = " ",
    },
    mode = {
      enabled = true,
      names = {
        resize_mode = "RESIZE",
        copy_mode = "VISUAL",
        search_mode = "SEARCH",
      },
    },
  },
  tabs = {
    numerals = "arabic", -- or "roman"
    pane_count = "superscript", -- or "subscript", false
    brackets = {
      active = { "", ":" },
      inactive = { "", ":" },
    },
  },
  clock = { -- note that this overrides the whole set_right_status
    enabled = false,
    format = "%H:%M", -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
  },
})

return c
