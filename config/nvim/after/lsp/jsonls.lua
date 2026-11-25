---@type vim.lsp.Config
return {
    init_options = {
        -- formatting is handled by prettierd through conform
        provideFormatter = false,
        documentRangeFormattingProvider = false,
    },
    settings = {
        json = {
            validate = { enable = true },
            schemas = require("schemastore").json.schemas(),
        },
    },
}
