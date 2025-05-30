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
                    accept = '<M-l>',
                    accept_word = '<M-i>',
                    accept_line = '<M-o>',
                    next = '<M-j>',
                    prev = '<M-k>',
                    dismiss = '<M-h>',
                },
            }
        },
        config = function(_, opts)
            local cmp = require 'cmp'
            local copilot = require 'copilot.suggestion'
            local luasnip = require 'luasnip'

            require('copilot').setup(opts)

            local function set_trigger(trigger)
                vim.b.copilot_suggestion_auto_trigger = trigger
                vim.b.copilot_suggestion_hidden = not trigger
            end

            -- Hide the completion when menu is open.
            cmp.event:on('menu_opened', function()
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
            cmp.event:on('menu_closed', function()
                set_trigger(not luasnip.expand_or_locally_jumpable())
            end)

            vim.api.nvim_create_autocmd('User', {
                pattern = { 'LuasnipInsertNodeEnter', 'LuasnipInsertNodeLeave' },
                callback = function()
                    set_trigger(not luasnip.expand_or_locally_jumpable())
                end,
            })
        end,
    },
    {
        "jonahgoldwastaken/copilot-status.nvim",
        dependencies = { "zbirenbaum/copilot.lua" },
        lazy = true,
        opts = {
            icons = {
                idle = " ",
                error = "✗ ",
                offline = " ",
                warning = "𥉉",
                loading = " ",
            },
            debug = false,
        }
    },
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        enabled = false,
        config = function()
            require("chatgpt").setup({
                -- api_key_cmd = "op read op://Personal/OpenAI/api_credential --no-newline",
                actions_paths = { "~/.config/nvim/lua/kerooz/config/chatgpt-actions.json" },
            })
        end,
        keys = {
            { "<leader>gpt",  "<cmd>ChatGPT<CR>",                    mode = "n",          desc = "ChatGPT - Launch" },
            { "<leader>gpte", "<cmd>ChatGPTEditWithInstruction<CR>", mode = { "n", "v" }, desc = "ChatGPT - Edit with instruction" },
            { "<leader>gptx", "<cmd>ChatGPTRun explain_code<CR>",    mode = { "n", "v" }, desc = "ChatGPT - Explain code" },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        event = "VeryLazy",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
        },
        opts = {
            debug = false, -- Enable debugging
        },
        keys = {
            -- Show prompts actions with telescope
            {
                "<leader>cp",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
                desc = "CopilotChat - Prompt actions",
            },
            {
                "<leader>ct", "<cmd>CopilotChatToggle<CR>", mode = "n", desc = "CopilotChat - Toggle"
            }
        }
    }
}
