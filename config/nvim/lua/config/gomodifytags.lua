local M = {}

local DEFAULT_TAGS = "json"
local TRANSFORM = "camelcase"

---@param bufnr integer
---@param action "add"|"remove"
---@param tags string
---@param range? { [1]: integer, [2]: integer } 1-based inclusive line range (visual selection)
local function run(bufnr, action, tags, range)
    if vim.fn.executable("gomodifytags") == 0 then
        vim.notify("gomodifytags is not installed", vim.log.levels.ERROR)
        return
    end

    local file = vim.api.nvim_buf_get_name(bufnr)
    local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n") .. "\n"

    local cmd = { "gomodifytags", "-file", file, "-modified", "-format", "json" }
    if range then
        vim.list_extend(cmd, { "-line", range[1] .. "," .. range[2] })
    else
        local pos = vim.api.nvim_win_get_cursor(0)
        vim.list_extend(cmd, { "-offset", tostring(vim.fn.line2byte(pos[1]) - 1 + pos[2]) })
    end

    if action == "add" then
        vim.list_extend(cmd, { "-add-tags", tags, "-transform", TRANSFORM })
    else
        vim.list_extend(cmd, { "-remove-tags", tags })
    end

    -- `-modified` reads an archive from stdin so unsaved buffers are supported
    local archive = file .. "\n" .. #content .. "\n" .. content

    vim.system(cmd, { stdin = archive, text = true }, function(res)
        vim.schedule(function()
            if res.code ~= 0 then
                vim.notify("gomodifytags: " .. vim.trim(res.stderr or ""), vim.log.levels.ERROR)
                return
            end
            local ok, decoded = pcall(vim.json.decode, res.stdout)
            if not ok or type(decoded) ~= "table" or not decoded.lines then
                vim.notify("gomodifytags: unexpected output", vim.log.levels.ERROR)
                return
            end
            if not vim.api.nvim_buf_is_valid(bufnr) then
                return
            end
            vim.api.nvim_buf_set_lines(bufnr, decoded.start - 1, decoded["end"], false, decoded.lines)
        end)
    end)
end

---Register :GoAddTags and :GoRemoveTags for the given buffer.
---@param bufnr integer
function M.setup(bufnr)
    local function define(name, action, desc)
        vim.api.nvim_buf_create_user_command(bufnr, name, function(opts)
            local tags = opts.args ~= "" and opts.args or DEFAULT_TAGS
            local range = opts.range > 0 and { opts.line1, opts.line2 } or nil
            run(bufnr, action, tags, range)
        end, { nargs = "?", range = true, desc = desc })
    end

    define("GoAddTags", "add", "gomodifytags: add struct tags (default: json)")
    define("GoRemoveTags", "remove", "gomodifytags: remove struct tags (default: json)")
end

return M
