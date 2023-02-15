local M = {}

function M.setup()
    local dap = require "dap"
    -- dap.adapters.php = {
    --     type = 'executable',
    --     command = 'node',
    --     args = { os.getenv("HOME") .. '/.local/lib/vscode-php-debug/out/phpDebug.js' }
    -- }
    dap.adapters.php = {
        type = 'executable',
        command = 'php-debug-adapter',
    }

    dap.configurations.php = {
        {
            type = 'php',
            request = 'launch',
            name = 'Listen for Xdebug',
            port = 9003,
            pathMappings = {
                ['/srv/deploy/'] = "${workspaceFolder}",
            },
        }
    }
end

return M
