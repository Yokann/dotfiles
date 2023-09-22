local M = {}

function M.setup()
    local dap = require "dap"
    dap.configurations.lua = {
        {
            type = "nlua",
            request = "attach",
            name = "attach to running Neovim instance",
        },
    }

    dap.adapters.nlua = function(callback, config)
        callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
    end
end

return M
