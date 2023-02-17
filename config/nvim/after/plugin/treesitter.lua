local ok, nvimtreesitterconfig = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

nvimtreesitterconfig.setup {
    ensure_installed = "all",
    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    context_commentstring = {
        enable = true,
    }
}
