return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = {},
        dashboard = {
            sections = {
                { section = "header" },
                {
                    pane = 2,
                    section = "terminal",
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
        explorer = {},
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
                grep = { hidden = true, ignored = true, layout = "wide_with_preview" },
                noice = { layout = "ivy" },
                git_branches = { layout = "vscode" },
                gh_pr = { layout = "wide_with_preview" },
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
        { "<leader>/",       function() Snacks.picker.grep() end,            desc = "Live Grep" },
        -- { "<leader>n", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Neovim config" },
        { "<leader>u",       function() Snacks.picker.resume() end,          desc = "Resume" },
        { "<leader>:",       function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>t",       function() Snacks.explorer() end,               desc = "Open File Explorer" },
        { "<leader>e",       function() Snacks.picker.todo_comments() end,   desc = "Find Todos" },
        { "<leader>git",     function() Snacks.lazygit() end,                desc = "Open LazyGit" },
    },
    -- stylue: ignore end
}
