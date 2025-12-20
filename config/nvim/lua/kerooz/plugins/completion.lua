return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
    },
    {
        "saghen/blink.cmp",
        event = "VeryLazy",
        dependencies = {
            "L3MON4D3/LuaSnip",
        },
        version = "1.*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            appearance = {
                kind_icons = {
                    Text = " ",
                    Method = " ",
                    Function = " ",
                    Constructor = " ",
                    Field = " ",
                    Variable = " ",
                    Class = " ",
                    Interface = " ",
                    Module = " ",
                    Property = " ",
                    Unit = " ",
                    Value = " ",
                    Enum = " ",
                    Keyword = " ",
                    Snippet = " ",
                    Color = " ",
                    File = " ",
                    Reference = " ",
                    Folder = " ",
                    EnumMember = " ",
                    Constant = " ",
                    Struct = " ",
                    Event = " ",
                    Operator = " ",
                    TypeParameter = " ",
                },
            },
            completion = {
                documentation = { auto_show = false },
                menu = {
                    draw = {
                        padding = { 0, 1 },
                        componentes = {
                            kind_icons = {
                                text = function(ctx)
                                    return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
                                end,
                            },
                        },
                    },
                },
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
            },
            snippets = { preset = "luasnip" },
            sources = {
                default = {
                    "lsp",
                    "snippets",
                    "buffer",
                    "path",
                },
                per_filetype = {
                    lua = { inherit_defaults = true, "lazydev" },
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100, -- show at a higher priority than lsp
                    },
                    path = {
                        opts = { get_cwd = vim.uv.cwd },
                    },
                    lsp = {
                        fallbacks = {},
                    },
                    buffer = {
                        max_items = 2,
                        min_keyword_length = 2,
                        score_offset = -3,
                    },
                },
            },
            keymap = {
                preset = "super-tab",
                ["<M-k>"] = { "select_prev", "fallback" },
                ["<M-j>"] = { "select_next", "fallback" },
                ["<Tab>"] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_and_accept()
                        end
                    end,
                    "snippet_forward",
                    "fallback",
                },
            },
            cmdline = {
                keymap = { preset = "inherit" },
                completion = {
                    menu = { auto_show = true },
                },
            },
        },
    },
}
