return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        cmdline = {
            view = "cmdline",
        },
        messages = {
            -- NOTE: If you enable messages, then the cmdline is enabled automatically.
            -- This is a current Neovim limitation.
            enabled = true,              -- enables the Noice messages UI
            view = "mini",               -- default view for messages
            view_error = "mini",         -- view for errors
            view_warn = "mini",          -- view for warnings
            view_history = "messages",   -- view for :messages
            view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        },
        routes = {
            -- filter messages https://github.com/folke/noice.nvim/blob/main/lua/noice/config/routes.lua
            {
                filter = {
                    any = {
                        { event = "msg_show", kind = "",        find = "written" },
                        { event = "msg_show", kind = "",        find = "ago" },
                        { event = "msg_show", find = "AutoSave" },
                    },
                },
                view = "mini"
            },
            {
                filter = { event = "msg_show", kind = { "", "echo", "echomsg" }, min_height = 3 },
                view = "messages"
            }
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
                timeout = 1000,
            }
        },
        "MunifTanjim/nui.nvim",
    }
}
