local Remap = require("kerooz.keymap")
local nnoremap = Remap.nnoremap

require("nvim-tree").setup{
    update_focused_file = {
       enable = true
    }
}

local api = require("nvim-tree.api")
nnoremap('<leader>tt', function()
  api.tree.toggle(false, false)
end)

