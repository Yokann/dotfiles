local M = {}

function M.setup(dap, dapui)
    vim.keymap.set("n", "<F1>", function() dapui.toggle() end, { desc = "Debugger - Toggle UI", noremap=false })
    vim.keymap.set("n", "<F9>", function() dap.continue() end, { desc = "Debugger - Start" })
    vim.keymap.set("n", "<F3>", function() dap.toggle_breakpoint() end, { desc = "Debugger - Toggle breakpoint" })
    vim.keymap.set("n", "<F5>", function() dap.step_over() end, { desc = "Deugger - Next Step" })
    vim.keymap.set("n", "<F4>", function() dap.step_into() end, { desc = "Debugger - Step Into" })
    vim.keymap.set("n", "<F7>", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", { desc = "Debugger - Conditionnal breakpoint" })
    -- vim.keymap.set("n", "", c(dap), { desc = "" })

    local keymap_n = {
        R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
        -- E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
        -- C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
        -- b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
        d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
        e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
        -- g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
        -- h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
        -- S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
        -- p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
        q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
        -- r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
        x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
        u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    }

    for bindkey, cmd in pairs(keymap_n) do
        local description = "Debug " .. cmd[2]
        local finalBindkey = string.match(bindkey, "^<(?*)>$") and bindkey or "<leader>d" .. bindkey
        vim.keymap.set("n", finalBindkey, cmd[1], { silent = true, noremap = false, desc = description })
    end

    local keymap_v = {
        e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    }

    for bindkey, cmd in pairs(keymap_v) do
        local description = "Debug " .. cmd[2]
        vim.keymap.set("v", "<leader>e" .. bindkey, cmd[1], { silent = true, noremap = true, desc = description })
    end
end

return M
