return {
    "nvim-lua/plenary.nvim",         -- Useful lua functions used ny lots of plugins
    {
        "nvim-lualine/lualine.nvim", -- Status bar
        lazy = false,
        opts = {
            theme = "catppuccin",
            --     options = {
            --         disabled_filetypes = {
            --             'NvimTree', 'DapBreakpoint', 'DapScope', 'DapStack'
            --         }
            --     }
            -- }
            sections = {
                lualine_b = {
                    { "branch", icon = "" },
                    {
                        "diff",
                        colored = true,
                        -- diff_color = {
                        --     added    = { fg = "#28A745" },
                        --     modified = { fg = "#DBAB09" },
                        --     removed  = { fg = "#D73A49" }
                        -- },
                        symbols = {
                            added    = " ",
                            modified = " ",
                            removed  = " "
                        }
                    },
                    -- { "diagnostics' }
                },
                lualine_c = {
                    "diagnostics",
                    { "filename", path = 1 },
                },
                lualine_x = {
                    'encoding', 'fileformat', 'filetype',
                    {
                        function() return require("copilot_status").status_string() end,
                        cnd = function() return require("copilot_status").enabled() end
                    },
                }
            }
        }
    },
    { "tpope/vim-surround",   lazy = false },
    { "tpope/vim-repeat",     lazy = false },
    { "tpope/vim-unimpaired", lazy = false },
    { "airblade/vim-rooter",  lazy = false }, -- load root dir at vim startup on a file
    {
        "ggandor/leap.nvim",                  -- intersting way to move
        lazy = false,
        config = function()
            require("leap").add_default_mappings()
        end
    },
    { "numToStr/Comment.nvim",          lazy = false, opts = {} }, -- comment block
    { "christoomey/vim-tmux-navigator", lazy = false }, -- use same keymap to switch pane and buffer
    {
        "pocco81/auto-save.nvim",
        lazy = false,
        keys = {
            { '<leader>as', '<cmd>ASToggle<CR>', desc = "Toggle autosave" }
        }
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    },
    {
        "rmagatti/auto-session", -- restore previous dir session
        lazy = false,
        opts = function()
            vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
            return {
                log_level = "error",
                auto_session_suppress_dirs = { "~/" },
                auto_restore_enabled = true,
                auto_session_create_enabled = true,
                pre_save_cmds = {
                    -- close everything useless before save session
                    require("nvim-tree.api").tree.close,
                    require("aerial").close,
                    require("kerooz.dap.init").closeUI
                }
            }
        end
    },
    {
        -- Manipulaite array string etc
        'Wansmer/treesj',
        keys = {
            { '<leader>mjt', function() require("treesj").toggle() end, desc = 'Toggle' },
            { '<leader>mjs', function() require("treesj").split() end,  desc = 'Split' },
            { '<leader>mjj', function() require("treesj").join() end,   desc = 'Join' },
        },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            use_default_keymaps = false,
        }
    },
}
