return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        local luasnip = require("luasnip")
        local select_opts = { behavior = cmp.SelectBehavior.Select }

        local source_mapping = {
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            path = "[Path]",
            cmp_tabnine = "[TN]",
            luasnip = "[SNP]"
        }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                --["<C-u>"] = cmp.mapping.scroll_docs(-4),
                --["<C-d>"] = cmp.mapping.scroll_docs(4),
                ['<A-e>'] = cmp.mapping.abort(),
                ["<A-Space>"] = cmp.mapping.complete(),

                ['<Tab>'] = cmp.mapping(function(fallback)
                    local col = vim.fn.col('.') - 1

                    if cmp.visible() then
                        cmp.select_next_item(select_opts)
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                        fallback()
                    else
                        cmp.complete()
                    end
                end, { 'i', 's' }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item(select_opts)
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            window = {
                documentation = cmp.config.window.bordered()
            },
            -- Custome result formating
            formatting = {
                format = function(entry, vim_item)
                    vim_item.kind = lspkind.presets.default[vim_item.kind]
                    local menu = source_mapping[entry.source.name]
                    if entry.source.name == "cmp_tabnine" then
                        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                            menu = entry.completion_item.data.detail .. " " .. menu
                        end
                        vim_item.kind = ""
                    end
                    vim_item.menu = menu
                    return vim_item
                end,
            },
            -- Sort is important
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'path' },
                { name = 'buffer' },
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
