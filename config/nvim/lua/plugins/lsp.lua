return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        init = function()
            require("mason").setup({
                PATH = "prepend",
            })
        end,
        config = function()
            require("config.lsp").configure()

            -- Display diagnostic on hover the line
            -- vim.api.nvim_create_autocmd(
            --     { "CursorHold" },
            --     { command = "lua vim.diagnostic.open_float(nil, {focus=false})" }
            -- )

            --  Floating window styles {{
            --
            -- vim.diagnostic.config({
            --     virtual_text = false,
            --     signs = true,
            --     float = {
            --         source = true,
            --         border = "rounded",
            --     },
            -- })
            require("lspconfig.ui.windows").default_options.border = "single"
            -- }}
        end,
        dependencies = {
            "nvimtools/none-ls.nvim",
            "saghen/blink.nvim",
        },
    },
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            notification = {
                window = {
                    winblend = 0,
                },
            },
        },
    }, --loader for lsp
    {
        "towolf/vim-helm",
        ft = "helm",
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
                -- "dockerls",
                "hadolint",
                "docker_compose_language_service",
                "gh_actions_ls",
                "gopls",
                "gomodifytags",
                "goimports",
                "golangci-lint",
                "gofumpt",
                "golines",
                "html",
                "helm_ls",
                "hyprls",
                "jdtls",
                "jsonls",
                "js-debug-adapter",
                "lemminx",
                "lua_ls",
                "marksman",
                "php-debug-adapter",
                "phpactor",
                "prettierd",
                "rust_analyzer",
                "sqlls",
                "sqlfmt",
                "selene",
                "stylua",
                "terraformls",
                "tflint",
                "yamlls",
            },
            auto_update = true,
            run_on_start = false,
            start_delay = 3000,
            debounce_hours = 5, -- at least 5 hours between attempts to install/update
            integrations = {
                ["mason-lspconfig"] = true,
                ["mason-null-ls"] = true,
                ["mason-nvim-dap"] = true,
            },
        },
        dependencies = {
            "neovim/nvim-lspconfig",
            "jay-babu/mason-nvim-dap.nvim",
            "b0o/schemastore.nvim",
        },
    },
    {
        "nvimtools/none-ls.nvim",
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources or {}, {
                nls.builtins.code_actions.gomodifytags,
                nls.builtins.formatting.goimports,
                nls.builtins.formatting.golines.with({
                    extra_args = {
                        "--max-len=120",
                        "--base-formatter=gofumpt",
                    },
                }),
                nls.builtins.diagnostics.golangci_lint,
            })
        end,
    },
}
