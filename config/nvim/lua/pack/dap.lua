local pack = require("pack.util")

pack.add({ "mfussenegger/nvim-dap", "jay-babu/mason-nvim-dap.nvim" })
require("mason-nvim-dap").setup({
    ensure_installed = {
        "delve",
        "js",
        "cppdbg",
        "codelldb",
        "php",
        "firefox",
    },
})

pack.lazy({
    plugins = {
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
        "jbyuki/one-small-step-for-vimkind",
        "rcarriga/nvim-dap-ui",
    },
    event = "VeryLazy",
    config = function()
        require("config.dap.init").setup()
    end,
})
