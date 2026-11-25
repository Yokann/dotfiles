local M = {}

local capabilities = require("blink.cmp").get_lsp_capabilities()
local lsp_flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
}

-- stylua: ignore start
local function set_keymaps(bufnr)
    local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("gd", function() Snacks.picker.lsp_definitions() end, "[G]o [D]efinition")
    map("gtd", function() Snacks.picker.lsp_type_definitions() end, "[G]o [T]ype [D]efinition")
    map("gr", function() Snacks.picker.lsp_references() end, "[G]oto [R]eferences")
    map("<leader>s", function() Snacks.picker.lsp_symbols() end, "[F]ind [S]ymbols")
    map("<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, "[F]ind [W]orkspace [S]ymbols")
    map("gi", function() Snacks.picker.lsp_implementations() end, "[G]o [I]mplemention")
    map("K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Hover")
    map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Go to next [D]iagnostic message")
    map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Go to previous [D]iagnostic message")
    map("ga", function() vim.lsp.buf.code_action() end, "[V]iew [C]ode [A]ction")
    map("gA", function()
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
    end, "[V]iew [C]ode actions [O]thers")
    map("<leader>rn", function() vim.lsp.buf.rename() end, "[R]e[N]ame")
end
-- stylua: ignore end

M.configure = function()
    vim.lsp.config("*", {
        capabilities = capabilities,
        flags = lsp_flags,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        desc = "Buffer-local LSP keymaps",
        callback = function(args)
            set_keymaps(args.buf)

            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if not client then
                return
            end

            if client:supports_method("textDocument/inlayHint") then
                vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end

            if client:supports_method("textDocument/codeLens") then
                vim.lsp.codelens.refresh({ bufnr = args.buf })
                vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                    buffer = args.buf,
                    desc = "Refresh code lenses",
                    callback = function()
                        vim.lsp.codelens.refresh({ bufnr = args.buf })
                    end,
                })
            end
        end,
    })

    vim.keymap.set("n", "<leader>ih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
    end, { desc = "Toggle inlay hints" })
end

return M
