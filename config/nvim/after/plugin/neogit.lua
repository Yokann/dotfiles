-- https://github.com/TimUntersberger/neogit
local neogit = require('neogit')
local nnoremap = require('kerooz.keymap').nnoremap

neogit.setup {
  kind = "vsplit",
}

nnoremap("<leader>gs", function()
    neogit.open()
end)
