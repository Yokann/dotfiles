local set = vim.keymap.set

-- Buffer
set("n", "<A-d>", "<Cmd>:bd<CR>:bn<CR>", { desc = "Close buffer", noremap = true })
set("n", "<leader>bd", "<Cmd>:%bd!<CR>", { desc = "Close all buffer", noremap = true })
set("n", "<C-s>", "<Cmd>:w<CR>", { desc = "Save buffer", noremap = true })

-- Move block selection up and down
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block code up" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block code down" })
-- set("n", "K", "<esc>:m .-2<CR>==", { noremap = true, desc = "Move line down" })
-- set("n", "J", "<esc>:m .+1<CR>==", { noremap = true, desc = "Move line up" })

-- indent
set("v", "<S-Tab>", "<gv", { desc = "Unindent line" })
set("v", "<Tab>", ">gv", { desc = "Indent line" })
-- set("n", "J", "mzJ`z") -- keep the cursor at the start of the line

-- Copy paste over system clipboard
-- set({ "n", "v" }, "<leader>y", [["+y]])
-- set("n", "<leader>Y", [["+Y]])
-- set({ "n", "v" }, "<leader>d", [["_d]])

-- yank and keep in buffer after paste
set("x", "<leader>p", "\"_dp")

set("n", "Q", "<nop>") -- don't binding anything on this key
set("i", "kj", "<Esc>")

set("n", "<esc>", "<Cmd>:noh<CR>", { noremap = false })

-- Keep cursor centered when scrolling
-- set("n", "<C-u>", "<C-u>zz")
-- set("n", "<C-d>", "<C-d>zz")

set("n", "<leader>sr", ":%s/<C-R><C-W>/")
