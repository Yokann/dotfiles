local Remap = require("kerooz.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

-- Buffer
nnoremap("<C-h>", ":bn<CR>")
nnoremap("<C-l>", ":bp<CR>")
nnoremap("<C-d>", ":bd<CR>")
nnoremap("<C-s>", ":w<CR>")
-- quotes 
--inoremap('"', '""<Left>')
--inoremap("'", "''<Left>")
-- Azerty Bracket Hell
inoremap("<C-(>", "[]<Left>")
inoremap("<C-b>", "{}<Left>")
inoremap("(", "()<Left>")
