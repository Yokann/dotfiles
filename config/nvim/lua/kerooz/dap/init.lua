local M = {}

local dap, dapui = require('dap'), require('dapui')

-- Setup colors and icons of the breakpoint UI elements
local function configure()
    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#9a79db", bg = "#20222e" })
    vim.api.nvim_set_hl(0, "DapReject", { ctermbg = 0, fg = "#993939", bg = "#20222e" })
    vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#20222e" })
    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#20222e" })
    local dap_breakpoint = {
        error = {
            text = "🛑",
            texthl = "DapBreakpoint",
            linehl = "DapBreakpoint",
            numhl = "DapBreakpoint",
        },
        conditionnal = {
            text = "❓",
            texthl = "DapBreakpoint",
            linehl = "DapBreakpoint",
            numhl = "DapBreakpoint",

        },
        rejected = {
            text = "❌",
            texthl = "DapReject",
            linehl = "DapReject",
            numhl = "DapReject",
        },
        stopped = {
            text = "🖖",
            texthl = "DapStopped",
            linehl = "DapStopped",
            numhl = "DapStopped",
        },
    }

    vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
    vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
    vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
    vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.conditionnal)
end

local function configure_exts(dap, dapui)
    require('nvim-dap-virtual-text').setup {
        commented = true,
    }

    dapui.setup({}) -- use default
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
end

local function configure_debuggers(dap)
    require('kerooz.dap.lua').setup(dap)
    require('kerooz.dap.go').setup(dap)
    require('kerooz.dap.php').setup(dap)
    require('kerooz.dap.rust').setup(dap)
    require('kerooz.dap.javascript').setup(dap)
end

function M.setup()
    configure()                                     -- Configuration
    configure_exts(dap, dapui)                      -- Extensions
    configure_debuggers(dap)                        -- Debugger
    require('kerooz.lib.dap.config').load_custom_configuration(dap)
    require('kerooz.dap.keymaps').setup(dap, dapui) -- Keymaps
end

-- Autosession callback before closing nvim
-- Avoid to save session with DAP UI opened
function M.closeUI()
    dapui.close()
end

-- require("dap").set_log_level("TRACE")

return M
