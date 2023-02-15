require("nvim-tree").setup {
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
}

local api = require("nvim-tree.api")
vim.keymap.set("n", '<leader>tt', function()
    api.tree.toggle(false, false)
end)
