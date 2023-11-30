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
    }
}
