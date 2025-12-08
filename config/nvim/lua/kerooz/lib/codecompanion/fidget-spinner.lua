local progress = require("fidget.progress")

local M = {}
M.handles = {}

local function store_progress_handle(id, handle)
    M.handles[id] = handle
end

local function pop_progress_handle(id)
    local handle = M.handles[id]
    M.handles[id] = nil
    return handle
end

local function llm_role_title(adapter)
    local parts = {}
    table.insert(parts, adapter.formatted_name or "Unknown")
    if adapter.model and adapter.model ~= "" then
        table.insert(parts, "(" .. adapter.model .. ")")
    end
    return table.concat(parts, " ")
end

local function create_progress_handle(request)
    local adapter = request.data.adapter or {}
    return progress.handle.create({
        title = " Requesting assistance (" .. (request.data.strategy or "unknown") .. ")",
        message = "In progress...",
        lsp_client = {
            name = llm_role_title(adapter),
        },
    })
end

local function report_exit_status(handle, request)
    local status = request.data.status
    if status == "success" then
        handle.message = "Completed"
    elseif status == "error" then
        handle.message = " Error"
    elseif status == "cancelled" then
        handle.message = "󰜺 Cancelled"
    else
        handle.message = "Unknown status"
    end
end

--- Initialize Fidget spinner hooks for CodeCompanion events.
function M.init()
    local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})

    vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionRequestStarted",
        group = group,
        callback = function(request)
            if not request or not request.data or not request.data.id then
                vim.notify("Invalid request data for RequestStarted", vim.log.levels.ERROR)
                return
            end
            local handle = create_progress_handle(request)
            store_progress_handle(request.data.id, handle)
        end,
    })

    vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionRequestFinished",
        group = group,
        callback = function(request)
            if not request or not request.data or not request.data.id then
                vim.notify("Invalid request data for RequestFinished", vim.log.levels.ERROR)
                return
            end
            local handle = pop_progress_handle(request.data.id)
            if handle then
                report_exit_status(handle, request)
                handle:finish()
            else
                vim.notify("No progress handle found for id: " .. tostring(request.data.id), vim.log.levels.WARN)
            end
        end,
    })
end

M.init = M.init

return M
