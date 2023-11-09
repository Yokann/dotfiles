return {
    "nvim-lua/plenary.nvim",         -- Useful lua functions used ny lots of plugins
    {
        "nvim-lualine/lualine.nvim", -- Status bar
        lazy = false,
        opts = {
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
                    "filename",
                }
            }
        }
    },
    { "tpope/vim-surround",  lazy = false },
    { "tpope/vim-repeat",    lazy = false },
    { "airblade/vim-rooter", lazy = false }, -- load root dir at vim startup on a file
    {
        "ggandor/leap.nvim",                 -- intersting way to move
        lazy = false,
        config = function()
            require("leap").add_default_mappings()
        end
    },
    { "numToStr/Comment.nvim",          lazy = false, opts = {} }, -- comment block
    { "xiyaowong/transparent.nvim",     lazy = false },
    { "christoomey/vim-tmux-navigator", lazy = false },  -- use same keymap to switch pane and buffer
    { "pocco81/auto-save.nvim", lazy = false },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
    },

    -- Aerial
    {
        "stevearc/aerial.nvim", -- move inside code by symbols
        opts = {
            -- optionally use on_attach to set keymaps when aerial has attached to a buffer
            on_attach = function(bufnr)
                -- Jump forwards/backwards with '{' and '}'
                vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
                vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
            end
        },
        keys = {
            { '<leader>te', '<cmd>AerialToggle!<CR>', desc = "Toggle Aerial" }
        }
    },

    -- Nvim Tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        init = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
        opts = {
            update_focused_file = {
                enable = true
            },
            disable_netrw = true,
            diagnostics = {
                enable = true
            },
            git = {
                enable = true,
                timeout = 400 -- (in ms)
            },
            filters = {
                dotfiles = false,
                custom = { "^.git$" }
            },
            trash = {
                cmd = "trash",
                require_confirm = true,
            },
            renderer = {
                highlight_git = true
            }
        },
        keys = {
            { "<leader>tt", function() require('nvim-tree.api').tree.toggle(false, false) end,
                                                                                                  desc =
                "[T]oggle Nvim[T]ree" },
            { "<leader>tr", function() require('nvim-tree.api').tree.focus() end,             desc = "Focus Nvim[T][R]ee" },
        }
    },

    {
        "rmagatti/auto-session", -- restore previous dir session
        dependencies = {
            "nvim-tree/nvim-tree.lua",
            "stevearc/aerial.nvim"
        },
        lazy = false,
        opts = function()
            return {
                log_level = "error",
                auto_session_suppress_dirs = { "~/" },
                cwd_change_handling = {
                    restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
                    pre_cwd_changed_hook = nil,      -- already the default, no need to specify like this, only here as an example
                },
                pre_save_cmds = {
                    require("nvim-tree.api").tree.close,
                    require("aerial").close
                }
            }
        end
    }
}
