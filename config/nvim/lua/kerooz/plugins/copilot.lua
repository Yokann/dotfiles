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
        event = "VeryLazy",
        dependencies = {
            "j-hui/fidget.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "folke/snacks.nvim",
        },
        opts = {
            opts = {
                log_level = "ERROR",
            },
        },
        init = function()
            require("kerooz.lib.codecompanion.fidget-spinner").init()
        end,
        -- stylua: ignore start
        keys = {
            { "<leader>ct", "<cmd>CodeCompanionChat<CR>",                                                         mode = "n",          desc = "CodeCompanionChat - Toggle" },
            { "<leader>cp", function() require("codecompanion").actions({ provider = { name = "snacks", } }) end, mode = { "n", "v" }, desc = "CodeCompanionChat - Prompt actions" },
        },
        -- stylua: ignore end
    },
}
