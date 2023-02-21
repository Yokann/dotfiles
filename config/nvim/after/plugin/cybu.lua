local ok, cybu = pcall(require, "cybu")
if not ok then
    return
end

cybu.setup({
  position = {
      anchor = "topright",
      vertical_offset = 2,
  },
  display_time = 2000,
})
vim.keymap.set("n", "<A-k>", "<Plug>(CybuPrev)", { noremap = true })
vim.keymap.set("n", "<A-j>", "<Plug>(CybuNext)", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-s-tab>", "<plug>(CybuLastusedPrev)",
    { desc = "Previous last used buffer" })
vim.keymap.set({ "n", "v" }, "<c-tab>", "<plug>(CybuLastusedNext)", { desc = "Next last used buffer " })
