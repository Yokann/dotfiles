return {
    { -- javascript debugger
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "theHamsta/nvim-dap-virtual-text",
            "mfussenegger/nvim-dap",
            "nvim-telescope/telescope-dap.nvim",
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
