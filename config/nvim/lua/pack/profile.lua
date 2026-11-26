-- :PackProfile - startup / lazy-load timings, in the spirit of lazy.nvim's profile view.
local pack = require("pack.util")

local function fmt(ms)
    return ms and ("%7.2f ms"):format(ms) or "        -  "
end

vim.api.nvim_create_user_command("PackProfile", function()
    local items = {}
    local startup, lazy_total, loaded = 0, 0, 0

    for _, m in ipairs(pack.profile.modules) do
        startup = startup + m.ms
        items[#items + 1] = { kind = "startup", name = m.name, ms = m.ms, detail = "eager module" }
    end
    for _, l in ipairs(pack.profile.lazy) do
        if l.ms then
            loaded = loaded + 1
            lazy_total = lazy_total + l.ms
            items[#items + 1] = {
                kind = "lazy",
                name = l.name,
                ms = l.ms,
                detail = ("%s  @%.0fms  (packadd %.1f, config %.1f)"):format(l.trigger, l.at, l.packadd, l.config),
            }
        else
            items[#items + 1] = { kind = "pending", name = l.name, detail = "not loaded yet" }
        end
    end
    -- slowest first, not-yet-loaded plugins last
    table.sort(items, function(a, b)
        return (a.ms or -1) > (b.ms or -1)
    end)
    for _, item in ipairs(items) do
        item.text = item.name .. " " .. item.kind
    end

    local total = #pack.profile.lazy
    Snacks.picker({
        title = ("Pack profile - startup %.1f ms, lazy %.1f ms (%d/%d loaded)"):format(
            startup,
            lazy_total,
            loaded,
            total
        ),
        items = items,
        preview = "none",
        format = function(item)
            local hl = ({ startup = "DiagnosticWarn", lazy = "DiagnosticInfo", pending = "Comment" })[item.kind]
            return {
                { fmt(item.ms) .. "  ", hl },
                { ("%-8s"):format(item.kind), "Comment" },
                { item.name .. "  ", "SnacksPickerLabel" },
                { item.detail, "Comment" },
            }
        end,
        confirm = function(picker)
            picker:close()
        end,
    })
end, { desc = "Show vim.pack startup/lazy-load profile" })
