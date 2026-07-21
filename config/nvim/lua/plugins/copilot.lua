-- Copilot and AI assistant plugins configuration
-- Includes: GitHub Copilot, Copilot status indicator, CodeCompanion, and Claude Code integration
return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip",
        },
        opts = {
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
                    dismiss = "<C-e>",
                },
            },
        },
        config = function(_, opts)
            local copilot = require("copilot.suggestion")
            local luasnip = require("luasnip")
            require("copilot").setup(opts)

            -- Tab is tab when there is no suggestion
            -- vim.keymap.set('i', '<Tab>', function()
            --     if copilot.is_visible() then
            --         copilot.accept()
            --     else
            --         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
            --     end
            -- end, { desc = "Super Tab" })

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
                    copilot.dismiss()
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
    },
    {
        "jonahgoldwastaken/copilot-status.nvim",
        dependencies = { "zbirenbaum/copilot.lua" },
        event = "VeryLazy",
        opts = {
            icons = {
                idle = " ",
                error = "✗ ",
                offline = " ",
                warning = "𥉉",
                loading = " ",
            },
            debug = false,
        },
    },
    {
        "olimorris/codecompanion.nvim",
        enabled = true,
        cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
        dependencies = {
            "j-hui/fidget.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "folke/snacks.nvim",
        },
        -- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
        opts = {
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
        },
        config = function(_, opts)
            require("config.codecompanion").setup(opts)
        end,
        -- stylua: ignore start
        keys = {
            { "<leader>af", "<cmd>CodeCompanionChat toggle<CR>",                                                  mode = "n",          desc = "CodeCompanionChat - Toggle" },
            { "<leader>ap", function() require("codecompanion").actions({ provider = { name = "snacks", } }) end, mode = { "n", "v" }, desc = "CodeCompanionChat - Prompt actions" },
        },
        -- stylua: ignore end
    },
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = false,
        keys = {
            { "<leader>a", nil, desc = "AI/Claude Code" },
            { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
            { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
            {
                "<leader>as",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
            },
            -- Diff management
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
        },
    },
}
