local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  defaults = {
    lazy = true,
  },
  dev = {
    path = "~/code",
    fallback = true, -- get plugin from git if not found in path
  },
}

local present, lazy = pcall(require, "lazy")
if not present then
  return
end

lazy.setup("kerooz.plugins", opts)
