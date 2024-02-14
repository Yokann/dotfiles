return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        init = function()
            require('mason').setup()
        end,
        config = function()
            local config = require('kerooz.lib.lsp.common_config')
            local masonLspConfig = require('mason-lspconfig')
            local lspconfig = require('lspconfig')
            local util = require('lspconfig.util')

            masonLspConfig.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup(config())
                end,
                ["lua_ls"] = function()
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

            -- vim.api.nvim_create_autocmd({ "CursorHold" }, { command = "lua vim.diagnostic.open_float(nil, {focus=false})" })

            --  Floating window styles {{
            --
            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
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
        end,
        dependencies = {
            {
                "williamboman/mason.nvim",
            },
            {
                "williamboman/mason-lspconfig.nvim",
                opts = {
                    ensure_installed = {
                        "bashls",
                        "cmake",
                        "dockerls",
                        "docker_compose_language_service",
                        "gopls",
                        "html",
                        "helm_ls",
                        "jdtls",
                        "jsonls",
                        "lemminx",
                        "lua_ls",
                        "marksman",
                        "rust_analyzer",
                        -- "phpactor",
                        "sqlls",
                        "tflint",
                        "tsserver",
                        "yamlls",
                    }
                },
                dependencies = { "williamboman/mason.nvim" }
            },
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
    }
}
