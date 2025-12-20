return {
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            { "jbyuki/one-small-step-for-vimkind", module = "osv" },
        },
        config = function()
            require("kerooz.dap").setup()
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
            ensure_installed = {
                "delve",
                "js",
                "cppdbg",
                "codelldb",
                "php",
                "firefox",
            },
        },
    },
}
