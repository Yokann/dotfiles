local telescope = require("telescope.themes")

local M = {}

-- @param height number|nil
-- @param width number|nil
-- @param previewer boolean|nil
local function get_dropdown(height, width, previewer)
    height = height or 0.5
    width = width or 0.5
    previewer = previewer or false

    return telescope.get_dropdown({
        previewer = false,
        layout_strategy = "vertical",
        layout_config = {
            height = height,
            width = width,
        },
    })
end

M.get_dropdown = get_dropdown

return M
