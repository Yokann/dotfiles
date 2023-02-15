local cmp = require("cmp")
local lspkind = require("lspkind")
--local capabilities = require('cmp_nvim_lsp').default_capabilities()
local luasnip = require("luasnip")
local select_opts = { behavior = cmp.SelectBehavior.Select }

local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    path = "[Path]",
    cmp_tabnine = "[TN]"
}

-- Setup nvim-cpm
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
            elseif luasnip.jumpable( -1) then
                luasnip.jump( -1)
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
        { name = 'cmp_tabnine' },
        { name = 'nvim_lsp' },
        { name = 'luasnip',    keyword_length = 2 },
        { name = 'path' },
        { name = 'buffer' },
    }
})

-- Tabnine init
local tabnine = require("cmp_tabnine.config")
tabnine.setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
})

-- LSP Configuration {{

-- Global binding on all LSP
local function config(_config)
    return vim.tbl_deep_extend("force", {
        on_attach = function()
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "[G]o [D]efinition" })
            vim.keymap.set("n", "fmt", function() vim.lsp.buf.format({ async = true }) end, { desc = "[F]or[M]a[T]" })
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end,
                { desc = "[V]iew [D]iagnostic" })
            vim.keymap.set("n", "$d", function() vim.diagnostic.goto_next() end, { desc = "Next occurrence" })
            vim.keymap.set("n", "ùd", function() vim.diagnostic.goto_prev() end, { desc = "Previous occurence" })
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
                { desc = "[V]iew [C]ode [A]ction" })
            vim.keymap.set("n", "<leader>vco", function()
                vim.lsp.buf.code_action({
                    filter = function(code_action)
                        if not code_action or not code_action.data then
                            return false
                        end

                        local data = code_action.data.id
                        return string.sub(data, #data - 1, #data) == ":0"
                    end,
                    apply = true
                })
            end, { desc = "[V]iew [C]ode actions [O]thers" })
            vim.keymap.set("n", "<leader>vcr", function() vim.lsp.buf.references() end,
                { desc = "[V]iew [C]ode [R]eferences" })
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, { desc = "[V]iew [R]e[N]ame" })
            vim.keymap.set("i", "<A-h>", function() vim.lsp.buf.signature_help() end,
                { desc = "View code signature" })
        end,
        -- capabilities = require("cmp_nvim_lsp").default_capabilities,
    }, _config or {})
end

local mason = require("mason")
local masonLspConfig = require("mason-lspconfig")

mason.setup();
masonLspConfig.setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "bashls",
        "cmake",
        "dockerls",
        "docker_compose_language_service",
        "gopls",
        "phpactor",
        "sqlls",
        "tflint",
        "yamlls",
        "tsserver",
        "marksman",
        "jsonls",
        "html"
    }
})

local lspconfig = require("lspconfig")
masonLspConfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup(config())
    end,
    ["lua_ls"] = function () 
        lspconfig.lua_ls.setup(config(
        {
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                        -- Setup your lua path
                        path = vim.split(package.path, ";"),
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        },
                    },
                },
            },
        }))
    end,
    ["gopls"] = function()
        lspconfig.gopls.setup(config({
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                }
            }
        }))
    end
})

require("luasnip.loaders.from_vscode").lazy_load()

-- }}

--  Floating window styles {{
--
vim.diagnostic.config({
    float = {
        source = 'always',
        border = 'rounded',
    },
})
require('lspconfig.ui.windows').default_options.border = 'single'

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)

-- }}
