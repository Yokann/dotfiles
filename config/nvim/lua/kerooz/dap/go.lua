local M = {}

local default_config = {
    delve = {
        terminal = "foot",
        path = "dlv",
        initialize_timeout_sec = 20,
        port = "${port}",
        args = {},
        build_flags = "",
        detached = true,
    },
}

local function setup_delve_adapter(dap, config)
    local args = { "dap", "-l", "127.0.0.1:" .. config.delve.port }
    vim.list_extend(args, config.delve.args)

    dap.adapters.go = {
        type = "server",
        port = config.delve.port,
        executable = {
            command = config.delve.path,
            args = args,
            detached = config.delve.detached,
            cwd = config.delve.cwd,
        },
        options = {
            initialize_timeout_sec = config.delve.initialize_timeout_sec,
        },
    }
    -- Adapter to open the program in an external terminal, very useful for TUI programs
    dap.adapters.go_tui = {
        type = "server",
        port = config.delve.port,
        executable = {
            command = config.delve.terminal,
            args = vim.list_extend({ "--title=dap-debugger", config.delve.path }, args),
            detached = config.delve.detached,
            cwd = config.delve.cwd,
        },
        options = {
            initialize_timeout_sec = config.delve.initialize_timeout_sec,
        },
    }
end

local function setup_go_configuration(dap, config)
    local common = require('kerooz.dap.common')
    dap.configurations.go = {
        {
            type = "go",
            name = "Debug",
            request = "launch",
            program = "${file}",
            buildFlags = config.delve.build_flags,
        },
        {
            type = "go",
            name = "Debug (Arguments)",
            request = "launch",
            program = "${file}",
            args = common.prompt_arguments,
            buildFlags = config.delve.build_flags,
        },
        {
            type = "go",
            name = "Debug Package",
            request = "launch",
            program = "${fileDirname}",
            buildFlags = config.delve.build_flags,
        },
        {
            type = "go",
            name = "Attach",
            mode = "local",
            request = "attach",
            processId = common.filtered_pick_process,
            buildFlags = config.delve.build_flags,
        },
        {
            type = "go",
            name = "Debug test",
            request = "launch",
            mode = "test",
            program = "${file}",
            buildFlags = config.delve.build_flags,
        },
        {
            type = "go",
            name = "Debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}",
            buildFlags = config.delve.build_flags,
        },
    }
end

function M.setup(dap, opts)
    local config = vim.tbl_deep_extend('force', default_config, opts or {})
    setup_delve_adapter(dap, config)
    setup_go_configuration(dap, config)
end

return M
