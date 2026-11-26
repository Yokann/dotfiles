-- Snacks picker for nvim-dap configuration selection, with a preview of the
-- selected configuration (replacement for telescope-dap's configurations picker).
local M = {}

---Pick one DAP configuration with a preview window.
---@param items table[] dap configurations
---@param prompt? string
---@param label_fn fun(item: table): string
---@param cb fun(item?: table)
local function pick_configuration(items, prompt, label_fn, cb)
    local title = (prompt or "Configuration"):gsub("^%s*", ""):gsub("[%s:]*$", "")
    local completed = false

    local function done(item)
        if completed then
            return
        end
        completed = true
        vim.schedule(function()
            cb(item)
        end)
    end

    Snacks.picker.pick({
        source = "dap_configurations",
        title = title,
        layout = { preset = "wide_with_preview" },
        finder = function()
            local ret = {}
            for idx, item in ipairs(items) do
                ret[#ret + 1] = {
                    idx = idx,
                    text = idx .. " " .. label_fn(item),
                    label = label_fn(item),
                    item = item,
                }
            end
            return ret
        end,
        format = function(item)
            return {
                { ("%d. "):format(item.idx), "SnacksPickerIdx" },
                { item.label },
            }
        end,
        preview = function(ctx)
            local lines = vim.split(vim.inspect(ctx.item.item), "\n")
            ctx.preview:reset()
            ctx.preview:set_lines(lines)
            ctx.preview:highlight({ ft = "lua" })
        end,
        actions = {
            confirm = function(picker, item)
                picker:close()
                done(item and item.item)
            end,
        },
        on_close = function()
            done(nil)
        end,
    })
end

function M.setup()
    local dap_ui = require("dap.ui")
    local pick_one = dap_ui.pick_one

    -- nvim-dap uses `dap.ui.pick_one` (-> vim.ui.select) for every picker, so only
    -- take over the "Configuration" one and keep the default for the others.
    dap_ui.pick_one = function(items, prompt, label_fn, cb)
        if not (type(prompt) == "string" and prompt:match("^Configuration")) then
            return pick_one(items, prompt, label_fn, cb)
        end

        -- Same coroutine handling as dap.ui.pick_one when no callback is given
        local co
        if not cb then
            co = coroutine.running()
            if co then
                cb = function(item)
                    coroutine.resume(co, item)
                end
            end
        end
        pick_configuration(items, prompt, label_fn, cb)
        if co then
            return coroutine.yield()
        end
    end
end

return M
