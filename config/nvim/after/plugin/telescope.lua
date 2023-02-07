require('telescope').load_extension('ag')
local builtin = require('telescope.builtin')

vim.keymap.set("n", '<leader>ff', builtin.find_files, { desc = "[F]ind in all [F]iles"})
vim.keymap.set("n", '<leader>fg', builtin.git_files, { desc = "[F]ind in [G]it files" } )
vim.keymap.set("n", '<leader>fb', builtin.buffers, { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", '<leader>fh', builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", '<leader>sg', function ()
    local search = vim.fn.input("Grep > ")
    vim.cmd('Ag '.. search)
end, { desc = "[S]earch [G]rep" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics"})
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })

