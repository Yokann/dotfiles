local pack = require("pack.util")

pack.add({ "folke/snacks.nvim" })
require("snacks").setup({
    bigfile = {},
    scroll = {
        animate = {
            easing = "inOutSine",
        },
    },
    dashboard = {
        sections = {
            { section = "header" },
            {
                pane = 2,
                section = "terminal",
                enabled = function()
                    return vim.fn.executable("colorscript") == 1
                end,
                cmd = "colorscript -e fade",
                height = 5,
                padding = 1,
            },
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
            -- the built-in "startup" section depends on lazy.nvim, show the plugin count instead
            function()
                local count = #vim.pack.get()
                return { { text = { { "⚡ " .. count .. " plugins", hl = "footer" } }, align = "center" } }
            end,
        },
        preset = {
            -- Default keys, except "Restore Session": snacks only detects session plugins
            -- through lazy.nvim, so auto-session is wired by hand (and the "Lazy" entry is dropped).
            -- stylua: ignore
            keys = {
                { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                { icon = " ", key = "s", desc = "Restore Session", action = ":AutoSession restore" },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
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
    explorer = {
        replace_netrw = true,
        trash = true,
    },
    ---@type snacks.indent.Config
    indent = {
        enabled = true,
        animate = {
            enabled = false,
        },
    },
    lazygit = {},
    picker = {
        sources = {
            files = {
                hidden = true,
                ignored = false,
                layout = "wide_with_preview",
            },
            explorer = {
                layout = "sidebar",
                hidden = true,
                ignored = false,
                auto_close = true,
                watch = true,
            },
            grep = {
                hidden = true,
                ignored = true,
                exclude = { ".git", "node_modules", "vendor" },
                layout = "wide_with_preview",
            },
            noice = { layout = "ivy" },
            git_branches = { layout = "vscode" },
            gh_pr = { layout = "big_preview" },
            gh_diff = { layout = "big_preview" },
            git_log = { layout = "wide_with_preview" },
            todo_comments = { layout = "ivy" },
            -- select = { layout = "basic_no_preview" },
        },
        previewers = {
            cmd = { "delta" },
        },
        ui_select = true,
        layout = "basic_no_preview",
        layouts = { -- define available layouts
            basic_no_preview = {
                layout = {
                    box = "horizontal",
                    width = 0.5,
                    height = 0.6,
                    border = "none",
                    {
                        title = "{title} {live} {flags}",
                        title_pos = "center",
                        border = "vpad", -- invisible border: a title needs a border row to be drawn
                        box = "vertical",
                        { win = "input", height = 1, border = "vpad" },
                        { win = "list", border = "none" },
                    },
                },
            },
            wide_with_preview = {
                preset = "basic_no_preview",
                layout = {
                    preview = "table",
                    width = 0.90,
                    [2] = {
                        win = "preview",
                        title = "{preview}",
                        title_pos = "center",
                        border = "vpad",
                        width = 0.5,
                        wo = { number = false, statuscolumn = " ", signcolumn = "no" },
                    },
                },
            },
            big_preview = {
                preset = "wide_with_preview",
                layout = {
                    height = 0.85,
                    [2] = { width = 0.6 },
                },
            },
        },
    },
})

-- stylua: ignore
for _, k in ipairs({
        { "<leader><space>", function() Snacks.picker.smart() end,           desc = "Smart Find Files" },
        { "<leader>f",       function() Snacks.picker.files() end,           desc = "Find Files" },
        { "<leader>b",       function() Snacks.picker.buffers() end,         desc = "Find Buffers" },
        { "<leader>h",       function() Snacks.picker.help() end,            desc = "Find Help" },
        { "<leader>k",       function() Snacks.picker.keymaps() end,         desc = "Find Keymaps" },
        { "<leader>dl",      function() Snacks.picker.diagnostics() end,     desc = "Find Diagnostics" },
        { "<leader>gco",     function() Snacks.picker.git_branches() end,    desc = "Git Checkout Branch" },
        { "<leader>gl",      function() Snacks.picker.git_log() end,         desc = "Git Log" },
        { "<leader>gho",     function() Snacks.picker.gh_pr() end,           desc = "Github Checkout PR" },
        { "<leader>/",       function() Snacks.picker.grep() end,            desc = "Live Grep" },
        -- { "<leader>n", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Neovim config" },
        { "<leader>u",       function() Snacks.picker.resume() end,          desc = "Resume" },
        { "<leader>:",       function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>yy",      function() Snacks.picker.registers() end,       desc = "Yank registers" },
        { "<leader>t",       function() Snacks.explorer() end,               desc = "Open File Explorer" },
        { "<leader>e",       function() Snacks.picker.todo_comments() end,   desc = "Find Todos" },
        { "<leader>git",     function() Snacks.lazygit() end,                desc = "Open LazyGit" },
    }) do
    vim.keymap.set(k.mode or "n", k[1], k[2], { desc = k.desc })
end
