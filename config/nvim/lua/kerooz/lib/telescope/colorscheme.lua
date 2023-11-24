-- prompt borderless style
local M = {}

M.setPromptStyle = function(style)
    local TelescopePrompt = {}

    if style == 'borderless' then
        TelescopePrompt = {
            TelescopePromptNormal = {
                bg = '#2d3149',
            },
            TelescopePromptBorder = {
                fg = '#2d3149',
                bg = '#2d3149'
            },
            TelescopePromptTitle = {
                fg = '#2d3149',
                bg = '#2d3149',
            },
            TelescopePreviewTitle = {
                fg = '#b2b8f2',
                bg = '#1F2335',
            },
            TelescopePreviewBorder = {
                fg = '#1F2335',
                bg = '#1F2335'
            },
            TelescopePreviewNormal = {
                bg = '#1F2335',
            },
            TelescopeResultsNormal = {
                bg = '#1F2335',
            },
            TelescopeResultsBorder = {
                fg = '#1F2335',
                bg = '#1F2335'
            },
            TelescopeResultsTitle = {
                fg = '#1F2335',
                bg = '#1F2335',
            },
        }
    end

    for hl, col in pairs(TelescopePrompt) do
        vim.api.nvim_set_hl(0, hl, col)
    end
end

return M
