-- Global binding on all LSP
return function(_config)
    return vim.tbl_deep_extend("force", {
        on_attach = function()
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "[G]o [D]efinition" })
            vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, { desc = "[G]o [I]mplemention" })
            vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "[C]ode [A]ction" })
            vim.keymap.set("n", "fmt", function() vim.lsp.buf.format({ async = true }) end, { desc = "[F]or[M]a[T]" })
            vim.keymap.set("n", "U", function() vim.lsp.buf.hover() end)
            vim.keymap.set("n", "vd", function() vim.diagnostic.open_float(nil, { focus = false }) end,
                { desc = "[V]iew [D]iagnostic" })
            vim.keymap.set("n", "vdj", function() vim.diagnostic.goto_next() end, { desc = "Next occurrence" })
            vim.keymap.set("n", "vdk", function() vim.diagnostic.goto_prev() end, { desc = "Previous occurence" })
            vim.keymap.set("n", "<leader>cc", function() vim.lsp.buf.code_action() end,
                { desc = "[V]iew [C]ode [A]ction" })
            vim.keymap.set("n", "<leader>co", function()
                vim.lsp.buf.code_action({
                    filter = function(code_action)
                        if not code_action or not code_action.data then
                            return false
                        end

                        local data = code_action.data.id
                        return string.sub(data, #data - 1, #data) == ":0"
                    end,
                    apply = true
                })
            end, { desc = "[V]iew [C]ode actions [O]thers" })
            vim.keymap.set("n", "<leader>vcr", function() vim.lsp.buf.references() end,
                { desc = "[V]iew [C]ode [R]eferences" })
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, { desc = "[V]iew [R]e[N]ame" })
            vim.keymap.set({ "n", "i" }, "<A-h>", function() vim.lsp.buf.signature_help() end,
                { desc = "View code signature" })

            --  Autoformat on save
            --     if client.supports_method("textDocument/formatting") then
            --         local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            --         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            --         vim.api.nvim_create_autocmd("BufWritePre", {
            --             group = augroup,
            --             buffer = bufnr,
            --             callback = function()
            --                 vim.lsp.buf.format()
            --             end,
            --         })
            --     end
        end,
    }, _config or {})
end
