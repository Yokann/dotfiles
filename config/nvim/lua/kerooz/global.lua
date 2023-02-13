-- Buffer
vim.keymap.set("n", "<A-h>", "<Cmd>:bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<A-l>", "<Cmd>:bp<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<A-d>", "<Cmd>:bd<CR>:bn<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<A-s>", "<Cmd>:w<CR>", { desc = "Save buffer" })
-- quotes 
--vim.keymap.set("i", '"', '""<Left>')
--vim.keymap.set("i", "'", "''<Left>")

-- Azerty Bracket Hell
vim.keymap.set("i", "<A-(>", "[]<Left>")
vim.keymap.set("i", "<A-b>", "{}<Left>")
--vim.keymap.set("i", "(", "()<Left>")

-- Move block selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block code up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block code down" })

vim.keymap.set("n", "J", "mzJ`z") -- keep the cursor at the start of the line

-- Copy paste over system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- yank and keep in buffer after paste 
vim.keymap.set("x", "<leader>p", "\"_dp")

vim.keymap.set("n", "Q", "<nop>") -- don't binding anything on this key
vim.keymap.set("i", "jh", "<Esc>")

vim.keymap.set("n", "<leader>nh", "<Cmd>:noh<CR>")

