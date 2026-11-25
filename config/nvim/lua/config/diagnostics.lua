local icons = {
    [vim.diagnostic.severity.ERROR] = "",
    [vim.diagnostic.severity.WARN] = "",
    [vim.diagnostic.severity.INFO] = "",
    [vim.diagnostic.severity.HINT] = "",
}

vim.diagnostic.config({
    -- inline diagnostics are rendered by tiny-inline-diagnostic.nvim
    virtual_text = false,
    signs = {
        text = icons,
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        },
    },
    severity_sort = true,
    update_in_insert = false,
    float = {
        source = true,
        border = "rounded",
    },
})
