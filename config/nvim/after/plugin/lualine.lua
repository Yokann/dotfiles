local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end
lualine.setup {
    --     options = {
    --         disabled_filetypes = {
    --             'NvimTree', 'DapBreakpoint', 'DapScope', 'DapStack'
    --         }
    --     }
    -- }
    sections = {
        lualine_b = {
            { "branch", icon = "" },
            {
                "diff",
                colored = true,
                -- diff_color = {
                --     added    = { fg = "#28A745" },
                --     modified = { fg = "#DBAB09" },
                --     removed  = { fg = "#D73A49" }
                -- },
                symbols = {
                    added    = " ",
                    modified = " ",
                    removed  = " "
                }
            },
            -- { "diagnostics' }
        },
        lualine_c = {
            "diagnostics",
            "filename",
        }
    }
}
