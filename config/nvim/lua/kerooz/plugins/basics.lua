return {
    "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
    { "tpope/vim-surround",   lazy = false },
    { "tpope/vim-repeat",     lazy = false },
    { "tpope/vim-unimpaired", event = "VeryLazy" },
    { "airblade/vim-rooter",  lazy = false }, -- load root dir at vim startup on a file
    { "ku1ik/vim-pasta",      lazy = false }, -- Ajust indentation when pasting code
    {
        "ggandor/leap.nvim",                  -- intersting way to move
        lazy = false,
        config = function()
            require("leap").add_default_mappings()
        end
    },
    { "numToStr/Comment.nvim",          lazy = false, opts = {} }, -- comment block
    { "christoomey/vim-tmux-navigator", lazy = false },            -- use same keymap to switch pane and buffer
    {
        "pocco81/auto-save.nvim",
        enabled = false,
        lazy = false,
        keys = {
            { '<leader>as', '<cmd>ASToggle<CR>', desc = "Toggle autosave" }
        }
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
                enable_check_bracket_line = false,
            })
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    },
    {
        "rmagatti/auto-session", -- restore previous dir session
        lazy = false,
        opts = function()
            vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
            return {
                log_level = "error",
                auto_session_suppress_dirs = { "~/" },
                auto_restore_enabled = false,
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
