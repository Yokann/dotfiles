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
            vim.lsp.config("qml-language-server", {
                cmd = { "qml-language-server" },
                filetypes = { "qml" },
                root_markers = { { "qmldir", "shell.qml" }, ".git" },
            })

            vim.lsp.enable("qml-language-server")
        end,
        dependencies = {
            "saghen/blink.cmp",
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
                "html",
                "helm_ls",
                "hyprls",
                "jsonls",
                "js-debug-adapter",
                "lemminx",
                "lua_ls",
                "marksman",
                "php-debug-adapter",
                "phpactor",
                "prettierd",
                "rust_analyzer",
                "shfmt",
                "sqlls",
                "sqlfmt",
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
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufWritePost" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                go = { "golangcilint" },
            }
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = vim.api.nvim_create_augroup("UserLint", { clear = true }),
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        cmd = { "ConformInfo", "FormatToggle" },
        init = function()
            vim.api.nvim_create_user_command("FormatToggle", function()
                vim.g.disable_autoformat = not vim.g.disable_autoformat
                vim.notify("Autoformat " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
            end, { desc = "Toggle format on save" })
        end,
        opts = {
            log_level = vim.log.levels.WARN,
            default_format_opts = { lsp_format = "fallback" },
            formatters_by_ft = {
                go = { "goimports", "gofumpt" },
                lua = { "stylua" },
                sh = { "shfmt" },
                sql = { "sqlfmt" },
                json = { "prettierd" },
                jsonc = { "prettierd" },
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                if vim.bo[bufnr].filetype == "helm" then
                    return
                end
                if vim.api.nvim_buf_line_count(bufnr) > 10000 then
                    return
                end
                return { timeout_ms = 2000, lsp_format = "fallback" }
            end,
        },
    },
}
