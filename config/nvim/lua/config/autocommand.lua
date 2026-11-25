-- Reload tmux conf on configuration edit
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("tmux_user_config", { clear = true }),
    pattern = ".tmux.conf",
    command = "!tmux source-file %",
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "lspinfo",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ timeout = 800 })
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    desc = "Keep splits equally sized on window resize",
    command = "wincmd =",
})

vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Restore cursor position",
    callback = function(ctx)
        if vim.bo[ctx.buf].buftype ~= "" then
            return
        end
        vim.cmd([[silent! normal! g`"]])
    end,
})

-- Reload buffers changed on disk (e.g. edited by an external tool)
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
    desc = "Check for external file changes",
    group = vim.api.nvim_create_augroup("checktime", { clear = true }),
    callback = function()
        if vim.fn.getcmdwintype() == "" then
            vim.cmd("checktime")
        end
    end,
})

-- Track when Neovim started
local nvim_start_time = vim.uv.hrtime()
vim.api.nvim_create_autocmd("FocusGained", {
    desc = "Close all non-existing buffers on `FocusGained`.",
    callback = function()
        -- Don't run cleanup in the first 10 seconds after starting Neovim
        if (vim.uv.hrtime() - nvim_start_time) < 10e9 then
            return
        end

        local allBufs = vim.fn.getbufinfo({ buflisted = 1 })
        local closedBuffers = vim.iter(allBufs):fold({}, function(acc, buf)
            if not vim.api.nvim_buf_is_valid(buf.bufnr) then
                return acc
            end
            local virtual = buf.name:match("^%w[%w+.-]*://") ~= nil
            local stillExists = virtual or vim.uv.fs_stat(buf.name) ~= nil
            local specialBuffer = vim.bo[buf.bufnr].buftype ~= ""
            local newBuffer = buf.name == ""
            if stillExists or specialBuffer or newBuffer then
                return acc
            end
            table.insert(acc, vim.fs.basename(buf.name))
            vim.api.nvim_buf_delete(buf.bufnr, { force = false })
            return acc
        end)
        if #closedBuffers == 0 then
            return
        end

        if #closedBuffers == 1 then
            vim.notify(closedBuffers[1], nil, { title = "Buffer closed", icon = "󰅗" })
        else
            local text = "- " .. table.concat(closedBuffers, "\n- ")
            vim.notify(text, nil, { title = "Buffers closed", icon = "󰅗" })
        end
    end,
})

-- Start treesitter (highlight, indent, folds) on filetypes that have a parser,
-- skipping huge files to avoid the delay on startup.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(ctx)
        if vim.api.nvim_buf_line_count(ctx.buf) > 50000 then
            return
        end
        if ctx.match == "" or not pcall(vim.treesitter.start, ctx.buf) then
            return
        end
        vim.bo[ctx.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
})

-- Change line number colors based on mode
local default_line
local default_cursor
local current_kind

local function mode_kind(mode)
    if mode:find("^i") then
        return "insert"
    elseif mode:find("^[vV\22]") then
        return "visual"
    end
    return "normal"
end

local function set_line_number_colors(kind)
    if kind == current_kind or not default_line then
        return
    end
    current_kind = kind
    local ok, palette = pcall(function()
        return require("catppuccin.palettes").get_palette()
    end)
    if not ok then
        return
    end
    if kind == "insert" then
        vim.api.nvim_set_hl(0, "LineNr", { fg = palette.green })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = palette.lavender, bold = true })
    elseif kind == "visual" then
        vim.api.nvim_set_hl(0, "LineNr", { fg = palette.mauve })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = palette.sapphire, bold = true })
    else
        -- Normal: restore theme defaults
        vim.api.nvim_set_hl(0, "LineNr", default_line)
        vim.api.nvim_set_hl(0, "CursorLineNr", default_cursor)
    end
end

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        -- store defaults for the lineNr color swaps below
        default_line = vim.api.nvim_get_hl(0, { name = "LineNr" })
        default_cursor = vim.api.nvim_get_hl(0, { name = "CursorLineNr" })
        current_kind = "normal"
    end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
    group = vim.api.nvim_create_augroup("ModeLineNumbers", { clear = true }),
    callback = function()
        set_line_number_colors(mode_kind(vim.fn.mode()))
    end,
})
