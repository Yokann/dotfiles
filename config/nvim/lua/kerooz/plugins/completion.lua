return {
    "hrsh7th/nvim-cmp",
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        local luasnip = require("luasnip")
        local select_opts = { behavior = cmp.SelectBehavior.Replace }

        local source_mapping = {
            buffer = " ",
            nvim_lsp = " ",
            path = " ",
            copilot = " ",
            luasnip = "",
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<CR>"] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                if cmp.get_active_entry() then
                                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                                end
                            end
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                    c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                }),
                --["<C-u>"] = cmp.mapping.scroll_docs(-4),
                --["<C-d>"] = cmp.mapping.scroll_docs(4),
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
                documentation = cmp.config.window.bordered()
            },
            -- Custom result formating
            formatting = {
                format = function(entry, vim_item)
                    vim_item.kind = lspkind.presets.default[vim_item.kind]
                    local menu = source_mapping[entry.source.name]
                    if entry.source.name == "copilot" then
                        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                            menu = entry.completion_item.data.detail .. " " .. menu
                        end
                        vim_item.kind = " "
                    end
                    vim_item.menu = menu
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
    end,
    dependencies = {
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        { "onsails/lspkind-nvim", dependencies = "neovim/nvim-lspconfig" },
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
