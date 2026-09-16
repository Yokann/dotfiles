local M = {}

local deviceConfig = {
    ["steelseries-aerox"] = {
        name = "steelseries-steelseries-aerox-3-wireless",
        sensitivity = 1,
        accel_profile = "flat",
    },
}
---@param deviceName string
M.loadConfig = function(deviceName)
    if deviceConfig[deviceName] then
        hl.device(deviceConfig[deviceName])
    end
end

return M
