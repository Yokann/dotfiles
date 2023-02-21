local ok, cybu = pcall(require, "cybu")
if not ok then
    return
end

cybu.setup({
    position = {
        anchor = "topright",
        vertical_offset = 2,
    },
    style = {
        path = "relative", -- absolute, relative, tail (filename only)
        path_abbreviation = "none", -- none, shortened
        border = "rounded", -- single, double, rounded, none
        separator = " ", -- string used as separator
        prefix = "…", -- string used as prefix for truncated paths
        padding = 1, -- left & right padding in number of spaces
        hide_buffer_id = true, -- hide buffer IDs in window
        devicons = {
            enabled = true, -- enable or disable web dev icons
            colored = true, -- enable color for web dev icons
            truncate = true, -- truncate wide icons to one char width
        },
        highlights = { -- see highlights via :highlight
            current_buffer = "CybuFocus", -- current / selected buffer
            adjacent_buffers = "CybuAdjacent", -- buffers not in focus
            background = "CybuBackground", -- window background
            border = "CybuBorder", -- border of the window
        },
    },
    behavior = { -- set behavior for different modes
        mode = {
            default = {
                switch = "immediate", -- immediate, on_close
                view = "paging", -- paging, rolling
            },
            last_used = {
                switch = "on_close", -- immediate, on_close
                view = "paging", -- paging, rolling
            },
            auto = {
                view = "rolling", -- paging, rolling
            },
        },
        show_on_autocmd = false, -- event to trigger cybu (eg. "BufEnter")
    },
    display_time = 2000,
})
vim.keymap.set("n", "<A-k>", "<Plug>(CybuPrev)", { noremap = true })
vim.keymap.set("n", "<A-j>", "<Plug>(CybuNext)", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-s-tab>", "<plug>(CybuLastusedPrev)",
    { desc = "Previous last used buffer" })
vim.keymap.set({ "n", "v" }, "<c-tab>", "<plug>(CybuLastusedNext)", { desc = "Next last used buffer " })
