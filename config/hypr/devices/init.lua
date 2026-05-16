local M = {}

---@param deviceName string
M.loadConfig = function(deviceName)
    if deviceName == "steelseries-aerox" then
        hl.device({
            name = "steelseries-steelseries-aerox-3-wireless",
            sensitivity = 1,
            accel_profile = "flat",
        })
    end
end

return M
