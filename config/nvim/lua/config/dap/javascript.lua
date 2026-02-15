local M = {}

local default_config = {
    js = {
        port = "${port}",
        host = "localhost",
    },
}

local function setup_js_adapter(dap, config)
    dap.adapters["pwa-node"] = {
        type = "server",
        host = config.js.host,
        port = config.js.port,
        executable = {
            command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
            args = {
                config.js.port,
            },
        },
    }

    dap.adapters.firefox = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/firefox-debug-adapter",
    }
end

local function setup_js_configuration(dap, config)
    for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file in new node process",
                program = "${file}",
                cwd = "${workspaceFolder}",
            },
            {
                type = "pwa-node",
                request = "attach",
                name = "Attach debugger to existing `node --inspect` process",
                processId = require("config.dap.common").filtered_pick_process,
                cwd = "${workspaceFolder}",
                resolveSourceMapLocations = {
                    "${workspaceFolder}/**",
                    "!**/node_modules/**",
                },
            },
            {
                type = "pwa-node",
                request = "launch",
                name = "Run and debug Jest tests",
                -- trace = true, -- include debugger info
                runtimeExecutable = "node",
                runtimeArgs = {
                    "${workspaceFolder}/node_modules/.bin/jest",
                    "--runInBand",
                },
                rootPath = "${workspaceFolder}",
                cwd = "${workspaceFolder}",
                console = "integratedTerminal",
                internalConsoleOptions = "neverOpen",
            },
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch Test Current File (node with jest)",
                cwd = vim.fn.getcwd(),
                runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
                runtimeExecutable = "node",
                args = { "${file}", "--coverage", "false" },
                rootPath = "${workspaceFolder}",
                sourceMaps = true,
                console = "integratedTerminal",
                internalConsoleOptions = "neverOpen",
                skipFiles = { "**/node_modules/**" },
            },
            {
                type = "firefox",
                request = "launch",
                -- name of the debug action
                name = "Launch in Firefox - localhost:3000",
                -- default vite dev server url
                -- url = "http://localhost:5173",
                url = "http://localhost:3000",
                reAttach = true,
                -- for TypeScript/Svelte
                sourceMaps = true,
                webRoot = "${workspaceFolder}/src",
                skipFiles = { "**/node_modules/**" },
                firefoxExecutable = "/usr/bin/firefox",
            },
            {
                type = "pwa-node",
                request = "launch",
                name = "Debug PNPM start",
                runtimeExecutable = "pnpm",
                cwd = "${workspaceFolder}",
                args = {
                    "start",
                },
                skipFiles = { "**/node_modules/**" },
            },
        }
    end
end

function M.setup(dap, opts)
    local config = vim.tbl_deep_extend("force", default_config, opts or {})
    setup_js_adapter(dap, config)
    setup_js_configuration(dap, config)
end

return M
