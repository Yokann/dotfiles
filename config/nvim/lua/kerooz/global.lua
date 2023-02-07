-- Buffer
vim.keymap.set("n", "<C-h>", ":bn<CR>")
vim.keymap.set("n", "<C-l>", ":bp<CR>")
vim.keymap.set("n", "<C-d>", ":bd<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
-- quotes 
--vim.keymap.set("i", '"', '""<Left>')
--vim.keymap.set("i", "'", "''<Left>")
-- Azerty Bracket Hell
vim.keymap.set("i", "<C-(>", "[]<Left>")
vim.keymap.set("i", "<C-b>", "{}<Left>")
vim.keymap.set("i", "(", "()<Left>")
-- Move block selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z") -- keep the cursor a 

-- Copy paste over system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("i", "jh", "<Esc>")



