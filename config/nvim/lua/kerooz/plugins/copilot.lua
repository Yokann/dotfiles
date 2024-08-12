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
                enabled = false,
            }
        },
        config = function(_, opts)
            require("copilot").setup(opts)
        end,
    },

    {
        "zbirenbaum/copilot-cmp",
        lazy = false,
        dependencies = {
            "zbirenbaum/copilot.lua",
        },
        config = function(_, opts)
            require("copilot_cmp").setup(opts)
        end
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
        branch = "canary",
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
