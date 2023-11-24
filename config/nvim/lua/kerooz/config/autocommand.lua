local M = {}

function M.load_on_startup()
    -- Reload tmux conf on configuration edit
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("tmux_user_config", { clear = true }),
        pattern = ".tmux.conf",
        command = "!tmux source-file %"
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
end


function M.setup()
    M.load_on_startup()
end

return M
