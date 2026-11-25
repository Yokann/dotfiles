---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                -- Managed by lazydev.nvim, don't add anything here manually
            },
            -- formatting is handled by stylua through conform
            format = { enable = false },
        },
    },
}
