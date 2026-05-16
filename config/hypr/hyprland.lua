local lib = require("config.lib")
local M = {}

---@class defaultOptions
---@field theme string
---@field enableNvidia boolean
---@field beforeExecs function
local defaultOptions = {
    theme = "2024",
    enableNvidia = false,
    beforeExecs = function() end,
}

---@params opts defaultOptions
M.setup = function(opts)
    opts = lib.table_merge(defaultOptions, opts or {})
    require("config.core.globals")
    require("config.core.env")
    require("config.themes." .. opts.theme .. ".env")
    if opts.enableNvidia then
        require("lib.nvidia").loadEnv()
    end
    opts.beforeExecs()
    require("config.core.execs")
    require("config.themes." .. opts.theme .. ".execs")
    require("config.core.inputs")
    require("config.core.settings")
    require("config.themes." .. opts.theme .. ".settings")
    require("config.core.rules")
    require("config.core.bind")
end

---@params deviceNames string[]
M.loadDevicesConfig = function(deviceNames)
    local devices = require("devices")
    for _, deviceName in ipairs(deviceNames) do
        devices.loadConfig(deviceName)
    end
end

return M
