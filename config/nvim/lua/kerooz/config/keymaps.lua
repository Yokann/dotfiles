local set = vim.keymap.set

-- Buffer
set("n", "<M-j>", "<Cmd>:bn<CR>", { desc = "Next buffer", noremap = true })
set("n", "<M-k>", "<Cmd>:bp<CR>", { desc = "Previous buffer", noremap = true })
set("n", "<M-d>", "<Cmd>:bd<CR>", { desc = "Close buffer", noremap = true })
set("n", "<M-D>", "<Cmd>:%bd!<CR>", { desc = "Close all buffer", noremap = true })
set("n", "<C-s>", "<Cmd>:w<CR>", { desc = "Save buffer", noremap = true })

-- Move block selection up and down
set("n", "<Down>", "<cmd>. move +1<CR>==", { desc = "󰜮 Move line down" })
set("n", "<Up>", "<cmd>. move -2<CR>==", { desc = "󰜷 Move line up" })
set("n", "<Right>", [["zx"zp]], { desc = "➡️ Move char right" })
set("n", "<Left>", [["zdh"zph]], { desc = "⬅ Move char left" })
set("x", "<Down>", [[:move '>+1<CR>gv=gv]], { desc = "󰜮 Move selection down", silent = true })
set("x", "<Up>", [[:move '<-2<CR>gv=gv]], { desc = "󰜷 Move selection up", silent = true })
set("x", "<Right>", [["zx"zpgvlolo]], { desc = "➡️ Move selection right" })
set("x", "<left>", [["zxhh"zpgvhoho]], { desc = "⬅ Move selection left" })

-- indent
set("x", "<S-Tab>", "<gv", { desc = "Unindent line" })
set("x", "<Tab>", ">gv", { desc = "Indent line" })

-- undo
set("n", "u", "<cmd>silent undo<CR>zv", { desc = "󰜊 Silent undo" })
set("n", "U", "<cmd>silent redo<CR>zv", { desc = "󰛒 Silent redo" })

set("n", "Q", "<nop>") -- don't binding anything on this key
set("i", "kj", "<Esc>")

set("n", "<esc>", "<Cmd>:noh<CR>", { noremap = false })

set("n", "<leader>sr", ":%s/<C-R><C-W>/")
-- set("n", "<C-$>", ":%s/<C-r>0//g<Left><Left>", { desc = "Replace last yanked text" })

-- Resize windows
set("n", "<C-Up>", "<C-w>3-")
set("n", "<C-Down>", "<C-w>3+")
set("n", "<C-Left>", "<C-w>5<")
set("n", "<C-Right>", "<C-w>5>")

-- Delete to void register
set({ "n", "x" }, "x", '"_x')
set({ "n", "x" }, "c", '"_c')
set("n", "C", '"_C')
set("x", "p", "P")
set("n", "dd", function()
    local lineEmpty = vim.trim(vim.api.nvim_get_current_line()) == ""
    return (lineEmpty and '"_dd' or "dd")
end, { expr = true })
