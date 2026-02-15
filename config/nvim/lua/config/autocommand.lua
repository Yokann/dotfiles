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
        vim.highlight.on_yank({ timeout = 800 })
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

vim.api.nvim_create_autocmd("WinScrolled", {
    desc = "Exit snippet",
    callback = function()
        vim.snippet.stop()
    end,
})

vim.api.nvim_create_autocmd("FocusLost", {
    desc = "Auto-cleanup. Once a week, on first `FocusLost`, delete older files.",
    once = true,
    callback = function()
        if jit.os ~= "OSX" then
            return
        end -- using macOS commands
        if os.date("%a") == "Mon" then
            vim.system({ "find", vim.o.undodir, "-mtime", "+30d", "-delete" })
            vim.system({ "find", vim.lsp.log.get_filename(), "-size", "+20M", "-delete" })
        end
    end,
})

vim.api.nvim_create_autocmd("FocusGained", {
    desc = "Close all non-existing buffers on `FocusGained`.",
    callback = function()
        local allBufs = vim.fn.getbufinfo({ buflisted = 1 })
        local closedBuffers = vim.iter(allBufs):fold({}, function(acc, buf)
            if not vim.api.nvim_buf_is_valid(buf.bufnr) then
                return acc
            end
            local stillExists = vim.uv.fs_stat(buf.name) ~= nil
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

        -- If ending up in empty buffer, re-open the first oldfile that exists
        vim.schedule(function()
            if vim.api.nvim_buf_get_name(0) ~= "" then
                return
            end
            for _, file in ipairs(vim.v.oldfiles) do
                if vim.uv.fs_stat(file) and vim.fs.basename(file) ~= "COMMIT_EDITMSG" then
                    vim.cmd.edit(file)
                    return
                end
            end
        end)
    end,
})
