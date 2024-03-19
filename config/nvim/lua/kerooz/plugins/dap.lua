return {
    { -- javascript debugger
        "microsoft/vscode-js-debug",
        build = "rm -f package-lock.json && npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
        tag = "v1.86.0",
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
