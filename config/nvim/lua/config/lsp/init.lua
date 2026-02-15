local M = {}

local capabilities = require("blink.cmp").get_lsp_capabilities()
local lsp_flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
}

-- stylua: ignore start
M.configure = function()
    vim.lsp.config("*", {
        on_attach = function(client, bufnr)
            vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "[G]o [D]efinition" })
            vim.keymap.set("n", "gtd", function() Snacks.picker.lsp_type_definitions() end,
                { desc = "[G]o [T]ype [D]efinition" })
            vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "[G]oto [R]eferences" })
            vim.keymap.set("n", "<leader>s", function() Snacks.picker.lsp_symbols() end, { desc = "[F]ind [S]ymbols" })
            vim.keymap.set("n", "<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end,
                { desc = "[F]ind [W]orkspace [S]ymbols" })
            vim.keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end,
                { desc = "[G]o [I]mplemention" })
            -- vim.keymap.set("n", "fmt", function() vim.lsp.buf.format({ async = true }) end, { desc = "[F]or[M]a[T]" })
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end)
            vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end,
                { desc = "Go to next [D]iagnostic message" })
            vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end,
                { desc = "Go to previous [D]iagnostic message" })
            vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end,
                { desc = "[V]iew [C]ode [A]ction" })
            vim.keymap.set("n", "gA", function()
                vim.lsp.buf.code_action({
                    filter = function(code_action)
                        if not code_action or not code_action.data then
                            return false
                        end

                        local data = code_action.data.id
                        return string.sub(data, #data - 1, #data) == ":0"
                    end,
                    apply = true,
                })
            end, { desc = "[V]iew [C]ode actions [O]thers" })
            vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, { desc = "[R]e[N]ame" })

            vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
            -- -- Autoformat on save
            if client.supports_method("textDocument/formatting") then
                local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end
        end,
        capabilities = capabilities,
        flags = lsp_flags,
    })
end
-- stylua: ignore end

return M
