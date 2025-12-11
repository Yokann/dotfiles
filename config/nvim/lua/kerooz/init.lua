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
require("kerooz.config.settings")
require("kerooz.config.keymaps")
require("kerooz.config.autocommand")
require("kerooz.config.filetype")
require("kerooz.config.package_manager")
