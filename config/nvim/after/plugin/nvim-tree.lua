require("nvim-tree").setup{
    update_focused_file = {
       enable = true
    },
    disable_netrw = true,
    diagnostics = {
        enable = true
    }
}

local api = require("nvim-tree.api")
vim.keymap.set("n", '<leader>tt', function()
  api.tree.toggle(false, false)
end)

