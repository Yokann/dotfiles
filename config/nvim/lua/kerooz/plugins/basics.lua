return {
    "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
    { "tpope/vim-surround", lazy = false },
    { "tpope/vim-repeat", lazy = false },
    { "tpope/vim-unimpaired", event = "VeryLazy" },
    { "airblade/vim-rooter", lazy = false }, -- load root dir at vim startup on a file
    { "ku1ik/vim-pasta", lazy = false }, -- Ajust indentation when pasting code
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    jump_labels = true,
                },
            },
        },
        -- stylua: ignore start
        keys = {
            { "s",     function() require("flash").jump() end,              mode = { "n", "x", "o" }, desc = "Flash" },
            { "S",     function() require("flash").treesitter() end,        mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
            { "r",     function() require("flash").remote() end,            mode = { "o" },           desc = "Remote Flash" },
            { "R",     function() require("flash").treesitter_search() end, mode = { "o", "x" },      desc = "Treesitter Search" },
            { "<c-s>", function() require("flash").toggle() end,            mode = { "c" },           desc = "Toggle Flash" }
        },
        -- stylua: ignore end
    },
    { "numToStr/Comment.nvim", lazy = false, opts = {} }, -- comment block
    { "christoomey/vim-tmux-navigator", lazy = false }, -- use same keymap to switch pane and buffer
    {
        "pocco81/auto-save.nvim",
        enabled = false,
        lazy = false,
        keys = {
            { "<leader>as", "<cmd>ASToggle<CR>", desc = "Toggle autosave" },
        },
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
        end,
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
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
                    require("snacks.explorer.actions").actions.explorer_close(),
                    require("aerial").close,
                    require("kerooz.dap.init").closeUI,
                },
            }
        end,
    },
    {
        -- Manipulaite array string etc
        "Wansmer/treesj",
        -- stylua: ignore start
        keys = {
            { '<leader>mt', function() require("treesj").toggle() end, desc = 'Toggle' },
            { '<leader>ms', function() require("treesj").split() end,  desc = 'Split' },
            { '<leader>mj', function() require("treesj").join() end,   desc = 'Join' },
        },
        -- stylua: ignore end
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            use_default_keymaps = false,
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        cmd = "LazyDev",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
            },
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            render_modes = true, -- Render in ALL modes
            sign = {
                enabled = false, -- Turn off in the status column
            },
            latex = { enabled = false },
            overrides = {
                filetype = {
                    codecompanion = {
                        html = {
                            tag = {
                                buf = { icon = " ", highlight = "CodeCompanionChatIcon" },
                                file = { icon = " ", highlight = "CodeCompanionChatIcon" },
                                group = { icon = " ", highlight = "CodeCompanionChatIcon" },
                                help = { icon = "󰘥 ", highlight = "CodeCompanionChatIcon" },
                                image = { icon = " ", highlight = "CodeCompanionChatIcon" },
                                symbols = { icon = " ", highlight = "CodeCompanionChatIcon" },
                                tool = { icon = "󰯠 ", highlight = "CodeCompanionChatIcon" },
                                url = { icon = "󰌹 ", highlight = "CodeCompanionChatIcon" },
                            },
                        },
                    },
                },
            },
        },
    },
}
