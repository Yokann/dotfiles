-- Small lazy-loading layer on top of vim.pack (replacement for lazy.nvim specs).
local M = {}

local function normalize(plugins)
    local out = {}
    for _, p in ipairs(type(plugins) == "string" and { plugins } or plugins) do
        local spec = type(p) == "string" and { src = p } or vim.deepcopy(p)
        if not spec.src:find("^%a[%w+.-]*://") then
            spec.src = "https://github.com/" .. spec.src
        end
        out[#out + 1] = spec
    end
    return out
end

local function autocmd_ids(event)
    local ids = {}
    for _, a in ipairs(vim.api.nvim_get_autocmds({ event = event })) do
        ids[a.id or a] = true
    end
    return ids
end

--- Load, then replay `ev` for the autocmds the plugin registered while loading
--- (it missed the event that triggered the load). Other handlers are not re-run.
local function load_and_replay(load, ev)
    local before = autocmd_ids(ev.event)
    load()
    for _, a in ipairs(vim.api.nvim_get_autocmds({ event = ev.event })) do
        local matches = a.pattern == "*" or a.pattern == ev.match or (a.buflocal and a.buffer == ev.buf)
        if a.id and not before[a.id] and matches then
            local args = vim.tbl_extend("force", ev, { id = a.id, group = a.group })
            if a.callback then
                pcall(a.callback, args)
            elseif a.command and a.command ~= "" then
                vim.api.nvim_buf_call(ev.buf, function()
                    pcall(vim.cmd, a.command)
                end)
            end
        end
    end
end

--- Install and load plugins right away.
---@param plugins string|table  "user/repo" or { src = "user/repo", version = "main" }, or a list of them
function M.add(plugins)
    vim.pack.add(normalize(plugins))
end

---@class pack.LazySpec
---@field plugins string|table      plugin(s) to load, dependencies first
---@field config? fun()             run once, after the plugins are loaded
---@field event? string|string[]    autocmd events; "VeryLazy" = right after UIEnter
---@field ft? string|string[]
---@field cmd? string|string[]
---@field keys? { [1]: string, [2]: string|fun(), mode?: string|string[], desc?: string }[]

--- Install now, load on first trigger (event / ft / cmd / key).
---@param spec pack.LazySpec
function M.lazy(spec)
    local plugins = normalize(spec.plugins)
    -- install only: a no-op `load` keeps the plugin off the runtimepath until triggered
    vim.pack.add(plugins, { load = function() end })

    local group = vim.api.nvim_create_augroup("pack_lazy_" .. plugins[#plugins].src, { clear = true })
    local loaded = false
    local cleanup = {}

    local function load()
        if loaded then
            return
        end
        loaded = true
        vim.api.nvim_del_augroup_by_id(group)
        for _, fn in ipairs(cleanup) do
            fn()
        end
        for _, p in ipairs(plugins) do
            vim.cmd.packadd(p.name or p.src:match("([^/]+)$"):gsub("%.git$", ""))
        end
        if spec.config then
            spec.config()
        end
    end

    local function list(v)
        return type(v) == "table" and v or { v }
    end

    for _, ev in ipairs(spec.event and list(spec.event) or {}) do
        if ev == "VeryLazy" then
            vim.api.nvim_create_autocmd("UIEnter", {
                group = group,
                once = true,
                callback = function()
                    vim.schedule(load)
                end,
            })
        else
            vim.api.nvim_create_autocmd(ev, {
                group = group,
                once = true,
                callback = function(e)
                    if not loaded then
                        load_and_replay(load, e)
                    end
                end,
            })
        end
    end

    if spec.ft then
        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            pattern = list(spec.ft),
            callback = function(ev)
                if not loaded then
                    load_and_replay(load, ev)
                end
            end,
        })
    end

    for _, name in ipairs(spec.cmd and list(spec.cmd) or {}) do
        vim.api.nvim_create_user_command(name, function(args)
            load()
            vim.cmd({
                cmd = name,
                args = args.fargs,
                bang = args.bang,
                range = args.range > 0 and { args.line1, args.line2 } or nil,
            })
        end, { nargs = "*", bang = true, range = true })
        cleanup[#cleanup + 1] = function()
            pcall(vim.api.nvim_del_user_command, name)
        end
    end

    for _, key in ipairs(spec.keys or {}) do
        local lhs, rhs, mode = key[1], key[2], key.mode or "n"
        local opts = { desc = key.desc }
        vim.keymap.set(mode, lhs, function()
            load()
            if type(rhs) == "function" then
                rhs()
            else
                vim.api.nvim_feedkeys(vim.keycode(rhs), "m", false)
            end
        end, opts)
        -- once loaded, bind the real mapping so later presses skip the stub
        cleanup[#cleanup + 1] = function()
            vim.keymap.set(mode, lhs, rhs, opts)
        end
    end
end

return M
