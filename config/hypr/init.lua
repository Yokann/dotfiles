local this_file = debug.getinfo(1, "S").source:sub(2) -- remove '@'
local this_dir = this_file:match("(.*/)")
package.path = this_dir .. "?.lua;" .. this_dir .. "?/init.lua;" .. package.path

local lib = require("lib")
local M = {}

---@class defaultOptions
---@field theme string
---@field enableNvidia boolean
---@field beforeExecs function
local defaultOptions = {
    theme = "2024",
    enableNvidia = false,
    loadGlobals = function() end,
    beforeExecs = function() end,
}

---@params opts defaultOptions
M.setup = function(opts)
    opts = lib.table_merge(defaultOptions, opts or {})
    require("core.globals").loadGlobals(opts)
    require("core.env")
    require("themes." .. opts.theme .. ".env")
    if opts.enableNvidia then
        require("lib.nvidia").loadEnv()
    end
    opts.beforeExecs()
    require("core.execs")
    require("themes." .. opts.theme .. ".execs")
    require("core.inputs")
    require("core.settings")
    require("themes." .. opts.theme .. ".settings")
    require("core.rules")
    require("core.bind")
end

---@params deviceNames string[]
M.loadDevicesConfig = function(deviceNames)
    local devices = require("devices")
    for _, deviceName in ipairs(deviceNames) do
        devices.loadConfig(deviceName)
    end
end

return M
