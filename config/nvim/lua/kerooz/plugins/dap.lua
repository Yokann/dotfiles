return {
    { -- javascript debugger
        "microsoft/vscode-js-debug",
        version = "1.x",
        build = "npm install && npx gulp vsDebugServerBundle && mv dist out",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "nvim-telescope/telescope-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
            { "jbyuki/one-small-step-for-vimkind", module = "osv" },
            {
                "mxsdev/nvim-dap-vscode-js",
                opts = {
                    node_path = 'node',
                    debugger_path = os.getenv('HOME') .. '/.local/share/nvim/lazy/vscode-js-debug',
                    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
                }
            }
        },
        config = function()
            require("kerooz.dap").setup()
        end,
        lazy = true,
        event = "BufReadPre"
    }
}
