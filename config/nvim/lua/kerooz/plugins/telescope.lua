return {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-ui-select.nvim",
        {
            "nvim-telescope/telescope-smart-history.nvim",
            dependencies = {
                "kkharji/sqlite.lua",
            },
        },
    },
    opts = function()
        return {
            defaults = {
                file_ignore_patterns = { "^%.git/" },
                history = {
                    path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3",
                    limit = 100,
                },
                mappings = {
                    i = {
                        ["<C-j>"] = require("telescope.actions").cycle_history_next,
                        ["<C-k>"] = require("telescope.actions").cycle_history_prev,
                    },
                    n = {
                        ["q"] = require("telescope.actions").close,
                    },
                },
                dynamic_preview_title = true,
            },
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                ["ui-select"] = {
                    require("kerooz.lib.telescope.helper").get_dropdown(0.5, 20, true),
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    no_ignore = true,
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden", "--trim" }
                    end,
                },
            },
        }
    end,
    config = function(_, opts)
        require("telescope").setup(opts)
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")
        pcall(require("telescope").load_extension, "smart_history")
        pcall(require("telescope").load_extension, "noice")
        require("kerooz.lib.telescope.colorscheme").setPromptStyle("borderless")
    end,
    -- stylua: ignore start
    keys = {
        -- { "<leader>f",   function() require("kerooz.lib.telescope.pickers").prettyFilesPicker({ picker = "find_files" }) end,                              desc = "Find in all Files" },
        -- { "<leader><space>", function() require("kerooz.lib.telescope.pickers").prettyFilesPicker({ picker = "git_files" }) end,                               desc = "Find in Git files" },
        -- {
        --     "<leader>fr",
        --     function()
        --         require("kerooz.lib.telescope.pickers").prettyFilesPicker({ picker = "oldfiles" })
        --     end,
        --     desc = "[F]ind [r]ecently opened files",
        -- },
        -- { "<leader>b",   function() require("telescope.builtin").buffers() end,                                                                            desc = "Find Buffers" },
        -- { "<leader>h",   function() require("telescope.builtin").help_tags() end,                                                                          desc = "Find Help" },
        -- { "<leader>k",   function() require("telescope.builtin").keymaps() end,                                                                            desc = "Find Keymap" },
        -- { "<leader>d",   function() require("telescope.builtin").diagnostics() end,                                                                        desc = "Find Diagnostics" },
        -- { "<leader>gco", function() require("telescope.builtin").git_branches({ show_remote_tracking_branches = false }) end,                              desc = "Git Checkout branch" },
        -- -- { "<leader>fss", function() require('telescope.builtin').treesitter() end, desc = "[F]ind [S]ymbols" },
        -- -- Search
        -- { "<leader>gg",  function() require("kerooz.lib.telescope.pickers").prettyGrepPicker({ picker = "live_grep", options = { debounce = 100 }, }) end, desc = "Live Grep" },
        -- { "<leader>gs",  function() require("kerooz.lib.telescope.pickers").prettyGrepPicker({ picker = "grep_string" }) end,                              desc = "Grep String" },
        -- { "<leader>n",   function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end,                                       desc = "Find Neovim files" },
        -- { "<leader>u",   function() require("telescope.builtin").resume() end },
    },
    -- stylua: ignore end
}
