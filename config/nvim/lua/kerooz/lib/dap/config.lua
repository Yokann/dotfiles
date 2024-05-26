local M = {}

local default_config = {
    enabled = true,
    path = (function()
        local root_dir = require('lspconfig.util').find_git_ancestor(vim.loop.fs_realpath('.')) or '.'
        return root_dir .. '/dap.json'
    end)(),
}

local function load_json_file(path)
    local file = io.open(path, "r")
    if file == nil then
        return nil
    end
    local content = file:read("*all")
    file:close()

    return vim.fn.json_decode(content)
end

function M.load_custom_configuration(dap, opts)
    local config = vim.tbl_deep_extend('force', default_config, opts or {})
    if config.enabled then
        local dap_configs = load_json_file(config.path)
        if dap_configs ~= nil then
            for _, c in ipairs(dap_configs) do
              table.insert(dap.configurations[c.dap], c)
            end
        end
    end
end

return M
