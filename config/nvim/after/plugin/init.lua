vim.cmd(":TSInstall all");

-- Nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
    renderer = {
        highlight_git = true
    }
})

