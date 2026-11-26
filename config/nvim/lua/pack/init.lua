-- vim.pack entry point (enabled with NVIM_PACK=1, see init.lua).

-- Build steps. Must be registered BEFORE any vim.pack.add().
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if kind ~= "install" and kind ~= "update" then
            return
        end
        if not ev.data.active then
            vim.cmd.packadd(name)
        end
        if name == "nvim-treesitter" then
            vim.cmd("TSUpdate")
        elseif name == "markdown-preview.nvim" then
            vim.fn["mkdp#util#install"]()
        end
    end,
})

-- Order matters: later modules use plugins from earlier ones
-- (auto-session needs snacks + aerial, lsp needs blink, lualine/incline need devicons...).
require("pack.snacks")
require("pack.ui")
require("pack.treesitter")
require("pack.basics")
require("pack.noice")
require("pack.completion")
require("pack.lsp") -- also loads pack.dap
require("pack.copilot")
require("pack.git")
require("pack.miscellaneous")
