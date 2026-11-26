-- vim.pack entry point (enabled with NVIM_PACK=1, see init.lua).

-- Build steps. Must be registered BEFORE any vim.pack.add().
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if kind ~= "install" and kind ~= "update" then
            return
        end
        if not ev.data.active then
            vim.cmd.packadd(name)
        end
        if name == "nvim-treesitter" then
            vim.cmd("TSUpdate")
        elseif name == "markdown-preview.nvim" then
            vim.fn["mkdp#util#install"]()
        end
    end,
})

local pack = require("pack.util")

-- Order matters: later modules use plugins from earlier ones
-- (auto-session needs snacks + aerial, lsp needs blink, lualine/incline need devicons...).
pack.module("pack.snacks")
pack.module("pack.ui")
pack.module("pack.treesitter")
pack.module("pack.basics")
pack.module("pack.noice")
pack.module("pack.completion")
pack.module("pack.lsp") -- also loads pack.dap
pack.module("pack.copilot")
pack.module("pack.git")
pack.module("pack.miscellaneous")

-- :PackList - browse installed plugins (name, loaded state, revision); <CR> browses the plugin's files
vim.api.nvim_create_user_command("PackList", function()
    local plugins = vim.pack.get()
    table.sort(plugins, function(a, b)
        return a.spec.name < b.spec.name
    end)
    local items = {}
    for _, p in ipairs(plugins) do
        items[#items + 1] = {
            text = p.spec.name,
            dir = p.path,
            active = p.active,
            rev = p.rev:sub(1, 7),
            src = p.spec.src,
        }
    end
    Snacks.picker({
        title = ("Plugins (%d)"):format(#items),
        items = items,
        format = function(item)
            return {
                { item.active and "● " or "○ ", item.active and "DiagnosticOk" or "Comment" },
                { item.text .. " ", "SnacksPickerLabel" },
                { item.rev .. " ", "Comment" },
                { item.src, "Comment" },
            }
        end,
        preview = "none",
        confirm = function(picker, item)
            picker:close()
            if item then
                Snacks.picker.files({ cwd = item.dir })
            end
        end,
    })
end, { desc = "List vim.pack plugins" })

-- :PackUpdate [plugin...] - review and apply updates (all plugins if none given).
-- With a bang, skip fetching and just show the plugins at their current revision.
vim.api.nvim_create_user_command("PackUpdate", function(opts)
    vim.pack.update(#opts.fargs > 0 and opts.fargs or nil, { offline = opts.bang })
end, {
    nargs = "*",
    bang = true,
    desc = "Update vim.pack plugins",
    complete = function(arglead)
        local names = vim.tbl_map(function(p)
            return p.spec.name
        end, vim.pack.get())
        table.sort(names)
        return vim.tbl_filter(function(name)
            return vim.startswith(name, arglead)
        end, names)
    end,
})

require("pack.profile")
