-- Copilot and AI assistant plugins configuration
-- Includes: GitHub Copilot, Copilot status indicator, CodeCompanion
local pack = require("pack.util")

pack.lazy({
    plugins = { "L3MON4D3/LuaSnip", "zbirenbaum/copilot.lua" },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        local luasnip = require("luasnip")
        require("copilot").setup({
            panel = {
                enabled = false,
            },
            suggestion = {
                auto_trigger = true,
                hide_during_completion = true,
                keymap = {
                    accept = "<M-l>",
                    accept_word = "<M-i>",
                    accept_line = "<M-o>",
                    next = "<M-j>",
                    prev = "<M-k>",
                    dismiss = "<C-c>",
                },
            },
        })

        -- Disable when snippet.
        vim.api.nvim_create_autocmd("User", {
            pattern = { "LuasnipInsertNodeEnter", "LuasnipInsertNodeLeave" },
            callback = function()
                vim.b.copilot_suggestion_hidden = not luasnip.expand_or_locally_jumpable()
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuOpen",
            callback = function()
                vim.b.copilot_suggestion_hidden = true
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuClose",
            callback = function()
                vim.b.copilot_suggestion_hidden = false
            end,
        })
    end,
})

pack.lazy({
    plugins = { "zbirenbaum/copilot.lua", "jonahgoldwastaken/copilot-status.nvim" },
    event = "VeryLazy",
    config = function()
        require("copilot_status").setup({
            icons = {
                idle = " ",
                error = "✗ ",
                offline = " ",
                warning = "𥉉",
                loading = " ",
            },
            debug = false,
        })
    end,
})

pack.lazy({
    plugins = {
        "j-hui/fidget.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "folke/snacks.nvim",
        "olimorris/codecompanion.nvim",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    config = function()
        -- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
        require("config.codecompanion").setup({
            opts = {
                log_level = "ERROR",
            },
            prompt_library = {
                markdown = {
                    dirs = { vim.fn.stdpath("config") .. "/prompts" },
                },
            },
            display = {
                chat = {
                    show_settings = false,
                    intro_message = "Hello! I'm IA du cul! Press ? for options",
                },
            },
            interactions = {
                chat = {
                    adapter = {
                        name = "claude_code",
                        model = "sonnet",
                    },
                },
                inline = {
                    adapter = {
                        name = "copilot",
                        model = "gpt-5-mini",
                    },
                },
                -- tools = {
                --     opts = {
                --         default_tools = { "insert_edit_into_file" },
                --     },
                -- },
            },
            adapters = {
                acp = {
                    claude_code = function()
                        return require("codecompanion.adapters").extend("claude_code", {
                            env = {
                                CLAUDE_CODE_OAUTH_TOKEN = "cmd:op read op://Arkadev/Anthropic/credential --no-newline",
                            },
                        })
                    end,
                },
            },
        })
    end,
    -- stylua: ignore
    keys = {
            { "<leader>af", "<cmd>CodeCompanionChat toggle<CR>",                                                  mode = "n",          desc = "CodeCompanionChat - Toggle" },
            { "<leader>ap", function() require("codecompanion").actions({ provider = { name = "snacks", } }) end, mode = { "n", "v" }, desc = "CodeCompanionChat - Prompt actions" },
        },
})
