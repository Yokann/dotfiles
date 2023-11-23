return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        opts = {
            sync_install = false,
            ensure_installed = {
                "bash",
                "c",
                "css",
                "help",
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
            },
            context_commentstring = {
                enable = true,
            }
        }
    },
    {
        "nvim-treesitter/playground",
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        }
    }
}
