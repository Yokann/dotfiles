_G.nvim_start_hr = vim.uv.hrtime() -- for the dashboard startup time
vim.loader.enable()

if vim.env.PROF then
    local snacks = vim.env.NVIM_PACK and (vim.fn.stdpath("data") .. "/site/pack/core/opt/snacks.nvim")
        or (vim.fn.stdpath("data") .. "/lazy/snacks.nvim")
    vim.opt.rtp:append(snacks)
    require("snacks.profiler").startup({
        startup = {
            event = "VimEnter",
        },
    })
end

--  https://github.com/folke/lazy.nvim#-user-events
require("config.settings")
require("config.diagnostics")
require("config.keymaps")
require("config.autocommand")
require("config.filetype")
if vim.env.NVIM_PACK then
    require("pack") -- experimental: native vim.pack
else
    require("config.package_manager")
end
