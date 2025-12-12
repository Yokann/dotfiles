return {
    "folke/snacks.nvim",
    priority = 500,
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = {
            sources = {
                explorer = {
                    hidden = true,
                    ignored = false,
                    auto_close = true,
                    watch = true,
                },
                grep = { hidden = true, ignored = true },
                noice = { layout = "ivy" },
                git_branches = { layout = "vscode" },
            },
            previewers = {
                cmd = { "delta" },
            },
        },
        explorer = {},
        lazygit = {},
        bigfile = {},
        dashboard = {
            sections = {
                { section = "header" },
                -- {
                --     pane = 2,
                --     section = "terminal",
                --     cmd = "colorscript -e square",
                --     height = 5,
                --     padding = 1,
                -- },
                { section = "keys", gap = 1, padding = 1 },
                { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                {
                    pane = 2,
                    icon = " ",
                    title = "Git Status",
                    section = "terminal",
                    enabled = function()
                        return Snacks.git.get_root() ~= nil
                    end,
                    cmd = "git status --short --branch --renames",
                    height = 5,
                    padding = 1,
                    ttl = 5 * 60,
                    indent = 3,
                },
                { section = "startup" },
            },
            preset = {
                header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣷⣤⣙⢻⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⡿⠛⠛⠿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⠿⣆⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀
⠀⢀⣾⣿⣿⠿⠟⠛⠋⠉⠉⠀⠀⠀⠀⠀⠀⠉⠉⠙⠛⠻⠿⣿⣿⣷⡀⠀
⣠⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣄
           ]],
            },
        },
    },
    -- stylua: ignore start
    keys = {
        { "<leader><space>", function() Snacks.picker.smart() end,           desc = "Smart Find Files" },
        { "<leader>f",       function() Snacks.picker.files() end,           desc = "Find Files" },
        { "<leader>b",       function() Snacks.picker.buffers() end,         desc = "Find Buffers" },
        { "<leader>h",       function() Snacks.picker.help() end,            desc = "Find Help" },
        { "<leader>k",       function() Snacks.picker.keymaps() end,         desc = "Find Keymaps" },
        { "<leader>dl",      function() Snacks.picker.diagnostics() end,     desc = "Find Diagnostics" },
        { "<leader>gco",     function() Snacks.picker.git_branches() end,    desc = "Git Checkout Branch" },
        { "<leader>gl",      function() Snacks.picker.git_log() end,         desc = "Git Log" },
        { "<leader>gho",     function() Snacks.picker.gh_pr() end,           desc = "Github Checkout PR" },
        { "<leader>gg",      function() Snacks.picker.grep() end,            desc = "Live Grep" },
        -- { "<leader>n", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Neovim config" },
        { "<leader>u",       function() Snacks.picker.resume() end,          desc = "Resume" },
        { "<leader>:",       function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>t",       function() Snacks.explorer() end,               desc = "Open File Explorer" },
        { "<leader>e",       function() Snacks.picker.todo_comments() end,   desc = "Find Todos" },
        { "<leader>git",     function() Snacks.lazygit() end,                desc = "Open LazyGit" },
    },
    -- stylue: ignore end
    ui_select = true,
    layout = "small_no_preview", -- = default layout
    layouts = {                  -- define available layouts
        small_no_preview = {
            layout = {
                box = "horizontal",
                width = 0.65,
                height = 0.6,
                border = "none",
                {
                    box = "vertical",
                    border = vim.o.winborder --[[@as "rounded"|"single"|"double"|"solid"]],
                    title = "{title} {live} {flags}",
                    { win = "input", height = 1,     border = "bottom" },
                    { win = "list",  border = "none" },
                },
            },
        },
        very_vertical = {
            preset = "small_no_preview",
            layout = { height = 0.95, width = 0.45 },
        },
        wide_with_preview = {
            preset = "small_no_preview",
            layout = {
                width = 0.99,
                [2] = { -- as second column
                    win = "preview",
                    title = "{preview}",
                    border = vim.o.winborder --[[@as "rounded"|"single"|"double"|"solid"]],
                    width = 0.5,
                    wo = { number = false, statuscolumn = " ", signcolumn = "no" },
                },
            },
        },
        toggled_preview = { ---@diagnostic disable-line: missing-fields
            preset = "big_preview",
            preview = false, ---@diagnostic disable-line: assign-type-mismatch
        },
        big_preview = {
            preset = "wide_with_preview",
            layout = {
                height = 0.85,
                [2] = { width = 0.6 }, -- second win is the preview
            },
        },
    },
}
