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
}
