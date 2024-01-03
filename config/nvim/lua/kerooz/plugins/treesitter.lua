return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                sync_install = false,
                ensure_installed = {
                    "bash",
                    "c",
                    "css",
                    "vimdoc",
                    "html",
                    "javascript",
                    "jq",
                    "jsonnet",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "tsx",
                    "typescript",
                    "vim",
                    "yaml",
                    "rust",
                    "php",
                    "go",
                    "gomod",
                    "gosum",
                    "terraform"
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                }
            })
            require("ts_context_commentstring").setup({
                enable_autocmd = true,
            })
        end
    },
    {
        "nvim-treesitter/playground",
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        }
    }
}
