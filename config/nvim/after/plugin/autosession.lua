local ok, autosession = pcall(require, "auto-session")
if not ok then
    return
end

autosession.setup {
    log_level = "error",
    auto_session_suppress_dirs = { "~/" },
    cwd_change_handling = {
        restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
        pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
    },
    pre_save_cmds = {require("nvim-tree.api").tree.close}
}

