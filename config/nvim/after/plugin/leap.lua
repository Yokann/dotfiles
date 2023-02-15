local ok, leap = pcall(require, "leap")
if not ok then
    return
end

leap.add_default_mappings()
--vim.keymap.set("n" , "<leader>a", function ()
--local current_window = vim.fn.win_getid()
--leap.leap { target_windows = { current_window } }
--end)
