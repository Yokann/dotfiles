local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n" .. out, "ErrorMsg" } }, true, {})
        return
    end
end
vim.opt.rtp:prepend(lazypath)

local opts = {
    defaults = {
        lazy = true,
    },
    git = {
        timeout = 60,
    },
    dev = {
        path = "~/.local/share/nvim/dev",
        fallback = true, -- get plugin from git if not found in path
    },
    change_detection = {
        notify = false, -- GTFO
    },
    rocks = { enabled = false },
    performance = {
        rtp = {
            disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin", "netrwPlugin" },
        },
    },
}

local present, lazy = pcall(require, "lazy")
if not present then
    return
end

lazy.setup("plugins", opts)
