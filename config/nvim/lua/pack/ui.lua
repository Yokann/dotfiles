local pack = require("pack.util")

pack.add({ "nvim-tree/nvim-web-devicons" })

-- color scheme: should load before everything
pack.add({ { src = "catppuccin/nvim", name = "catppuccin" } })
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
vim.api.nvim_set_hl(0, "SnacksPickerPreview", { bg = palette.base })
vim.cmd.colorscheme("catppuccin")

-- move inside code by symbols (also used by auto-session)
pack.add({ "stevearc/aerial.nvim" })
require("aerial").setup({
    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
})
vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial" })

pack.lazy({
    plugins = "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
        require("tiny-inline-diagnostic").setup({
            options = {
                multilines = {
                    enabled = true,
                },
            },
        })
    end,
})

pack.lazy({
    plugins = "tadaa/vimade",
    event = "VeryLazy",
    config = function()
        require("vimade").setup({
            recipe = { "minimalist", { animate = true } },
            fadelevel = 0.55,
            basebg = "#1e2030",
        })
    end,
})

-- Buffer title bar
pack.lazy({
    plugins = { "nvim-tree/nvim-web-devicons", "b0o/incline.nvim" },
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
                    ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
                    " ",
                    { filename, gui = modified and "bold,italic" or "bold" },
                    " ",
                    -- guibg = '#44406e',
                }
            end,
        })
    end,
})

pack.lazy({
    plugins = "NvChad/nvim-colorizer.lua",
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
    config = function()
        require("colorizer").setup({
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
        })
    end,
})

-- run :TransparentToggle to activate bg transparency
pack.add({ "xiyaowong/transparent.nvim" })
require("transparent").setup({
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
})

-- Status bar
pack.lazy({
    plugins = { "nvim-tree/nvim-web-devicons", "nvim-lualine/lualine.nvim" },
    event = "VeryLazy",
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
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
                            local ok, status = pcall(require, "copilot_status")
                            return ok and status.status_string() or ""
                        end,
                        cnd = function()
                            local ok, status = pcall(require, "copilot_status")
                            return ok and status.enabled()
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
        })
    end,
})
