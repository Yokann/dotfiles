local function showWindow(title, syntax, contents)
    local Float = require("plenary.window.float")
    local out = {}
    for match in string.gmatch(contents, "[^\n]+") do
        table.insert(out, match)
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

    vim.api.nvim_set_option_value("filetype", syntax, { buf = float.bufnr })
    vim.api.nvim_buf_set_lines(float.bufnr, 0, -1, false, out)
end

local function request(client, method, title, syntax)
    local res = client:request_sync(method, { ["return"] = true }, 5000, 0)
    if res and res.result then
        showWindow(title, syntax, res.result)
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspPhpactor", { clear = true }),
    desc = "Phpactor buffer-local commands",
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= "phpactor" then
            return
        end
        local function cmd(name, fn, desc)
            vim.api.nvim_buf_create_user_command(args.buf, name, fn, { nargs = 0, desc = desc })
        end

        cmd("LspPhpactorReindex", function()
            client:notify("phpactor/indexer/reindex", {})
        end, "Phpactor: reindex")
        cmd("LspPhpactorConfig", function()
            request(client, "phpactor/debug/config", "Phpactor LSP Configuration", "json")
        end, "Phpactor: dump config")
        cmd("LspPhpactorStatus", function()
            request(client, "phpactor/status", "Phpactor Status", "markdown")
        end, "Phpactor: status")
        cmd("LspPhpactorBlackfireStart", function()
            client:notify("blackfire/start", {})
        end, "Phpactor: start blackfire")
        cmd("LspPhpactorBlackfireFinish", function()
            client:notify("blackfire/finish", {})
        end, "Phpactor: finish blackfire")
    end,
})
