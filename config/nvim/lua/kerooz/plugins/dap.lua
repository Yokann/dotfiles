-- return {
--     {
--         "mfussenegger/nvim-dap",
--         lazy = true,
--         event = "BufReadPre",
--         -- module = { "dap" },
--         dependencies = {
--             "theHamsta/nvim-dap-virtual-text",
--             "rcarriga/nvim-dap-ui",
--             "nvim-telescope/telescope-dap.nvim",
--             { "jbyuki/one-small-step-for-vimkind", module = "osv" },
--         },
--         config = function()
--             require("kerooz.dap").setup()
--         end,
--     }
-- }
 return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "mfussenegger/nvim-dap",
        "nvim-telescope/telescope-dap.nvim",
        { "jbyuki/one-small-step-for-vimkind", module = "osv" },
    },
    config = function ()
        require("kerooz.dap").setup()
    end,
    lazy = true,
    event = "BufReadPre"
 }
