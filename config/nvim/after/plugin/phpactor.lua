local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
    return
end

local Float = require "plenary.window.float"

local lspPhpactorGroup = vim.api.nvim_create_augroup("LspPhpactor", { clear = true })
vim.api.nvim_create_autocmd("Filetype", { pattern = "php", group = lspPhpactorGroup, command = 'command! -nargs=0 LspPhpactorReindex lua vim.lsp.buf_notify(0, "phpactor/indexer/reindex",{})' })
vim.api.nvim_create_autocmd("Filetype", { pattern = "php", group = lspPhpactorGroup, command = "command! -nargs=0 LspPhpactorConfig lua LspPhpactorDumpConfig()" })
vim.api.nvim_create_autocmd("Filetype", { pattern = "php", group = lspPhpactorGroup, command = "command! -nargs=0 LspPhpactorStatus lua LspPhpactorStatus()" })
vim.api.nvim_create_autocmd("Filetype", { pattern = "php", group = lspPhpactorGroup, command = "command! -nargs=0 LspPhpactorBlackfireStart lua LspPhpactorBlackfireStart()" })
vim.api.nvim_create_autocmd("Filetype", { pattern = "php", group = lspPhpactorGroup, command = "command! -nargs=0 LspPhpactorBlackfireFinish lua LspPhpactorBlackfireFinish()" })

local function showWindow(title, syntax, contents)
    local out = {};
    for match in string.gmatch(contents, "[^\n]+") do
        table.insert(out, match);
    end

    local float = Float.percentage_range_window(0.6, 0.4, { winblend = 0 }, {
        title = title,
        topleft = "┌",
        topright = "┐",
        top = "─",
        left = "│",
        right = "│",
        botleft = "└",
        botright = "┘",
        bot = "─",
    })

    vim.api.nvim_buf_set_option(float.bufnr, "filetype", syntax)
    vim.api.nvim_buf_set_lines(float.bufnr, 0, -1, false, out)
end

function LspPhpactorDumpConfig()
    local results, _ = vim.lsp.buf_request_sync(0, "phpactor/debug/config", {["return"]=true})
    for _, res in pairs(results or {}) do
        showWindow("Phpactor LSP Configuration", "json", res["result"])
    end
end
function LspPhpactorStatus()
    local results, _ = vim.lsp.buf_request_sync(0, "phpactor/status", {["return"]=true})
    for _, res in pairs(results or {}) do
        showWindow("Phpactor Status", "markdown", res["result"])
    end
end

function LspPhpactorBlackfireStart()
    local _, _ = vim.lsp.buf_request_sync(0, "blackfire/start", {})
end
function LspPhpactorBlackfireFinish()
    local _, _ = vim.lsp.buf_request_sync(0, "blackfire/finish", {})
end
