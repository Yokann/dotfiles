local M = {}

function M.setup(dap)
    for _, language in ipairs({ 'typescript', 'javascript' }) do
        dap.configurations[language] = {
            {
                type = 'pwa-node',
                request = 'launch',
                name = 'Launch file in new node process',
                program = '${file}',
                cwd = '${workspaceFolder}',
            },
            {
                type = 'pwa-node',
                request = 'attach',
                name = 'Attach debugger to existing `node --inspect` process',
                processId = require('kerooz.dap.common').filtered_pick_process,
                cwd = '${workspaceFolder}',
                resolveSourceMapLocations = {
                    '${workspaceFolder}/**',
                    '!**/node_modules/**'
                },
            },
            {
                type = 'pwa-node',
                request = 'launch',
                name = 'Run and debug Jest tests',
                -- trace = true, -- include debugger info
                runtimeExecutable = 'node',
                runtimeArgs = {
                    '${workspaceFolder}/node_modules/.bin/jest',
                    '--runInBand',
                },
                rootPath = '${workspaceFolder}',
                cwd = '${workspaceFolder}',
                console = 'integratedTerminal',
                internalConsoleOptions = 'neverOpen',
            },
            {
                type = 'pwa-node',
                request = 'launch',
                name = 'Launch Test Current File (pwa-node with jest)',
                cwd = vim.fn.getcwd(),
                runtimeArgs = { '${workspaceFolder}/node_modules/.bin/jest' },
                runtimeExecutable = 'node',
                args = { '${file}', '--coverage', 'false' },
                rootPath = '${workspaceFolder}',
                sourceMaps = true,
                console = 'integratedTerminal',
                internalConsoleOptions = 'neverOpen',
                skipFiles = { '**/node_modules/**' },
            },
            {
                type = 'pwa-chrome',
                request = 'launch',
                -- name of the debug action
                name = 'Launch Chrome to debug client side code',
                -- default vite dev server url
                url = 'http://localhost:5173',
                -- for TypeScript/Svelte
                sourceMaps = true,
                webRoot = '${workspaceFolder}/src',
                protocol = 'inspector',
                port = 9222,
                skipFiles = { '**/node_modules/**' },
            },
            {
                type = 'pwa-node',
                request = 'launch',
                name = 'Debug PNPM start',
                runtimeExecutable = 'pnpm',
                cwd = '${workspaceFolder}',
                args = {
                    'start'
                },
                skipFiles = { '**/node_modules/**' },
            }

        }
    end
end

return M
