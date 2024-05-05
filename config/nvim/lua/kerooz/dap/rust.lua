local M = {}

function M.setup()
    local dap = require "dap"
    -- dap.adapters.codelldb = {
    --     type = 'server',
    --     port = "${port}",
    --     executable = {
    --         command = '/usr/bin/codelldb',
    --         args = { "--port", "${port}" },
    --     }
    -- }
    dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode", -- adjust as needed
        name = "lldb",
    }
    dap.configurations.rust = {
        {
            name = "Rust debug",
            type = "lldb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
            end,
            options = {
                env = {
                    TWT_TOKEN = "oauth:t2pnngdx9lbqxuwcqd5si8167g77d2"
                }
            },
            cwd = '${workspaceFolder}',
            stopOnEntry = true,
        },
    }
end

return M
