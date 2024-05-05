return {
    {
        "neovim/nvim-lspconfig",
        event = 'VeryLazy',
        init = function()
            require('mason').setup({
                PATH = "prepend",
            })
        end,
        config = function()
            local config = require('kerooz.lib.lsp.common_config')
            local masonLspConfig = require('mason-lspconfig')
            local lspconfig = require('lspconfig')

            --  Add any additional override configuration in the following tables. Available keys are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
            local servers = {
                lua_ls = {
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
                    }
                },
                gopls = {
                    settings = {
                        gopls = {
                            analyses = {
                                unusedparams = true,
                            },
                            staticcheck = true,
                        }
                    },
                }
            }

            masonLspConfig.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup(config(servers[server_name] or {}))
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
