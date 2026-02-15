return {
    -- Aerial
    {
        "stevearc/aerial.nvim", -- move inside code by symbols
        opts = {
            -- optionally use on_attach to set keymaps when aerial has attached to a buffer
            on_attach = function(bufnr)
                -- Jump forwards/backwards with '{' and '}'
                vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
            end,
        },
        keys = {
            { "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
        },
    },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        opts = {
            options = {
                multilines = {
                    enabled = true,
                },
            },
        },
        init = function()
            vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
        end,
    },

    {
        "catppuccin/nvim", -- color scheme
        lazy = false,
        enabled = true,
        name = "catppuccin",
        priority = 1000, -- should load before everything
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato", -- latte, frappe, macchiato, mocha
                transparent_background = false,
                integrations = {
                    flash = true,
                    mason = true,
                    noice = true,
                    notify = true,
                    mini = true,
                    blink_cmp = {
                        style = "bordered",
                    },
                },
                compile = {
                    enabled = true,
                    path = vim.fn.stdpath("cache") .. "/catppuccin",
                },
            })
            local palette = require("catppuccin.palettes").get_palette()

            local function lspSymbol(name, icon, color)
                local signName = "DiagnosticSign" .. name
                vim.fn.sign_define(signName, { text = icon, texthl = signName, numhl = signName, fg = color })
            end

            -- Change color from diagnostic icon
            lspSymbol("Error", "", palette.red)
            lspSymbol("Hint", "", palette.teal)
            lspSymbol("Info", "", palette.sky)
            lspSymbol("Warn", "", palette.yellow)

            vim.api.nvim_set_hl(0, "SnacksPickerPreview", { bg = palette.base })

            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = false,
        config = function()
            require("ibl").setup()
        end,
    },

    {
        "tadaa/vimade",
        event = "VeryLazy",
        opts = {
            recipe = { "minimalist", { animate = true } },
            fadelevel = 0.55,
            basebg = "#1e2030",
        },
    },

    { -- Buffer title bar
        "b0o/incline.nvim",
        event = "BufReadPre",
        config = function()
            local helpers = require("incline.helpers")
            local devicons = require("nvim-web-devicons")
            require("incline").setup({
                window = {
                    margin = {
                        horizontal = 0,
                        vertical = 0,
                    },
                },
                hide = {
                    cursorline = true,
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    if filename == "" then
                        filename = "[No Name]"
                    end
                    local ft_icon, ft_color = devicons.get_icon_color(filename)
                    local modified = vim.bo[props.buf].modified
                    return {
                        ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
                            or "",
                        " ",
                        { filename, gui = modified and "bold,italic" or "bold" },
                        " ",
                        -- guibg = '#44406e',
                    }
                end,
            })
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        lazy = false,
        ft = {
            "html",
            "css",
            "javascript",
            "typescript",
            "typescriptreact",
            "javascriptreact",
            "lua",
            "sass",
            "scss",
            "less",
        },
        opts = {
            filetypes = {
                "html",
                "css",
                "javascript",
                "typescript",
                "typescriptreact",
                "javascriptreact",
                "lua",
                "sass",
                "scss",
                "less",
            },
            user_default_options = {
                mode = "background",
                tailwind = true, -- Enable tailwind colors
            },
        },
    },
    { -- run :TransparentToggle to activate bg transparency
        "xiyaowong/transparent.nvim",
        lazy = false,
        opts = {
            groups = { -- table: default group
                "Normal",
                "NormalNC",
                "Comment",
                "Constant",
                "Special",
                "Identifier",
                "Statement",
                "PreProc",
                "Type",
                "Underlined",
                "Todo",
                "String",
                "Function",
                "Conditional",
                "Repeat",
                "Operator",
                "Structure",
                "LineNr",
                "NonText",
                "SignColumn",
                "CursorLine",
                "CursorLineNr",
                "StatusLine",
                "StatusLineNC",
                "EndOfBuffer",
            },
            extra_groups = {}, -- table: additional groups that should be cleared
            exclude_groups = {}, -- table: groups you don't want to clear
            on_clear = function() end,
        },
    },
    {
        "karb94/neoscroll.nvim",
        lazy = false,
        opts = {
            easing_function = "sine", -- Default easing function
        },
    },
    {
        "nvim-lualine/lualine.nvim", -- Status bar
        event = "VeryLazy",
        opts = {
            options = {
                icons_enabled = true,
                theme = "catppuccin",
                --         disabled_filetypes = {
                --             'NvimTree', 'DapBreakpoint', 'DapScope', 'DapStack'
                --         }
            },
            sections = {
                lualine_b = {
                    { "branch", icon = "" },
                    {
                        "diff",
                        colored = true,
                        symbols = {
                            added = " ",
                            modified = " ",
                            removed = " ",
                        },
                    },
                    -- { "diagnostics' }
                },
                lualine_c = {
                    "diagnostics",
                    { "filename", path = 1 },
                },
                lualine_x = {
                    "encoding",
                    "fileformat",
                    "filetype",
                    {
                        function()
                            return require("copilot_status").status_string()
                        end,
                        cnd = function()
                            return require("copilot_status").enabled()
                        end,
                    },
                },
            },
            tabline = {
                lualine_a = { "buffers" },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "tabs" },
            },
        },
    },
}
