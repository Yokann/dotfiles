local M = {}

function M.filtered_pick_process()
    local opts = {}
    vim.ui.input(
        { prompt = "Search by process name (lua pattern), or hit enter to select from the process list: " },
        function(input)
            opts["filter"] = input or ""
        end
    )
    return require('dap.utils').pick_process(opts)
end

function M.prompt_arguments()
    return coroutine.create(function(c)
        local args = {}
        vim.ui.input({ prompt = "Args: " }, function(input)
            args = vim.split(input or "", " ")
            coroutine.resume(c, args)
        end)
    end)
end

return M
