return {
    "hrsh7th/nvim-cmp",
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local select_opts = { behavior = cmp.SelectBehavior.Replace }

        local source_mapping = {
            buffer = " ",
            nvim_lsp = " ",
            path = " ",
            copilot = " ",
            luasnip = " ",
        }

        local kind_icons = {
            Text = ' ',
            Method = ' ',
            Function = ' ',
            Constructor = ' ',
            Field = ' ',
            Variable = ' ',
            Class = ' ',
            Interface = ' ',
            Module = ' ',
            Property = ' ',
            Unit = ' ',
            Value = ' ',
            Enum = ' ',
            Keyword = ' ',
            Snippet = ' ',
            Color = ' ',
            File = ' ',
            Reference = ' ',
            Folder = ' ',
            EnumMember = ' ',
            Constant = ' ',
            Struct = ' ',
            Event = ' ',
            Operator = ' ',
            TypeParameter = ' ',
        }

        local crComplete = function(fallback)
            if cmp.visible() then
                if luasnip.expandable() then
                    luasnip.expand()
                else
                    if cmp.get_active_entry() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    else
                        fallback()
                    end
                end
            else
                fallback()
            end
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<CR>"] = cmp.mapping({
                    i = crComplete,
                    c = crComplete,
                    s = cmp.mapping.confirm({ select = true }),
                }),
                -- ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                -- ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ['<M-a>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ['<M-m>'] = cmp.mapping({
                    i = cmp.mapping.complete()
                }),
                ['<Tab>'] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }
                ),
                ['<S-Tab>'] = cmp.mapping(
                    function(fallback)
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }
                ),
                ['<M-j>'] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item(select_opts)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }
                ),
                ['<M-k>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item(select_opts)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
            window = {
                documentation = cmp.config.window.bordered(),
                completion = {
                    col_offset = -3,
                    side_padding = 0,
                },
            },
            view = {
                -- revert result order when completion display ahead of cursor
                entries = { name = 'custom', selection_order = 'near_cursor' }
            },
            -- Custom result formating
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = " " .. (kind_icons[vim_item.kind] or "")
                    vim_item.menu = " " .. (source_mapping[entry.source.name] or "")

                    return vim_item
                end,
            },
            -- Sort is important
            sources = {
                { name = 'nvim_lsp', priority = 10, max_item_count = 6 },
                { name = 'luasnip',  priority = 6,  max_item_count = 3 },
                { name = 'buffer',   priority = 6,  keyword_length = 2, max_item_count = 5 },
                { name = 'path',     priority = 4 },
            }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }
            })
        })

        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Customization for Pmenu
        vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#24273a", fg = "NONE" })
        vim.api.nvim_set_hl(0, "Pmenu", { fg = "#cad3f5", bg = "#181926" })
        vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#eed49f", bg = "NONE", strikethrough = true })
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#8aadf4", bg = "NONE", bold = true })
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#8aadf4", bg = "NONE", bold = true })
        vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#b8c0e0", bg = "NONE" })
        vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#ffe3e7", bg = "#ed8796" })
        vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#ffe3e7", bg = "#ed8796" })
        vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#ffe3e7", bg = "#ed8796" })
        vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#485e41", bg = "#a6da95" })
        vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#485e41", bg = "#a6da95" })
        vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#485e41", bg = "#a6da95" })
        vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#f7dfd2", bg = "#f5a97f" })
        vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#f7dfd2", bg = "#f5a97f" })
        vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#f7dfd2", bg = "#f5a97f" })
        vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#c6a0f6" })
        vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#c6a0f6" })
        vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#c6a0f6" })
        vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#c6a0f6" })
        vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#c6a0f6" })
        vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#24273a", bg = "#8aadf4" })
        vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#24273a", bg = "#8aadf4" })
        vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
        vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
        vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })
        vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#b7bdf8" })
        vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#b7bdf8" })
        vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#b7bdf8" })
        vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#8bd5ca" })
        vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#8bd5ca" })
        vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#8bd5ca" })
    end,
    dependencies = {
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        -- Snippet
        "saadparwaiz1/cmp_luasnip",
        {
            "L3MON4D3/LuaSnip",
            dependencies = {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            }
        },
    }
}
