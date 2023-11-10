local M = {}

function M.setup()
    local dap = require "dap"
    dap.configurations.go = {
        {
            type = 'delve',
            name = 'Delve: Debug',
            request = 'launch',
            program = '${file}',
        },
        {
            type = 'delve',
            name = 'Delve: Debug test', -- configuration for debugging test files
            request = 'launch',
            mode = 'test',
            program = '${file}',
        },
        -- works with go.mod packages and sub packages
        {
            type = 'delve',
            name = 'Delve: Debug test (go.mod)',
            request = 'launch',
            mode = 'test',
            program = './${relativeFileDirname}',
        },
    }

    dap.adapters.delve = {
        type = 'server',
        port = '${port}',
        executable = {
            command = 'dlv',
            args = { 'dap', '-l', '127.0.0.1:${port}', '--check-go-version=false' },
        }
    }
end

return M
