local pack = require("pack.util")

pack.add({ { src = "nvim-treesitter/nvim-treesitter", version = "main" } })

require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
    local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
    local filename = vim.fn.fnamemodify(filepath, ":t")
    return string.match(filename, ".*mise.*%.toml$")
end, { force = true, all = false })

require("nvim-treesitter").install({
    "bash",
    "c",
    "cpp",
    "css",
    "diff",
    "dockerfile",
    "git_config",
    "gitcommit",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "helm",
    "hcl",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "php",
    "query",
    "regex",
    "rust",
    "sql",
    "terraform",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
})
