return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        init = function()
            require('mason').setup({
                PATH = "prepend",
            })
        end,
        config = function()
            local configurer = require('kerooz.lsp.config')
            local masonLspConfig = require('mason-lspconfig')
            local lspconfig = require('lspconfig')

            masonLspConfig.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup(configurer.configure(server_name))
                end,
            })

            -- Display diagnostic on hover the line
            vim.api.nvim_create_autocmd({ "CursorHold" },
                { command = "lua vim.diagnostic.open_float(nil, {focus=false})" })

            --  Floating window styles {{
            --
            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
                float = {
                    source = true,
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
        end,
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                dependencies = { "williamboman/mason.nvim" }
            },
            "nvimtools/none-ls.nvim",
        }
    },
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        opts = {}
    }, --loader for lsp
    {
        "towolf/vim-helm", ft = "helm"
    },
    { -- auto install lsp, formatter, dap
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        lazy = false,
        opts = {
            ensure_installed = {
                "bashls",
                "cmake",
                "clangd",
                "codelldb",
                "cpptools",
                "delve",
                "dockerls",
                "docker_compose_language_service",
                "gopls",
                "gomodifytags",
                "golangci-lint",
                "gofumpt",
                "golines",
                "html",
                "helm_ls",
                "jdtls",
                "jsonls",
                "lemminx",
                "lua_ls",
                "marksman",
                "php-debug-adapter",
                "phpactor",
                "rust_analyzer",
                "sqlls",
                "terraformls",
                "tflint",
                "tsserver",
                "yamlls",

            },
            auto_update = false,
            run_on_start = false,
            start_delay = 3000,
            debounce_hours = 5, -- at least 5 hours between attempts to install/update
            integrations = {
                ['mason-lspconfig'] = true,
                ['mason-null-ls'] = true,
                ['mason-nvim-dap'] = true,
            }
        },
        dependencies = {
            "neovim/nvim-lspconfig"
        }
    },
    {
        "nvimtools/none-ls.nvim",
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources or {}, {
                nls.builtins.code_actions.gomodifytags,
                nls.builtins.formatting.golines.with({
                    extra_args = {
                        "--max-len=120",
                        "--base-formatter=gofumpt",
                    }
                }),
                nls.builtins.diagnostics.golangci_lint,
            })
        end,
    }
}
