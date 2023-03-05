local ok, palette = pcall(require, "catppuccin.palettes")
if not ok then
    return
end

local C = palette.get_palette()

-- Diagnostic Icon
local function lspSymbol(name, icon, color)
    vim.fn.sign_define(
        "DiagnosticSign" .. name,
        { text = icon, numhl = "DiagnosticDefault" .. name, fg = color }
    )
end
lspSymbol("Error", "", C.red)
lspSymbol("Hint", "", C.teal)
lspSymbol("Info", "", C.sky)
lspSymbol("Warning", "", C.yellow)
