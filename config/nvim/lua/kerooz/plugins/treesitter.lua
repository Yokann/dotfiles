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
        init = function()
            require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
                local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
                local filename = vim.fn.fnamemodify(filepath, ":t")
                return string.match(filename, ".*mise.*%.toml$")
            end, { force = true, all = false })
        end,
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                sync_install = false,
                ensure_installed = {
                    "bash",
                    "c",
                    "css",
                    "gitignore",
                    "go",
                    "gomod",
                    "gosum",
                    "gowork",
                    "html",
                    "javascript",
                    "jq",
                    "jsonnet",
                    "json",
                    "jsonc",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "php",
                    "python",
                    "query",
                    "regex",
                    "rust",
                    "tsx",
                    "terraform",
                    "toml",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-Space>",
                        node_incremental = "<C-Space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
            })
            require("ts_context_commentstring").setup({
                enable_autocmd = true,
            })
        end
    },
}
