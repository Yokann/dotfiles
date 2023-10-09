return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-ui-select.nvim",
        {
            "nvim-telescope/telescope-smart-history.nvim",
            dependencies = {
                "kkharji/sqlite.lua"
            }
        }
    },
    opts = function()
        return {
            defaults = {
                file_ignore_patterns = { "^%.git/" },
                history = {
                    path = vim.fn.stdpath('data') .. '/telescope_history.sqlite3',
                    limit = 100,
                },
                mappings = {
                    i = {
                        ["<C-j>"] = require('telescope.actions').cycle_history_next,
                        ["<C-k>"] = require('telescope.actions').cycle_history_prev,
                    }
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = 'smart_case',       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(
                        {
                            layout_strategy = 'vertical',
                            layout_config = {
                                prompt_position = 'bottom',
                                vertical = {
                                    width = 0.5,
                                    height = 20,
                                },
                            },
                        }
                    )
                }
            },
            pickers = {
                find_files = {
                    hidden = true,
                    no_ignore = true,
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end
                }
            }
        }
    end,
    config = function(_, opts)
        local telescope = require('telescope')
        telescope.setup(opts)
        telescope.load_extension('fzf')
        telescope.load_extension('ui-select')
        telescope.load_extension('smart_history')
    end,
    keys = {
        { "<leader>ff",      function() require('telescope.builtin').find_files() end,            desc =
        "[F]ind in all [F]iles" },
        { "<leader><space>", function() require('telescope.builtin').git_files() end,             desc =
        "[F]ind in [G]it files" },
        { "<leader>fr",      function() require('telescope.builtin').oldfiles() end,
                                                                                                      desc =
            "[F]ind [r]ecently opened files" },
        { "<leader>fb",      function() require('telescope.builtin').buffers() end,               desc =
        "[F]ind [B]uffers" },
        { "<leader>fh",      function() require('telescope.builtin').help_tags() end,             desc = "[F]ind [H]elp" },
        { "<leader>fk",      function() require('telescope.builtin').keymaps() end,               desc =
        "[F]ind [K]eymap" },
        { "<leader>fd",      function() require('telescope.builtin').diagnostics() end,           desc =
        "[F]ind [D]iagnostics" },
        { "<leader>fss",     function() require('telescope.builtin').treesitter() end,            desc =
        "[F]ind [S]ymbols" },
        -- Search
        { "<leader>gg",      function() require('telescope.builtin').live_grep() end,             desc = "Live [G]rep" },
        -- LSP
        { "gr",              function() require('telescope.builtin').lsp_references() end,        desc =
        "[G]oto [R]eferences" },
        { "<leader>fs",      function() require('telescope.builtin').lsp_workspace_symbols() end,
                                                                                                      desc =
            "[F]ind [S]ymbols" },
    }
}
