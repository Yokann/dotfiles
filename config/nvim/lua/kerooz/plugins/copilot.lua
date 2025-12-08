return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
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
                    dismiss = "<M-h>",
                },
            },
        },
        config = function(_, opts)
            local cmp = require("cmp")
            local copilot = require("copilot.suggestion")
            local luasnip = require("luasnip")

            require("copilot").setup(opts)

            local function set_trigger(trigger)
                vim.b.copilot_suggestion_auto_trigger = trigger
                vim.b.copilot_suggestion_hidden = not trigger
            end

            -- Hide the completion when menu is open.
            cmp.event:on("menu_opened", function()
                if copilot.is_visible() then
                    copilot.dismiss()
                end
                set_trigger(false)
            end)

            -- Tab is tab when there is no suggestion
            -- vim.keymap.set('i', '<Tab>', function()
            --     if copilot.is_visible() then
            --         copilot.accept()
            --     else
            --         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
            --     end
            -- end, { desc = "Super Tab" })

            -- Disable when snippet.
            cmp.event:on("menu_closed", function()
                set_trigger(not luasnip.expand_or_locally_jumpable())
            end)

            vim.api.nvim_create_autocmd("User", {
                pattern = { "LuasnipInsertNodeEnter", "LuasnipInsertNodeLeave" },
                callback = function()
                    set_trigger(not luasnip.expand_or_locally_jumpable())
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
        },
        opts = {
            opts = {
                log_level = "DEBUG",
            },
        },
        init = function()
            require("kerooz.lib.codecompanion.fidget-spinner").init()
        end,
        -- stylua: ignore start
        keys = {
            -- Show prompts actions with telescope
            { "<leader>ct", "<cmd>CodeCompanionChat<CR>",    mode = "n",          desc = "CodeCompanionChat - Toggle" },
            { "<leader>cp", "<cmd>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "CodeCompanionChat - Prompt actions" },
        },
        -- stylua: ignore end
    },
}
