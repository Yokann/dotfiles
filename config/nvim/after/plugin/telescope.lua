-- https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
local Remap = require("kerooz.keymap")
local nnoremap = Remap.nnoremap

require('telescope').load_extension('ag')
local builtin = require('telescope.builtin')
nnoremap('<leader>ff', builtin.find_files)
nnoremap('<leader>fg', builtin.live_grep)
nnoremap('<leader>fb', builtin.buffers)
nnoremap('<leader>fh', builtin.help_tags)
