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
                            format = {
                                enable = true,
                                defaultConfig = {
                                    indent_style = "space",
                                    indent_size = "4"
                                }
                            }
                        },
                    }
                },
                gopls = {
                    settings = {
                        gopls = {
                            gofumpt = true,
                            codelenses = {
                                gc_details = false,
                                generate = true,
                                regenerate_cgo = true,
                                run_govulncheck = true,
                                test = true,
                                tidy = true,
                                upgrade_dependency = true,
                                vendor = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            analyses = {
                                fieldalignment = true,
                                nilness = true,
                                unusedparams = true,
                                unusedwrite = true,
                                useany = true,
                            },
                            usePlaceholders = true,
                            completeUnimported = true,
                            staticcheck = true,
                            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                            semanticTokens = true,
                        }
                    },
                    init_options = {
                        usePlaceholders = true,
                    }
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
                "goimports",
                "gofumpt",
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
                nls.builtins.formatting.goimports,
                nls.builtins.formatting.gofumpt,
            })
        end,
    }
}
