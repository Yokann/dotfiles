local M = {}

local function addAutocmd()
    vim.api.nvim_create_autocmd("User", {
        desc = "User: format & show diff when CodeCompanion finished",
        pattern = "CodeCompanionInlineFinished",
        callback = vim.schedule_wrap(function(ctx)
            vim.lsp.buf.format({ bufnr = ctx.buf, async = true })
        end),
    })
end

M.setup = function(opts)
    require("codecompanion").setup(opts)
    require("utils.codecompanion.fidget-spinner").init()
    addAutocmd()
end

return M
