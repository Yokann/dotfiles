local M = {}

M.loadGlobals = function(opts)
    MainMod = "SUPER"
    Terminal = "footclient"
    FileManager = "yazi"
    ConfigPath = os.getenv("DOTFILES_PATH") .. "/config/hypr"
    MachineType = "desktop"
    Uwsm = "uwsm app -- "
    Launcher = "walker"
    HomeDir = os.getenv("HOME")
    ThemeName = opts.theme
    -- Load custom globals
    opts.loadGlobals()
end

return M
