local pack = require("pack.util")

pack.add({
    "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "airblade/vim-rooter", -- load root dir at vim startup on a file
    "ku1ik/vim-pasta", -- Adjust indentation when pasting code
    "christoomey/vim-tmux-navigator", -- use same keymap to switch pane and buffer
})

pack.lazy({ plugins = "tpope/vim-unimpaired", event = "VeryLazy" })

pack.lazy({
    plugins = "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
        require("flash").setup({
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    jump_labels = true,
                },
            },
        })
    end,
    -- stylua: ignore
    keys = {
            { "s",     function() require("flash").jump() end,              mode = { "n", "x", "o" }, desc = "Flash" },
            { "S",     function() require("flash").treesitter() end,        mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
            { "r",     function() require("flash").remote() end,            mode = { "o" },           desc = "Remote Flash" },
            { "R",     function() require("flash").treesitter_search() end, mode = { "o", "x" },      desc = "Treesitter Search" },
            { "<c-s>", function() require("flash").toggle() end,            mode = { "c" },           desc = "Toggle Flash" }
        },
})

pack.lazy({
    plugins = "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true,
            enable_check_bracket_line = false,
        })
    end,
})

-- restore previous dir session
pack.add({ "rmagatti/auto-session" })
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
require("auto-session").setup({
    log_level = "error",
    suppressed_dirs = { "~/", "/" },
    auto_restore = false,
    auto_restore_last_session = false,
    auto_create = true,
    pre_save_cmds = {
        -- close everything useless before save session (resolved lazily: nvim-dap may not be loaded yet)
        function(...)
            require("snacks.explorer.actions").actions.explorer_close(...)
        end,
        function(...)
            require("aerial").close(...)
        end,
        function(...)
            require("config.dap").closeUI(...)
        end,
    },
})

-- Manipulate array, string, etc.
pack.lazy({
    plugins = "Wansmer/treesj",
    config = function()
        require("treesj").setup({ use_default_keymaps = false })
    end,
    -- stylua: ignore
    keys = {
        { "<leader>mt", function() require("treesj").toggle() end, desc = "Toggle" },
        { "<leader>ms", function() require("treesj").split() end,  desc = "Split" },
        { "<leader>mj", function() require("treesj").join() end,   desc = "Join" },
    },
})

pack.lazy({
    plugins = "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    config = function()
        require("lazydev").setup({
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
            },
        })
    end,
})

pack.lazy({
    plugins = { "MeanderingProgrammer/render-markdown.nvim", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown", "codecompanion" },
    config = function()
        require("render-markdown").setup({
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
        })
    end,
})
