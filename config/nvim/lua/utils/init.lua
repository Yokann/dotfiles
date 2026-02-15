local M = {}

M.playsound = function(sound_file)
    local sound_path = vim.fn.stdpath("config") .. "/sounds/" .. sound_file
    local is_mac = vim.fn.has("macunix") == 1
    local is_linux = vim.fn.has("unix") == 1 and not is_mac

    if is_mac then
        vim.system({ "afplay", sound_path })
    elseif is_linux then
        vim.system({ "pw-play", sound_path })
    end
end

return M
