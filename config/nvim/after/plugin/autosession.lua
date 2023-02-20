local ok, autosession = pcall(require, "auto-session")
if not ok then
    return
end

autosession.setup {
    log_level = "error",
    auto_session_suppress_dirs = { "~/" },
}

