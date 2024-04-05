return {
    -- Aerial
    {
        "stevearc/aerial.nvim", -- move inside code by symbols
        opts = {
            -- optionally use on_attach to set keymaps when aerial has attached to a buffer
            on_attach = function(bufnr)
                -- Jump forwards/backwards with '{' and '}'
                vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
                vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
            end
        },
        keys = {
            { '<leader>te', '<cmd>AerialToggle!<CR>', desc = "Toggle Aerial" }
        }
    },

    -- Nvim Tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        init = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
        opts = {
            update_focused_file = {
                enable = true,
            },
            disable_netrw = true,
            diagnostics = {
                enable = true
            },
            git = {
                enable = true,
                timeout = 400 -- (in ms)
            },
            filters = {
                git_ignored = false,
                dotfiles = false,
                custom = { "^.git$", ".idea" }
            },
            trash = {
                cmd = "trash",
                require_confirm = true,
            },
            renderer = {
                highlight_git = true
            }
        },
        keys = {
            {
                "<leader>tt",
                function() require('nvim-tree.api').tree.toggle(false, false) end,
                desc =
                "[T]oggle Nvim[T]ree"
            },
            { "<leader>tr", function() require('nvim-tree.api').tree.focus() end, desc = "Focus Nvim[T][R]ee" },
            { "<leader>dgg",
                function()
                    local node = require('nvim-tree.api').tree.get_node_under_cursor()
                    if node.type == 'directory' then
                        require('kerooz.lib.telescope.pickers').prettyGrepPicker({
                            picker = 'live_grep',
                            options = { cwd = node.absolute_path, debounce = 100 }
                        })
                    end
                end
            }
        }
    },

    {
        "catppuccin/nvim", -- color scheme
        lazy = false,
        name = "catppuccin",
        priority = 1000,           -- should load before everything
        opts = {
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            transparent_background = false,
            integrations = {
                leap = true,
                mason = true,
                noice = true,
                notify = true,
            },
            compile = {
                enabled = true,
                path = vim.fn.stdpath("cache") .. "/catppuccin",
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            local palette = require('catppuccin.palettes').get_palette()

            local function lspSymbol(name, icon, color)
                local signName = "DiagnosticSign" .. name
                vim.fn.sign_define(
                    signName,
                    { text = icon, texthl = signName, numhl = signName, fg = color }
                )
            end

            -- Change color from diagnostic icon
            lspSymbol("Error", "", palette.red)
            lspSymbol("Hint", "", palette.teal)
            lspSymbol("Info", "", palette.sky)
            lspSymbol("Warn", "", palette.yellow)

            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = false,
        config = function()
            require('ibl').setup()
        end
    },
    {
        "levouh/tint.nvim", -- highlight current buffer
        event = "VeryLazy",
        opts = {
            tint = -30,
            saturation = 0.5,
            highlight_ignore_patterns = {
                "LspInlayHint.*",
                "WinBar.*",
                "WinSeparator",
                "IndentBlankline.*",
                "SignColumn",
                "EndOfBuffer",
                "Neotest*", -- for some reason Neotest window get tinted when it shouldn't
            },
            window_ignore_function = function(winid)
                local DONT_TINT = true
                local TINT = false
                -- Don't tint floating windows.
                if vim.api.nvim_win_get_config(winid).relative ~= "" then
                    return DONT_TINT
                end

                local bufnr = vim.api.nvim_win_get_buf(winid)
                -- Only tint normal buffers.
                if vim.api.nvim_buf_get_option(bufnr, "buftype") == "" then
                    return TINT
                end
                return DONT_TINT
            end,
        }
    },

    { -- Buffer title bar
        "b0o/incline.nvim",
        event = "BufReadPre",
        config = function()
            require("incline").setup({
                window = {
                    margin = {
                        horizontal = 0,
                        vertical = 0
                    }
                }
            })
        end,
    },

    -- Cybu Buffer navigation helper
    {
        "ghillb/cybu.nvim",
        lazy = false,
        branch = "main", -- timely updates
        -- branch = "v1.x", -- won't receive breaking changes
        opts = {
            position = {
                anchor = "center",
                -- vertical_offset = 2,
            },
            style = {
                path = "relative", -- absolute, relative, tail (filename only)
                path_abbreviation = "none", -- none, shortened
                border = "rounded", -- single, double, rounded, none
                separator = " ", -- string used as separator
                prefix = "…", -- string used as prefix for truncated paths
                padding = 1, -- left & right padding in number of spaces
                hide_buffer_id = true, -- hide buffer IDs in window
                devicons = {
                    enabled = true, -- enable or disable web dev icons
                    colored = true, -- enable color for web dev icons
                    truncate = true, -- truncate wide icons to one char width
                },
                highlights = { -- see highlights via :highlight
                    current_buffer = "CybuFocus", -- current / selected buffer
                    adjacent_buffers = "CybuAdjacent", -- buffers not in focus
                    background = "CybuBackground", -- window background
                    border = "CybuBorder", -- border of the window
                },
            },
            behavior = { -- set behavior for different modes
                mode = {
                    default = {
                        switch = "immediate", -- immediate, on_close
                        view = "paging",      -- paging, rolling
                    },
                    last_used = {
                        switch = "immediat", -- immediate, on_close
                        view = "paging",     -- paging, rolling
                    },
                    auto = {
                        view = "rolling", -- paging, rolling
                    },
                },
                show_on_autocmd = false, -- event to trigger cybu (eg. "BufEnter")
            },
            display_time = 0500,
        },
        init = function()
            vim.keymap.set("n", "<A-k>", "<Plug>(CybuPrev)", { noremap = true, desc = "Previous Buffer" })
            vim.keymap.set("n", "<A-j>", "<Plug>(CybuNext)", { noremap = true, desc = "Next Buffer" })
            vim.keymap.set({ "n", "v" }, "<A-S-k>", "<plug>(CybuLastusedPrev)",
                { noremap = true, desc = "Previous last used buffer" })
            vim.keymap.set({ "n", "v" }, "<A-S-j>", "<plug>(CybuLastusedNext)",
                { noremap = true, desc = "Next last used buffer " })
        end,
        dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
    },
    {
        'NvChad/nvim-colorizer.lua',
        lazy = false,
        ft = {
            'html',
            'css',
            'javascript',
            'typescript',
            'typescriptreact',
            'javascriptreact',
            'lua',
            'sass',
            'scss',
            'less',
        },
        opts = {
            filetypes = {
                'html',
                'css',
                'javascript',
                'typescript',
                'typescriptreact',
                'javascriptreact',
                'lua',
                'sass',
                'scss',
                'less',
            },
            user_default_options = {
                mode = 'background',
                tailwind = true, -- Enable tailwind colors
            },
        }
    },
    { -- run :TransparentToggle to activate bg transparency
        "xiyaowong/transparent.nvim",
        lazy = false,
        opts = {
            extra_groups = {},   -- table: additional groups that should be cleared
            exclude_groups = {}, -- table: groups you don't want to clear
        },
    },
    { 'karb94/neoscroll.nvim', lazy = false, opts = {
        easing_function = "sine", -- Default easing function
    }},
}
