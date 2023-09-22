local ok, nvimtreesitterconfig = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

nvimtreesitterconfig.setup {
    sync_install = false,
    ensure_installed = {
        "bash",
        "c",
        "css",
        "help",
        "html",
        "javascript",
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
