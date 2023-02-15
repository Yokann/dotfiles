local ok, nvimtree = pcall(require, "nvim-tree")
if not ok then
    return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup {
    update_focused_file = {
        enable = true
    },
    disable_netrw = true,
    diagnostics = {
        enable = true
    },
    git = {
        enable = true,
        timeout = 400 -- (in ms)
    },
    filters = {
        dotfiles = false,
        custom = { "^.git$" }
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
    renderer = {
        highlight_git = true
    }
}

local api = require("nvim-tree.api")
vim.keymap.set("n", '<leader>tt', function()
    api.tree.toggle(false, false)
end)
vim.keymap.set("n", "<leader>tr", function ()
    api.tree.focus()
end)
