return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        cmdline = {
            view = "cmdline",
        },
        routes = {
            -- filter messages
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = { skip = true },
            },
        },
        lsp = {
            progress = {
                enabled = false,
            },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            hover = {
                enabled = true,
                silent = true, -- set to true to not show a message if hover is not available
                view = nil,    -- when nil, use defaults from documentation
                opts = {},     -- merged with defaults from documentation
            },
            message = {
                -- Messages shown by lsp servers
                enabled = true,
                view = "mini",
                opts = {},
            },
        },
        presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            long_message_to_split = true, -- long messages will be sent to a split
            lsp_doc_border = true,        -- add a border to hover docs and signature help
        },
    },
    keys = {
        { '<S-Enter>',  function() require('noice').redirect(vim.fn.getcmdline()) end, mode = 'c', desc = 'Redirect Cmdline' },
        { '<leader>nh', function() require('noice').cmd('history') end,                mode = 'n', desc = 'Notifications history' }
    },
    dependencies = {
        {
            "rcarriga/nvim-notify",
            opts = {
                stages = "fade",
                timeout = 2000,
            }
        },
        "MunifTanjim/nui.nvim",
    }
}
