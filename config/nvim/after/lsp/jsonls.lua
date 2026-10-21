---@type vim.lsp.Config
return {
    init_options = {
        -- use Biome instead
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
