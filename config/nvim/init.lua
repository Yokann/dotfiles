if vim.env.PROF then
    local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
    vim.opt.rtp:append(snacks)
    require("snacks.profiler").startup({
        startup = {
            event = "VimEnter",
        },
    })
end

--  https://github.com/folke/lazy.nvim#-user-events
require("config.settings")
require("config.keymaps")
require("config.autocommand")
require("config.filetype")
require("config.package_manager")
