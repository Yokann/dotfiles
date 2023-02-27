local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end
lualine.setup{}
-- lualine.setup {
--     options = {
--         disabled_filetypes = {
--             'NvimTree', 'DapBreakpoint', 'DapScope', 'DapStack'
--         }
--     }
-- }
